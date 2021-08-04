Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7F23DFB46
	for <lists+linux-spi@lfdr.de>; Wed,  4 Aug 2021 07:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhHDFxH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Aug 2021 01:53:07 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:25572 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhHDFxF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Aug 2021 01:53:05 -0400
X-Greylist: delayed 1388 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Aug 2021 01:53:05 EDT
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 1745TjeU038424
        for <linux-spi@vger.kernel.org>; Wed, 4 Aug 2021 13:29:45 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.94])
        by TWHMLLG3.macronix.com with ESMTP id 1745TWSg038339;
        Wed, 4 Aug 2021 13:29:32 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
From:   Zhengxun Li <zhengxunli@mxic.com.tw>
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Cc:     Zhengxun Li <zhengxunli@mxic.com.tw>
Subject: [PATCH v6] spi: mxic: patch for octal DTR mode support
Date:   Wed,  4 Aug 2021 13:27:07 +0800
Message-Id: <1628054827-458-1-git-send-email-zhengxunli@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com 1745TWSg038339
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Driver patch for octal DTR mode support.

Owing to the spi_mem_default_supports_op() is not support dtr
operation. Based on commit <539cf68cd51b> (spi: spi-mem: add
spi_mem_dtr_supports_op()) add spi_mem_dtr_supports_op()
to support dtr and keep checking the buswidth and command bytes.

Changes in v6:
- Rebase on top of spi-next and modify comments.
- Separate from the "Add octal DTR support for Macronix flash" series

Signed-off-by: Zhengxun Li <zhengxunli@mxic.com.tw>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mxic.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 96b4182..32e757a 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -335,8 +335,10 @@ static int mxic_spi_data_xfer(struct mxic_spi *mxic, const void *txbuf,
 static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
 				     const struct spi_mem_op *op)
 {
-	if (op->data.buswidth > 4 || op->addr.buswidth > 4 ||
-	    op->dummy.buswidth > 4 || op->cmd.buswidth > 4)
+	bool all_false;
+
+	if (op->data.buswidth > 8 || op->addr.buswidth > 8 ||
+	    op->dummy.buswidth > 8 || op->cmd.buswidth > 8)
 		return false;
 
 	if (op->data.nbytes && op->dummy.nbytes &&
@@ -346,7 +348,13 @@ static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
 	if (op->addr.nbytes > 7)
 		return false;
 
-	return spi_mem_default_supports_op(mem, op);
+	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
+		    !op->data.dtr;
+
+	if (all_false)
+		return spi_mem_default_supports_op(mem, op);
+	else
+		return spi_mem_dtr_supports_op(mem, op);
 }
 
 static int mxic_spi_mem_exec_op(struct spi_mem *mem,
@@ -355,14 +363,15 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	struct mxic_spi *mxic = spi_master_get_devdata(mem->spi->master);
 	int nio = 1, i, ret;
 	u32 ss_ctrl;
-	u8 addr[8];
-	u8 opcode = op->cmd.opcode;
+	u8 addr[8], cmd[2];
 
 	ret = mxic_spi_set_freq(mxic, mem->spi->max_speed_hz);
 	if (ret)
 		return ret;
 
-	if (mem->spi->mode & (SPI_TX_QUAD | SPI_RX_QUAD))
+	if (mem->spi->mode & (SPI_TX_OCTAL | SPI_RX_OCTAL))
+		nio = 8;
+	else if (mem->spi->mode & (SPI_TX_QUAD | SPI_RX_QUAD))
 		nio = 4;
 	else if (mem->spi->mode & (SPI_TX_DUAL | SPI_RX_DUAL))
 		nio = 2;
@@ -374,19 +383,25 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	       mxic->regs + HC_CFG);
 	writel(HC_EN_BIT, mxic->regs + HC_EN);
 
-	ss_ctrl = OP_CMD_BYTES(1) | OP_CMD_BUSW(fls(op->cmd.buswidth) - 1);
+	ss_ctrl = OP_CMD_BYTES(op->cmd.nbytes) |
+		  OP_CMD_BUSW(fls(op->cmd.buswidth) - 1) |
+		  (op->cmd.dtr ? OP_CMD_DDR : 0);
 
 	if (op->addr.nbytes)
 		ss_ctrl |= OP_ADDR_BYTES(op->addr.nbytes) |
-			   OP_ADDR_BUSW(fls(op->addr.buswidth) - 1);
+			   OP_ADDR_BUSW(fls(op->addr.buswidth) - 1) |
+			   (op->addr.dtr ? OP_ADDR_DDR : 0);
 
 	if (op->dummy.nbytes)
 		ss_ctrl |= OP_DUMMY_CYC(op->dummy.nbytes);
 
 	if (op->data.nbytes) {
-		ss_ctrl |= OP_DATA_BUSW(fls(op->data.buswidth) - 1);
+		ss_ctrl |= OP_DATA_BUSW(fls(op->data.buswidth) - 1) |
+			   (op->data.dtr ? OP_DATA_DDR : 0);
 		if (op->data.dir == SPI_MEM_DATA_IN)
 			ss_ctrl |= OP_READ;
+			if (op->data.dtr)
+				ss_ctrl |= OP_DQS_EN;
 	}
 
 	writel(ss_ctrl, mxic->regs + SS_CTRL(mem->spi->chip_select));
@@ -394,7 +409,10 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
 	       mxic->regs + HC_CFG);
 
-	ret = mxic_spi_data_xfer(mxic, &opcode, NULL, 1);
+	for (i = 0; i < op->cmd.nbytes; i++)
+		cmd[i] = op->cmd.opcode >> (8 * (op->cmd.nbytes - i - 1));
+
+	ret = mxic_spi_data_xfer(mxic, cmd, NULL, op->cmd.nbytes);
 	if (ret)
 		goto out;
 
@@ -567,7 +585,8 @@ static int mxic_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->mode_bits = SPI_CPOL | SPI_CPHA |
 			SPI_RX_DUAL | SPI_TX_DUAL |
-			SPI_RX_QUAD | SPI_TX_QUAD;
+			SPI_RX_QUAD | SPI_TX_QUAD |
+			SPI_RX_OCTAL | SPI_TX_OCTAL;
 
 	mxic_spi_hw_init(mxic);
 
-- 
1.9.1

