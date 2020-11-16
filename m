Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894242B527C
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 21:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgKPU0U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 15:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732478AbgKPU0U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 15:26:20 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BA7C0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 12:26:20 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id v143so18256856qkb.2
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Mbu12453EhW7kXBeiAhJcr1Rijn44Lye6C+HfVUBCFs=;
        b=IigKCraQlgN+AKl54OxAluWmDkKEDCaKHYpSau0ZozgOxQtaT5uSOO5aEDzUqZ5dK6
         9rUEmSKLwbFPR1BeEirx5WkPtaNeDDOG2qdKnW7+leFRc9khnKKkwezkpAkB7mvw2rMR
         Ascr+wJOjFim5i8BeZKb4+nZa/atICuSBRRvK38jKpzeXJp1YwypZ4rl0agxktHVS0UY
         nbBv2MFO5slBsBtFM/6qlw1ALL+qYUNcDQnEi4vIiw5qp6kRMbBRu89YBX24bbCM76Xv
         QuUg/fg2pqmC6sZHZ3Ie9Xp7Jb/FjxlXffq+kDgOOmbfPyW5UFqXlNZumBZK5zgxzvNr
         jl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mbu12453EhW7kXBeiAhJcr1Rijn44Lye6C+HfVUBCFs=;
        b=SuCA6JwrwBWJHNODVkj9Rn6hQrS7lwJfEaEM52i5mmEgcHpXY+jEiOQ8Jwl6iPoaAZ
         ZjbFDAnJgkWhqOxoMSHjIYmwfA2gohhnY37M4EM1S2kxh8/6AONPZA6SwjiRosoH8zlU
         36BxGsGCagLA+3JnhytNWN+5DwFIVE2yRmddpi8Qc7N01O70/mJrHkwhMRfQKnfl+mXD
         p/ChTSoESFgOaF5dYnJOy8SSibE8BJBQFp+i8lgnEeTFAMKhCcgS89+9NTRoB2gNANTV
         HJV2m6ESQdwJODH4Mv/jTG/uzqE9OqSVNBbZMOCyrJo4KQoTEvKsS48X71+5ZPFjXcQb
         gCiw==
X-Gm-Message-State: AOAM533TN3Kk60BJWLf3z7nhNozEM8jYr8aBBpUlYjPqjC99zFkbWySt
        Q13SJsKHXGIEGMHDkRtyGaaTjOKe5erKBA==
X-Google-Smtp-Source: ABdhPJy0cM7MGFCzomTpZyWRGKxYtZLxppcOB76Rg+PQ1NgKEOq591er3xizHbP3ATrW+N4r4PVspA==
X-Received: by 2002:a37:b545:: with SMTP id e66mr16182932qkf.392.1605558379585;
        Mon, 16 Nov 2020 12:26:19 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:997:213a:a240:fc07:36c8])
        by smtp.gmail.com with ESMTPSA id d188sm13594779qkb.10.2020.11.16.12.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 12:26:18 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     shawnguo@kernel.org, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] spi: imx: Remove unused .id_table support
Date:   Mon, 16 Nov 2020 17:26:06 -0300
Message-Id: <20201116202606.29888-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since 5.10-rc1 i.MX is a devicetree-only platform and the existing
.id_table support in this driver was only useful for old non-devicetree
platforms.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/spi/spi-imx.c | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 8911465d8f47..7513ef552d79 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1019,33 +1019,6 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.devtype = IMX53_ECSPI,
 };
 
-static const struct platform_device_id spi_imx_devtype[] = {
-	{
-		.name = "imx1-cspi",
-		.driver_data = (kernel_ulong_t) &imx1_cspi_devtype_data,
-	}, {
-		.name = "imx21-cspi",
-		.driver_data = (kernel_ulong_t) &imx21_cspi_devtype_data,
-	}, {
-		.name = "imx27-cspi",
-		.driver_data = (kernel_ulong_t) &imx27_cspi_devtype_data,
-	}, {
-		.name = "imx31-cspi",
-		.driver_data = (kernel_ulong_t) &imx31_cspi_devtype_data,
-	}, {
-		.name = "imx35-cspi",
-		.driver_data = (kernel_ulong_t) &imx35_cspi_devtype_data,
-	}, {
-		.name = "imx51-ecspi",
-		.driver_data = (kernel_ulong_t) &imx51_ecspi_devtype_data,
-	}, {
-		.name = "imx53-ecspi",
-		.driver_data = (kernel_ulong_t) &imx53_ecspi_devtype_data,
-	}, {
-		/* sentinel */
-	}
-};
-
 static const struct of_device_id spi_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx1-cspi", .data = &imx1_cspi_devtype_data, },
 	{ .compatible = "fsl,imx21-cspi", .data = &imx21_cspi_devtype_data, },
@@ -1581,8 +1554,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
 	int ret, irq, spi_drctl;
-	const struct spi_imx_devtype_data *devtype_data = of_id ? of_id->data :
-		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
+	const struct spi_imx_devtype_data *devtype_data = of_id->data;
 	bool slave_mode;
 	u32 val;
 
@@ -1823,7 +1795,6 @@ static struct platform_driver spi_imx_driver = {
 		   .of_match_table = spi_imx_dt_ids,
 		   .pm = &imx_spi_pm,
 	},
-	.id_table = spi_imx_devtype,
 	.probe = spi_imx_probe,
 	.remove = spi_imx_remove,
 };
-- 
2.17.1

