Return-Path: <linux-spi+bounces-12040-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF88CD19AF
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 20:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C80F305A174
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 19:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768ED342513;
	Fri, 19 Dec 2025 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZhHE4gt3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB833F8BB;
	Fri, 19 Dec 2025 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172215; cv=none; b=qqCRZAXQxbKZuigzJgpiEQNX5QaAFAbX+xwGCzw2M6h9qtBmbJ7u9qyBfdCIxdvUTQXkkANSXQFLKyXvuXzjwvML966nBjjnDiB87n+eOv7aOe+5JDIAz6IqfaTvskwvcxS0L+C2V/B1jeDGzFFbe5tvgzFFY6BqAAlVQBCl0lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172215; c=relaxed/simple;
	bh=4HLN4eEUc8jtN8p7gYjJlCzKWetlTySmNUckYiNNvyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XNsWN6C4hxOQDeWcPnSULrNAwCw51WABWWKW8P0DtA9YbK8lUm8y64h+M2XE9y4XhCYWPYISROUChHL5Lhy1NMNBI5vsZHbBhsKgyCNMZfkrICVc7q6ht1CsTRwJSGIPfR1u/39QBZrwQ5912eMCoKeCtibo5VbTWLeKecjQva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZhHE4gt3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D9D0F4E40B7D;
	Fri, 19 Dec 2025 19:23:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B0ECC6071D;
	Fri, 19 Dec 2025 19:23:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70646102F0BC0;
	Fri, 19 Dec 2025 20:23:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766172210; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QNJbnESKqjEsiJlavsE5GSotm9cq+dbTnrHbs5KBhwU=;
	b=ZhHE4gt3g1dURnaxbkDeFYAJAGfIz9tR441HyQghlp2K9H1BorGy3CRKDfDQnGXvveEWJw
	HfzourDRkz9Rxni9R5EKL16YGZSuv10tlGFfDiS4BCXyD2CO//Yzlyed3UOboCtrhRefVN
	xDuWAWkP3RHtfSnvlgVfoUKfFweeszMYP1RNxEvPG50elzOCvH3/aASJum1L0nPQEl+bdj
	x5zU/61sjbID1SF2VzL8x/umQE1GvlBtZlC+jEKWDNKaxVYQxWQby5yPE5l4Rn2OBU2XBS
	f4pfyM47p4kq3KUWPtVNXjk/b+/8jElXcuTUkA/srM77WwKhPioJq588mCLEVQ==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Fri, 19 Dec 2025 20:22:13 +0100
Subject: [PATCH 11/13] spi: cadence-qspi: Make sure write protection is
 disabled
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-schneider-6-19-rc1-qspi-v1-11-8ad505173e44@bootlin.com>
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
modifications. For instance, they feature a write protection of the
direct mapping at the controller level, with this feature all data
writes to the AHB region are aborted.

Despite the fact that the flag setting write protection is disabled by
default, Bootloaders may (and actually do) set it, so mark this feature
as being available with a specific flag to, if applicable, make sure it
is disabled.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 340f7a186d92..ef036a65c628 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -48,6 +48,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 #define CQSPI_DISABLE_STIG_MODE		BIT(9)
 #define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
 #define CQSPI_NO_INDIRECT_MODE		BIT(11)
+#define CQSPI_HAS_WR_PROTECT		BIT(12)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -218,6 +219,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_IRQSTATUS			0x40
 #define CQSPI_REG_IRQMASK			0x44
 
+#define CQSPI_REG_WR_PROT_CTRL			0x58
+
 #define CQSPI_REG_INDIRECTRD			0x60
 #define CQSPI_REG_INDIRECTRD_START_MASK		BIT(0)
 #define CQSPI_REG_INDIRECTRD_CANCEL_MASK	BIT(1)
@@ -1647,6 +1650,10 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 		       cqspi->iobase + CQSPI_REG_INDIRECTWRWATERMARK);
 	}
 
+	/* Disable write protection at controller level */
+	if (cqspi->ddata && cqspi->ddata->quirks & CQSPI_HAS_WR_PROTECT)
+		writel(0, cqspi->iobase + CQSPI_REG_WR_PROT_CTRL);
+
 	/* Disable direct access controller */
 	if (!cqspi->use_direct_mode) {
 		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);

-- 
2.51.1


