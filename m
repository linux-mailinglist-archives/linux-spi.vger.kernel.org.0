Return-Path: <linux-spi+bounces-6175-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A5A9FC0C5
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 18:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034E61884B4B
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDC9212FAA;
	Tue, 24 Dec 2024 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DYX7H+op"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6D213E98;
	Tue, 24 Dec 2024 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735060057; cv=none; b=ujF+tlF/AbygBj+1svYos6Lhl7tQ1XhbA36aUVmQfLUej8tWqKiuWUGKH3AKvl2tu6rN+ZcmS50nI/Cbfb30e+4zG3nmkV8+lQUbvc6jSmtTLkWi6I/a0GEyKu2MXa2fbnpgB3LJaQcQECECH2biaTgSjXbL30TkmLZ47ENtqj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735060057; c=relaxed/simple;
	bh=tdzOHSmhGBFud+Mj9GWjh3iEegUbdmip/OfwD7jW+Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQ218htZYx+7XY0sa0T9KJx6/N+g/ri1D5rnUuPs7cgZ+jLCe1YaN0Jhpfu9sQW77NJbxVa0kYh9ziMTQY3ieQ39ZjfNCFCgo9pb0gCjwMkU9LDF0Qk2kASVRNVgyLbuV6iItzHceQUl8DcgQ9p4kwqcBu/3jKykRMLOqTaVQt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DYX7H+op; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B5DC40004;
	Tue, 24 Dec 2024 17:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735060054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dlkm5iEGnjrM/0g/DWcfF67rhxN4oprE30zNEwCGgo0=;
	b=DYX7H+opRaGC9vHfQchChEJj2F8PQOQdXIHRPK9bAOM+u/ERMSIVBuyKyi7AWeAjlJ7rHn
	kdRcyZ2B52m5tEQnLPgXhTDFxP+sfKXOUkSSpBYnBaYf5N2R0ppYswTQtcAkzqiYyj8Kwf
	ycDSoKLOuZ7fwI4eCn351YiEe4+b/unBiog0OZhgh6EnsqB0OrZdNP4XSm1FWprx+uGIVJ
	m/49JVxPD0jC1QD1GS4mbPFJLGxeYq+sMoO8pyIZWDRpb/76W2GKA6X/KMj2pVMXHRvB3n
	e7W/cA4MNxJvBa0gXhGmTTRntEE2hjbM6aZiLYfdAz08IAc6CtzcEPLRKpZJeQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:06:00 +0100
Subject: [PATCH v2 15/27] spi: spi-ti-qspi: Support per spi-mem operation
 frequency switches
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-15-ad218dbc406f@bootlin.com>
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

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-ti-qspi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 9122350402b5062dfc8bcf70ac47ba51fad64b3e..49516fee74b0f2062c43d714fcb97c7a55580b37 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -623,7 +623,7 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 	mutex_lock(&qspi->list_lock);
 
 	if (!qspi->mmap_enabled || qspi->current_cs != spi_get_chipselect(mem->spi, 0)) {
-		ti_qspi_setup_clk(qspi, mem->spi->max_speed_hz);
+		ti_qspi_setup_clk(qspi, op->max_freq);
 		ti_qspi_enable_memory_map(mem->spi);
 	}
 	ti_qspi_setup_mmap_read(mem->spi, op->cmd.opcode, op->data.buswidth,
@@ -658,6 +658,10 @@ static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
 	.adjust_op_size = ti_qspi_adjust_op_size,
 };
 
+static const struct spi_controller_mem_caps ti_qspi_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int ti_qspi_start_transfer_one(struct spi_controller *host,
 		struct spi_message *m)
 {
@@ -777,6 +781,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	host->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
 				   SPI_BPW_MASK(8);
 	host->mem_ops = &ti_qspi_mem_ops;
+	host->mem_caps = &ti_qspi_mem_caps;
 
 	if (!of_property_read_u32(np, "num-cs", &num_cs))
 		host->num_chipselect = num_cs;

-- 
2.47.0


