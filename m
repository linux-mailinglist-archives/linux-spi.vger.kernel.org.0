Return-Path: <linux-spi+bounces-6176-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD79FC0C7
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 18:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C2E16532C
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EE221420C;
	Tue, 24 Dec 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o9cmLlei"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D35214203;
	Tue, 24 Dec 2024 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735060061; cv=none; b=fVduCdtKym9zlfSl6N7IEgKnQW6vaK8P/XVg7X9rolq9LBAgX044rWKTezKT8D1+WmRXhtktggpkSJ26cQBCwwmL57tb6UbYyJSlWTla4S01e7MFiFffYggI6aCFaohv36hx614HNDjNjRcIN+EjTYfTYGHxHMjdj63WaJXY4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735060061; c=relaxed/simple;
	bh=MGW29IUoGrPhIwu1wd92X/ceTEAzhoShMYyFycHDplo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mxsS5ccgh4cbtUa9eQNofistJ/jT+MAuG2p1rB8Z5PB8/m2Dnn7THHRtEcTMst4yopBuAW1EcMwbh8goZJTHBqx6nzq+tYZdOy+G6kf+LmfLTSssJDpoSjQoWy8t8WBJT74DFjVc7CfAC14/G3BS5gJiV57PX77viQ9SEQCsqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o9cmLlei; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4653940002;
	Tue, 24 Dec 2024 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735060058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrGU5YmafXBcwzax7Dz7/fkc5aKf/Lo+6Qt8hqq78ww=;
	b=o9cmLlei4SVjACmnx8b9OR17EDa9MM8UqcY95EsA75X6fF5V55vjDRjx6S/m4N5rv61PMV
	Qg9pjzjzdnmwCj+bdQwuOGNte7wETrmUz1JOty5bUgGke0N/UaoI5+vkTHK8LVw1T1IVuz
	PQ1Zkmxrnc+Bmwr1g9lLsFzQ8jojwMNwizGoU1g/UAmb4oCUUwbk8++N6d5oGjFLJWrcEn
	3HnOM41v0tL1h/opiKnYgNKlhdAHzmF8LniGkL7z0LekHLcYNF6+PTROTXb8l2HMCujaZC
	EnuGOoTh4fSBqmWqCn4QNi5iGH2SEtsVBQfOy0yAAO0hOu7vW8682g/tQCB+ig==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:06:01 +0100
Subject: [PATCH v2 16/27] spi: zynq-qspi: Support per spi-mem operation
 frequency switches
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-16-ad218dbc406f@bootlin.com>
References: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
In-Reply-To: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
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

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynq-qspi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index dee9c339a35e74c86fe1c768990a3f870b0a1b9d..f3cacb01e25b97892f9fbefc6e5cf43b9722ae4d 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -318,6 +318,7 @@ static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
  * zynq_qspi_config_op - Configure QSPI controller for specified transfer
  * @xqspi:	Pointer to the zynq_qspi structure
  * @spi:	Pointer to the spi_device structure
+ * @op:		The memory operation to execute
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer and
  * sets the requested clock frequency.
@@ -331,7 +332,8 @@ static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
  * controller the driver will set the highest or lowest frequency supported by
  * controller.
  */
-static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
+static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi,
+			       const struct spi_mem_op *op)
 {
 	u32 config_reg, baud_rate_val = 0;
 
@@ -346,7 +348,7 @@ static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
 	 */
 	while ((baud_rate_val < ZYNQ_QSPI_CONFIG_BAUD_DIV_MAX)  &&
 	       (clk_get_rate(xqspi->refclk) / (2 << baud_rate_val)) >
-		spi->max_speed_hz)
+		op->max_freq)
 		baud_rate_val++;
 
 	config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_CONFIG_OFFSET);
@@ -534,7 +536,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 		op->dummy.buswidth, op->data.buswidth);
 
 	zynq_qspi_chipselect(mem->spi, true);
-	zynq_qspi_config_op(xqspi, mem->spi);
+	zynq_qspi_config_op(xqspi, mem->spi, op);
 
 	if (op->cmd.opcode) {
 		reinit_completion(&xqspi->data_completion);
@@ -620,6 +622,10 @@ static const struct spi_controller_mem_ops zynq_qspi_mem_ops = {
 	.exec_op = zynq_qspi_exec_mem_op,
 };
 
+static const struct spi_controller_mem_caps zynq_qspi_mem_caps = {
+	.per_op_freq = true,
+};
+
 /**
  * zynq_qspi_probe - Probe method for the QSPI driver
  * @pdev:	Pointer to the platform_device structure
@@ -706,6 +712,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	ctlr->mode_bits =  SPI_RX_DUAL | SPI_RX_QUAD |
 			    SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->mem_ops = &zynq_qspi_mem_ops;
+	ctlr->mem_caps = &zynq_qspi_mem_caps;
 	ctlr->setup = zynq_qspi_setup_op;
 	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
 	ctlr->dev.of_node = np;

-- 
2.47.0


