Return-Path: <linux-spi+bounces-5481-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC2F9B098A
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18071C231C4
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003BD184549;
	Fri, 25 Oct 2024 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nZ/w4Jbq"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893AC18785B
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872922; cv=none; b=Uz7hxbxxJUGvCvpVXgf21plhwEpVys00yo96bHfDr4D9XryHOvekbu9fXCgIcVoUIuPGu8bUQnFmXuAociLGEQjlkV++1iB3H7GtvBHojOdaeG3j1a9YHq47UH8Phi25ut5y/p4EoVII4awzKN3c+UjyMck1+K2dwik7IzYNO08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872922; c=relaxed/simple;
	bh=ewkro0bIQxVhzugGzT92tN9Ov0ntXu1crg1BNIIXvMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LB32zXoSj0EIc8xdr32+l0m7uCN/zUbuKMgHFcsty21qGLBYXbmJYItcVk6w1F+eU1ilJGitgmPg68wgf7fqgoThvlfV12zSi5APTM+imIi7qLZdexqEoKeUZohoozxvgUnBWSN/BkoUGsOTie9vOo7eJFDnOHrXkxWw23qrOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nZ/w4Jbq; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20218E0005;
	Fri, 25 Oct 2024 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4t+dl7gmNqGkztIaVCZ8ld2RWttPHaiN3Tjvzd9pcg=;
	b=nZ/w4Jbqp6BrAgG/r8hqYAPw+c7bcWRlFy+CBq9HHvWxggqA6d5bit1S9icyUqYYJeE4EN
	erjbUA1/EWNdr0h9vWxGzYfj1XH0El/gs+OFRSQzCp8TJrUQFfmlsbSyls6PfmUBEjzcUR
	0N2wJGbLQdgtvEzo/RJ2Ly1tZQWckRxdRivukVhPX4RLp/tneV6jQtEUIc2PpzAW6QNAxb
	aqbn3fE2xYJpfI6+Vhdj+SAmufA8GYiArzIH4qHNuPpEujCVaDeApcluhEKwwup5rG6Q/w
	Yp0CJYBHkedpgDOtKYN+Xtg3X/ljQILAjejMTHLfTyA1fWIivL/8D6A1fGQuqQ==
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
Subject: [PATCH 13/24] spi: spi-sn-f-ospi: Support per spi-mem operation frequency switches
Date: Fri, 25 Oct 2024 18:14:50 +0200
Message-ID: <20241025161501.485684-14-miquel.raynal@bootlin.com>
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
 drivers/spi/spi-sn-f-ospi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index a7c3b3923b4a..6a999a103208 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -335,7 +335,6 @@ static void f_ospi_config_indir_protocol(struct f_ospi *ospi,
 static int f_ospi_indir_prepare_op(struct f_ospi *ospi, struct spi_mem *mem,
 				   const struct spi_mem_op *op)
 {
-	struct spi_device *spi = mem->spi;
 	u32 irq_stat_en;
 	int ret;
 
@@ -343,7 +342,7 @@ static int f_ospi_indir_prepare_op(struct f_ospi *ospi, struct spi_mem *mem,
 	if (ret)
 		return ret;
 
-	f_ospi_config_clk(ospi, spi->max_speed_hz);
+	f_ospi_config_clk(ospi, op->max_freq);
 
 	f_ospi_config_indir_protocol(ospi, mem, op);
 
@@ -577,6 +576,10 @@ static const struct spi_controller_mem_ops f_ospi_mem_ops = {
 	.exec_op = f_ospi_exec_op,
 };
 
+static const struct spi_controller_mem_caps f_ospi_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int f_ospi_init(struct f_ospi *ospi)
 {
 	int ret;
@@ -614,6 +617,7 @@ static int f_ospi_probe(struct platform_device *pdev)
 		| SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL
 		| SPI_MODE_0 | SPI_MODE_1 | SPI_LSB_FIRST;
 	ctlr->mem_ops = &f_ospi_mem_ops;
+	ctlr->mem_caps = &f_ospi_mem_caps;
 	ctlr->bus_num = -1;
 	of_property_read_u32(dev->of_node, "num-cs", &num_cs);
 	if (num_cs > OSPI_NUM_CS) {
-- 
2.43.0


