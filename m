Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941DA2120BF
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 12:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgGBKOs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 06:14:48 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:18722 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgGBKO2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jul 2020 06:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593684868; x=1625220868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XQYsjl64zP8M+z5DPL3i21yoQTL0J6GAeocWD3p/Y0U=;
  b=XI8MSDB/vTLuOB6l7WaDKKti/tG8kNs29NTAkFqHfxJHNCBcTtzQUTJt
   shnFzMiyCetYH0Zl8fYrWvgszDcnGliKIHciSzWGm5GxCiLEukE3N3zP+
   SMah+UpDi34LhUBtg94Es/XVZd7ygRPvszqidFEZkTsRkMAz2lEXqAxI3
   giM4d0yIlS1Klx4o5+VM+DvJ150ngp+WK687RWLMffvFBSgYOEYZbWoMM
   FXZjMiyVXM/EvMEVEnQN6u0j9XcNx3v/O818I0jFfLj9Ny+Ccmib5LuVf
   XHhwsA/EVFkDIEhPXj8lwMw1mc9ggTUIDIn/XfCrdtR4TaBIUHn2laMTx
   g==;
IronPort-SDR: gZLwhB/KpHp6yFCVGg8pOL49wT1aT8GDV+EC8V+Br/gL4/h6AN7twm396y8TBd3uObNh4u1ket
 +bUjAgMRWpdUp4dupiTdV0h81KkcQjf65ADFWpOr4rVKryhoWX45t+ftjW3O+PmBzYoSsycDbL
 vfHomF7lpxpq9QpfhYrypTlzp6xWc5UCrX7px8f38CttkHzZ0kk+FNAlGdl1/psXG22SVNBV24
 oibG7Ze/vwap8GNEyo6pBc1D5+ixDvahygHBZiEOJP7Bv5RD2Pu1/9SMIYBqWC76AAw9PkVsZ/
 qFY=
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="82369319"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 03:14:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 03:13:59 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 2 Jul 2020 03:13:57 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v3 3/8] spi: dw: Add Microchip Sparx5 support
Date:   Thu, 2 Jul 2020 12:13:26 +0200
Message-ID: <20200702101331.26375-4-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702101331.26375-1-lars.povlsen@microchip.com>
References: <20200702101331.26375-1-lars.povlsen@microchip.com>
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

 * The Sparx5 SPI controller has 2 different SPI bus interfaces on the
   same controller (don't ask...). The "mux-controls" property must be
   set, and the mux should be configured with the bus/device mapping
   information.

 * The CS override is controlled by a new set of registers for
   this purpose.

 * The Sparx5 SPI controller has the RX sample delay register, and it
   must be configured for the (SPI NAND) device on SPI2.

As Sparx5 requires CONFIG_MULTIPLEXER, this will automatically be
enabled when this driver is selected.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/spi/Kconfig       |  1 +
 drivers/spi/spi-dw-mmio.c | 79 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8f1f8fca79e37..2bc2d42b25120 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -237,6 +237,7 @@ config SPI_DW_PCI
 
 config SPI_DW_MMIO
 	tristate "Memory-mapped io interface driver for DW SPI core"
+	select MULTIPLEXER
 	depends on HAS_IOMEM
 
 endif
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 403403deae664..05bc09be4a8bd 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -20,6 +20,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/mux/consumer.h>
 
 #include "spi-dw.h"
 
@@ -45,6 +46,9 @@ struct dw_spi_mmio {
 #define MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE	BIT(13)
 #define MSCC_SPI_MST_SW_MODE_SW_SPI_CS(x)	(x << 5)
 
+#define SPARX5_FORCE_ENA			0xa4
+#define SPARX5_FORCE_VAL			0xa8
+
 /*
  * For Keem Bay, CTRLR0[31] is used to select controller mode.
  * 0: SSI is slave
@@ -54,7 +58,8 @@ struct dw_spi_mmio {
 
 struct dw_spi_mscc {
 	struct regmap       *syscon;
-	void __iomem        *spi_mst;
+	void __iomem        *spi_mst; /* Not sparx5 */
+	struct mux_control  *spi_mux; /* Sparx5 bus interface */
 };
 
 /*
@@ -134,6 +139,77 @@ static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
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
+		/* Drive mux */
+		if (mux_control_select(dwsmscc->spi_mux, cs))
+			dev_err(&spi->dev, "Unable to drive SPI mux\n");
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
+		/* Deselect mux */
+		mux_control_deselect(dwsmscc->spi_mux);
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
+	/* Get SPI mux */
+	dwsmscc->spi_mux = devm_mux_control_get(dev, NULL);
+	if (IS_ERR(dwsmscc->spi_mux)) {
+		dev_err(dev, "SPI mux is required\n");
+		return PTR_ERR(dwsmscc->spi_mux);
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
@@ -297,6 +373,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_dw_apb_init},
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
+	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.27.0

