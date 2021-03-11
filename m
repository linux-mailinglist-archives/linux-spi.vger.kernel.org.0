Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E66C337D6F
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhCKTNY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:13:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44276 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhCKTMx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:12:53 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BJCfkl072981;
        Thu, 11 Mar 2021 13:12:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615489961;
        bh=OhuGeU0Ap5BT7Sl9DsCYa3Ndt+hNk93fO4NJx/FnSKQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eh4R1oMJGkaqFg1L4275raVqJ9xVf1hbgZPsbamWqIk8KgE7V1NMVLV7l4w6FInhU
         /JIJzZLvrn54QL9PKimr5fDbtS434AM70iLss7Nebgo+S5FMFs9A3kD7NslJ4APae8
         wecIOPirp1su8cXZ+CEQ5eEFNuIug2+eEAyj7S48=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BJCf5p110575
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 13:12:41 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 13:12:40 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 13:12:40 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BJCHvV080816;
        Thu, 11 Mar 2021 13:12:36 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [RFC PATCH 4/6] spi: cadence-qspi: Use PHY for DAC reads if possible
Date:   Fri, 12 Mar 2021 00:42:14 +0530
Message-ID: <20210311191216.7363-5-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210311191216.7363-1-p.yadav@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Check if a read is eligible for PHY and if it is, enable PHY and DQS.

Since PHY reads only work at an address that is 16-byte aligned and of
size that is a multiple of 16 bytes, read the starting and ending
unaligned portions without PHY, and only enable PHY for the middle part.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 203 ++++++++++++++++++++++++++----
 1 file changed, 182 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index e2d6ea833423..e64d8e125263 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -41,19 +41,27 @@
 
 struct cqspi_st;
 
+struct phy_setting {
+	u8		rx;
+	u8		tx;
+	u8		read_delay;
+};
+
 struct cqspi_flash_pdata {
-	struct cqspi_st	*cqspi;
-	u32		clk_rate;
-	u32		read_delay;
-	u32		tshsl_ns;
-	u32		tsd2d_ns;
-	u32		tchsh_ns;
-	u32		tslch_ns;
-	u8		inst_width;
-	u8		addr_width;
-	u8		data_width;
-	bool		dtr;
-	u8		cs;
+	struct cqspi_st		*cqspi;
+	u32			clk_rate;
+	u32			read_delay;
+	u32			tshsl_ns;
+	u32			tsd2d_ns;
+	u32			tchsh_ns;
+	u32			tslch_ns;
+	u8			inst_width;
+	u8			addr_width;
+	u8			data_width;
+	bool			dtr;
+	u8			cs;
+	bool			use_phy;
+	struct phy_setting	phy_setting;
 };
 
 struct cqspi_st {
@@ -108,12 +116,14 @@ struct cqspi_driver_platdata {
 /* Register map */
 #define CQSPI_REG_CONFIG			0x00
 #define CQSPI_REG_CONFIG_ENABLE_MASK		BIT(0)
+#define CQSPI_REG_CONFIG_PHY_EN			BIT(3)
 #define CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL	BIT(7)
 #define CQSPI_REG_CONFIG_DECODE_MASK		BIT(9)
 #define CQSPI_REG_CONFIG_CHIPSELECT_LSB		10
 #define CQSPI_REG_CONFIG_DMA_MASK		BIT(15)
 #define CQSPI_REG_CONFIG_BAUD_LSB		19
 #define CQSPI_REG_CONFIG_DTR_PROTO		BIT(24)
+#define CQSPI_REG_CONFIG_PHY_PIPELINE		BIT(25)
 #define CQSPI_REG_CONFIG_DUAL_OPCODE		BIT(30)
 #define CQSPI_REG_CONFIG_IDLE_LSB		31
 #define CQSPI_REG_CONFIG_CHIPSELECT_MASK	0xF
@@ -150,6 +160,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_READCAPTURE_BYPASS_LSB	0
 #define CQSPI_REG_READCAPTURE_DELAY_LSB		1
 #define CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
+#define CQSPI_REG_READCAPTURE_DQS_LSB		8
 
 #define CQSPI_REG_SIZE				0x14
 #define CQSPI_REG_SIZE_ADDRESS_LSB		0
@@ -999,6 +1010,7 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
 
 static void cqspi_readdata_capture(struct cqspi_st *cqspi,
 				   const bool bypass,
+				   const bool dqs,
 				   const unsigned int delay)
 {
 	void __iomem *reg_base = cqspi->iobase;
@@ -1017,6 +1029,11 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi,
 	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
 		<< CQSPI_REG_READCAPTURE_DELAY_LSB;
 
+	if (dqs)
+		reg |= (1 << CQSPI_REG_READCAPTURE_DQS_LSB);
+	else
+		reg &= ~(1 << CQSPI_REG_READCAPTURE_DQS_LSB);
+
 	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
 }
 
@@ -1035,6 +1052,64 @@ static void cqspi_controller_enable(struct cqspi_st *cqspi, bool enable)
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 
+static void cqspi_phy_enable(struct cqspi_flash_pdata *f_pdata, bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	u32 reg;
+	u8 dummy;
+
+	if (enable) {
+		cqspi_readdata_capture(cqspi, 1, true,
+				       f_pdata->phy_setting.read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg |= CQSPI_REG_CONFIG_PHY_EN |
+		       CQSPI_REG_CONFIG_PHY_PIPELINE;
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		/*
+		 * Reduce dummy cycle by 1. This is a requirement of PHY mode
+		 * operation for correctly reading the data.
+		 */
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = (reg >> CQSPI_REG_RD_INSTR_DUMMY_LSB) &
+			CQSPI_REG_RD_INSTR_DUMMY_MASK;
+		dummy--;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK <<
+			 CQSPI_REG_RD_INSTR_DUMMY_LSB);
+
+		reg |= (dummy & CQSPI_REG_RD_INSTR_DUMMY_MASK)
+		       << CQSPI_REG_RD_INSTR_DUMMY_LSB;
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+	} else {
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
+				       f_pdata->read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg &= ~(CQSPI_REG_CONFIG_PHY_EN |
+			 CQSPI_REG_CONFIG_PHY_PIPELINE);
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		/*
+		 * Dummy cycles were decremented when enabling PHY. Increment
+		 * dummy cycle by 1 to restore the original value.
+		 */
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = (reg >> CQSPI_REG_RD_INSTR_DUMMY_LSB) &
+			CQSPI_REG_RD_INSTR_DUMMY_MASK;
+		dummy++;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK <<
+			 CQSPI_REG_RD_INSTR_DUMMY_LSB);
+
+		reg |= (dummy & CQSPI_REG_RD_INSTR_DUMMY_MASK)
+		       << CQSPI_REG_RD_INSTR_DUMMY_LSB;
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+	}
+
+	cqspi_wait_idle(cqspi);
+}
+
 static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 			    unsigned long sclk)
 {
@@ -1056,7 +1131,7 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
 		cqspi_delay(f_pdata);
-		cqspi_readdata_capture(cqspi, !cqspi->rclk_en,
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
 				       f_pdata->read_delay);
 	}
 
@@ -1098,6 +1173,39 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
 }
 
+/*
+ * Check if PHY mode can be used on the given op. This is assuming it will be a
+ * DAC mode read, since PHY won't work on any other type of operation anyway.
+ */
+static bool cqspi_phy_op_eligible(const struct spi_mem_op *op)
+{
+	/* PHY is only tuned for 8D-8D-8D. */
+	if (!(op->cmd.dtr && op->addr.dtr && op->dummy.dtr && op->data.dtr))
+		return false;
+	if (op->cmd.buswidth != 8)
+		return false;
+	if (op->addr.nbytes && op->addr.buswidth != 8)
+		return false;
+	if (op->dummy.nbytes && op->dummy.buswidth != 8)
+		return false;
+	if (op->data.nbytes && op->data.buswidth != 8)
+		return false;
+
+	return true;
+}
+
+static bool cqspi_use_phy(struct cqspi_flash_pdata *f_pdata,
+			  const struct spi_mem_op *op)
+{
+	if (!f_pdata->use_phy)
+		return false;
+
+	if (op->data.nbytes < 16)
+		return false;
+
+	return cqspi_phy_op_eligible(op);
+}
+
 static void cqspi_rx_dma_callback(void *param)
 {
 	struct cqspi_st *cqspi = param;
@@ -1105,8 +1213,8 @@ static void cqspi_rx_dma_callback(void *param)
 	complete(&cqspi->rx_dma_complete);
 }
 
-static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
-				     u_char *buf, loff_t from, size_t len)
+static int cqspi_direct_read_dma(struct cqspi_flash_pdata *f_pdata,
+				 u_char *buf, loff_t from, size_t len)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
@@ -1118,11 +1226,6 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	dma_addr_t dma_dst;
 	struct device *ddev;
 
-	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
-		memcpy_fromio(buf, cqspi->ahb_base + from, len);
-		return 0;
-	}
-
 	ddev = cqspi->rx_chan->device->dev;
 	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(ddev, dma_dst)) {
@@ -1164,6 +1267,64 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
+				     const struct spi_mem_op *op)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	loff_t from = op->addr.val;
+	loff_t from_aligned, to_aligned;
+	size_t len = op->data.nbytes;
+	size_t len_aligned;
+	u_char *buf = op->data.buf.in;
+	int ret;
+
+	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
+		memcpy_fromio(buf, cqspi->ahb_base + from, len);
+		return 0;
+	}
+
+	if (!cqspi_use_phy(f_pdata, op))
+		return cqspi_direct_read_dma(f_pdata, buf, from, len);
+
+	/*
+	 * PHY reads must be 16-byte aligned, and they must be a multiple of 16
+	 * bytes.
+	 */
+	from_aligned = (from + 0xF) & ~0xF;
+	to_aligned = (from + len) & ~0xF;
+	len_aligned = to_aligned - from_aligned;
+
+	/* Read the unaligned part at the start. */
+	if (from != from_aligned) {
+		ret = cqspi_direct_read_dma(f_pdata, buf, from,
+					    from_aligned - from);
+		if (ret)
+			return ret;
+		buf += from_aligned - from;
+	}
+
+	if (len_aligned) {
+		cqspi_phy_enable(f_pdata, true);
+		ret = cqspi_direct_read_dma(f_pdata, buf, from_aligned,
+					    len_aligned);
+		cqspi_phy_enable(f_pdata, false);
+		if (ret)
+			return ret;
+		buf += len_aligned;
+	}
+
+	/* Now read the remaining part, if any. */
+	if (to_aligned != (from + len)) {
+		ret = cqspi_direct_read_dma(f_pdata, buf, to_aligned,
+					    (from + len) - to_aligned);
+		if (ret)
+			return ret;
+		buf += (from + len) - to_aligned;
+	}
+
+	return 0;
+}
+
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 			  const struct spi_mem_op *op)
 {
@@ -1182,7 +1343,7 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 		return ret;
 
 	if (cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size))
-		return cqspi_direct_read_execute(f_pdata, buf, from, len);
+		return cqspi_direct_read_execute(f_pdata, op);
 
 	return cqspi_indirect_read_execute(f_pdata, buf, from, len);
 }
-- 
2.30.0

