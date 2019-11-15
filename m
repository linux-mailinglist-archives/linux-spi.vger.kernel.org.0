Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D416FDA57
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2019 11:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKOKEB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Nov 2019 05:04:01 -0500
Received: from twhmllg3.macronix.com ([122.147.135.201]:20680 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfKOKEB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Nov 2019 05:04:01 -0500
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id xAF8xp4i046911
        for <linux-spi@vger.kernel.org>; Fri, 15 Nov 2019 16:59:51 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id xAF8wWGx046218;
        Fri, 15 Nov 2019 16:58:36 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, vigneshr@ti.com,
        bbrezillon@kernel.org, tudor.ambarus@microchip.com
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH 4/4] spi: mxic: Add support for Octal 8D-8D-8D mode
Date:   Fri, 15 Nov 2019 16:58:08 +0800
Message-Id: <1573808288-19365-5-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw>
References: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com xAF8wWGx046218
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

patch driver for 8-8-8 and 8D-8D-8D mode support.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/spi/spi-mxic.c | 98 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 67 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index f48563c..50e2055 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -280,10 +280,58 @@ static void mxic_spi_hw_init(struct mxic_spi *mxic)
 	       mxic->regs + HC_CFG);
 }
 
+static u32 mxic_spi_mem_prep_op_cfg(const struct spi_mem_op *op)
+{
+	u32 cfg =  OP_CMD_BYTES(op->cmd.nbytes) |
+		   OP_CMD_BUSW(fls(op->cmd.buswidth) - 1) |
+		   (op->cmd.dtr ? OP_CMD_DDR : 0);
+
+	if (op->addr.nbytes)
+		cfg |= OP_ADDR_BYTES(op->addr.nbytes) |
+		       OP_ADDR_BUSW(fls(op->addr.buswidth) - 1) |
+		       (op->addr.dtr ? OP_ADDR_DDR : 0);
+
+	if (op->dummy.nbytes)
+		cfg |= OP_DUMMY_CYC(op->dummy.nbytes);
+
+	if (op->data.nbytes) {
+		cfg |= OP_DATA_BUSW(fls(op->data.buswidth) - 1) |
+		      (op->data.dtr ? OP_DATA_DDR : 0);
+		if (op->data.dir == SPI_MEM_DATA_IN) {
+			cfg |= OP_READ;
+			if (op->data.dtr == OP_DATA_DDR)
+				cfg |= OP_DQS_EN;
+		}
+	}
+
+	return cfg;
+}
+
+static void mxic_spi_set_hc_cfg(struct spi_device *spi, u32 flags)
+{
+	struct mxic_spi *mxic = spi_master_get_devdata(spi->master);
+	int nio = 1;
+
+	if (spi->mode & (SPI_RX_OCTAL | SPI_TX_OCTAL))
+		nio = 8;
+	else if (spi->mode & (SPI_TX_QUAD | SPI_RX_QUAD))
+		nio = 4;
+	else if (spi->mode & (SPI_TX_DUAL | SPI_RX_DUAL))
+		nio = 2;
+
+	writel(flags | HC_CFG_NIO(nio) |
+	       HC_CFG_TYPE(spi->chip_select, HC_CFG_TYPE_SPI_NOR) |
+	       HC_CFG_SLV_ACT(spi->chip_select) | HC_CFG_IDLE_SIO_LVL(1),
+	       mxic->regs + HC_CFG);
+}
+
 static int mxic_spi_data_xfer(struct mxic_spi *mxic, const void *txbuf,
 			      void *rxbuf, unsigned int len)
 {
 	unsigned int pos = 0;
+	bool dtr_enabled;
+
+	dtr_enabled = (readl(mxic->regs + SS_CTRL(0)) & OP_DATA_DDR);
 
 	while (pos < len) {
 		unsigned int nbytes = len - pos;
@@ -302,6 +350,9 @@ static int mxic_spi_data_xfer(struct mxic_spi *mxic, const void *txbuf,
 		if (ret)
 			return ret;
 
+		if (dtr_enabled && len & 0x1)
+			nbytes++;
+
 		writel(data, mxic->regs + TXD(nbytes % 4));
 
 		if (rxbuf) {
@@ -319,6 +370,8 @@ static int mxic_spi_data_xfer(struct mxic_spi *mxic, const void *txbuf,
 
 			data = readl(mxic->regs + RXD);
 			data >>= (8 * (4 - nbytes));
+			if (dtr_enabled && len & 0x1)
+				nbytes++;
 			memcpy(rxbuf + pos, &data, nbytes);
 			WARN_ON(readl(mxic->regs + INT_STS) & INT_RX_NOT_EMPTY);
 		} else {
@@ -335,8 +388,8 @@ static int mxic_spi_data_xfer(struct mxic_spi *mxic, const void *txbuf,
 static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
 				     const struct spi_mem_op *op)
 {
-	if (op->data.buswidth > 4 || op->addr.buswidth > 4 ||
-	    op->dummy.buswidth > 4 || op->cmd.buswidth > 4)
+	if (op->data.buswidth > 8 || op->addr.buswidth > 8 ||
+	    op->dummy.buswidth > 8 || op->cmd.buswidth > 8)
 		return false;
 
 	if (op->data.nbytes && op->dummy.nbytes &&
@@ -353,47 +406,29 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
 	struct mxic_spi *mxic = spi_master_get_devdata(mem->spi->master);
-	int nio = 1, i, ret;
-	u32 ss_ctrl;
+	int i, ret;
 	u8 addr[8];
+	u8 cmd[2];
 
 	ret = mxic_spi_set_freq(mxic, mem->spi->max_speed_hz);
 	if (ret)
 		return ret;
 
-	if (mem->spi->mode & (SPI_TX_QUAD | SPI_RX_QUAD))
-		nio = 4;
-	else if (mem->spi->mode & (SPI_TX_DUAL | SPI_RX_DUAL))
-		nio = 2;
+	mxic_spi_set_hc_cfg(mem->spi, HC_CFG_MAN_CS_EN);
 
-	writel(HC_CFG_NIO(nio) |
-	       HC_CFG_TYPE(mem->spi->chip_select, HC_CFG_TYPE_SPI_NOR) |
-	       HC_CFG_SLV_ACT(mem->spi->chip_select) | HC_CFG_IDLE_SIO_LVL(1) |
-	       HC_CFG_MAN_CS_EN,
-	       mxic->regs + HC_CFG);
 	writel(HC_EN_BIT, mxic->regs + HC_EN);
 
-	ss_ctrl = OP_CMD_BYTES(1) | OP_CMD_BUSW(fls(op->cmd.buswidth) - 1);
-
-	if (op->addr.nbytes)
-		ss_ctrl |= OP_ADDR_BYTES(op->addr.nbytes) |
-			   OP_ADDR_BUSW(fls(op->addr.buswidth) - 1);
-
-	if (op->dummy.nbytes)
-		ss_ctrl |= OP_DUMMY_CYC(op->dummy.nbytes);
-
-	if (op->data.nbytes) {
-		ss_ctrl |= OP_DATA_BUSW(fls(op->data.buswidth) - 1);
-		if (op->data.dir == SPI_MEM_DATA_IN)
-			ss_ctrl |= OP_READ;
-	}
-
-	writel(ss_ctrl, mxic->regs + SS_CTRL(mem->spi->chip_select));
+	writel(mxic_spi_mem_prep_op_cfg(op),
+	       mxic->regs + SS_CTRL(mem->spi->chip_select));
 
 	writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
 	       mxic->regs + HC_CFG);
 
-	ret = mxic_spi_data_xfer(mxic, &op->cmd.opcode, NULL, 1);
+	cmd[0] = op->cmd.opcode;
+	if (op->cmd.nbytes == 2)
+		cmd[1] = op->cmd.ext_opcode;
+
+	ret = mxic_spi_data_xfer(mxic, cmd, NULL, op->cmd.nbytes);
 	if (ret)
 		goto out;
 
@@ -566,7 +601,8 @@ static int mxic_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->mode_bits = SPI_CPOL | SPI_CPHA |
 			SPI_RX_DUAL | SPI_TX_DUAL |
-			SPI_RX_QUAD | SPI_TX_QUAD;
+			SPI_RX_QUAD | SPI_TX_QUAD |
+			SPI_RX_OCTAL | SPI_TX_OCTAL;
 
 	mxic_spi_hw_init(mxic);
 
-- 
1.9.1

