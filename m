Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9512007E5
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 13:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbgFSLcN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 07:32:13 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:58666 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbgFSLbt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Jun 2020 07:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592566308; x=1624102308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xnsFrORwOjtogo6UJal+A+gIzNwJELeloZHLPftY5EA=;
  b=0tpUJF+Oqk61xhXU188n8SWQlGqMKpzEEs7eypXe6Lkz4PTzI/QCTtIm
   FLRweNYMGUEHmK5Fq6+Xy3WTIfnuKxAQX2D1VB6DELUjjEvObsZ5K9kEX
   fGUvOtrx3i6H4UmrM0cEuYkYPUnqd6vdsNiklRmm8BxoLfCQtGmJO9XjB
   U/qFKhYD/Hg1cdYNIR5ILN4TS7frofHWKzCk4EfcFpnRWFeIPYF3MpLnf
   T/wGnaKNlED5A+orFj11MqPr10Xmphv4GTNvcKsI2WjFMoAHI0SeIVkNP
   a1uaBQncQr6bMj5wXxj2Ya8sSJgVof7fgj1LioGF9YgNt1VR8S6vX9R6L
   A==;
IronPort-SDR: jnSH7JQJRMUKjkOVpFNL6yCg2p1STeTL6ynffCgAqQrrmOzlUdOtnw2b5nrgcfHa3oEj3n89T4
 NB35CxhfSdupHaw/zLPfVHm6BjVl64jpieBsCT9LjstwjUpkkozlIXGkHfARkMISr7UlVJLPj8
 1miu95dar4uAb45MDe5U6ZtQWgxuJT9FiDhnfL5uPjHJOPWes6WVXDLRhb2jOfFJ+28nVdk6kb
 dXHeX05pBDj3eVuyB9FIR7dJWu+wfKI1lLv4b+1qbMzj9Khm3sZzwGNbIg81mPCNAYCEjiFjKs
 iwg=
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="84298540"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jun 2020 04:31:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 04:31:33 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 19 Jun 2020 04:31:30 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: [PATCH v2 3/6] spi: dw: Add Microchip Sparx5 support
Date:   Fri, 19 Jun 2020 13:31:18 +0200
Message-ID: <20200619113121.9984-4-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619113121.9984-1-lars.povlsen@microchip.com>
References: <20200619113121.9984-1-lars.povlsen@microchip.com>
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
   same controller (don't ask...). As each SPI slave is physically
   located on a particular bus, they must be configured
   accordingly. The microchip,spi-interface2 property is used for
   this. Switching between busses also requires specific
   handling/timing.

 * The CS override is controlled by a new set of registers for
   this purpose.

 * The Sparx5 SPI controller has the RX sample delay register, and it
   must be configured for the (SPI NAND) device on SPI2.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/spi/spi-dw-mmio.c | 113 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 403403deae664..78241d93289f5 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -20,6 +20,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/bitfield.h>
 
 #include "spi-dw.h"
 
@@ -41,6 +42,12 @@ struct dw_spi_mmio {
 #define MSCC_IF_SI_OWNER_SIBM			1
 #define MSCC_IF_SI_OWNER_SIMC			2
 
+#define SPARX5_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x88
+#define SPARX5_IF_SI_OWNER			GENMASK(7, 6)
+#define SPARX5_IF_SI2_OWNER			GENMASK(5, 4)
+#define SPARX5_FORCE_ENA			0xa4
+#define SPARX5_FORCE_VAL			0xa8
+
 #define MSCC_SPI_MST_SW_MODE			0x14
 #define MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE	BIT(13)
 #define MSCC_SPI_MST_SW_MODE_SW_SPI_CS(x)	(x << 5)
@@ -54,7 +61,8 @@ struct dw_spi_mmio {
 
 struct dw_spi_mscc {
 	struct regmap       *syscon;
-	void __iomem        *spi_mst;
+	void __iomem        *spi_mst; /* Not sparx5 */
+	u32		    if2mask;  /* sparx5 only */
 };
 
 /*
@@ -134,6 +142,108 @@ static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
 				JAGUAR2_IF_SI_OWNER_OFFSET);
 }
 
+/*
+ * Set the owner of the SPI interface
+ */
+static void dw_spi_sparx5_set_owner(struct regmap *syscon,
+				    u8 owner, u8 owner2)
+{
+	u32 val, msk;
+
+	val = FIELD_PREP(SPARX5_IF_SI_OWNER, owner) |
+		FIELD_PREP(SPARX5_IF_SI2_OWNER, owner2);
+	msk = SPARX5_IF_SI_OWNER | SPARX5_IF_SI2_OWNER;
+	regmap_update_bits(syscon,
+			   SPARX5_CPU_SYSTEM_CTRL_GENERAL_CTRL,
+			   msk, val);
+}
+
+static void dw_spi_sparx5_set_cs_owner(struct dw_spi_mmio *dwsmmio,
+				       u8 cs, u8 owner)
+{
+	struct dw_spi_mscc *dwsmscc = dwsmmio->priv;
+	u8 other = (owner == MSCC_IF_SI_OWNER_SIBM ?
+		    MSCC_IF_SI_OWNER_SIMC : MSCC_IF_SI_OWNER_SIBM);
+	if (dwsmscc->if2mask & BIT(cs))
+		/* SPI2 */
+		dw_spi_sparx5_set_owner(dwsmscc->syscon, other, owner);
+	else
+		/* SPI1 */
+		dw_spi_sparx5_set_owner(dwsmscc->syscon, owner, other);
+}
+
+/*
+ * The Designware SPI controller (referred to as master in the
+ * documentation) automatically deasserts chip select when the tx fifo
+ * is empty. The chip selects then needs to be driven by a CS override
+ * register. enable is an active low signal.
+ */
+static void dw_spi_sparx5_set_cs(struct spi_device *spi, bool nEnable)
+{
+	struct dw_spi *dws = spi_master_get_devdata(spi->master);
+	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
+	struct dw_spi_mscc *dwsmscc = dwsmmio->priv;
+	u8 cs = spi->chip_select;
+
+	if (!nEnable)
+		dw_spi_sparx5_set_cs_owner(dwsmmio, cs,
+					   MSCC_IF_SI_OWNER_SIMC);
+
+	if (!nEnable) {
+		/* Ensure CS toggles, so start off all disabled */
+		regmap_write(dwsmscc->syscon, SPARX5_FORCE_VAL, ~0);
+		/* CS override drive enable */
+		regmap_write(dwsmscc->syscon, SPARX5_FORCE_ENA, 1);
+		/* Allow settle */
+		udelay(1);
+		/* Now set CSx enabled */
+		regmap_write(dwsmscc->syscon, SPARX5_FORCE_VAL, ~BIT(cs));
+	} else {
+		/* CS value */
+		regmap_write(dwsmscc->syscon, SPARX5_FORCE_VAL, ~0);
+		/* CS override drive disable */
+		regmap_write(dwsmscc->syscon, SPARX5_FORCE_ENA, 0);
+	}
+
+	dw_spi_set_cs(spi, nEnable);
+}
+
+static int dw_spi_mscc_sparx5_init(struct platform_device *pdev,
+				   struct dw_spi_mmio *dwsmmio)
+{
+	const char *syscon_name = "microchip,sparx5-cpu-syscon";
+	struct dw_spi_mscc *dwsmscc;
+	struct device_node *nc;
+
+	dwsmscc = devm_kzalloc(&pdev->dev, sizeof(*dwsmscc), GFP_KERNEL);
+	if (!dwsmscc)
+		return -ENOMEM;
+
+	dwsmscc->syscon =
+		syscon_regmap_lookup_by_compatible(syscon_name);
+	if (IS_ERR(dwsmscc->syscon)) {
+		dev_err(&pdev->dev, "No syscon map %s\n", syscon_name);
+		return PTR_ERR(dwsmscc->syscon);
+	}
+
+	/* SPI2 mapping bitmask */
+	for_each_available_child_of_node(pdev->dev.of_node, nc) {
+		u32 cs;
+
+		if (of_property_read_u32(nc, "reg", &cs) == 0 &&
+		    of_property_read_bool(nc, "microchip,spi-interface2"))
+			dwsmscc->if2mask |= BIT(cs);
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
@@ -297,6 +407,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_dw_apb_init},
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
+	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.27.0

