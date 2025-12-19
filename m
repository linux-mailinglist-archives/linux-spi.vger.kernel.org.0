Return-Path: <linux-spi+bounces-12041-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B335CD19C4
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 20:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C50333064EF9
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 19:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0E9343D9B;
	Fri, 19 Dec 2025 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hgbqDmtu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491833F8C2
	for <linux-spi@vger.kernel.org>; Fri, 19 Dec 2025 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172216; cv=none; b=PAlMOfRmWHMHqr3quKO8GpJ2KXzw8qOvbZCwqHjraQBWOJ7EVLjR79BJhUgE6m7Wtj22ofihuC9lGLZjCgAzqERQerAb2NkdYti/hemavx8oa8zg115WLBKVP17TOsDJmYxUzaxPyY39CRdmwrM29XBiR4qTjbItrJJcQv6WfsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172216; c=relaxed/simple;
	bh=7Hv4KlFtQM/zhfnuDnQXeAQAujULts0xi6r5nvf+Xv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lwTax1TErVebiX45rith/oz3KKs4HD2k115OIQKnRYkD4xmBKTXY7iaf8LoO2Nwo+5VKztqoVhrbwfqhlgh3ihjmanDarOv3PcbRRDu6h+L56b0W9P10eSBSo3g9L28mwdluXRhcqTlLwEcANAlWI3S4hyK0uUkb+H1nvw4BLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hgbqDmtu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 74A624E41C39;
	Fri, 19 Dec 2025 19:23:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4A7966071D;
	Fri, 19 Dec 2025 19:23:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E5DA10AA981C;
	Fri, 19 Dec 2025 20:23:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766172212; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=H8DEEPmnp7dKOfpVV6DAwyTdXFHX+2yIaLDtP6fELWM=;
	b=hgbqDmtuceSH08b7JQw5kopwTYlsfPJrntqzp6nYZuN61yk/z/qisnoKFl3XpboV6thUTW
	rcL3p4kNUCMD8BBY3af5/R2eWv6AqGQQpF5CoA6zWuNivilZdskct9aQZpBJAHx0NDpa+2
	AabXikJTirn71OshHS3BNZCbq2a3tN+7Gjq3XyZ/N6m7tYBlhPu9K7z2tLDtUKuq9gmKiW
	SuKPHBru+XIst2yC/zrA+ctmlSaK6GCuRBhKpQxfIrHhegzxYfJrLwZdDp+GwuylWZkpqW
	2Q3AshFiYcBd5JzRUstgyHJK7Tb7jXQAOuGHK2JdQjb1k+6MX90bHP+pHzFREg==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Fri, 19 Dec 2025 20:22:14 +0100
Subject: [PATCH 12/13] spi: cadence-qspi: Add support for the Renesas RZ/N1
 controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-schneider-6-19-rc1-qspi-v1-12-8ad505173e44@bootlin.com>
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
In-Reply-To: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Renesas RZ/N1 QSPI controllers embed a modified version of the Cadence
IP with the following settings:
- a limited bus clock range
- no DTR support
- no DMA
- no useful interrupt flag
- only direct accesses (no INDAC mode)
- write protection

The controller has been tested by running the SPI NOR check list with a
custom RZ/N1D400 based board mounted with a Spansion s25fl128s1 quad
SPI.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
Output of the SPI NOR test procedure:
s25fl128s1
0120184d0180
spansion
xxd: /sys/bus/spi/devices/spi0.0/spi-nor/sfdp: No such file or directory
md5sum: can't open '/sys/bus/spi/devices/spi0.0/spi-nor/sfdp': No such file or directory
1+0 records in
1+0 records out
Copied 65536 bytes from qspi_test to address 0x00000000 in flash
Erased 65536 bytes from address 0x00000000 in flash
Copied 65536 bytes from address 0x00000000 in flash to qspi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0010000
Copied 65536 bytes from qspi_test to address 0x00000000 in flash
Copied 65536 bytes from address 0x00000000 in flash to qspi_read
71f8b056a4bf5f51639a972dc9aac55eb8654fdc  qspi_test
71f8b056a4bf5f51639a972dc9aac55eb8654fdc  qspi_read

Read speed:
* page read speed is 6464 KiB/s
* 2 page read speed is 9014 KiB/s
* eraseblock read speed is 14222 KiB/s
Write speed:
* page write speed is 621 KiB/s
* 2 page write speed is 626 KiB/s
* eraseblock write speed is 633 KiB/s
Erase speed:
* erase speed is 617 KiB/s
---
 drivers/spi/spi-cadence-quadspi.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ef036a65c628..03963857664b 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -110,6 +110,7 @@ struct cqspi_st {
 	bool			apb_ahb_hazard;
 
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
+	bool			is_rzn1; /* Flag for Renesas RZN1 SoC */
 	bool			disable_stig_mode;
 	refcount_t		refcount;
 	refcount_t		inflight_ops;
@@ -1343,8 +1344,9 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 	 * mode. So, we can not use direct mode when in DTR mode for writing
 	 * data.
 	 */
-	if (!op->cmd.dtr && cqspi->use_direct_mode &&
-	    cqspi->use_direct_mode_wr && ((to + len) <= cqspi->ahb_size)) {
+	if ((!op->cmd.dtr && cqspi->use_direct_mode &&
+	     cqspi->use_direct_mode_wr && ((to + len) <= cqspi->ahb_size)) ||
+	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE)) {
 		memcpy_toio(cqspi->ahb_base + to, buf, len);
 		return cqspi_wait_idle(cqspi);
 	}
@@ -1518,6 +1520,7 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 static bool cqspi_supports_mem_op(struct spi_mem *mem,
 				  const struct spi_mem_op *op)
 {
+	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	bool all_true, all_false;
 
 	/*
@@ -1544,6 +1547,9 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 		/* A single opcode is supported, it will be repeated */
 		if ((op->cmd.opcode >> 8) != (op->cmd.opcode & 0xFF))
 			return false;
+
+		if (cqspi->is_rzn1)
+			return false;
 	} else if (!all_false) {
 		/* Mixed DTR modes are not supported. */
 		return false;
@@ -1804,6 +1810,8 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi = spi_controller_get_devdata(host);
 	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi"))
 		cqspi->is_jh7110 = true;
+	if (of_device_is_compatible(pdev->dev.of_node, "renesas,rzn1-qspi"))
+		cqspi->is_rzn1 = true;
 
 	cqspi->pdev = pdev;
 	cqspi->host = host;
@@ -1898,7 +1906,12 @@ static int cqspi_probe(struct platform_device *pdev)
 	reset_control_deassert(rstc_ocp);
 
 	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clks[CLK_QSPI_REF].clk);
-	host->max_speed_hz = cqspi->master_ref_clk_hz;
+	if (!cqspi->is_rzn1) {
+		host->max_speed_hz = cqspi->master_ref_clk_hz;
+	} else {
+		host->max_speed_hz = cqspi->master_ref_clk_hz / 2;
+		host->min_speed_hz = cqspi->master_ref_clk_hz / 32;
+	}
 
 	/* write completion is supported by default */
 	cqspi->wr_completion = true;
@@ -1969,7 +1982,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (ddata && (ddata->quirks & CQSPI_SUPPORT_DEVICE_RESET))
 		cqspi_device_reset(cqspi);
 
-	if (cqspi->use_direct_mode) {
+	if (cqspi->use_direct_mode && !cqspi->is_rzn1) {
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER)
 			goto disable_controller;
@@ -2148,6 +2161,12 @@ static const struct cqspi_driver_platdata mobileye_eyeq5_ospi = {
 		  CQSPI_RD_NO_IRQ,
 };
 
+static const struct cqspi_driver_platdata renesas_rzn1_qspi = {
+	.hwcaps_mask = CQSPI_SUPPORTS_QUAD,
+	.quirks = CQSPI_NO_SUPPORT_WR_COMPLETION | CQSPI_RD_NO_IRQ |
+		  CQSPI_HAS_WR_PROTECT | CQSPI_NO_INDIRECT_MODE,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -2189,6 +2208,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "amd,versal2-ospi",
 		.data = &versal2_ospi,
 	},
+	{
+		.compatible = "renesas,rzn1-qspi",
+		.data = &renesas_rzn1_qspi,
+	},
 	{ /* end of table */ }
 };
 

-- 
2.51.1


