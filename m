Return-Path: <linux-spi+bounces-5475-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ABA9B0984
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 18:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6798D1C22F8F
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EFB186298;
	Fri, 25 Oct 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cbHiZgR+"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F62B1CC8AB
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872915; cv=none; b=OsNxtaNyV6Po/rY4iQAgJMFEMkJt5iIj4Q+ErUYo2nOFNVcCTKLrG2DgRzRB0q7OG5RXap1KM94ClaeVrPfrV8YAlDZaq8MzSjGEW8X1XSg7nBNfRFz09nzVzmA+absQbN1BExCtsu6D8vWYTlvwOipMn3xtcKnKw3H5cdzuhrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872915; c=relaxed/simple;
	bh=FO5EPi1d78JOdoXrM4h+q6R0z5UN3IpplagzlNTgU2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ny3AvCXxjwvYYd2ezHRLw/5yG6Qilm6GN2FkKPzJqvvZGnzXnBn5rJEfMNUPtoTnxb+FK87HCDni7U9SZZSNCPm+fSuysCf67ZdpACaieaOUP9Em+QMVRIDXCX2LTiNEBiEtkhbY8xTU11cwdwL7sycgJ9s/G4JvuzVnHNCnLP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cbHiZgR+; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77A83E000C;
	Fri, 25 Oct 2024 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729872911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfhqxAS164vg4hu2rhFqymgBKF09/+06swQixk+O+Fc=;
	b=cbHiZgR+9ODTHtLHjYGMhyiHXbZFFvHwNsCm1TQPODPUZDkJtbT5iMhXbDIiIpXFbDLwAe
	VTN9LtmvBAQI4y2c4uIAJByP3keRrx2H9RzCV+qZs2PJhAkMBOq8HECvjqd94pI3/6qNWd
	ub8qHXBNIflwnLI23SqMBK9QZvkNLL0E82gPr7g21QeUhuWHXHiHfQkp8mJq0Jm1m+l5rT
	ikMmd7Y/KrilUFauJBoL9OovLukNg4ag5UhIsQPvGkFUo7JgrW4pF0mSZpwjUr81gpO/+g
	sXSGpQoadtEdFENN/p2YlM10Qf4Ctl5wAEmT2CC7rngjmt4Z1EKEctT32TVbTg==
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
Subject: [PATCH 07/24] spi: fsl-qspi: Support per spi-mem operation frequency switches
Date: Fri, 25 Oct 2024 18:14:44 +0200
Message-ID: <20241025161501.485684-8-miquel.raynal@bootlin.com>
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

Cc: Han Xu <han.xu@nxp.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-fsl-qspi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 79bac30e79af..ce86f44b0e93 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -522,9 +522,10 @@ static void fsl_qspi_invalidate(struct fsl_qspi *q)
 	qspi_writel(q, reg, q->iobase + QUADSPI_MCR);
 }
 
-static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi)
+static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
+				const struct spi_mem_op *op)
 {
-	unsigned long rate = spi->max_speed_hz;
+	unsigned long rate = op->max_freq;
 	int ret;
 
 	if (q->selected == spi_get_chipselect(spi, 0))
@@ -652,7 +653,7 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	fsl_qspi_readl_poll_tout(q, base + QUADSPI_SR, (QUADSPI_SR_IP_ACC_MASK |
 				 QUADSPI_SR_AHB_ACC_MASK), 10, 1000);
 
-	fsl_qspi_select_mem(q, mem->spi);
+	fsl_qspi_select_mem(q, mem->spi, op);
 
 	if (needs_amba_base_offset(q))
 		addr_offset = q->memmap_phy;
@@ -839,6 +840,10 @@ static const struct spi_controller_mem_ops fsl_qspi_mem_ops = {
 	.get_name = fsl_qspi_get_name,
 };
 
+static const struct spi_controller_mem_caps fsl_qspi_mem_caps = {
+	.per_op_freq = true,
+};
+
 static int fsl_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -923,6 +928,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 4;
 	ctlr->mem_ops = &fsl_qspi_mem_ops;
+	ctlr->mem_caps = &fsl_qspi_mem_caps;
 
 	fsl_qspi_default_setup(q);
 
-- 
2.43.0


