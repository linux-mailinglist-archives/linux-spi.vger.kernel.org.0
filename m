Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCCD818CE6E
	for <lists+linux-spi@lfdr.de>; Fri, 20 Mar 2020 14:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCTNF5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Mar 2020 09:05:57 -0400
Received: from foss.arm.com ([217.140.110.172]:48696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgCTNF4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Mar 2020 09:05:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABA721FB;
        Fri, 20 Mar 2020 06:05:53 -0700 (PDT)
Received: from localhost (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63BB03F85E;
        Fri, 20 Mar 2020 06:05:53 -0700 (PDT)
Date:   Fri, 20 Mar 2020 13:05:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     alexandre.belloni@bootlin.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Ludovic.Desroches@microchip.com, Mark Brown <broonie@kernel.org>,
        Nicolas.Ferre@microchip.com, Tudor.Ambarus@microchip.com
Subject: Applied "spi: atmel-quadspi: Add verbose debug facilities to monitor register accesses" to the spi tree
In-Reply-To:  <20200320065058.891221-1-tudor.ambarus@microchip.com>
Message-Id:  <applied-20200320065058.891221-1-tudor.ambarus@microchip.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: atmel-quadspi: Add verbose debug facilities to monitor register accesses

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From c528ecfbef040ba0d6672d843e7502cb326bcb4d Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Fri, 20 Mar 2020 06:51:01 +0000
Subject: [PATCH] spi: atmel-quadspi: Add verbose debug facilities to monitor
 register accesses

This feature should not be enabled in release but can be useful for
developers who need to monitor register accesses at some specific places.

Helped me identify a bug in u-boot, by comparing the register accesses
from the linux driver with the ones from its u-boot variant.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Link: https://lore.kernel.org/r/20200320065058.891221-1-tudor.ambarus@microchip.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/atmel-quadspi.c | 119 +++++++++++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 13def7f78b9e..cb44d1e169aa 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -173,6 +173,81 @@ static const struct atmel_qspi_mode atmel_qspi_modes[] = {
 	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
 };
 
+#ifdef VERBOSE_DEBUG
+static const char *atmel_qspi_reg_name(u32 offset, char *tmp, size_t sz)
+{
+	switch (offset) {
+	case QSPI_CR:
+		return "CR";
+	case QSPI_MR:
+		return "MR";
+	case QSPI_RD:
+		return "MR";
+	case QSPI_TD:
+		return "TD";
+	case QSPI_SR:
+		return "SR";
+	case QSPI_IER:
+		return "IER";
+	case QSPI_IDR:
+		return "IDR";
+	case QSPI_IMR:
+		return "IMR";
+	case QSPI_SCR:
+		return "SCR";
+	case QSPI_IAR:
+		return "IAR";
+	case QSPI_ICR:
+		return "ICR/WICR";
+	case QSPI_IFR:
+		return "IFR";
+	case QSPI_RICR:
+		return "RICR";
+	case QSPI_SMR:
+		return "SMR";
+	case QSPI_SKR:
+		return "SKR";
+	case QSPI_WPMR:
+		return "WPMR";
+	case QSPI_WPSR:
+		return "WPSR";
+	case QSPI_VERSION:
+		return "VERSION";
+	default:
+		snprintf(tmp, sz, "0x%02x", offset);
+		break;
+	}
+
+	return tmp;
+}
+#endif /* VERBOSE_DEBUG */
+
+static u32 atmel_qspi_read(struct atmel_qspi *aq, u32 offset)
+{
+	u32 value = readl_relaxed(aq->regs + offset);
+
+#ifdef VERBOSE_DEBUG
+	char tmp[8];
+
+	dev_vdbg(&aq->pdev->dev, "read 0x%08x from %s\n", value,
+		 atmel_qspi_reg_name(offset, tmp, sizeof(tmp)));
+#endif /* VERBOSE_DEBUG */
+
+	return value;
+}
+
+static void atmel_qspi_write(u32 value, struct atmel_qspi *aq, u32 offset)
+{
+#ifdef VERBOSE_DEBUG
+	char tmp[8];
+
+	dev_vdbg(&aq->pdev->dev, "write 0x%08x into %s\n", value,
+		 atmel_qspi_reg_name(offset, tmp, sizeof(tmp)));
+#endif /* VERBOSE_DEBUG */
+
+	writel_relaxed(value, aq->regs + offset);
+}
+
 static inline bool atmel_qspi_is_compatible(const struct spi_mem_op *op,
 					    const struct atmel_qspi_mode *mode)
 {
@@ -293,32 +368,32 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 	 * Serial Memory Mode (SMM).
 	 */
 	if (aq->mr != QSPI_MR_SMM) {
-		writel_relaxed(QSPI_MR_SMM, aq->regs + QSPI_MR);
+		atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
 		aq->mr = QSPI_MR_SMM;
 	}
 
 	/* Clear pending interrupts */
-	(void)readl_relaxed(aq->regs + QSPI_SR);
+	(void)atmel_qspi_read(aq, QSPI_SR);
 
 	if (aq->caps->has_ricr) {
 		if (!op->addr.nbytes && op->data.dir == SPI_MEM_DATA_IN)
 			ifr |= QSPI_IFR_APBTFRTYP_READ;
 
 		/* Set QSPI Instruction Frame registers */
-		writel_relaxed(iar, aq->regs + QSPI_IAR);
+		atmel_qspi_write(iar, aq, QSPI_IAR);
 		if (op->data.dir == SPI_MEM_DATA_IN)
-			writel_relaxed(icr, aq->regs + QSPI_RICR);
+			atmel_qspi_write(icr, aq, QSPI_RICR);
 		else
-			writel_relaxed(icr, aq->regs + QSPI_WICR);
-		writel_relaxed(ifr, aq->regs + QSPI_IFR);
+			atmel_qspi_write(icr, aq, QSPI_WICR);
+		atmel_qspi_write(ifr, aq, QSPI_IFR);
 	} else {
 		if (op->data.dir == SPI_MEM_DATA_OUT)
 			ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
 
 		/* Set QSPI Instruction Frame registers */
-		writel_relaxed(iar, aq->regs + QSPI_IAR);
-		writel_relaxed(icr, aq->regs + QSPI_ICR);
-		writel_relaxed(ifr, aq->regs + QSPI_IFR);
+		atmel_qspi_write(iar, aq, QSPI_IAR);
+		atmel_qspi_write(icr, aq, QSPI_ICR);
+		atmel_qspi_write(ifr, aq, QSPI_IFR);
 	}
 
 	return 0;
@@ -345,7 +420,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
 		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
-		(void)readl_relaxed(aq->regs + QSPI_IFR);
+		(void)atmel_qspi_read(aq, QSPI_IFR);
 
 		/* Send/Receive data */
 		if (op->data.dir == SPI_MEM_DATA_IN)
@@ -356,22 +431,22 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 				     op->data.nbytes);
 
 		/* Release the chip-select */
-		writel_relaxed(QSPI_CR_LASTXFER, aq->regs + QSPI_CR);
+		atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
 	}
 
 	/* Poll INSTRuction End status */
-	sr = readl_relaxed(aq->regs + QSPI_SR);
+	sr = atmel_qspi_read(aq, QSPI_SR);
 	if ((sr & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
 		return err;
 
 	/* Wait for INSTRuction End interrupt */
 	reinit_completion(&aq->cmd_completion);
 	aq->pending = sr & QSPI_SR_CMD_COMPLETED;
-	writel_relaxed(QSPI_SR_CMD_COMPLETED, aq->regs + QSPI_IER);
+	atmel_qspi_write(QSPI_SR_CMD_COMPLETED, aq, QSPI_IER);
 	if (!wait_for_completion_timeout(&aq->cmd_completion,
 					 msecs_to_jiffies(1000)))
 		err = -ETIMEDOUT;
-	writel_relaxed(QSPI_SR_CMD_COMPLETED, aq->regs + QSPI_IDR);
+	atmel_qspi_write(QSPI_SR_CMD_COMPLETED, aq, QSPI_IDR);
 
 	return err;
 }
@@ -410,7 +485,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
 		scbr--;
 
 	aq->scr = QSPI_SCR_SCBR(scbr);
-	writel_relaxed(aq->scr, aq->regs + QSPI_SCR);
+	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
 
 	return 0;
 }
@@ -418,14 +493,14 @@ static int atmel_qspi_setup(struct spi_device *spi)
 static void atmel_qspi_init(struct atmel_qspi *aq)
 {
 	/* Reset the QSPI controller */
-	writel_relaxed(QSPI_CR_SWRST, aq->regs + QSPI_CR);
+	atmel_qspi_write(QSPI_CR_SWRST, aq, QSPI_CR);
 
 	/* Set the QSPI controller by default in Serial Memory Mode */
-	writel_relaxed(QSPI_MR_SMM, aq->regs + QSPI_MR);
+	atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
 	aq->mr = QSPI_MR_SMM;
 
 	/* Enable the QSPI controller */
-	writel_relaxed(QSPI_CR_QSPIEN, aq->regs + QSPI_CR);
+	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
 }
 
 static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
@@ -433,8 +508,8 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 	struct atmel_qspi *aq = dev_id;
 	u32 status, mask, pending;
 
-	status = readl_relaxed(aq->regs + QSPI_SR);
-	mask = readl_relaxed(aq->regs + QSPI_IMR);
+	status = atmel_qspi_read(aq, QSPI_SR);
+	mask = atmel_qspi_read(aq, QSPI_IMR);
 	pending = status & mask;
 
 	if (!pending)
@@ -569,7 +644,7 @@ static int atmel_qspi_remove(struct platform_device *pdev)
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 
 	spi_unregister_controller(ctrl);
-	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
+	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
 	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
 	return 0;
@@ -596,7 +671,7 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 
 	atmel_qspi_init(aq);
 
-	writel_relaxed(aq->scr, aq->regs + QSPI_SCR);
+	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
 
 	return 0;
 }
-- 
2.20.1

