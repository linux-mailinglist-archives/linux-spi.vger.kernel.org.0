Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247BA1D16B9
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 16:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388826AbgEMOBA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 10:01:00 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:48473 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388815AbgEMOA7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 10:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589378458; x=1620914458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DD4LaygJ0MQ0zaaJOlyQ+qY2g/ubHGxZEC346Rx98Bw=;
  b=AEP4/mP4HbTp4RqhFC7cIa+vVRb5hVpdkLzIG1Cn1E2ynRdqJ0A18v8v
   pmee+I/n9uPXII4Ixo1hr+V0DhcIMx4PshAIMjcS7VDZUPhm5BoOPQW6q
   kbd7EZKjuDBHB/uak3Y+rZTAqOmODAhbPzZpb3rbbkmBlDb1ZLfu4S3iq
   3hgDIUbojqoa4QLEqjz4iD4GLvU5mOZ7A1x9/KCt5KviBH3loK6DzaGGH
   i/nBdf+MMwMvUBO2s+73vrEbX/XvlrfI0NCsue2mZAkpy0gfC6q5dA6BE
   LZN63mFv11+h3KrHYm+3borLUcCKOjjjuLb34CPNMtv+qYfHfhwyO2gE4
   w==;
IronPort-SDR: Gdiuw+xCaXFKEgjuCPbTKtA4QIfkMfKZcyb5vkMlHX1E1wru1WWewHF6r2LSZdNZOpQhM/EiP5
 RkLef45i8bUb9KJBnRkJd4nrZF9zsSEoYlN8OyWv6F3OI+/NdfHxmKWHKrQyZAFS1ul4k0sNgp
 fDU6dbf2vhUdMp927ZQwUd3PMHEGImVv1JIy52OeZZMfIOtt9Pcy+E1/UQD94ddmtVszhvgf6J
 ILIbRL6ZUK5lGmu7kOfrv+ZjI8VgYXfVBuP9ugc47KKhLbErXlyBRh2hkr/WGM2hJ38uNcrFIZ
 mtA=
X-IronPort-AV: E=Sophos;i="5.73,388,1583218800"; 
   d="scan'208";a="79447574"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 07:00:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 07:01:00 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 07:00:55 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 07/10] spi: spi-dw-mchp: Add Sparx5 support
Date:   Wed, 13 May 2020 16:00:28 +0200
Message-ID: <20200513140031.25633-8-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513140031.25633-1-lars.povlsen@microchip.com>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This adds support for the Sparx5 SoC in the spi-dw-mchp SPI controller.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/spi/spi-dw-mchp.c | 211 ++++++++++++++++++++++++++++++++++----
 1 file changed, 189 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-dw-mchp.c b/drivers/spi/spi-dw-mchp.c
index 0828a7616d9ab..3abdd44a550ea 100644
--- a/drivers/spi/spi-dw-mchp.c
+++ b/drivers/spi/spi-dw-mchp.c
@@ -28,21 +28,22 @@

 #define MAX_CS		4

-#define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
-#define OCELOT_IF_SI_OWNER_OFFSET		4
-#define JAGUAR2_IF_SI_OWNER_OFFSET		6
 #define MSCC_IF_SI_OWNER_MASK			GENMASK(1, 0)
 #define MSCC_IF_SI_OWNER_SISL			0
 #define MSCC_IF_SI_OWNER_SIBM			1
 #define MSCC_IF_SI_OWNER_SIMC			2

 #define MSCC_SPI_MST_SW_MODE			0x14
-#define MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE	BIT(13)
-#define MSCC_SPI_MST_SW_MODE_SW_SPI_CS(x)	(x << 5)

 struct dw_spi_mchp_props {
 	const char *syscon_name;
-	u32 si_owner_bit;
+	u32 general_ctrl_off;
+	u32 si_owner_bit, si_owner2_bit;
+	u32 pinctrl_bit_off;
+	u32 cs_bit_off;
+	u32 ss_force_ena_off;
+	u32 ss_force_val_off;
+	u32 bootmaster_cs;
 };

 struct dw_spi_mchp {
@@ -53,44 +54,176 @@ struct dw_spi_mchp {
 	void __iomem			*spi_mst;
 	const struct dw_spi_mchp_props	*props;
 	u32				gen_owner;
+	u32				if2mask;
 };

 static const struct dw_spi_mchp_props dw_spi_mchp_props_ocelot = {
 	.syscon_name		= "mscc,ocelot-cpu-syscon",
+	.general_ctrl_off	= 0x24,
 	.si_owner_bit		= 4,
+	.pinctrl_bit_off	= 13,
+	.cs_bit_off		= 5,
+	.bootmaster_cs		= 0,
 };

 static const struct dw_spi_mchp_props dw_spi_mchp_props_jaguar2 = {
 	.syscon_name		= "mscc,ocelot-cpu-syscon",
+	.general_ctrl_off	= 0x24,
 	.si_owner_bit		= 6,
+	.pinctrl_bit_off	= 13,
+	.cs_bit_off		= 5,
+	.bootmaster_cs		= 0,
+};
+
+static const struct dw_spi_mchp_props dw_spi_mchp_props_sparx5 = {
+	.syscon_name		= "microchip,sparx5-cpu-syscon",
+	.general_ctrl_off	= 0x88,
+	.si_owner_bit		= 6,
+	.si_owner2_bit		= 4,
+	.ss_force_ena_off	= 0xa4,
+	.ss_force_val_off	= 0xa8,
+	.bootmaster_cs		= 0,
 };

 /*
- * The Designware SPI controller (referred to as master in the documentation)
- * automatically deasserts chip select when the tx fifo is empty. The chip
- * selects then needs to be either driven as GPIOs or, for the first 4 using the
- * the SPI boot controller registers. the final chip select is an OR gate
- * between the Designware SPI controller and the SPI boot controller.
+ * Set the owner of the SPI interface
  */
-static void dw_spi_mchp_set_cs(struct spi_device *spi, bool enable)
+static void dw_spi_mchp_set_owner(struct dw_spi_mchp *dwsmchp,
+				  const struct dw_spi_mchp_props *props,
+				  u8 owner, u8 owner2)
+{
+	u32 val, msk;
+
+	val = (owner << props->si_owner_bit);
+	msk = (MSCC_IF_SI_OWNER_MASK << props->si_owner_bit);
+	if (props->si_owner2_bit) {
+		val |= owner2 << props->si_owner2_bit;
+		msk |= (MSCC_IF_SI_OWNER_MASK << props->si_owner2_bit);
+	}
+	if (dwsmchp->gen_owner != val) {
+		regmap_update_bits(dwsmchp->syscon, props->general_ctrl_off,
+				   msk, val);
+		dwsmchp->gen_owner = val;
+	}
+}
+
+static void dw_spi_mchp_set_cs_owner(struct dw_spi_mchp *dwsmchp,
+				     const struct dw_spi_mchp_props *props,
+				     u8 cs, u8 owner)
 {
+	u8 dummy = (owner == MSCC_IF_SI_OWNER_SIBM ?
+		    MSCC_IF_SI_OWNER_SIMC : MSCC_IF_SI_OWNER_SIBM);
+	if (props->si_owner2_bit && (dwsmchp->if2mask & BIT(cs))) {
+		/* SPI2 */
+		dw_spi_mchp_set_owner(dwsmchp, props, dummy, owner);
+	} else {
+		/* SPI1 */
+		dw_spi_mchp_set_owner(dwsmchp, props, owner, dummy);
+	}
+}
+
+/*
+ * The Designware SPI controller (referred to as master in the
+ * documentation) automatically deasserts chip select when the tx fifo
+ * is empty. The chip selects then needs to be either driven as GPIOs
+ * or, for the first 4 using the the SPI boot controller
+ * registers. the final chip select is an OR gate between the
+ * Designware SPI controller and the SPI boot controller.  nselect is
+ * an active low signal
+ */
+static void dw_spi_mchp_set_cs(struct spi_device *spi, bool nEnable)
+{
+	bool enable = !nEnable;	/* This keeps changing in the API... */
 	struct dw_spi *dws = spi_master_get_devdata(spi->master);
 	struct dw_spi_mchp *dwsmchp = container_of(dws, struct dw_spi_mchp,
 						   dws);
-	u32 cs = spi->chip_select;
+	const struct dw_spi_mchp_props *props = dwsmchp->props;
+	u8 cs = spi->chip_select;

-	if (cs < 4) {
-		u32 sw_mode = MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE;
+	if (enable)
+		dw_spi_mchp_set_cs_owner(dwsmchp, props, cs,
+					 MSCC_IF_SI_OWNER_SIMC);

-		if (!enable)
-			sw_mode |= MSCC_SPI_MST_SW_MODE_SW_SPI_CS(BIT(cs));
+	if (dwsmchp->spi_mst && (cs < MAX_CS)) {
+		u32 sw_mode;

+		if (enable)
+			sw_mode = BIT(props->pinctrl_bit_off) |
+				(BIT(cs) << props->cs_bit_off);
+		else
+			sw_mode = 0;
 		writel(sw_mode, dwsmchp->spi_mst + MSCC_SPI_MST_SW_MODE);
+	} else if (props->ss_force_ena_off) {
+		if (enable) {
+			/* Ensure CS toggles, so start off all disabled */
+			regmap_write(dwsmchp->syscon, props->ss_force_val_off,
+				     ~0);
+			/* CS override drive enable */
+			regmap_write(dwsmchp->syscon, props->ss_force_ena_off,
+				     1);
+			/* Allow settle */
+			udelay(1);
+			/* Now set CSx enabled */
+			regmap_write(dwsmchp->syscon, props->ss_force_val_off,
+				     ~BIT(cs));
+		} else {
+			/* CS value */
+			regmap_write(dwsmchp->syscon, props->ss_force_val_off,
+				     ~0);
+			/* CS override drive disable */
+			regmap_write(dwsmchp->syscon, props->ss_force_ena_off,
+				     0);
+		}
 	}

-	dw_spi_set_cs(spi, enable);
+	dw_spi_set_cs(spi, nEnable);
+}
+
+static int dw_mchp_bootmaster_exec_mem_op(struct spi_mem *mem,
+					  const struct spi_mem_op *op)
+{
+	struct spi_device *spi = mem->spi;
+	int ret = -ENOTSUPP;
+
+	/* Only reads, addrsize 1..4 */
+	if (!op->data.nbytes || !op->addr.nbytes || op->addr.nbytes > 4 ||
+	    op->data.dir != SPI_MEM_DATA_IN)
+		return ret;
+
+	/* Only handle (normal+fast) 3/4 bytes read */
+	if (op->cmd.opcode != SPINOR_OP_READ &&
+	    op->cmd.opcode != SPINOR_OP_READ_FAST &&
+	    op->cmd.opcode != SPINOR_OP_READ_4B &&
+	    op->cmd.opcode != SPINOR_OP_READ_FAST_4B)
+		return ret;
+
+	/* CS0..3, only 16M reach */
+	if ((spi->chip_select < MAX_CS) &&
+	    (op->addr.val + op->data.nbytes) < SZ_16M) {
+		struct dw_spi *dws = spi_master_get_devdata(spi->master);
+		struct dw_spi_mchp *dwsmchp = container_of(dws,
+							   struct dw_spi_mchp,
+							   dws);
+		const struct dw_spi_mchp_props *props = dwsmchp->props;
+		u8 __iomem *src = dwsmchp->read_map +
+			(spi->chip_select * SZ_16M) + op->addr.val;
+
+		if (props->bootmaster_cs != spi->chip_select)
+			return ret;
+
+		/* Make boot master owner of SI interface */
+		dw_spi_mchp_set_cs_owner(dwsmchp, props, spi->chip_select,
+					 MSCC_IF_SI_OWNER_SIBM);
+		memcpy(op->data.buf.in, src, op->data.nbytes);
+		ret = op->data.nbytes;
+	}
+	return ret;
 }

+static const struct spi_controller_mem_ops dw_mchp_bootmaster_mem_ops = {
+	.exec_op = dw_mchp_bootmaster_exec_mem_op,
+};
+
 static int dw_spi_mchp_init(struct platform_device *pdev,
 			    struct dw_spi *dws,
 			    struct dw_spi_mchp *dwsmchp,
@@ -107,6 +240,18 @@ static int dw_spi_mchp_init(struct platform_device *pdev,
 		}
 	}

+	/* See if we have a direct read window */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	if (res && resource_size(res) >= (SZ_16M*MAX_CS)) {
+		void __iomem *ptr = devm_ioremap_resource(&pdev->dev, res);
+
+		if (!IS_ERR(ptr)) {
+			dwsmchp->read_map = ptr;
+			dws->mem_ops = &dw_mchp_bootmaster_mem_ops;
+			dev_info(&pdev->dev, "Enabling fast memory operations\n");
+		}
+	}
+
 	dwsmchp->syscon =
 		syscon_regmap_lookup_by_compatible(props->syscon_name);
 	if (IS_ERR(dwsmchp->syscon)) {
@@ -119,10 +264,9 @@ static int dw_spi_mchp_init(struct platform_device *pdev,
 	if (dwsmchp->spi_mst)
 		writel(0, dwsmchp->spi_mst + MSCC_SPI_MST_SW_MODE);

-	/* Select the owner of the SI interface */
-	regmap_update_bits(dwsmchp->syscon, MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL,
-			   MSCC_IF_SI_OWNER_MASK << props->si_owner_bit,
-			   MSCC_IF_SI_OWNER_SIMC << props->si_owner_bit);
+	/* SPI2 mapping bitmask */
+	device_property_read_u32(&pdev->dev, "interface-mapping-mask",
+				 &dwsmchp->if2mask);

 	dwsmchp->dws.set_cs = dw_spi_mchp_set_cs;

@@ -180,6 +324,27 @@ static int dw_spi_mchp_probe(struct platform_device *pdev)
 	dws->rx_sample_dly = DIV_ROUND_UP(rx_sample_dly,
 					  (dws->max_freq / 1000000));

+	if (pdev->dev.of_node) {
+		int i;
+
+		for (i = 0; i < dws->num_cs; i++) {
+			int cs_gpio = of_get_named_gpio(pdev->dev.of_node,
+					"cs-gpios", i);
+
+			if (cs_gpio == -EPROBE_DEFER) {
+				ret = cs_gpio;
+				goto out;
+			}
+
+			if (gpio_is_valid(cs_gpio)) {
+				ret = devm_gpio_request(&pdev->dev, cs_gpio,
+						dev_name(&pdev->dev));
+				if (ret)
+					goto out;
+			}
+		}
+	}
+
 	props = device_get_match_data(&pdev->dev);
 	if (props)
 		ret = dw_spi_mchp_init(pdev, dws, dwsmchp, props);
@@ -213,6 +378,8 @@ static int dw_spi_mchp_remove(struct platform_device *pdev)
 static const struct of_device_id dw_spi_mchp_of_match[] = {
 	{ .compatible = "mscc,ocelot-spi", .data = &dw_spi_mchp_props_ocelot},
 	{ .compatible = "mscc,jaguar2-spi", .data = &dw_spi_mchp_props_jaguar2},
+	{ .compatible = "microchip,sparx5-spi",
+	  .data = &dw_spi_mchp_props_sparx5},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mchp_of_match);
--
2.26.2
