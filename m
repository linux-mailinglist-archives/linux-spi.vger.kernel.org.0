Return-Path: <linux-spi+bounces-6170-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EAE9FC0BB
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 18:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DEC165109
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C910212D95;
	Tue, 24 Dec 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZWKmgERF"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12102135D5;
	Tue, 24 Dec 2024 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735060032; cv=none; b=kJjTUFu1DXSbQboq6MhS2022jLen7ry5QlWibYc8dSE6fyj6c34Lpgl2NvhI4M4pOaUbL2/93DHPdnxdokBdURn6jtnjx74B8jPkcZuRtHcI0uEEDTz7OH610K4ecyCeZVMKfeGIjVmDGs9Odt+407oxbEhd029E05OSN6QpYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735060032; c=relaxed/simple;
	bh=TKm9n9D4fhpze2cEh1mmvZQ8OY1fea8h08ypTR3zGfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwlBWqDhoZxw9aAsX89I7Q16kwW8IyToJU+TpAgtiq/D2V6Fm2UuwqWLOGyPWcW3qM5CZ1VXouz7PZWZiEKJS5FB2P45GVjPOy0S/rpFU8LXbvmIwbslW6Tbs8I15FnOx8rv56JFdrAAcckgO8jFQev8FCXZEacJV6XOG5X9AJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZWKmgERF; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF6EA40005;
	Tue, 24 Dec 2024 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735060029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPTwujdULqDMAWJvUaFFPZ6Ty000e2Bmk5z+jRzLZ3I=;
	b=ZWKmgERFc9lmwxxx6UvyJo+HxANoWAKFnt/84JjZx6t4upVdrlwsfWjPeuUq0FzAgyEy2V
	shJMU0k3uOASbarNefu0/toxF9Ps41PKa8/7p2T8WOuvxGopWz3GPQFWE8P85t2tlE94+J
	KtOa58aSvfYrt2wSk3EV3aLtdFGKCWiJqyBkUJnFoVjd9Q7u+p3UO7Jz45ZylJT3sLWl1w
	nzWNmOxyeogdCFXripvD68o2ySV+xFEEEqPwnUWpBL1Qw15mT7yDGUH9GMNQgd5QZDkQby
	2X9/D8BdT4Xodu2qrCeJUPqRR/kgmoVlDw9kPD+uIFaxUrHmS9ndMaoaPEvjAg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Dec 2024 18:05:55 +0100
Subject: [PATCH v2 10/27] spi: mt65xx: Support per spi-mem operation
 frequency switches
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-winbond-6-11-rc1-quad-support-v2-10-ad218dbc406f@bootlin.com>
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

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mt65xx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 85f3bafc975dbc3fd95f77b8dcfc0ca9aac32f5d..197bf2dbe5de7e853ccddf2c90d8bff40202f025 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -961,7 +961,7 @@ static int mtk_spi_mem_exec_op(struct spi_mem *mem,
 
 	mtk_spi_reset(mdata);
 	mtk_spi_hw_init(mem->spi->controller, mem->spi);
-	mtk_spi_prepare_transfer(mem->spi->controller, mem->spi->max_speed_hz);
+	mtk_spi_prepare_transfer(mem->spi->controller, op->max_freq);
 
 	reg_val = readl(mdata->base + SPI_CFG3_IPM_REG);
 	/* opcode byte len */
@@ -1122,6 +1122,10 @@ static const struct spi_controller_mem_ops mtk_spi_mem_ops = {
 	.exec_op = mtk_spi_mem_exec_op,
 };
 
+static const struct spi_controller_mem_caps mtk_spi_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int mtk_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1160,6 +1164,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	if (mdata->dev_comp->ipm_design) {
 		mdata->dev = dev;
 		host->mem_ops = &mtk_spi_mem_ops;
+		host->mem_caps = &mtk_spi_mem_caps;
 		init_completion(&mdata->spimem_done);
 	}
 

-- 
2.47.0


