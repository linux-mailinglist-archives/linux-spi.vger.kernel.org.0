Return-Path: <linux-spi+bounces-12393-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBFDD2392B
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 10:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DCF730EEC21
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 09:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CD438A9B9;
	Thu, 15 Jan 2026 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="t4VmVLNS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1AD38B7C9
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469160; cv=none; b=IDP4RuttVG2mh9hxbJ/kQ8DNtPBRtNodttJ9gjQSg4nvQqOwzCYcG0MiBqBGRajbZwnyqjtfdfHk50NDz8jes6FxAD2qaEgwjkBChsQ44VN+CtVHn/4x75EJLi0LEWFxrMVRJdn1WDKlTaCTja5onEdHBfAg46wIjCERom7ME7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469160; c=relaxed/simple;
	bh=ixa1KddeOiToUjFNFbO8o43ZPDD1it0jnw7nA0GSJUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=II76DYEhW8B7TWu1jJe+eonZoTTrDWUjZmMvr0CrrxJ/Qe2F7RclKoKKHsD4VIRDLkEzc5W4Y7X0zeBwz1ZHvVn2RRBHa9cKrIUYf8jby/CVXG41pVKSSzKHDOgxLJCgz2UAEzWBFuHWvSOAKk5ygsg9wXGk0nd63Sai5sasgqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=t4VmVLNS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 615691A287A;
	Thu, 15 Jan 2026 09:25:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 37E42606B6;
	Thu, 15 Jan 2026 09:25:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0956510B68534;
	Thu, 15 Jan 2026 10:25:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768469155; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rHT4Vl1bgtyP2vv8Z5ShLUQ7VoFtQgXFMIkmV8U1sY0=;
	b=t4VmVLNSP16vvuHkNci6S91sGep7d585qlJ/elt6Y3GItJNZxdlNPEGuSuX/LK3sDvrFlE
	4oJEWjnbSNARzuzzPcGzbHPwv3CXfEyoQxYYI9MzloubZKYtaYFB+V8ibiZsWklbzZ4N3i
	w4NU3dyDTpFAGOzGIVcC8LkB6xmocMeWvhWguG96U2BqgTe42fZl51hVsnbA1K/TaNbfjz
	fak+BAhcJkvgd2uc6LJxaBgCkg6NXvapMCCh8gTNoT7AKNbM2f+QNDJePR80omZ0VkFWA1
	Q7Xez+90h0dHHpM2z76q+TMH+isc18bOKsXTlS10XRiy36JIlUNnwYHjipqcCQ==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 15 Jan 2026 10:25:03 +0100
Subject: [PATCH v2 12/13] spi: cadence-qspi: Add support for the Renesas
 RZ/N1 controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-schneider-6-19-rc1-qspi-v2-12-7e6a06e1e17b@bootlin.com>
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
In-Reply-To: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
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
index fc7e64614a32..297336f51360 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -110,6 +110,7 @@ struct cqspi_st {
 	bool			apb_ahb_hazard;
 
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
+	bool			is_rzn1; /* Flag for Renesas RZN1 SoC */
 	bool			disable_stig_mode;
 	refcount_t		refcount;
 	refcount_t		inflight_ops;
@@ -1337,8 +1338,9 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
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
@@ -1512,6 +1514,7 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 static bool cqspi_supports_mem_op(struct spi_mem *mem,
 				  const struct spi_mem_op *op)
 {
+	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	bool all_true, all_false;
 
 	/*
@@ -1538,6 +1541,9 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 		/* A single opcode is supported, it will be repeated */
 		if ((op->cmd.opcode >> 8) != (op->cmd.opcode & 0xFF))
 			return false;
+
+		if (cqspi->is_rzn1)
+			return false;
 	} else if (!all_false) {
 		/* Mixed DTR modes are not supported. */
 		return false;
@@ -1798,6 +1804,8 @@ static int cqspi_probe(struct platform_device *pdev)
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
@@ -1963,7 +1976,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (ddata && (ddata->quirks & CQSPI_SUPPORT_DEVICE_RESET))
 		cqspi_device_reset(cqspi);
 
-	if (cqspi->use_direct_mode) {
+	if (cqspi->use_direct_mode && !cqspi->is_rzn1) {
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER) {
 			dev_err_probe(&pdev->dev, ret, "Failed to request mmap DMA\n");
@@ -2143,6 +2156,12 @@ static const struct cqspi_driver_platdata mobileye_eyeq5_ospi = {
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
@@ -2184,6 +2203,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
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


