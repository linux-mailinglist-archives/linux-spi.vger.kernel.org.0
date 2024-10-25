Return-Path: <linux-spi+bounces-5482-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC29B098B
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465D21C231E7
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C406188583;
	Fri, 25 Oct 2024 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OOh5JNyh"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA85C187877
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872922; cv=none; b=ONmZQJ29xFAiLJl7D3Vupv3AJMA+FK/gOddgIZb3FIcUpiih7DfCLamgzzxzz09T9TeTZffdRP+294KvnwIvro8gLpRGUrAQA+sF/ivbQMArmQ0OrcNQk27/4pN7hyDRy4FlGvgInvdWKs4CrcPCVk81RZ7GtHh41PW091ltW68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872922; c=relaxed/simple;
	bh=E3so5GPqO6lYK6I95+bYhHkhliplPTbAdRzVknIBZFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELSsBG26+r9f06jvHmTucWwNRme9LxACl2ksApO8jjEnyz72AakKAUU3Z2/Jo+sQnM2C2ZL6S5nKdFDZ8GQhbSFpZ5EQ2aDuNf7EcMHcGPB70d9RHsQGNEUgOSuWHuFR3l0DJv9/Puol3MBhu5pYp1xApAf9S+9sRj00gmSOJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OOh5JNyh; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A197E0006;
	Fri, 25 Oct 2024 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKND3LIYgR1AN1EmSepdOfhyWMAXG9qLwbCjvI13gwc=;
	b=OOh5JNyhPmtZ+73pjLqAr0l8FQciiNgv0iEG2IRRyVXsPujwW1whJXrOmTyjM2HUIRvx/T
	N6ku+z/a17z5k6nD8ipOk9ruvXp9DO1K18O+S3aQeWH6rMBAtVlufeVJJnrrQnIbymenx5
	qIaxOz9zW8G8QsURIw8/Xeh5IAsYikcyoy6h2art9eTybBLlnkdta5CmsWCVOy3P9linrE
	pKqZ+aq3Bg+0hdquFi8WUtCF4bfaV+hKqW048D4cCOjO/v5xkTW8TmDl/HApxvlFMbpL/G
	ubNfpGqtKwdgXdBOcx807lKpoR51PplCRhyBL6xfBwWCePLqCpRB9s0rnwowrw==
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
Subject: [PATCH 14/24] spi: spi-ti-qspi: Support per spi-mem operation frequency switches
Date: Fri, 25 Oct 2024 18:14:51 +0200
Message-ID: <20241025161501.485684-15-miquel.raynal@bootlin.com>
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

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-ti-qspi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 0fe6899e78dd..36a3a650160d 100644
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
2.43.0


