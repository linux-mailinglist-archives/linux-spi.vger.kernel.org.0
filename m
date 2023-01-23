Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7401E6775E7
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jan 2023 08:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjAWH6v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Jan 2023 02:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjAWH6p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Jan 2023 02:58:45 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A85113DB
        for <linux-spi@vger.kernel.org>; Sun, 22 Jan 2023 23:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=+rP+iJ7Bo+AhHbGLGRgw74tWH8m
        /Vv6r9swhNzKbF+0=; b=V8jwZ7Vpeb8REZ3UQesY9ewD0R82dMY5kZmfwK+3QKr
        /B67eMMPymDeYSn41fzLDAbZ9qbzabacf/nWQMtk2R/8Klb8Ddz1z2vhU40HyWwk
        GZ/zGfCWy2tod15pFa2889H4WfVLuulPP6OvoJHMtIi7ChV4EwqCkT59VeziuRXo
        =
Received: (qmail 2101998 invoked from network); 23 Jan 2023 08:58:39 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Jan 2023 08:58:39 +0100
X-UD-Smtp-Session: l3s3148p1@AORXxOnyyNEujnvx
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] spi: sh-msiof: drop support for R-Car H3 ES1.[01]
Date:   Mon, 23 Jan 2023 08:58:33 +0100
Message-Id: <20230123075833.50925-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

These revisions have HW issues and are only early engineering samples
used internally. We simply drop the MSIOF support for them.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

We got confirmation from Renesas for dropping ES1.* support.

 drivers/spi/spi-sh-msiof.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 9bca3d076f05..e3b249c71175 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sh_dma.h>
+#include <linux/sys_soc.h>
 
 #include <linux/spi/sh_msiof.h>
 #include <linux/spi/spi.h>
@@ -1257,8 +1258,15 @@ static void sh_msiof_release_dma(struct sh_msiof_spi_priv *p)
 	dma_release_channel(ctlr->dma_tx);
 }
 
+static const struct soc_device_attribute sh_msiof_blacklist[] = {
+	/* Those have HW issues */
+	{ .soc_id = "r8a7795", .revision = "ES1.[01]" },
+	{ /* Sentinel */ }
+};
+
 static int sh_msiof_spi_probe(struct platform_device *pdev)
 {
+	const struct soc_device_attribute *attr;
 	struct spi_controller *ctlr;
 	const struct sh_msiof_chipdata *chipdata;
 	struct sh_msiof_spi_info *info;
@@ -1267,6 +1275,10 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	int i;
 	int ret;
 
+	attr = soc_device_match(sh_msiof_blacklist);
+	if (attr)
+		return -ENOTSUPP;
+
 	chipdata = of_device_get_match_data(&pdev->dev);
 	if (chipdata) {
 		info = sh_msiof_spi_parse_dt(&pdev->dev);
-- 
2.30.2

