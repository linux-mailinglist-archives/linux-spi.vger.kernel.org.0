Return-Path: <linux-spi+bounces-5477-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D459B0986
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34A61F213F4
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4476718756A;
	Fri, 25 Oct 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E4rZAhmP"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226C189913
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872917; cv=none; b=iOr1I1DbkSg8DjAMGdVTjV7pwF9XJpLcTvwOPKMj5HBAixF4K3th28IA0zOHP/nSOSgUwt8DE1Q3Us5N2MmKKrT+gYKYk5jrhfE5uejfjn3/pWGYDl+e+G0Xp40hPXcqQuK0EHG6cJjY1AZUmO+icueUExQ/2XvBPxJFkI/+Sfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872917; c=relaxed/simple;
	bh=ay70kDEsaUyiL5tdQVLaK6toJUKIWavvUx/NSizoM20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9I3nHf9FOoCPDFhCh/Epu6HaRZ9heB1tZKy6ccDeOUSEHZ9GIct2HhiJCa24uZ/gd2VoF7MyPB81eRWHgOfpciZF+vnVkKb2WIPvc4HIlPif9X5aRQQ1scumvwtjHX8iuk4iY8hD1T0z6PRbbidGA1u9ozZqJqzclWL7Pn1u64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E4rZAhmP; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6E08E0006;
	Fri, 25 Oct 2024 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29SSgGVv0L/MV1x6zWKogOHokK9PmCL1QTWcSrPR3hQ=;
	b=E4rZAhmPb45D1L/mNCtcVFwR11sx7KLibzx0eg9qfXcKfDxOh21ZM6BUyn7mpoGmXDKxsK
	7Y8/N3GJLxjqB25Y7hQ1wpMi+drI6lVNbqzRqqd0UTiqn7HKLI6bS5finZZbkN8SotNxao
	HUpPTFGWJhrGH69wdzwm4rCK35JIl2pXSiOzAf1liwVPp0GrA4JmZ4WW16xBCZ8iGTwD2S
	bxGj+rCZgHyrvG0Hckj1bMVqUZnxYyLaix2b0ea0SEGzs02WB77jibaT6rzl4gIGSwrYZv
	jCRM5JRzJo8PVBAAMLaAGs2ZKLFqep5zARqeii1HtYGmjJ48YIz6b66yss9VPQ==
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
Subject: [PATCH 09/24] spi: mt65xx: Support per spi-mem operation frequency switches
Date: Fri, 25 Oct 2024 18:14:46 +0200
Message-ID: <20241025161501.485684-10-miquel.raynal@bootlin.com>
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

The per-operation frequency capability is thus advertised to the spi-mem
core.

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mt65xx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 36c2f52cd6b8..8b49d1acd73c 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -952,7 +952,7 @@ static int mtk_spi_mem_exec_op(struct spi_mem *mem,
 
 	mtk_spi_reset(mdata);
 	mtk_spi_hw_init(mem->spi->controller, mem->spi);
-	mtk_spi_prepare_transfer(mem->spi->controller, mem->spi->max_speed_hz);
+	mtk_spi_prepare_transfer(mem->spi->controller, op->max_freq);
 
 	reg_val = readl(mdata->base + SPI_CFG3_IPM_REG);
 	/* opcode byte len */
@@ -1113,6 +1113,10 @@ static const struct spi_controller_mem_ops mtk_spi_mem_ops = {
 	.exec_op = mtk_spi_mem_exec_op,
 };
 
+static const struct spi_controller_mem_caps mtk_spi_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int mtk_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1151,6 +1155,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	if (mdata->dev_comp->ipm_design) {
 		mdata->dev = dev;
 		host->mem_ops = &mtk_spi_mem_ops;
+		host->mem_caps = &mtk_spi_mem_caps;
 		init_completion(&mdata->spimem_done);
 	}
 
-- 
2.43.0


