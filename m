Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CE82AA368
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgKGIOl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:14:41 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgKGIOk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736880; x=1636272880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iimtT32W5p5FAu0oxnrDsTs89ZbKIS+MLA+sDDXHho0=;
  b=AlfKQSOB0nl6s+Vn43T8y2By5q7ObpDW7cc1jnwoUxVudUMJ9OGQQ1C0
   fx+Ee+hhOp9PZZBLDQDbDFolDmENbKO2FaYlpdPG8gGsG7ksxRMFBPIcO
   6/gfqfcQUT+kQw7cj6XXOav9SZcLiyROEkKp1Rv/Z4SbAdHeykjhigzLK
   ReAqAD6YEFaP/5Aw7Q6JHUDOCQFhtJ4/Q2+Kh2Qifc5rNcYigcDntev6p
   9hD/jIML2hatiJZa0A68edqh1m7Vc9JUKrBEQJzSAvHoMwT9390cIqZ26
   piL0w7jpwFLUtna6KILI6mLEHeqyqBjARjfYwFwn05jqsJH6TACvWpHBD
   Q==;
IronPort-SDR: tWorPkRcsuYmTInPZA/eqTJ8XgkJKrCRDzjPi4SeavPDazcdnuvv3Su6rDj02HLek0gY3i4zvV
 24UaQ+fAW82DP8sCE/pklSTs06k1wyw4Si4Rtau05TwxPGYdrY12pXzzMRwBVKbChYFZ8I2uOD
 m5QNaVIqqCfIbiDa5K3PkGQGSzUT5yagw/AI2Mcs+nQ0yAddSuTRXjnDJSEcs0s+yTOpNpaatG
 4HiGDrQ20d/wo6/Ob0DkUymB+Ow5DEVUEEXkIbFsR4L4rTe4zuP2qb4LxGl0opeNKI911lb0vF
 eqo=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564370"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:14:39 +0800
IronPort-SDR: WmpOUFDwtsEumDBmWyt19gIy0P07g2NblpMmTpZL/Tq6kiXTHK9afCT9LVHbXsjtGpxX+rtnLg
 YNyAvytdRXXCx4TRQbImd4R4fHHlVKOo56kmNMHu9GfzsASrFz8jPazWFNyfK3KEtFMnK3kE8j
 o7YGPMhUQIRO2jz7Ydn7mq//rxGzrY264pZ1NUBVx1MWR6moMvwxPJNDrtIkFyZByKUM9KHLNi
 Dc/lGB47JidRspsVMPA6qKcE9PZxYzKMT3W1MO3hF50i0Vo10MJ17HNpAM6WiaEvZ0NR7pz1l4
 mumSAzTjyNfafVvLpY9xMtbu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:31 -0800
IronPort-SDR: RdOTi/aGVzzkQ1zw17EziNuHaTrqDthul70mDxDqzYbCrfwEko2QLEnKEMOuhG7qnWoWA/RawD
 yGW/gIESiRbw3laeubqdNRnuPkK0x1U74x+9SYn1JOKiinSA1LOE59YqR8vJZafV2TIMgF1AUS
 OQSQYzCAAWxNgJjEfO/jvbDRiffLcgtGIhz/oif0Ha72+/m6X9m+m6S6iK5wvdpFNvj9mDvrGq
 bPp0ctzPKEEaOsD8G52/kknK9kSMFhbVN3EyosMlpCTNhxeJTA9JUp1Hbk0SL6hqyOiNo+jyTr
 DLI=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:38 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 06/32] spi: dw: Add support for the Kendryte K210 SoC
Date:   Sat,  7 Nov 2020 17:13:54 +0900
Message-Id: <20201107081420.60325-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The DW SPI master of the Kendryte K210 RISC-V SoC uses the 32-bits
ctrlr0 register format. This SoC is also quite slow and gets significant
SD card performance improvements from using no-delay polled transfers.
Add the dw_spi_k210_init() function tied to the
"canaan,kendryte-k210-spi" compatible string to set the
DW_SPI_CAP_DFS_32 and DW_SPI_CAP_POLL_NODELAY DW SPI capability fields
for this SoC.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/spi/spi-dw-mmio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 3f1bc384cb45..a00def6c5b39 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -223,6 +223,14 @@ static int dw_spi_keembay_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int dw_spi_k210_init(struct platform_device *pdev,
+			    struct dw_spi_mmio *dwsmmio)
+{
+	dwsmmio->dws.caps = DW_SPI_CAP_DFS_32 | DW_SPI_CAP_POLL_NODELAY;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -340,6 +348,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
+	{ .compatible = "canaan,kendryte-k210-spi", .data = dw_spi_k210_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.28.0

