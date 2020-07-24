Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5D422C423
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jul 2020 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgGXLOa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Jul 2020 07:14:30 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:42583 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgGXLO3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Jul 2020 07:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595589269; x=1627125269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iDLXHtKYHwzP+ugjc/80wOTrIdFuuALsdc6ntIleReo=;
  b=Ew7x2spQ4OUselFgvNxCqJV15EaC6DMq+jL4YMQH5uonOIY1Kp583FOC
   tPt5pmmmk2ym7xJAiw438fInfyH7r9WF/1R2/kbpKkI2zfTHDPlIrKmz7
   xdM4szhLfBs9ZrhSwt5fO2ybg5d64bhBoK0lO/k0VC2AMM8a/r5Unx5EB
   NhgzFt4WKtuVhoV8UL9SPjaoTRzoEnGEnyMarCoIkJ22GiAGiBpBm7xw4
   C4nchTBeLQRmlg7EHfUmnn8ApwZiqNDzW5hQ/QZAtALf0UX/UreKAhhqF
   dBuFP5eijBiT1/X3IuC4KVMljJUiJfSyryGyAmmN7TW8Z3uO8Rc+SdSFy
   Q==;
IronPort-SDR: 4xykpNO1RplJvK1pWaeXhZPvN8FqR90tzfj9cDg1WTqr8Jy0z8SdWLrAs0DIiBL7JwMQHlJDEV
 BJ0F6NSLnlF9zidPz0veiaACE58sZwqPf6nTFVDxxT6qkPkSMbEOhUkaa8SohiJbRr27QtOppR
 WaN20KsEO8DwlunCTMtiXyjKCHc3e655MvyQUiPFBxA94NKhUmvDPm1gTX0W30waEgieEjj2mo
 BhwTWPsRBLxUijj+52xiNzsth6Gn7gskid2aEd97GRiWmiNF6Vhbx3CMN6IhxFHvsJa3SKyy4b
 Q9s=
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="84468704"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2020 04:14:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 24 Jul 2020 04:13:45 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 24 Jul 2020 04:13:46 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v4 2/6] spi: dw: Add Microchip Sparx5 support
Date:   Fri, 24 Jul 2020 13:14:00 +0200
Message-ID: <20200724111404.13293-3-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724111404.13293-1-lars.povlsen@microchip.com>
References: <20200724111404.13293-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This adds SPI support for the Sparx5 SoC, which is using the MMIO
Designware SPI controller.

The Sparx5 differs from the Ocelot version in these areas:

 * The CS override is controlled by a new set of registers for
   this purpose.

 * The Sparx5 SPI controller has the RX sample delay register, and it
   must be configured for the (SPI NAND) device on SPI2.

 * The Sparx5 SPI controller has 2 different SPI bus interfaces on the
   same controller (don't ask...). The "spi-mux" driver should be used
   in conjunction with the SPI driver to select the appropriate bus.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/spi/spi-dw-mmio.c | 70 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 403403deae664..18772c0c92206 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -45,6 +45,9 @@ struct dw_spi_mmio {
 #define MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE	BIT(13)
 #define MSCC_SPI_MST_SW_MODE_SW_SPI_CS(x)	(x << 5)
 
+#define SPARX5_FORCE_ENA			0xa4
+#define SPARX5_FORCE_VAL			0xa8
+
 /*
  * For Keem Bay, CTRLR0[31] is used to select controller mode.
  * 0: SSI is slave
@@ -54,7 +57,7 @@ struct dw_spi_mmio {
 
 struct dw_spi_mscc {
 	struct regmap       *syscon;
-	void __iomem        *spi_mst;
+	void __iomem        *spi_mst; /* Not sparx5 */
 };
 
 /*
@@ -134,6 +137,70 @@ static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
 				JAGUAR2_IF_SI_OWNER_OFFSET);
 }
 
+/*
+ * The Designware SPI controller (referred to as master in the
+ * documentation) automatically deasserts chip select when the tx fifo
+ * is empty. The chip selects then needs to be driven by a CS override
+ * register. enable is an active low signal.
+ */
+static void dw_spi_sparx5_set_cs(struct spi_device *spi, bool enable)
+{
+	struct dw_spi *dws = spi_master_get_devdata(spi->master);
+	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
+	struct dw_spi_mscc *dwsmscc = dwsmmio->priv;
+	u8 cs = spi->chip_select;
+
+	if (!enable) {
+		/* CS override drive enable */
+		regmap_write(dwsmscc->syscon, SPARX5_FORCE_ENA, 1);
+		/* Now set CSx enabled */
+		regmap_write(dwsmscc->syscon, SPARX5_FORCE_VAL, ~BIT(cs));
+		/* Allow settle */
+		usleep_range(1, 5);
+	} else {
+		/* CS value */
+		regmap_write(dwsmscc->syscon, SPARX5_FORCE_VAL, ~0);
+		/* Allow settle */
+		usleep_range(1, 5);
+		/* CS override drive disable */
+		regmap_write(dwsmscc->syscon, SPARX5_FORCE_ENA, 0);
+	}
+
+	dw_spi_set_cs(spi, enable);
+}
+
+static int dw_spi_mscc_sparx5_init(struct platform_device *pdev,
+				   struct dw_spi_mmio *dwsmmio)
+{
+	const char *syscon_name = "microchip,sparx5-cpu-syscon";
+	struct device *dev = &pdev->dev;
+	struct dw_spi_mscc *dwsmscc;
+
+	if (!IS_ENABLED(CONFIG_SPI_MUX)) {
+		dev_err(dev, "This driver needs CONFIG_SPI_MUX\n");
+		return -EOPNOTSUPP;
+	}
+
+	dwsmscc = devm_kzalloc(dev, sizeof(*dwsmscc), GFP_KERNEL);
+	if (!dwsmscc)
+		return -ENOMEM;
+
+	dwsmscc->syscon =
+		syscon_regmap_lookup_by_compatible(syscon_name);
+	if (IS_ERR(dwsmscc->syscon)) {
+		dev_err(dev, "No syscon map %s\n", syscon_name);
+		return PTR_ERR(dwsmscc->syscon);
+	}
+
+	dwsmmio->dws.set_cs = dw_spi_sparx5_set_cs;
+	dwsmmio->priv = dwsmscc;
+
+	/* Register hook to configure CTRLR0 */
+	dwsmmio->dws.update_cr0 = dw_spi_update_cr0;
+
+	return 0;
+}
+
 static int dw_spi_alpine_init(struct platform_device *pdev,
 			      struct dw_spi_mmio *dwsmmio)
 {
@@ -297,6 +364,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_dw_apb_init},
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
+	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.27.0

