Return-Path: <linux-spi+bounces-6298-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA72EA0941F
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 15:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260597A160E
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A3E2135CE;
	Fri, 10 Jan 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sv3UfO/u"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8460A2135B1;
	Fri, 10 Jan 2025 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520353; cv=none; b=PnIL63jh2jhaM3/ihrRT3nPSKDEx6mXr2AAfoEA7BouffUVUuuFvukBGcWCcakS4Ctq86qc8JyB0mz/NsVG6q+VKRSIqU1qLupZofFCWMQeA0cQujiG1BE6SqhCq2Y3QOzC33/krRQvu5TYCkcSrItW+sYMNt4yE2EH0JbgWlos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520353; c=relaxed/simple;
	bh=cLl5NiG7U4cBcrN7Rwg5ybH+2Vhg/7FyE+px0ARkH8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sXnMSNOir78ciDfCrnbhvqyHrTiKeBNwZjdbumRP4mjCJentJifX85HN5kNYBo0Ifb7qGFQHh1ceNNMv9VzZNRHGogIrtQi2JK9HvOOtPfytPP8ZEpTQQlxdquv1fwQBY7TdXSmDuhri1S/bV3lxuCWawo/MFZP0XrbLXeSIVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sv3UfO/u; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E4C1FF80C;
	Fri, 10 Jan 2025 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736520350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUGghYrB4WitsSHuF0lDrbtdh7hpjjhPPG7Q2vRUm6U=;
	b=Sv3UfO/uRhHellLUV7bjdDRHuvtAW2kg1nixqAJ9dIeqwY1briltOT4820Cx4aF7OI3lKe
	yKMs5cQ67wQ5XdxhqDtPGmVzIGpH6UrQ4nRgNg4hMZD+jZ1NckjoJUh5k1vICzx1Y4VePc
	tgzkYxcqgrKhpjzakxLL4E5QAI2mTv6BdHqKRQV6EF9F5HG781prtwREpmhsldzoUJ0o8e
	bX0AfOnOkbJC8L+nYvUX9ST35HS04zMivhXUYqTOddf7lH3PD0aZgZtpd9JLghSYxSg7qn
	yYE0Q4508naMHRxBzkjaG/RlZVGNsWRP0UVLnzH6ntlBZsgXiqI5yLRqcKWJcw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 15:45:19 +0100
Subject: [PATCH v3 17/27] spi: zynqmp-gqspi: Support per spi-mem operation
 frequency switches
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-winbond-6-11-rc1-quad-support-v3-17-7ab4bd56cf6e@bootlin.com>
References: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
In-Reply-To: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Han Xu <han.xu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-mtd@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com

Every ->exec_op() call correctly configures the spi bus speed to the
maximum allowed frequency for the memory using the constant spi default
parameter. Since we can now have per-operation constraints, let's use
the value that comes from the spi-mem operation structure instead. In
case there is no specific limitation for this operation, the default spi
device value will be given anyway.

The per-operation frequency capability is thus advertised to the spi-mem
core.

Cc: Michal Simek <michal.simek@amd.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 549a6e0c96546211223dd45e8e70620fa5fd18ab..d800d79f62a70c74551e1ad6f628685ec6c18b0d 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -535,7 +535,7 @@ static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
  * zynqmp_qspi_config_op - Configure QSPI controller for specified
  *				transfer
  * @xqspi:	Pointer to the zynqmp_qspi structure
- * @qspi:	Pointer to the spi_device structure
+ * @op:		The memory operation to execute
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer and
  * sets the requested clock frequency.
@@ -553,12 +553,12 @@ static inline u32 zynqmp_qspi_selectspimode(struct zynqmp_qspi *xqspi,
  *	frequency supported by controller.
  */
 static int zynqmp_qspi_config_op(struct zynqmp_qspi *xqspi,
-				 struct spi_device *qspi)
+				 const struct spi_mem_op *op)
 {
 	ulong clk_rate;
 	u32 config_reg, req_speed_hz, baud_rate_val = 0;
 
-	req_speed_hz = qspi->max_speed_hz;
+	req_speed_hz = op->max_freq;
 
 	if (xqspi->speed_hz != req_speed_hz) {
 		xqspi->speed_hz = req_speed_hz;
@@ -1072,7 +1072,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 		op->dummy.buswidth, op->data.buswidth);
 
 	mutex_lock(&xqspi->op_lock);
-	zynqmp_qspi_config_op(xqspi, mem->spi);
+	zynqmp_qspi_config_op(xqspi, op);
 	zynqmp_qspi_chipselect(mem->spi, false);
 	genfifoentry |= xqspi->genfifocs;
 	genfifoentry |= xqspi->genfifobus;
@@ -1224,6 +1224,10 @@ static const struct spi_controller_mem_ops zynqmp_qspi_mem_ops = {
 	.exec_op = zynqmp_qspi_exec_op,
 };
 
+static const struct spi_controller_mem_caps zynqmp_qspi_mem_caps = {
+	.per_op_freq = true,
+};
+
 /**
  * zynqmp_qspi_probe - Probe method for the QSPI driver
  * @pdev:	Pointer to the platform_device structure
@@ -1333,6 +1337,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->mem_ops = &zynqmp_qspi_mem_ops;
+	ctlr->mem_caps = &zynqmp_qspi_mem_caps;
 	ctlr->setup = zynqmp_qspi_setup_op;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->dev.of_node = np;

-- 
2.47.0


