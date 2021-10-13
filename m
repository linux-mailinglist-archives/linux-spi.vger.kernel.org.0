Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE4A42C2FA
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbhJMOZw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 10:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbhJMOZq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 10:25:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A674AC061746
        for <linux-spi@vger.kernel.org>; Wed, 13 Oct 2021 07:23:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mafAM-0007eC-1P; Wed, 13 Oct 2021 16:23:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mafAK-0005d6-Fh; Wed, 13 Oct 2021 16:23:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mafAK-0007jS-Eq; Wed, 13 Oct 2021 16:23:32 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: [PATCH 1/2] spi: Make spi_add_lock a per-controller lock
Date:   Wed, 13 Oct 2021 15:37:09 +0200
Message-Id: <20211013133710.2679703-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=PNzZVIW0rJ/qRfe9wHF3FK/hHw6FosZGzO9EiHHeiH0=; m=QyKS/VkEwAN9+U5rEhQJG9lIqsLBTMARDoO6FgRw0wY=; p=0KreRDaOiTwyFokVK7Cwuq+zx8iQL3JbmYXP/jZWC0U=; g=869edb4edd311c511a0bbadc2ca6de5d9cbd0714
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFm4P8ACgkQwfwUeK3K7AkA/Qf/ZQQ Smk9T6UZR5qBQ+TGhqRjGXEREvGw2p/1tKH/U+Whk4olHkoCOF2vw2V95rlAIjd/ZmM0XbW1XVI/e Wn+KVV2GZmpedlYcFwKtne5zLdttN4l+2jy7WHLgG1QiQzlrf/CiUI0FUKVJ99NnIPN9cvBBmMoGq ZU4UMKYq61ig8U8fz3/DgnIwseIo0w+xrPvZKhvwLIh4OZWm4/jgAr7oA0Bs6L0DfEneyba1Px+lN pFRs47Ri1FM0PsS4r8W13ai4QXg7ut2pVRcQNkz3YfjN71/94uv07ouav4m84p/lx2U+0zA16KtLj NgwR8ndNOeNio5WoeoGkM5TIBouhBAQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi_add_lock that is removed with this change was held when
spi_add_device() called device_add() (via __spi_add_device()).

In the case where the added device is an spi-mux calling device_add()
might result in calling the spi-mux's probe function which adds another
controller and for that spi_add_device() might be called. This results
in a dead-lock.

To circumvent this deadlock replace the global spi_add_lock with a lock
per controller.

The biggest part of this patch was authored by Mark Brown.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi.c       | 17 ++++++-----------
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 50591de16e0f..193e3264f7eb 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -477,12 +477,6 @@ static LIST_HEAD(spi_controller_list);
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
@@ -635,9 +629,9 @@ static int spi_add_device(struct spi_device *spi)
 	/* Set the bus ID string */
 	spi_dev_set_name(spi);
 
-	mutex_lock(&spi_add_lock);
+	mutex_lock(&ctlr->add_lock);
 	status = __spi_add_device(spi);
-	mutex_unlock(&spi_add_lock);
+	mutex_unlock(&ctlr->add_lock);
 	return status;
 }
 
@@ -656,7 +650,7 @@ static int spi_add_device_locked(struct spi_device *spi)
 	/* Set the bus ID string */
 	spi_dev_set_name(spi);
 
-	WARN_ON(!mutex_is_locked(&spi_add_lock));
+	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
 	return __spi_add_device(spi);
 }
 
@@ -2909,6 +2903,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 	spin_lock_init(&ctlr->bus_lock_spinlock);
 	mutex_init(&ctlr->bus_lock_mutex);
 	mutex_init(&ctlr->io_mutex);
+	mutex_init(&ctlr->add_lock);
 	ctlr->bus_lock_flag = 0;
 	init_completion(&ctlr->xfer_completion);
 	if (!ctlr->max_dma_len)
@@ -3045,7 +3040,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 
 	/* Prevent addition of new devices, unregister existing ones */
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_lock(&spi_add_lock);
+		mutex_lock(&ctlr->add_lock);
 
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
@@ -3076,7 +3071,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	mutex_unlock(&board_lock);
 
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_unlock(&spi_add_lock);
+		mutex_unlock(&ctlr->add_lock);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 29e21d49aafc..5b61abe679f1 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -349,6 +349,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @max_message_size: function that returns the max message size for
  *	a &spi_device; may be %NULL, so the default %SIZE_MAX will be used.
  * @io_mutex: mutex for physical bus access
+ * @add_lock: mutex to avoid adding two devices on the same CS
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for exclusion of multiple callers
  * @bus_lock_flag: indicates that the SPI bus is locked for exclusive use
@@ -527,6 +528,9 @@ struct spi_controller {
 	/* I/O mutex */
 	struct mutex		io_mutex;
 
+	/* Used to avoid adding two devices on the same CS line */
+	struct mutex		add_lock;
+
 	/* lock and mutex for SPI bus locking */
 	spinlock_t		bus_lock_spinlock;
 	struct mutex		bus_lock_mutex;

base-commit: da21fde0fdb393c2fbe0ae0735cc826cd55fd46f
-- 
2.30.2

