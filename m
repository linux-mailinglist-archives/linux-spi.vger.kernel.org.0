Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393E34252CC
	for <lists+linux-spi@lfdr.de>; Thu,  7 Oct 2021 14:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbhJGMQT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Oct 2021 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbhJGMQR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Oct 2021 08:16:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D84C061762
        for <linux-spi@vger.kernel.org>; Thu,  7 Oct 2021 05:14:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYSI2-0007I9-56; Thu, 07 Oct 2021 14:14:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYSI1-000622-JE; Thu, 07 Oct 2021 14:14:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYSI1-0006pr-IU; Thu, 07 Oct 2021 14:14:21 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 4/4] spi: Make several public functions private to spi.c
Date:   Thu,  7 Oct 2021 14:14:15 +0200
Message-Id: <20211007121415.2401638-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007121415.2401638-1-u.kleine-koenig@pengutronix.de>
References: <20211007121415.2401638-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=JEKl68owTMEBj9pnQgUuZJxriBLZWXwTXHCXjAAt/OI=; m=upl22FB7NRzz0n3cW/ZPLOOBu7ujVYXVmWGcoEp85rY=; p=X9dJM14862NnjFeL6srqHWFhH4GeFqys6hZhVOft8tI=; g=ab1cac0fcc87971faac0ffc2928c6091ef79f5a1
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFe5JQACgkQwfwUeK3K7AmF5Af/Rtn BbAEXDxsg8vur0BMcIEorBsEsbR18Si2kfI4cL7swonp6AWxGm0IMuUnAFbsYuenpkAKFdHK3In57 Z7bUtjaQpKK/jOZJxQjaIhpysraVoge1YVxzvt6a3LT1cM/FmgeGtzIxug7Ew3Dx5u7VxNUCXR7z9 Goarch6PUwmTNl9CxLdBWsvojD6bmx9hvpujKrK1d7GNM8nV1khb3DvbZJpfDeLlW1aNFYE+7MAX3 tPF7zK6M6qLG/oHvDGiGtSjyMRIijW7VXDyioIBLRWITa6JRkdymoDMBoPuqYR6Gn+4j4IcpDyx92 N3bOfaZJTKCRZPgEh7ajBIpR4kMEbxg==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

All these functions have no callers apart from drivers/spi/spi.c. So
drop their declarations in include/linux/spi/spi.h and don't export
them.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi.c       | 41 +++++++++++--------------------
 include/linux/spi/spi.h | 53 -----------------------------------------
 2 files changed, 14 insertions(+), 80 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 397643104576..50591de16e0f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -285,9 +285,9 @@ static const struct attribute_group *spi_master_groups[] = {
 	NULL,
 };
 
-void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
-				       struct spi_transfer *xfer,
-				       struct spi_controller *ctlr)
+static void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
+					      struct spi_transfer *xfer,
+					      struct spi_controller *ctlr)
 {
 	unsigned long flags;
 	int l2len = min(fls(xfer->len), SPI_STATISTICS_HISTO_SIZE) - 1;
@@ -310,7 +310,6 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
 
 	spin_unlock_irqrestore(&stats->lock, flags);
 }
-EXPORT_SYMBOL_GPL(spi_statistics_add_transfer_stats);
 
 /* modalias support makes "modprobe $MODALIAS" new-style hotplug work,
  * and the sysfs version makes coldplug work too.
@@ -501,7 +500,7 @@ static DEFINE_MUTEX(spi_add_lock);
  *
  * Return: a pointer to the new device, or NULL.
  */
-struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
+static struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 {
 	struct spi_device	*spi;
 
@@ -526,7 +525,6 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 	device_initialize(&spi->dev);
 	return spi;
 }
-EXPORT_SYMBOL_GPL(spi_alloc_device);
 
 static void spi_dev_set_name(struct spi_device *spi)
 {
@@ -621,7 +619,7 @@ static int __spi_add_device(struct spi_device *spi)
  *
  * Return: 0 on success; negative errno on failure
  */
-int spi_add_device(struct spi_device *spi)
+static int spi_add_device(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
@@ -642,7 +640,6 @@ int spi_add_device(struct spi_device *spi)
 	mutex_unlock(&spi_add_lock);
 	return status;
 }
-EXPORT_SYMBOL_GPL(spi_add_device);
 
 static int spi_add_device_locked(struct spi_device *spi)
 {
@@ -833,9 +830,8 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
  * This may get enhanced in the future to allocate from a memory pool
  * of the @spi_device or @spi_controller to avoid repeated allocations.
  */
-void *spi_res_alloc(struct spi_device *spi,
-		    spi_res_release_t release,
-		    size_t size, gfp_t gfp)
+static void *spi_res_alloc(struct spi_device *spi, spi_res_release_t release,
+			   size_t size, gfp_t gfp)
 {
 	struct spi_res *sres;
 
@@ -848,14 +844,13 @@ void *spi_res_alloc(struct spi_device *spi,
 
 	return sres->data;
 }
-EXPORT_SYMBOL_GPL(spi_res_alloc);
 
 /**
  * spi_res_free - free an spi resource
  * @res: pointer to the custom data of a resource
  *
  */
-void spi_res_free(void *res)
+static void spi_res_free(void *res)
 {
 	struct spi_res *sres = container_of(res, struct spi_res, data);
 
@@ -865,28 +860,26 @@ void spi_res_free(void *res)
 	WARN_ON(!list_empty(&sres->entry));
 	kfree(sres);
 }
-EXPORT_SYMBOL_GPL(spi_res_free);
 
 /**
  * spi_res_add - add a spi_res to the spi_message
  * @message: the spi message
  * @res:     the spi_resource
  */
-void spi_res_add(struct spi_message *message, void *res)
+static void spi_res_add(struct spi_message *message, void *res)
 {
 	struct spi_res *sres = container_of(res, struct spi_res, data);
 
 	WARN_ON(!list_empty(&sres->entry));
 	list_add_tail(&sres->entry, &message->resources);
 }
-EXPORT_SYMBOL_GPL(spi_res_add);
 
 /**
  * spi_res_release - release all spi resources for this message
  * @ctlr:  the @spi_controller
  * @message: the @spi_message
  */
-void spi_res_release(struct spi_controller *ctlr, struct spi_message *message)
+static void spi_res_release(struct spi_controller *ctlr, struct spi_message *message)
 {
 	struct spi_res *res, *tmp;
 
@@ -899,7 +892,6 @@ void spi_res_release(struct spi_controller *ctlr, struct spi_message *message)
 		kfree(res);
 	}
 }
-EXPORT_SYMBOL_GPL(spi_res_release);
 
 /*-------------------------------------------------------------------------*/
 
@@ -3157,7 +3149,7 @@ static void __spi_replace_transfers_release(struct spi_controller *ctlr,
  * Returns: pointer to @spi_replaced_transfers,
  *          PTR_ERR(...) in case of errors.
  */
-struct spi_replaced_transfers *spi_replace_transfers(
+static struct spi_replaced_transfers *spi_replace_transfers(
 	struct spi_message *msg,
 	struct spi_transfer *xfer_first,
 	size_t remove,
@@ -3249,7 +3241,6 @@ struct spi_replaced_transfers *spi_replace_transfers(
 
 	return rxfer;
 }
-EXPORT_SYMBOL_GPL(spi_replace_transfers);
 
 static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 					struct spi_message *msg,
@@ -3799,7 +3790,7 @@ EXPORT_SYMBOL_GPL(spi_async);
  *
  * Return: zero on success, else a negative error code.
  */
-int spi_async_locked(struct spi_device *spi, struct spi_message *message)
+static int spi_async_locked(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_controller *ctlr = spi->controller;
 	int ret;
@@ -3818,7 +3809,6 @@ int spi_async_locked(struct spi_device *spi, struct spi_message *message)
 	return ret;
 
 }
-EXPORT_SYMBOL_GPL(spi_async_locked);
 
 /*-------------------------------------------------------------------------*/
 
@@ -4076,18 +4066,15 @@ EXPORT_SYMBOL_GPL(spi_write_then_read);
 
 /*-------------------------------------------------------------------------*/
 
-#if IS_ENABLED(CONFIG_OF)
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
 /* must call put_device() when done with returned spi_device device */
-struct spi_device *of_find_spi_device_by_node(struct device_node *node)
+static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
 {
 	struct device *dev = bus_find_device_by_of_node(&spi_bus_type, node);
 
 	return dev ? to_spi_device(dev) : NULL;
 }
-EXPORT_SYMBOL_GPL(of_find_spi_device_by_node);
-#endif /* IS_ENABLED(CONFIG_OF) */
 
-#if IS_ENABLED(CONFIG_OF_DYNAMIC)
 /* the spi controllers are not using spi_bus, so we find it with another way */
 static struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f8e322a46616..29e21d49aafc 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -78,10 +78,6 @@ struct spi_statistics {
 	unsigned long transfers_split_maxsize;
 };
 
-void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
-				       struct spi_transfer *xfer,
-				       struct spi_controller *ctlr);
-
 #define SPI_STATISTICS_ADD_TO_FIELD(stats, field, count)	\
 	do {							\
 		unsigned long flags;				\
@@ -783,15 +779,6 @@ struct spi_res {
 	unsigned long long      data[]; /* guarantee ull alignment */
 };
 
-extern void *spi_res_alloc(struct spi_device *spi,
-			   spi_res_release_t release,
-			   size_t size, gfp_t gfp);
-extern void spi_res_add(struct spi_message *message, void *res);
-extern void spi_res_free(void *res);
-
-extern void spi_res_release(struct spi_controller *ctlr,
-			    struct spi_message *message);
-
 /*---------------------------------------------------------------------------*/
 
 /*
@@ -1109,8 +1096,6 @@ static inline void spi_message_free(struct spi_message *m)
 
 extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
-extern int spi_async_locked(struct spi_device *spi,
-			    struct spi_message *message);
 extern int spi_slave_abort(struct spi_device *spi);
 
 static inline size_t
@@ -1193,15 +1178,6 @@ struct spi_replaced_transfers {
 	struct spi_transfer inserted_transfers[];
 };
 
-extern struct spi_replaced_transfers *spi_replace_transfers(
-	struct spi_message *msg,
-	struct spi_transfer *xfer_first,
-	size_t remove,
-	size_t insert,
-	spi_replaced_release_t release,
-	size_t extradatasize,
-	gfp_t gfp);
-
 /*---------------------------------------------------------------------------*/
 
 /* SPI transfer transformation methods */
@@ -1473,19 +1449,7 @@ spi_register_board_info(struct spi_board_info const *info, unsigned n)
  * use spi_new_device() to describe each device.  You can also call
  * spi_unregister_device() to start making that device vanish, but
  * normally that would be handled by spi_unregister_controller().
- *
- * You can also use spi_alloc_device() and spi_add_device() to use a two
- * stage registration sequence for each spi_device.  This gives the caller
- * some more control over the spi_device structure before it is registered,
- * but requires that caller to initialize fields that would otherwise
- * be defined using the board info.
  */
-extern struct spi_device *
-spi_alloc_device(struct spi_controller *ctlr);
-
-extern int
-spi_add_device(struct spi_device *spi);
-
 extern struct spi_device *
 spi_new_device(struct spi_controller *, struct spi_board_info *);
 
@@ -1500,23 +1464,6 @@ spi_transfer_is_last(struct spi_controller *ctlr, struct spi_transfer *xfer)
 	return list_is_last(&xfer->transfer_list, &ctlr->cur_msg->transfers);
 }
 
-/* OF support code */
-#if IS_ENABLED(CONFIG_OF)
-
-/* must call put_device() when done with returned spi_device device */
-extern struct spi_device *
-of_find_spi_device_by_node(struct device_node *node);
-
-#else
-
-static inline struct spi_device *
-of_find_spi_device_by_node(struct device_node *node)
-{
-	return NULL;
-}
-
-#endif /* IS_ENABLED(CONFIG_OF) */
-
 /* Compatibility layer */
 #define spi_master			spi_controller
 
-- 
2.30.2

