Return-Path: <linux-spi+bounces-5476-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A98C9B0985
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D9B1F214E3
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21DE200BA0;
	Fri, 25 Oct 2024 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cKsPAWHT"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A0B1FB8A9
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872916; cv=none; b=jyuuVzgwbfnec31ucUaAr0xT7CYpabcSEmMudcmVNHd+Km/mY7X7uRm0ZmUpyofYj3qO75XGNrMbbYzBO8DUafwArKi0hjx8Sw9DBjbo0pRKKe3weSIk/1ppLyrxdsQwF5TVJg7blzJyjX4xDHFObt3XKZJs6smvL9+tgz9tpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872916; c=relaxed/simple;
	bh=jQjgNo/j9WlpE6VHIP5HNiZRW4oCdy1G45/vLVHQcTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frpaKgza8blBx1gFXiUiZ7m6OybPS/uOAoHnahp7njSWOuXMmi7rCIfpNOMarlrwiRDxV6fHYfvW4bX2JIOM0YYuCd7iDkjHaxgJBIatXMu5kxX18OIpXQjP3W90FGpHBlrUAGlQBvPGMwXURNvkLnqwhnYozx6gorQ7MFuBI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cKsPAWHT; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85C35E0005;
	Fri, 25 Oct 2024 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+Arawoy3cRQk8LqoPoTZ3YWsca5b3szqcopcA2j82k=;
	b=cKsPAWHTgHlQqV7eK7/UuYKyUx5BWXxvsxOBzdJkuzhNxKlSX5hOBK0QK4CRI1a3615xYr
	gtpSjJj0uQCCZgWxfW1VYtxu6AdhnCOWnMvA+HZOb5iDBLkBB5FVfEZ4POVSbZ3pOlu3/H
	2ZXN/WkMdZlAenSJeq62vGFcWYCX3IHE545B3SZ8sNxAVfLSQy0+wkxGZFx7K87oKN88+e
	9yn/kdmtjbF12W3Vg6QGO48CB85Ex0xKGqSjc1Nx/T/sBdSe+ZvR7DDct5/LvoICpXEjlP
	/m08V1mjfLjaVeEF/6rGuogzqJfhtWgKyFmG6B7i20JkDjxqK+tH8uLTYVcHzg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>,
	Steam Lin <stlin2@winbond.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 08/24] spi: microchip-core-qspi: Support per spi-mem operation frequency switches
Date: Fri, 25 Oct 2024 18:14:45 +0200
Message-ID: <20241025161501.485684-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025161501.485684-1-miquel.raynal@bootlin.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Every ->exec_op() call correctly configures the spi bus speed to the
maximum allowed frequency for the memory using the constant spi default
parameter. Since we can now have per-operation constraints, let's use
the value that comes from the spi-mem operation structure instead. In
case there is no specific limitation for this operation, the default spi
device value will be given anyway.

This controller however performed a frequency check, which is also
observed during the ->check_op() phase.

The per-operation frequency capability is thus advertised to the spi-mem
core.

Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 09f16471c537..eb5c388895cf 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -265,7 +265,8 @@ static irqreturn_t mchp_coreqspi_isr(int irq, void *dev_id)
 	return ret;
 }
 
-static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_device *spi)
+static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_device *spi,
+				     const struct spi_mem_op *op)
 {
 	unsigned long clk_hz;
 	u32 control, baud_rate_val = 0;
@@ -274,11 +275,11 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
 	if (!clk_hz)
 		return -EINVAL;
 
-	baud_rate_val = DIV_ROUND_UP(clk_hz, 2 * spi->max_speed_hz);
+	baud_rate_val = DIV_ROUND_UP(clk_hz, 2 * op->max_freq);
 	if (baud_rate_val > MAX_DIVIDER || baud_rate_val < MIN_DIVIDER) {
 		dev_err(&spi->dev,
 			"could not configure the clock for spi clock %d Hz & system clock %ld Hz\n",
-			spi->max_speed_hz, clk_hz);
+			op->max_freq, clk_hz);
 		return -EINVAL;
 	}
 
@@ -399,7 +400,7 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 	if (err)
 		goto error;
 
-	err = mchp_coreqspi_setup_clock(qspi, mem->spi);
+	err = mchp_coreqspi_setup_clock(qspi, mem->spi, op);
 	if (err)
 		goto error;
 
@@ -457,6 +458,10 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 
 static bool mchp_coreqspi_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
+	struct mchp_coreqspi *qspi = spi_controller_get_devdata(mem->spi->controller);
+	unsigned long clk_hz;
+	u32 baud_rate_val;
+
 	if (!spi_mem_default_supports_op(mem, op))
 		return false;
 
@@ -479,6 +484,14 @@ static bool mchp_coreqspi_supports_op(struct spi_mem *mem, const struct spi_mem_
 			return false;
 	}
 
+	clk_hz = clk_get_rate(qspi->clk);
+	if (!clk_hz)
+		return false;
+
+	baud_rate_val = DIV_ROUND_UP(clk_hz, 2 * op->max_freq);
+	if (baud_rate_val > MAX_DIVIDER || baud_rate_val < MIN_DIVIDER)
+		return false;
+
 	return true;
 }
 
@@ -498,6 +511,10 @@ static const struct spi_controller_mem_ops mchp_coreqspi_mem_ops = {
 	.exec_op = mchp_coreqspi_exec_op,
 };
 
+static const struct spi_controller_mem_caps mchp_coreqspi_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int mchp_coreqspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -540,6 +557,7 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->mem_ops = &mchp_coreqspi_mem_ops;
+	ctlr->mem_caps = &mchp_coreqspi_mem_caps;
 	ctlr->setup = mchp_coreqspi_setup_op;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 			  SPI_TX_DUAL | SPI_TX_QUAD;
-- 
2.43.0


