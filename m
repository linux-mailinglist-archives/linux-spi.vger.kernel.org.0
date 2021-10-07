Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B1F4252CE
	for <lists+linux-spi@lfdr.de>; Thu,  7 Oct 2021 14:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbhJGMQT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Oct 2021 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241222AbhJGMQR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Oct 2021 08:16:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CF1C061760
        for <linux-spi@vger.kernel.org>; Thu,  7 Oct 2021 05:14:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYSI2-0007I8-4x; Thu, 07 Oct 2021 14:14:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYSI1-00061z-AT; Thu, 07 Oct 2021 14:14:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mYSI1-0006pk-9k; Thu, 07 Oct 2021 14:14:21 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/4] spi: Reorder functions to simplify the next commit
Date:   Thu,  7 Oct 2021 14:14:14 +0200
Message-Id: <20211007121415.2401638-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007121415.2401638-1-u.kleine-koenig@pengutronix.de>
References: <20211007121415.2401638-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=N41G5pjtUlhIoCSNa6Je7b/4oqqYc4UTf1RSWMpcUEA=; m=951182nalSvbvc34cHG9ctMHe6fioYmlV2Z4c+IBEsA=; p=cz5I2r/50JiZjU21PYZ/GxwkXfj1xNtApLoH2Q+GbWA=; g=33cff67682f56c48c439b6742c619577ec9b0093
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFe5JEACgkQwfwUeK3K7AlCGgf+PuH GPDryV+Q8kXUQGAy7Y4TW3+D7qF0vc59KKYlqMVXPxMaO/zaBi7zpsNy9B5R6x8Cu3/x9S5eCUN4q TTq16Y76W6sZ4E0+8LudsaI0r5iKfSw8nXHGut+sbMgfYWcCWpi+FIMLmWUd6cjR4fxID1mC6+o0P a3PpyPqnhcAmF2HFPioXpUCjG3eAxwqfdOqsAecP9R8fb/d3+qonWbKxuj3UcucegxrVZikZYLIdT T7dcdW0+jCxRWrIoIRT88c+EW5+yaF3GFJPkhOm0h/M12pLz+Xa1J0k0pRpW/oxgJyKkQEyoFYdWk nTk66rHUoEbupSXGZVFyMCq354Mq/8g==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently the "Core methods for SPI resource management" are exported
and public functions. They are however only used in drivers/spi/spi.c.
To allow to drop the global declarations and not to have to insert local
ones instead, move them before their users.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi.c | 172 +++++++++++++++++++++++-----------------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cc4ac42aa93d..397643104576 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -817,6 +817,92 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 
 /*-------------------------------------------------------------------------*/
 
+/* Core methods for SPI resource management */
+
+/**
+ * spi_res_alloc - allocate a spi resource that is life-cycle managed
+ *                 during the processing of a spi_message while using
+ *                 spi_transfer_one
+ * @spi:     the spi device for which we allocate memory
+ * @release: the release code to execute for this resource
+ * @size:    size to alloc and return
+ * @gfp:     GFP allocation flags
+ *
+ * Return: the pointer to the allocated data
+ *
+ * This may get enhanced in the future to allocate from a memory pool
+ * of the @spi_device or @spi_controller to avoid repeated allocations.
+ */
+void *spi_res_alloc(struct spi_device *spi,
+		    spi_res_release_t release,
+		    size_t size, gfp_t gfp)
+{
+	struct spi_res *sres;
+
+	sres = kzalloc(sizeof(*sres) + size, gfp);
+	if (!sres)
+		return NULL;
+
+	INIT_LIST_HEAD(&sres->entry);
+	sres->release = release;
+
+	return sres->data;
+}
+EXPORT_SYMBOL_GPL(spi_res_alloc);
+
+/**
+ * spi_res_free - free an spi resource
+ * @res: pointer to the custom data of a resource
+ *
+ */
+void spi_res_free(void *res)
+{
+	struct spi_res *sres = container_of(res, struct spi_res, data);
+
+	if (!res)
+		return;
+
+	WARN_ON(!list_empty(&sres->entry));
+	kfree(sres);
+}
+EXPORT_SYMBOL_GPL(spi_res_free);
+
+/**
+ * spi_res_add - add a spi_res to the spi_message
+ * @message: the spi message
+ * @res:     the spi_resource
+ */
+void spi_res_add(struct spi_message *message, void *res)
+{
+	struct spi_res *sres = container_of(res, struct spi_res, data);
+
+	WARN_ON(!list_empty(&sres->entry));
+	list_add_tail(&sres->entry, &message->resources);
+}
+EXPORT_SYMBOL_GPL(spi_res_add);
+
+/**
+ * spi_res_release - release all spi resources for this message
+ * @ctlr:  the @spi_controller
+ * @message: the @spi_message
+ */
+void spi_res_release(struct spi_controller *ctlr, struct spi_message *message)
+{
+	struct spi_res *res, *tmp;
+
+	list_for_each_entry_safe_reverse(res, tmp, &message->resources, entry) {
+		if (res->release)
+			res->release(ctlr, message, res->data);
+
+		list_del(&res->entry);
+
+		kfree(res);
+	}
+}
+EXPORT_SYMBOL_GPL(spi_res_release);
+
+/*-------------------------------------------------------------------------*/
+
 static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 {
 	bool activate = enable;
@@ -3035,92 +3121,6 @@ EXPORT_SYMBOL_GPL(spi_controller_resume);
 
 /*-------------------------------------------------------------------------*/
 
-/* Core methods for SPI resource management */
-
-/**
- * spi_res_alloc - allocate a spi resource that is life-cycle managed
- *                 during the processing of a spi_message while using
- *                 spi_transfer_one
- * @spi:     the spi device for which we allocate memory
- * @release: the release code to execute for this resource
- * @size:    size to alloc and return
- * @gfp:     GFP allocation flags
- *
- * Return: the pointer to the allocated data
- *
- * This may get enhanced in the future to allocate from a memory pool
- * of the @spi_device or @spi_controller to avoid repeated allocations.
- */
-void *spi_res_alloc(struct spi_device *spi,
-		    spi_res_release_t release,
-		    size_t size, gfp_t gfp)
-{
-	struct spi_res *sres;
-
-	sres = kzalloc(sizeof(*sres) + size, gfp);
-	if (!sres)
-		return NULL;
-
-	INIT_LIST_HEAD(&sres->entry);
-	sres->release = release;
-
-	return sres->data;
-}
-EXPORT_SYMBOL_GPL(spi_res_alloc);
-
-/**
- * spi_res_free - free an spi resource
- * @res: pointer to the custom data of a resource
- *
- */
-void spi_res_free(void *res)
-{
-	struct spi_res *sres = container_of(res, struct spi_res, data);
-
-	if (!res)
-		return;
-
-	WARN_ON(!list_empty(&sres->entry));
-	kfree(sres);
-}
-EXPORT_SYMBOL_GPL(spi_res_free);
-
-/**
- * spi_res_add - add a spi_res to the spi_message
- * @message: the spi message
- * @res:     the spi_resource
- */
-void spi_res_add(struct spi_message *message, void *res)
-{
-	struct spi_res *sres = container_of(res, struct spi_res, data);
-
-	WARN_ON(!list_empty(&sres->entry));
-	list_add_tail(&sres->entry, &message->resources);
-}
-EXPORT_SYMBOL_GPL(spi_res_add);
-
-/**
- * spi_res_release - release all spi resources for this message
- * @ctlr:  the @spi_controller
- * @message: the @spi_message
- */
-void spi_res_release(struct spi_controller *ctlr, struct spi_message *message)
-{
-	struct spi_res *res, *tmp;
-
-	list_for_each_entry_safe_reverse(res, tmp, &message->resources, entry) {
-		if (res->release)
-			res->release(ctlr, message, res->data);
-
-		list_del(&res->entry);
-
-		kfree(res);
-	}
-}
-EXPORT_SYMBOL_GPL(spi_res_release);
-
-/*-------------------------------------------------------------------------*/
-
 /* Core methods for spi_message alterations */
 
 static void __spi_replace_transfers_release(struct spi_controller *ctlr,
-- 
2.30.2

