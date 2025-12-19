Return-Path: <linux-spi+bounces-12039-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BCBCD19A9
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 20:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05D713055E22
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 19:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF9E342500;
	Fri, 19 Dec 2025 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pWsuPRBx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AEE33FE36
	for <linux-spi@vger.kernel.org>; Fri, 19 Dec 2025 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172213; cv=none; b=O4Tnlb85SxoiOLCctZ9sUaH1mbybjvsxFcQUWCsyXBD4XtflgZG+TBm3SHLItw05hJ52XCucnwplrI4hVUaPA7/SzgZOdOjAKXaHjeDDk6TfafmRPO4PCjtUxDDybZoLch0C9TGjjNFQAppExodXpgDNxsuqx2AVucvX5xulSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172213; c=relaxed/simple;
	bh=9b0L7zvgjoq3vB85KTuQ0hEKRh6+gto0s+EPwekHgIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dvmzymPmv59GPHC5Y5yC8tpjOlmd/Cz8gl+srEbEALl7hTDmNmWHh77PYy4M2ZzjibdVN0HQaLbn6UsONmgWESdlXHbi5YWEnTwEYIma1BLkSgkuPlqcRgHaU/dRPRE47CcXtJtOdEUoM2lhniplxK5NClZ7xBJQD4iYwge7JCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pWsuPRBx; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 639E2C1B20F;
	Fri, 19 Dec 2025 19:23:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2269C6071D;
	Fri, 19 Dec 2025 19:23:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A42DB10AA981B;
	Fri, 19 Dec 2025 20:23:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766172209; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MJHGZZNMdeJVGktGftmqJKyOTlwEgokSeVQPziFIuBs=;
	b=pWsuPRBxQUCCvu+3vOPs0Aj9/BN+k+IgDdpKbTW4tHvTElJyQ/XBNwmXhhe1131ZVOf8+T
	GwnlDw9KY7EmwavwjYhQnjwn0xtEYjRVM8hIVDYnFd6FE6ZeClbr0cD5NonZFlXsq+yRAO
	bAvifaiNDGOCF2CULEMpgg15/Q91v2uEPOnubBIf9q1gDomzzDwYaGwgXobtI3aZCOCpQO
	clr+WU6eR7fNDHMKOBu7SOTNIc76+zGu79+F8F0o9U3UsyutGJFe+buNJESagNL0g/xuie
	ddgFb1+yzR0tJZObfDc2F12zBdTLNub0uR5aK2x+Jeofz1vFyqPcbr8WiYQkAw==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Fri, 19 Dec 2025 20:22:12 +0100
Subject: [PATCH 10/13] spi: cadence-qspi: Add a flag for controllers
 without indirect access support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-schneider-6-19-rc1-qspi-v1-10-8ad505173e44@bootlin.com>
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

Renesas RZ/N1 QSPI controllers embed the Cadence IP with some
limitations/simplifications. One of the is that only direct access is
supported, none of the registers related to indirect writes are
populated, so create a flag to avoid these accesses and make sure only
direct accessors are called.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 3972bca5c4a9..340f7a186d92 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -47,6 +47,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 #define CQSPI_SUPPORT_DEVICE_RESET	BIT(8)
 #define CQSPI_DISABLE_STIG_MODE		BIT(9)
 #define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
+#define CQSPI_NO_INDIRECT_MODE		BIT(11)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -1429,7 +1430,8 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 	if (ret)
 		return ret;
 
-	if (cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size))
+	if ((cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size)) ||
+	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE))
 		return cqspi_direct_read_execute(f_pdata, buf, from, len);
 
 	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
@@ -1630,19 +1632,20 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 	/* Disable all interrupts. */
 	writel(0, cqspi->iobase + CQSPI_REG_IRQMASK);
 
-	/* Configure the SRAM split to 1:1 . */
-	writel(cqspi->fifo_depth / 2, cqspi->iobase + CQSPI_REG_SRAMPARTITION);
+	if (!(cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE)) {
+		/* Configure the SRAM split to 1:1 . */
+		writel(cqspi->fifo_depth / 2, cqspi->iobase + CQSPI_REG_SRAMPARTITION);
+		/* Load indirect trigger address. */
+		writel(cqspi->trigger_address,
+		       cqspi->iobase + CQSPI_REG_INDIRECTTRIGGER);
 
-	/* Load indirect trigger address. */
-	writel(cqspi->trigger_address,
-	       cqspi->iobase + CQSPI_REG_INDIRECTTRIGGER);
-
-	/* Program read watermark -- 1/2 of the FIFO. */
-	writel(cqspi->fifo_depth * cqspi->fifo_width / 2,
-	       cqspi->iobase + CQSPI_REG_INDIRECTRDWATERMARK);
-	/* Program write watermark -- 1/8 of the FIFO. */
-	writel(cqspi->fifo_depth * cqspi->fifo_width / 8,
-	       cqspi->iobase + CQSPI_REG_INDIRECTWRWATERMARK);
+		/* Program read watermark -- 1/2 of the FIFO. */
+		writel(cqspi->fifo_depth * cqspi->fifo_width / 2,
+		       cqspi->iobase + CQSPI_REG_INDIRECTRDWATERMARK);
+		/* Program write watermark -- 1/8 of the FIFO. */
+		writel(cqspi->fifo_depth * cqspi->fifo_width / 8,
+		       cqspi->iobase + CQSPI_REG_INDIRECTWRWATERMARK);
+	}
 
 	/* Disable direct access controller */
 	if (!cqspi->use_direct_mode) {

-- 
2.51.1


