Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DEA380FF3
	for <lists+linux-spi@lfdr.de>; Fri, 14 May 2021 20:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhENSmk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 May 2021 14:42:40 -0400
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:39306 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229819AbhENSmj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 May 2021 14:42:39 -0400
X-Greylist: delayed 1427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 May 2021 14:42:39 EDT
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1lhcNY-0001PK-6D; Fri, 14 May 2021 19:17:40 +0100
Received: from ben by rainbowdash with local (Exim 4.94.2)
        (envelope-from <ben@rainbowdash>)
        id 1lhcNX-002vnt-Ek; Fri, 14 May 2021 19:17:39 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-spi@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] RFC: move global bus add lock to per-controller lock
Date:   Fri, 14 May 2021 19:17:38 +0100
Message-Id: <20210514181738.698808-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When trying to use the spi-mux code the system deadlocked with the
spi_add_lock being held by a parent of the new devices being created
by the spi-mux. This ended up with a hung task and no devices being
added.

To try and stop this, I think it is possible (but not certain) to
put a lock per-controller to stop new additions when devices are
being added to that controller. The lock will also be held when
the controller is being removed.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/spi/spi.c       | 14 ++++----------
 include/linux/spi/spi.h |  2 ++
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ba425b9c7700..a111868df24b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -484,12 +484,6 @@ static LIST_HEAD(spi_controller_list);
  */
 static DEFINE_MUTEX(board_lock);
 
-/*
- * Prevents addition of devices with same chip select and
- * addition of devices below an unregistering controller.
- */
-static DEFINE_MUTEX(spi_add_lock);
-
 /**
  * spi_alloc_device - Allocate a new SPI device
  * @ctlr: Controller to which device is connected
@@ -587,7 +581,7 @@ int spi_add_device(struct spi_device *spi)
 	 * chipselect **BEFORE** we call setup(), else we'll trash
 	 * its configuration.  Lock against concurrent add() calls.
 	 */
-	mutex_lock(&spi_add_lock);
+	mutex_lock(&ctlr->bus_add_mutex);
 
 	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
 	if (status) {
@@ -629,7 +623,7 @@ int spi_add_device(struct spi_device *spi)
 		dev_dbg(dev, "registered child %s\n", dev_name(&spi->dev));
 
 done:
-	mutex_unlock(&spi_add_lock);
+	mutex_unlock(&ctlr->bus_add_mutex);
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_add_device);
@@ -2850,7 +2844,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 
 	/* Prevent addition of new devices, unregister existing ones */
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_lock(&spi_add_lock);
+		mutex_lock(&ctlr->bus_add_mutex);
 
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
@@ -2881,7 +2875,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	mutex_unlock(&board_lock);
 
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_unlock(&spi_add_lock);
+		mutex_unlock(&ctlr->bus_add_mutex);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 360a3bc767ca..8b6940d77c99 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -345,6 +345,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for exclusion of multiple callers
  * @bus_lock_flag: indicates that the SPI bus is locked for exclusive use
+ * @bus_add_mutex: lock to stop mulitple devices being added
  * @setup: updates the device mode and clocking records used by a
  *	device's SPI controller; protocol code may call this.  This
  *	must fail if an unrecognized or unsupported mode is requested.
@@ -528,6 +529,7 @@ struct spi_controller {
 	/* lock and mutex for SPI bus locking */
 	spinlock_t		bus_lock_spinlock;
 	struct mutex		bus_lock_mutex;
+	struct mutex		bus_add_mutex;
 
 	/* flag indicating that the SPI bus is locked for exclusive use */
 	bool			bus_lock_flag;
-- 
2.30.2

