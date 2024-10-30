Return-Path: <linux-spi+bounces-5541-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DA29B5E1A
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 09:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261391F2252E
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E66B190486;
	Wed, 30 Oct 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="hKbnog0k"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BBE149C64;
	Wed, 30 Oct 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277926; cv=none; b=br+0jSo7NVkiuAtt5pkxP5FtbBKqmNkTCXhHdoKGJzjROTn/DwJBZs/ODlN4UR2+rDUCZM0At3ajBqTX4mSoUEQH6iqTq05R1/8sOgd0I5DTcpxwOmVgSF0oO1XTP4w8omtMjY3OMhzvJ3zdbGpdqOFRfcPo1JSl7SpfE2QGy9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277926; c=relaxed/simple;
	bh=DjrKVkjupKb3hhQGkeCeNIG5gSTj6ohY3jj7zadFT4A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RBHBqFOH6+ARRVMaBFiX+CllYpJEjzrywZRiAxkL/uEhlN0D8CIaP8RQKCWceBMG2rOH9lxPFY66ElJR5dpSn5CZnlUnSWgMQS9z6l5himojhk573yMlLlp2fnXpAnD9N66k2q+gmpVtiIIj3g/N6o7a0O5F/RgFBZZ95lkc9mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=hKbnog0k; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BD22FA11B6;
	Wed, 30 Oct 2024 09:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=pCTs7xE1RNDjOAhXIwJf35Ye4AhjEVbQRROagoMzs9M=; b=
	hKbnog0k6h+HIXxGMurg+nml0X6WXIn5lG2XxzpBOxmO9phmczQsE0Ls7CoIkhCF
	h4tf10MLv1VQSp/STabqL6oOywt/sdbVRp3nu2cU6drXIq8rHBUlFz+QAUokHp9j
	vWLzsLP00CqjMFhCIv9DqQU6xapuFhYyfXCXOFbcTU5gFNAt5JpnPzkNsgpU9y3E
	yzzBR8TP2O2VjmErg4EMsx3n6AuLfIZfYbsNEVItEqXUdF5+yiHL1k3fhS8+n7Oq
	TQLZBb/xNULYZK8g3ohtmsv8aBjFZrPbrMfssnKUCk1733DDURhQzYlj284ulbbo
	RfVB5kxbkpQykVu5jsLPsW0k3iE0xWZ3EeSHjqaJkoALEugCRbszR+MANLCn8ejk
	ToFwZ5v03vbNPc8lOdxcGYjvIqUDUfjG/xDbAgH1HKpnEiwiO8amJBthOR9UuArg
	uC+4R2Ym9Y+anBkywKz1Jd/Y/pJJicL11y6i7c6Nsxt8DkV0MuE+9X4Ps0D4uSyu
	eE1CL3lH3DHcBetJO1c/IxFz0DcXaV7ApzvxjDpFW8J49uxQ0XF4hfggGGawtMgk
	OTYm51/Bqmo59x2NXBhoMyiuBkT5mB0xNftFUghNNHQaSxfwqm+6nUIpNRFFxMMv
	/JNmrSHtg5shKP7Kwp80DeD1F+BguUJGBV3sDksZLjo=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Tudor
 Ambarus" <tudor.ambarus@linaro.org>, Varshini Rajendran
	<varshini.rajendran@microchip.com>, Mark Brown <broonie@kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v2] spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer SoC families
Date: Wed, 30 Oct 2024 09:44:46 +0100
Message-ID: <20241030084445.2438750-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730277917;VERSION=7979;MC=2867805427;ID=197345;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667763

Refactor the code to introduce an ops struct, to prepare for merging
support for later SoCs, such as SAMA7G5. This code was based on the
vendor's kernel (linux4microchip). Cc'ing original contributors.

Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Varshini Rajendran <varshini.rajendran@microchip.com>

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

Notes:
    Changes in v2:
    * Remove obsolete SPI naming

 drivers/spi/atmel-quadspi.c | 111 +++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 95cdfc28361e..1d256ab3f7f2 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -138,11 +138,15 @@
 #define QSPI_WPSR_WPVSRC_MASK           GENMASK(15, 8)
 #define QSPI_WPSR_WPVSRC(src)           (((src) << 8) & QSPI_WPSR_WPVSRC)
 
+#define ATMEL_QSPI_TIMEOUT		1000	/* ms */
+
 struct atmel_qspi_caps {
 	bool has_qspick;
 	bool has_ricr;
 };
 
+struct atmel_qspi_ops;
+
 struct atmel_qspi {
 	void __iomem		*regs;
 	void __iomem		*mem;
@@ -150,13 +154,22 @@ struct atmel_qspi {
 	struct clk		*qspick;
 	struct platform_device	*pdev;
 	const struct atmel_qspi_caps *caps;
+	const struct atmel_qspi_ops *ops;
 	resource_size_t		mmap_size;
 	u32			pending;
+	u32			irq_mask;
 	u32			mr;
 	u32			scr;
 	struct completion	cmd_completion;
 };
 
+struct atmel_qspi_ops {
+	int (*set_cfg)(struct atmel_qspi *aq, const struct spi_mem_op *op,
+		       u32 *offset);
+	int (*transfer)(struct spi_mem *mem, const struct spi_mem_op *op,
+			u32 offset);
+};
+
 struct atmel_qspi_mode {
 	u8 cmd_buswidth;
 	u8 addr_buswidth;
@@ -404,10 +417,60 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 	return 0;
 }
 
+static int atmel_qspi_wait_for_completion(struct atmel_qspi *aq, u32 irq_mask)
+{
+	int err = 0;
+	u32 sr;
+
+	/* Poll INSTRuction End status */
+	sr = atmel_qspi_read(aq, QSPI_SR);
+	if ((sr & irq_mask) == irq_mask)
+		return 0;
+
+	/* Wait for INSTRuction End interrupt */
+	reinit_completion(&aq->cmd_completion);
+	aq->pending = sr & irq_mask;
+	aq->irq_mask = irq_mask;
+	atmel_qspi_write(irq_mask, aq, QSPI_IER);
+	if (!wait_for_completion_timeout(&aq->cmd_completion,
+					 msecs_to_jiffies(ATMEL_QSPI_TIMEOUT)))
+		err = -ETIMEDOUT;
+	atmel_qspi_write(irq_mask, aq, QSPI_IDR);
+
+	return err;
+}
+
+static int atmel_qspi_transfer(struct spi_mem *mem,
+			       const struct spi_mem_op *op, u32 offset)
+{
+	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->controller);
+
+	/* Skip to the final steps if there is no data */
+	if (!op->data.nbytes)
+		return atmel_qspi_wait_for_completion(aq,
+						      QSPI_SR_CMD_COMPLETED);
+
+	/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
+	(void)atmel_qspi_read(aq, QSPI_IFR);
+
+	/* Send/Receive data */
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		memcpy_fromio(op->data.buf.in, aq->mem + offset,
+			      op->data.nbytes);
+	else
+		memcpy_toio(aq->mem + offset, op->data.buf.out,
+			    op->data.nbytes);
+
+	/* Release the chip-select */
+	atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
+
+	return atmel_qspi_wait_for_completion(aq, QSPI_SR_CMD_COMPLETED);
+}
+
 static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->controller);
-	u32 sr, offset;
+	u32 offset;
 	int err;
 
 	/*
@@ -416,46 +479,20 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	 * when the flash memories overrun the controller's memory space.
 	 */
 	if (op->addr.val + op->data.nbytes > aq->mmap_size)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
+
+	if (op->addr.nbytes > 4)
+		return -EOPNOTSUPP;
 
 	err = pm_runtime_resume_and_get(&aq->pdev->dev);
 	if (err < 0)
 		return err;
 
-	err = atmel_qspi_set_cfg(aq, op, &offset);
+	err = aq->ops->set_cfg(aq, op, &offset);
 	if (err)
 		goto pm_runtime_put;
 
-	/* Skip to the final steps if there is no data */
-	if (op->data.nbytes) {
-		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
-		(void)atmel_qspi_read(aq, QSPI_IFR);
-
-		/* Send/Receive data */
-		if (op->data.dir == SPI_MEM_DATA_IN)
-			memcpy_fromio(op->data.buf.in, aq->mem + offset,
-				      op->data.nbytes);
-		else
-			memcpy_toio(aq->mem + offset, op->data.buf.out,
-				    op->data.nbytes);
-
-		/* Release the chip-select */
-		atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
-	}
-
-	/* Poll INSTRuction End status */
-	sr = atmel_qspi_read(aq, QSPI_SR);
-	if ((sr & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
-		goto pm_runtime_put;
-
-	/* Wait for INSTRuction End interrupt */
-	reinit_completion(&aq->cmd_completion);
-	aq->pending = sr & QSPI_SR_CMD_COMPLETED;
-	atmel_qspi_write(QSPI_SR_CMD_COMPLETED, aq, QSPI_IER);
-	if (!wait_for_completion_timeout(&aq->cmd_completion,
-					 msecs_to_jiffies(1000)))
-		err = -ETIMEDOUT;
-	atmel_qspi_write(QSPI_SR_CMD_COMPLETED, aq, QSPI_IDR);
+	err = aq->ops->transfer(mem, op, offset);
 
 pm_runtime_put:
 	pm_runtime_mark_last_busy(&aq->pdev->dev);
@@ -571,12 +608,17 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	aq->pending |= pending;
-	if ((aq->pending & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
+	if ((aq->pending & aq->irq_mask) == aq->irq_mask)
 		complete(&aq->cmd_completion);
 
 	return IRQ_HANDLED;
 }
 
+static const struct atmel_qspi_ops atmel_qspi_ops = {
+	.set_cfg = atmel_qspi_set_cfg,
+	.transfer = atmel_qspi_transfer,
+};
+
 static int atmel_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl;
@@ -601,6 +643,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
 	init_completion(&aq->cmd_completion);
 	aq->pdev = pdev;
+	aq->ops = &atmel_qspi_ops;
 
 	/* Map the registers */
 	aq->regs = devm_platform_ioremap_resource_byname(pdev, "qspi_base");
-- 
2.34.1



