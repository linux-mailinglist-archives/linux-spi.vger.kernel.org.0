Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1252E151AB9
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 13:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgBDMrz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Feb 2020 07:47:55 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46100 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgBDMry (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Feb 2020 07:47:54 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 014Clr7U107986;
        Tue, 4 Feb 2020 06:47:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580820473;
        bh=mQCZ56GeD/3tr/WG68NSchk+aiHKPk6FFzzRhMK/FR0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fqWdR5BMsQRceELe4CUbe/csQ+Yrp1H8djm8A7O3Nf6U0iafcnWVcvbgsMuCsePbt
         Mz4r1j2W27NJzUCxWTOHVNM/uV3madKuuRTgAtYF9ngp4s1fJ44CAWVSce1iBC6yVV
         DRY1MtDocJUkIzjYfcopszozLjn2uCTCCyXxMK+k=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 014ClrGQ034537
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Feb 2020 06:47:53 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 4 Feb
 2020 06:47:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 4 Feb 2020 06:47:53 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 014ClgcZ095019;
        Tue, 4 Feb 2020 06:47:49 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] spi: spi-omap2-mcspi: Handle DMA size restriction on AM65x
Date:   Tue, 4 Feb 2020 18:18:15 +0530
Message-ID: <20200204124816.16735-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204124816.16735-1-vigneshr@ti.com>
References: <20200204124816.16735-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On AM654, McSPI can only support 4K - 1 bytes per transfer when DMA is
enabled. Therefore populate master->max_transfer_size callback to
inform client drivers of this restriction when DMA channels are
available.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c                 | 26 +++++++++++++++++++
 include/linux/platform_data/spi-omap2-mcspi.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 7e2292c11d12..e9bc9cf984d6 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -130,6 +130,7 @@ struct omap2_mcspi {
 	int			fifo_depth;
 	bool			slave_aborted;
 	unsigned int		pin_dir:1;
+	size_t			max_xfer_len;
 };
 
 struct omap2_mcspi_cs {
@@ -1305,6 +1306,18 @@ static bool omap2_mcspi_can_dma(struct spi_master *master,
 	return (xfer->len >= DMA_MIN_BYTES);
 }
 
+static size_t omap2_mcspi_max_xfer_size(struct spi_device *spi)
+{
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
+	struct omap2_mcspi_dma *mcspi_dma =
+		&mcspi->dma_channels[spi->chip_select];
+
+	if (mcspi->max_xfer_len && mcspi_dma->dma_rx)
+		return mcspi->max_xfer_len;
+
+	return SIZE_MAX;
+}
+
 static int omap2_mcspi_controller_setup(struct omap2_mcspi *mcspi)
 {
 	struct spi_master	*master = mcspi->master;
@@ -1373,6 +1386,11 @@ static struct omap2_mcspi_platform_config omap4_pdata = {
 	.regs_offset = OMAP4_MCSPI_REG_OFFSET,
 };
 
+static struct omap2_mcspi_platform_config am654_pdata = {
+	.regs_offset = OMAP4_MCSPI_REG_OFFSET,
+	.max_xfer_len = SZ_4K - 1,
+};
+
 static const struct of_device_id omap_mcspi_of_match[] = {
 	{
 		.compatible = "ti,omap2-mcspi",
@@ -1382,6 +1400,10 @@ static const struct of_device_id omap_mcspi_of_match[] = {
 		.compatible = "ti,omap4-mcspi",
 		.data = &omap4_pdata,
 	},
+	{
+		.compatible = "ti,am654-mcspi",
+		.data = &am654_pdata,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, omap_mcspi_of_match);
@@ -1439,6 +1461,10 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		mcspi->pin_dir = pdata->pin_dir;
 	}
 	regs_offset = pdata->regs_offset;
+	if (pdata->max_xfer_len) {
+		mcspi->max_xfer_len = pdata->max_xfer_len;
+		master->max_transfer_size = omap2_mcspi_max_xfer_size;
+	}
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mcspi->base = devm_ioremap_resource(&pdev->dev, r);
diff --git a/include/linux/platform_data/spi-omap2-mcspi.h b/include/linux/platform_data/spi-omap2-mcspi.h
index 0bf9fddb8306..3b400b1919a9 100644
--- a/include/linux/platform_data/spi-omap2-mcspi.h
+++ b/include/linux/platform_data/spi-omap2-mcspi.h
@@ -11,6 +11,7 @@ struct omap2_mcspi_platform_config {
 	unsigned short	num_cs;
 	unsigned int regs_offset;
 	unsigned int pin_dir:1;
+	size_t max_xfer_len;
 };
 
 struct omap2_mcspi_device_config {
-- 
2.25.0

