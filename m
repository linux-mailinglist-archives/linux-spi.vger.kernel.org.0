Return-Path: <linux-spi+bounces-6173-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A195E9FC0C1
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 18:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E633C1881C17
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4F3212F94;
	Tue, 24 Dec 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DaW6nsGt"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AC5213E71;
	Tue, 24 Dec 2024 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735060046; cv=none; b=PwIIlxZHDPL0iG4smj4n07QHAReWInxXpGCckkVZGTgzRG1Yd2k5Fq8OY5t8vXGEw/fvDMIB4HdQVunS31177Y/ptNN/eUG7fURbpxcCF5zCIBQNcjEPa83NFVr99dtmpntSPErn4Ka4lCmCYTFsecUhejLROUmhSsjN0y/Kigo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735060046; c=relaxed/simple;
	bh=MNRDH89ZYKVuwkMKRXorlhqbPyg4neeuxaTuBODU+/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PNv16i6zjSiAscAd53H5mNPhuGe0juTK7v5ytP1++p2jXnGb9Ayw73baObQ9wjIn+8WPhSoTWX2nXSSmc/8FBxuG5pk5yIwrHMkeAf9/Uu76gRJokHcxTOY9SbMVOUmbdQFxpM5CsUeds+WHXY0tMpL+G3GAU5RWxbPl1U08VXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DaW6nsGt; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E12540006;
	Tue, 24 Dec 2024 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735060043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEtesl+ZX1jKYhDEYl+ivyiJHI5wxENJqdJo8H/qVyg=;
	b=DaW6nsGtxuL+VYTH1qyP+YcJ77RsDjocTmrTX77zhswDh2dpoPQ7dTfszm/J3jjEBRY5KB
	aooxCYrkpL4fX16VawH5/5KqUNJsk9aqS6BGmvbz6ObcpbsaFmYgLZQlEx+Bodnu5oWR3P
	KRIBVH9kiSLknUd3N6A1zOWiFvQJcEbXzqEt+ITzV+92bY3YGH7x1qw0+MyPohznFDJNlN
	GdNaNe4cJbRvKcA6QWHpdfUlnJpsIWl8PP66NbhgGyxBAfnD5YdxpCi8r3QWvEUomyv2XN
	hVZ22K0QC0AyukvmC4TpqJTrn8KHwL5hqbww3Eea1wOCIfneUyUkesAjY9jKHA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:05:58 +0100
Subject: [PATCH v2 13/27] spi: rockchip-sfc: Support per spi-mem operation
 frequency switches
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-13-ad218dbc406f@bootlin.com>
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

Cc: Han Xu <han.xu@nxp.com>
Cc: Haibo Chen <haibo.chen@nxp.com>
Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-rockchip-sfc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 69d0f21755684a8a01724c29eb97123044dcf6ae..a8163fbc18923f8a96114785e46623476cf97d04 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -491,11 +491,11 @@ static int rockchip_sfc_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op
 	u32 len = op->data.nbytes;
 	int ret;
 
-	if (unlikely(mem->spi->max_speed_hz != sfc->frequency)) {
-		ret = clk_set_rate(sfc->clk, mem->spi->max_speed_hz);
+	if (unlikely(op->max_freq != sfc->frequency)) {
+		ret = clk_set_rate(sfc->clk, op->max_freq);
 		if (ret)
 			return ret;
-		sfc->frequency = mem->spi->max_speed_hz;
+		sfc->frequency = op->max_freq;
 		dev_dbg(sfc->dev, "set_freq=%dHz real_freq=%ldHz\n",
 			sfc->frequency, clk_get_rate(sfc->clk));
 	}
@@ -535,6 +535,10 @@ static const struct spi_controller_mem_ops rockchip_sfc_mem_ops = {
 	.adjust_op_size = rockchip_sfc_adjust_op_size,
 };
 
+static const struct spi_controller_mem_caps rockchip_sfc_mem_caps = {
+	.per_op_freq = true,
+};
+
 static irqreturn_t rockchip_sfc_irq_handler(int irq, void *dev_id)
 {
 	struct rockchip_sfc *sfc = dev_id;
@@ -567,6 +571,7 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 
 	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	host->mem_ops = &rockchip_sfc_mem_ops;
+	host->mem_caps = &rockchip_sfc_mem_caps;
 	host->dev.of_node = pdev->dev.of_node;
 	host->mode_bits = SPI_TX_QUAD | SPI_TX_DUAL | SPI_RX_QUAD | SPI_RX_DUAL;
 	host->max_speed_hz = SFC_MAX_SPEED;

-- 
2.47.0


