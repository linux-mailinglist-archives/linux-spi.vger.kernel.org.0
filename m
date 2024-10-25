Return-Path: <linux-spi+bounces-5472-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C499B097E
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E97B1C22CE6
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232DF1D86FF;
	Fri, 25 Oct 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ABNP5yV+"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F20A1CC8AB
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872912; cv=none; b=LiyCiRJV71wCmvQzOloAglvbGaISBJmD2Bhi+V2nWDSqESpKvNHglGhAjb6pPOPRPEfyjBG9/uX1+FIRDtGJpe8Qpyd3ZBg3m7Fr0ngmAqTII1qdKoipFMIXUIQb8EEoz42nGrriNoTE1WP16W0qrzxnZ5DvqBdP9Dzo5x+KnEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872912; c=relaxed/simple;
	bh=DJPKiq8Cj2q2rkLXGYvHepj1sIcBqSnzmgeI98LSoIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkP4fq+B4OwCKbWWvGgCOrC+s/9sct1UyZHnIGISFcmFb57PyiCvm+qurTfRVhRKfAoW5nFYqByhtnBDti6pCpTITbQSR3bxVKnk71mtsSx4qcBQ7UuXjRejwKB3LSK0NN14vt0P3eG5rIEeTvsgUV1DbgNz/BbT23rfRgahYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ABNP5yV+; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29DD9E000A;
	Fri, 25 Oct 2024 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0vC0DL0bDzRlD8Mzhgsf/g4p+1Jphg3XH+Wo7G+9lo=;
	b=ABNP5yV+IqzOu77m+jOHMwud+fQf/AyzU0Vozov+woSMNv7sK0sTKgCGzVoFb8r8fvZ7Vo
	bLJKp2gndHhjdWjZXMNI3KMp33uyOjnESouNzFMyZ25Oju3h2ZzjcUBYMqU4IQwjpYn6Mq
	7yMgoI19dLaw1LrZbF453Z7AIrDG77296oall8SOEL8NanX+cVgctkosbO7gqvob12i9H8
	sqP6dXe18Czg2HuABTTqh+R+kXHYUKj22Jnd2sABOFE/rMePdUyf+pcOXgV2Przidbk2zI
	8NviwJGS8lwN1DdPwq5XUtLrDsqgElptOA4M2xXTjHvHRWhvZ9+rQQZHQXBFaA==
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
Subject: [PATCH 04/24] spi: amlogic-spifc-a1: Support per spi-mem operation frequency switches
Date: Fri, 25 Oct 2024 18:14:41 +0200
Message-ID: <20241025161501.485684-5-miquel.raynal@bootlin.com>
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
 drivers/spi/spi-amlogic-spifc-a1.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
index fadf6667cd51..18c9aa2cbc29 100644
--- a/drivers/spi/spi-amlogic-spifc-a1.c
+++ b/drivers/spi/spi-amlogic-spifc-a1.c
@@ -259,7 +259,7 @@ static int amlogic_spifc_a1_exec_op(struct spi_mem *mem,
 	size_t data_size = op->data.nbytes;
 	int ret;
 
-	ret = amlogic_spifc_a1_set_freq(spifc, mem->spi->max_speed_hz);
+	ret = amlogic_spifc_a1_set_freq(spifc, op->max_freq);
 	if (ret)
 		return ret;
 
@@ -320,6 +320,10 @@ static const struct spi_controller_mem_ops amlogic_spifc_a1_mem_ops = {
 	.adjust_op_size = amlogic_spifc_a1_adjust_op_size,
 };
 
+static const struct spi_controller_mem_caps amlogic_spifc_a1_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int amlogic_spifc_a1_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl;
@@ -356,6 +360,7 @@ static int amlogic_spifc_a1_probe(struct platform_device *pdev)
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->auto_runtime_pm = true;
 	ctrl->mem_ops = &amlogic_spifc_a1_mem_ops;
+	ctrl->mem_caps = &amlogic_spifc_a1_mem_caps;
 	ctrl->min_speed_hz = SPIFC_A1_MIN_HZ;
 	ctrl->max_speed_hz = SPIFC_A1_MAX_HZ;
 	ctrl->mode_bits = (SPI_RX_DUAL | SPI_TX_DUAL |
-- 
2.43.0


