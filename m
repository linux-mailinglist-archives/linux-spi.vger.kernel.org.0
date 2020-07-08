Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BCA218939
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 15:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgGHNgS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 09:36:18 -0400
Received: from mailout2.hostsharing.net ([83.223.78.233]:35203 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgGHNgR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jul 2020 09:36:17 -0400
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2020 09:36:16 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 3522A10189B24;
        Wed,  8 Jul 2020 15:36:15 +0200 (CEST)
Received: from localhost (pd95be530.dip0.t-ipconnect.de [217.91.229.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id E7E796106EC8;
        Wed,  8 Jul 2020 15:36:14 +0200 (CEST)
X-Mailbox-Line: From bf185285172a7b127424ac22fa42811eb2081cd4 Mon Sep 17 00:00:00 2001
Message-Id: <bf185285172a7b127424ac22fa42811eb2081cd4.1594214103.git.lukas@wunner.de>
In-Reply-To: <cover.1594214103.git.lukas@wunner.de>
References: <cover.1594214103.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 8 Jul 2020 15:27:02 +0200
Subject: [PATCH 2/3] driver core: Use rwsem for kill_device() serialization
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

kill_device() is currently serialized with driver probing by way of the
device_lock().  We're about to serialize it with device_add() as well
to prevent addition of children below a device which is going away.
However the parent's device_lock() cannot be taken by device_add()
lest deadlocks occur:  Addition of the parent may result in addition
of children (as is the case with SPI controllers) and device_add()
already takes the device_lock through the call to bus_probe_device() ->
device_initial_probe() -> __device_attach().

Avoid such deadlocks by introducing an rw_semaphore whose specific
purpose is to serialize kill_device() with other parts of the kernel.

Use an rw_semaphore instead of a mutex because the latter would preclude
concurrent driver probing of multiple children below the same parent.
The semaphore is acquired for writing when declaring a device dead and
otherwise only acquired for reading.  It is private to the driver core,
obviating the need to acquire a lock when calling kill_device(), as is
currently done in nvdimm's nd_device_unregister() and device_del().

An alternative approach would be to convert the device_lock() itself to
an rw_semaphore (instead of a mutex).

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/base.h  |  2 ++
 drivers/base/core.c  | 33 +++++++++++++++++++--------------
 drivers/base/dd.c    |  8 ++++++++
 drivers/nvdimm/bus.c |  8 +-------
 4 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 95c22c0f90360..7e71a1d262ef6 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -79,6 +79,7 @@ struct driver_private {
  * @async_driver - pointer to device driver awaiting probe via async_probe
  * @device - pointer back to the struct device that this structure is
  * associated with.
+ * @dead_sem - semaphore taken when declaring the device @dead.
  * @dead - This device is currently either in the process of or has been
  *	removed from the system. Any asynchronous events scheduled for this
  *	device should exit without taking any action.
@@ -94,6 +95,7 @@ struct device_private {
 	struct list_head deferred_probe;
 	struct device_driver *async_driver;
 	struct device *device;
+	struct rw_semaphore dead_sem;
 	u8 dead:1;
 };
 #define to_device_private_parent(obj)	\
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67d39a90b45c7..057da42b1a660 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2526,6 +2526,7 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
+	init_rwsem(&dev->p->dead_sem);
 	return 0;
 }
 
@@ -2780,21 +2781,27 @@ void put_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(put_device);
 
+/**
+ * kill_device - declare device dead
+ * @dev: device in question
+ *
+ * Declare @dev dead to prevent it from binding to a driver.
+ * Return true if it was killed or false if it was already dead.
+ */
 bool kill_device(struct device *dev)
 {
-	/*
-	 * Require the device lock and set the "dead" flag to guarantee that
-	 * the update behavior is consistent with the other bitfields near
-	 * it and that we cannot have an asynchronous probe routine trying
-	 * to run while we are tearing out the bus/class/sysfs from
-	 * underneath the device.
-	 */
-	lockdep_assert_held(&dev->mutex);
+	bool killed;
 
-	if (dev->p->dead)
-		return false;
-	dev->p->dead = true;
-	return true;
+	down_write(&dev->p->dead_sem);
+	if (dev->p->dead) {
+		killed = false;
+	} else {
+		dev->p->dead = true;
+		killed = true;
+	}
+	up_write(&dev->p->dead_sem);
+
+	return killed;
 }
 EXPORT_SYMBOL_GPL(kill_device);
 
@@ -2817,9 +2824,7 @@ void device_del(struct device *dev)
 	struct kobject *glue_dir = NULL;
 	struct class_interface *class_intf;
 
-	device_lock(dev);
 	kill_device(dev);
-	device_unlock(dev);
 
 	if (dev->fwnode && dev->fwnode->dev == dev)
 		dev->fwnode->dev = NULL;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 31c668651e824..9353d811cce83 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -817,6 +817,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 	};
 
 	device_lock(dev);
+	down_read(&dev->p->dead_sem);
 
 	/*
 	 * Check if device has already been removed or claimed. This may
@@ -838,6 +839,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 	if (dev->parent)
 		pm_runtime_put(dev->parent);
 out_unlock:
+	up_read(&dev->p->dead_sem);
 	device_unlock(dev);
 
 	put_device(dev);
@@ -848,6 +850,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 	int ret = 0;
 
 	device_lock(dev);
+	down_read(&dev->p->dead_sem);
 	if (dev->p->dead) {
 		goto out_unlock;
 	} else if (dev->driver) {
@@ -893,6 +896,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			pm_runtime_put(dev->parent);
 	}
 out_unlock:
+	up_read(&dev->p->dead_sem);
 	device_unlock(dev);
 	return ret;
 }
@@ -967,6 +971,7 @@ int device_driver_attach(struct device_driver *drv, struct device *dev)
 	int ret = 0;
 
 	__device_driver_lock(dev, dev->parent);
+	down_read(&dev->p->dead_sem);
 
 	/*
 	 * If device has been removed or someone has already successfully
@@ -975,6 +980,7 @@ int device_driver_attach(struct device_driver *drv, struct device *dev)
 	if (!dev->p->dead && !dev->driver)
 		ret = driver_probe_device(drv, dev);
 
+	up_read(&dev->p->dead_sem);
 	__device_driver_unlock(dev, dev->parent);
 
 	return ret;
@@ -987,6 +993,7 @@ static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
 	int ret = 0;
 
 	__device_driver_lock(dev, dev->parent);
+	down_read(&dev->p->dead_sem);
 
 	drv = dev->p->async_driver;
 
@@ -997,6 +1004,7 @@ static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
 	if (!dev->p->dead && !dev->driver)
 		ret = driver_probe_device(drv, dev);
 
+	up_read(&dev->p->dead_sem);
 	__device_driver_unlock(dev, dev->parent);
 
 	dev_dbg(dev, "driver %s async attach completed: %d\n", drv->name, ret);
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 09087c38fabdc..35e069c69386a 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -559,8 +559,6 @@ EXPORT_SYMBOL(nd_device_register);
 
 void nd_device_unregister(struct device *dev, enum nd_async_mode mode)
 {
-	bool killed;
-
 	switch (mode) {
 	case ND_ASYNC:
 		/*
@@ -584,11 +582,7 @@ void nd_device_unregister(struct device *dev, enum nd_async_mode mode)
 		 * or otherwise let the async path handle it if the
 		 * unregistration was already queued.
 		 */
-		nd_device_lock(dev);
-		killed = kill_device(dev);
-		nd_device_unlock(dev);
-
-		if (!killed)
+		if (!kill_device(dev))
 			return;
 
 		nd_synchronize();
-- 
2.27.0

