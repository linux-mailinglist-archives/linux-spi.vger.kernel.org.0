Return-Path: <linux-spi+bounces-5471-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99F69B097D
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0221F24ADE
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64614A0A7;
	Fri, 25 Oct 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bWifIWNM"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A6188736
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872911; cv=none; b=nLR1SZAP8X85VxdzJyhS0a/jQxlKb+0traMuPMo32OCRddN1PoPH+Sr/p5VhrqMxLhgzGC5VHwUVypbnZgFK2jKzS6Fl32UWvpj/cA5QrCvj+iKRwO88jNG9JHx+lROPP0+Xfs4lLFM0691Q84k2extG0SDQUn90EMP6Rsv64Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872911; c=relaxed/simple;
	bh=MkGwT6117BQCrXEANEFKN77Rp4D1T2ZsHRImpeBarSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfF+e17TEdk1TkPXYKnfANCiDqzcHWaGmmEdcEshC+o3TWkexgs1mFKmnyHGJN2VpYCPoOT46Ga1YLUOyt+rTPuhOv5uQEhHTHku1QMSh4mqUL4skJhoky+8xSmgFyomN9ddiUzMj3TfgSx6Ed4FDKgBOeCbX/I+BILituruZeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bWifIWNM; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B20CE000B;
	Fri, 25 Oct 2024 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFZxVOQ/r2YDg2GASorm7X58OaIx5nLZNYaGkN8S2hc=;
	b=bWifIWNMGhOzm/vMfquwTP7zgxTdpFHHCGeukY0hX9SxG1MuhfWxvEIC8k5BoOilU9QWrn
	QYwmIYE/M+nG2XFKL9eOODTy6soZKqxDU0b5PNDUMZ3lmqTy7WznG9DbbAZGGbLpQd/6mb
	GbNO6PJmlteeJYQBmsRvzGvNRflNotrRyO8xCvT9F8CfgrWpBmuJldPWPzzG+SBU+ErODE
	YHZ3dD9w2hvAdtSI67yfr3rTHSkfHMnFjqwGgtQfQqlI36D2gyjhdwEExyw8bJtzWCpRkd
	jQ54uw40l9n8uUgujgc/zsEt8+XNoMJUpivN6vh+pLmlJynydOK/WZXiRAjLXg==
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
Subject: [PATCH 03/24] spi: amd: Support per spi-mem operation frequency switches
Date: Fri, 25 Oct 2024 18:14:40 +0200
Message-ID: <20241025161501.485684-4-miquel.raynal@bootlin.com>
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

Cc: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-amd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 2245ad54b03a..f58dc6375582 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -368,6 +368,9 @@ static bool amd_spi_supports_op(struct spi_mem *mem,
 	    op->data.buswidth > 1 || op->data.nbytes > AMD_SPI_MAX_DATA)
 		return false;
 
+	if (op->max_freq < AMD_SPI_MIN_HZ)
+		return false;
+
 	return spi_mem_default_supports_op(mem, op);
 }
 
@@ -443,7 +446,7 @@ static int amd_spi_exec_mem_op(struct spi_mem *mem,
 
 	amd_spi = spi_controller_get_devdata(mem->spi->controller);
 
-	ret = amd_set_spi_freq(amd_spi, mem->spi->max_speed_hz);
+	ret = amd_set_spi_freq(amd_spi, op->max_freq);
 	if (ret)
 		return ret;
 
@@ -469,6 +472,10 @@ static const struct spi_controller_mem_ops amd_spi_mem_ops = {
 	.supports_op = amd_spi_supports_op,
 };
 
+static const struct spi_controller_mem_caps amd_spi_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int amd_spi_host_transfer(struct spi_controller *host,
 				   struct spi_message *msg)
 {
@@ -521,6 +528,7 @@ static int amd_spi_probe(struct platform_device *pdev)
 	host->setup = amd_spi_host_setup;
 	host->transfer_one_message = amd_spi_host_transfer;
 	host->mem_ops = &amd_spi_mem_ops;
+	host->mem_caps = &amd_spi_mem_caps;
 	host->max_transfer_size = amd_spi_max_transfer_size;
 	host->max_message_size = amd_spi_max_transfer_size;
 
-- 
2.43.0


