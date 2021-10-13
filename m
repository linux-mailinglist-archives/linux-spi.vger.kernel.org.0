Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD242BB7A
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 11:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbhJMJ3U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 05:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbhJMJ3U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 05:29:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50453C061570
        for <linux-spi@vger.kernel.org>; Wed, 13 Oct 2021 02:27:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maaXb-0002hu-M5; Wed, 13 Oct 2021 11:27:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maaXZ-0005KI-DW; Wed, 13 Oct 2021 11:27:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maaXZ-00075Y-CL; Wed, 13 Oct 2021 11:27:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] spi: Make spi_replaced_transfers private
Date:   Wed, 13 Oct 2021 11:27:11 +0200
Message-Id: <20211013092711.2672557-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=ymK2IBzqELL5gfIJ+sRiPwsYDtyxsH9Gx7tSw0OHwic=; m=9/kcDGPTMSjRuunucC051XyUlQuzioPNplqqgcRqRS0=; p=yg7DF1ZDJCHV/jauiV+RKxNpcQMKfG5HHFGZmtZXbXY=; g=679c092c5cce55df5e0e6f720f4e9ea1bcac2a91
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFmpmsACgkQwfwUeK3K7AnlsQf9Fkj 28N1aU1LOhuz4H8sX7/gQaIztV8u4bzO2KL7uESDoie1azivAjv1X1L4/Zzklh+7BTefdARBBcQ/Z isc5POXOA34gj+rA+lnDUb66yG1Ex0tDPctXUB76AjFKH3vrNTj5e9783VU2yP/7UCUAoquQw5+yO 0cHwOq2KPxZOMBDRhv3P3g9c85j4gyF6EsvMkYDg/658f6vQnh5xNuGXXnWXXnGKTcmnOxtM9J/Js 2oFBSPKr2YcPrpwsFsGdRInyjlVrCOeJ+eCIh02/MGMdigx/o21sQ9LERsYSTqes/L6GwR5QhGk6j TSMKDpH6impPlKITO/wvUhoGdyuOdEQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There are no users of struct spi_replaced_transfers and the
spi_replaced_release_t typedef apart from spi.c. So move their
definition there to not clutter the public namespace.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi.c       | 34 ++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h | 36 ------------------------------------
 2 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 50591de16e0f..e73498e6dee5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3115,6 +3115,40 @@ EXPORT_SYMBOL_GPL(spi_controller_resume);
 
 /* Core methods for spi_message alterations */
 
+struct spi_replaced_transfers;
+typedef void (*spi_replaced_release_t)(struct spi_controller *ctlr,
+				       struct spi_message *msg,
+				       struct spi_replaced_transfers *res);
+/**
+ * struct spi_replaced_transfers - structure describing the spi_transfer
+ *                                 replacements that have occurred
+ *                                 so that they can get reverted
+ * @release:            some extra release code to get executed prior to
+ *                      relasing this structure
+ * @extradata:          pointer to some extra data if requested or NULL
+ * @replaced_transfers: transfers that have been replaced and which need
+ *                      to get restored
+ * @replaced_after:     the transfer after which the @replaced_transfers
+ *                      are to get re-inserted
+ * @inserted:           number of transfers inserted
+ * @inserted_transfers: array of spi_transfers of array-size @inserted,
+ *                      that have been replacing replaced_transfers
+ *
+ * note: that @extradata will point to @inserted_transfers[@inserted]
+ * if some extra allocation is requested, so alignment will be the same
+ * as for spi_transfers
+ */
+struct spi_replaced_transfers {
+	spi_replaced_release_t release;
+	void *extradata;
+	struct list_head replaced_transfers;
+	struct list_head *replaced_after;
+	size_t inserted;
+	struct spi_transfer inserted_transfers[];
+};
+
+/*---------------------------------------------------------------------------*/
+
 static void __spi_replace_transfers_release(struct spi_controller *ctlr,
 					    struct spi_message *msg,
 					    void *res)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 29e21d49aafc..54fbec8acc20 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1144,42 +1144,6 @@ static inline bool spi_is_bpw_supported(struct spi_device *spi, u32 bpw)
 
 /*---------------------------------------------------------------------------*/
 
-/* SPI transfer replacement methods which make use of spi_res */
-
-struct spi_replaced_transfers;
-typedef void (*spi_replaced_release_t)(struct spi_controller *ctlr,
-				       struct spi_message *msg,
-				       struct spi_replaced_transfers *res);
-/**
- * struct spi_replaced_transfers - structure describing the spi_transfer
- *                                 replacements that have occurred
- *                                 so that they can get reverted
- * @release:            some extra release code to get executed prior to
- *                      relasing this structure
- * @extradata:          pointer to some extra data if requested or NULL
- * @replaced_transfers: transfers that have been replaced and which need
- *                      to get restored
- * @replaced_after:     the transfer after which the @replaced_transfers
- *                      are to get re-inserted
- * @inserted:           number of transfers inserted
- * @inserted_transfers: array of spi_transfers of array-size @inserted,
- *                      that have been replacing replaced_transfers
- *
- * note: that @extradata will point to @inserted_transfers[@inserted]
- * if some extra allocation is requested, so alignment will be the same
- * as for spi_transfers
- */
-struct spi_replaced_transfers {
-	spi_replaced_release_t release;
-	void *extradata;
-	struct list_head replaced_transfers;
-	struct list_head *replaced_after;
-	size_t inserted;
-	struct spi_transfer inserted_transfers[];
-};
-
-/*---------------------------------------------------------------------------*/
-
 /* SPI transfer transformation methods */
 
 extern int spi_split_transfers_maxsize(struct spi_controller *ctlr,

base-commit: da21fde0fdb393c2fbe0ae0735cc826cd55fd46f
-- 
2.30.2

