Return-Path: <linux-spi+bounces-12391-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9172D23897
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 10:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCDC63049F76
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 09:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E163876CB;
	Thu, 15 Jan 2026 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EYYdaoyY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A93803C9;
	Thu, 15 Jan 2026 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469155; cv=none; b=MepamZuaJTilZi+g6rwYIP3nmmAIndP0M1rCPFyOwl+fjpeOI6ELOHH/6BqhIjvLycnJ+oYaExOWo8yuxhyQ79XoB9UFIiamx7Y7E0XlSov/AY2N+JmI7DgIJuxx2fZDs+oNcNIUgS4oyrUcB9TuxuECR4/kW/vxTMx1UYlgwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469155; c=relaxed/simple;
	bh=xY0slUPcWTkNCDM5AqmMHEoa+4Vj0HcLqKCd1A0/8dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpJ7Oat/xRJ0OYO1723tr8LPgT/WjMPc5ltZsYNAN+mEgVr3WM7VjhrMGFnlhg9cV/T///dZ4H9QfLKXlXqo01eQu1j57RzUiXm81GztFLrpHC/RPge0CA3z9TzF928//LvtMQySdg6b2+YctTZeN8vfgyeTxDKuwNpZ6PmqBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EYYdaoyY; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 951401A287A;
	Thu, 15 Jan 2026 09:25:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CA0F606B6;
	Thu, 15 Jan 2026 09:25:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCFAA10B68531;
	Thu, 15 Jan 2026 10:25:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768469151; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+hBnNkivyv+n3X/ChkXKt4HpdgNECvLrCvfE+vU0L00=;
	b=EYYdaoyYp+DU+AlCtUod95q8Gkq9YlAkUAjyJRx8TCwib0C0IIH/2R22bNot9JhPcfVNsU
	3qnTXyHSQSQMB7Z7rVftopMWZw7qoaSoQYzQFYYuM5kT/0UtYDQyo+XHmIU+V9YtSP96oE
	bOUworhGtdXg9n6QhVxFRJIZOnaQxvoYzQbSUvFne//NNoo2oVqNdAWpmD7AgQ08/YYwKe
	DBf+g9xAmf6fP2eQgu0mY61naZlDeW3tfgLMDP16b+tki5YggSnyFlrKdNQHwyNcf8wiz4
	FRbR0VxYoPeBvIouk1ZMRocbZBOM0bbiUs7fDDAZe2Unxjl6uzoe7Jd0qUbDvg==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 15 Jan 2026 10:25:01 +0100
Subject: [PATCH v2 10/13] spi: cadence-qspi: Add a flag for controllers
 without indirect access support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-schneider-6-19-rc1-qspi-v2-10-7e6a06e1e17b@bootlin.com>
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
index e389422fe95e..d84531aa470c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -47,6 +47,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 #define CQSPI_SUPPORT_DEVICE_RESET	BIT(8)
 #define CQSPI_DISABLE_STIG_MODE		BIT(9)
 #define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
+#define CQSPI_NO_INDIRECT_MODE		BIT(11)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -1423,7 +1424,8 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 	if (ret)
 		return ret;
 
-	if (cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size))
+	if ((cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size)) ||
+	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE))
 		return cqspi_direct_read_execute(f_pdata, buf, from, len);
 
 	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
@@ -1624,19 +1626,20 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
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


