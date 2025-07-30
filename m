Return-Path: <linux-spi+bounces-9216-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1460B15879
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 07:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241CE1686D5
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 05:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4427217A303;
	Wed, 30 Jul 2025 05:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cDz6fbFJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B307462;
	Wed, 30 Jul 2025 05:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753853812; cv=none; b=QQfraJjWOPga/zPBS8+483kHtYVADUQ8Fuu99khv5UEYpJlg7x4QRxXdeFeyhKuG5bAkNBvMGYhCWriAUWgntVqRMGKsL9KAoJ3oja3M2XiR6Q1E4Uh26iHG1ADZeFuFhfDtutwbW+rHO564k38+vZKtN/9EqvDlMbSVLURWcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753853812; c=relaxed/simple;
	bh=N1w1SjMrVlxfirhilq++adg4shvXqJr7FQPDQ+oinmA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qHmC7SzmLlswAMEvQm8y7+tuZqy7+3aWl6Mc8mj3wu5ypsWi/aGDeHt3ZAqbzcLwwERrg0L7HEOtyig7MR4/Y45It2W+huO4Yn0IS9hubPNGrEYAo+OSp7s3m0OnYb3el/jehl5EWHOwhdo8tfJIRQ9nCVzU8KIblgQaERC0AFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cDz6fbFJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753853811; x=1785389811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N1w1SjMrVlxfirhilq++adg4shvXqJr7FQPDQ+oinmA=;
  b=cDz6fbFJQwg9yuagdAdi8NFJjtHto8VgSG70b0Ygx4DH9aiKg9mMEF3p
   V3R4clfgVAevidOIAs6cU8w2SbX+K9RiPLNGySb+oIwvCLzRS5jx6Yi3X
   GkYTWdPrSww/A77AHBsj9wgZK0Coa0MIIVy0tT0l4sEJoPkJ5ezrqFf0D
   dBEtiMXysY1gaeW0u9nu5XYVgBVCaOGJ+rtt9ywrzWZRU7QQ366WNmqMx
   wtTB2tCZYUctDzp6ro888LMcmrVKsfHkDTHLSIkMoe76fXpDM90j2GFGA
   QBgCaOZOIlvAdODNCZ6UK+D0sPJPRktfZeYSnzP7dNwLIgR0/spbtQ0La
   w==;
X-CSE-ConnectionGUID: KXdcS/E5QFaLzQr7m9yLTA==
X-CSE-MsgGUID: 95Lgc1qwR3ylPu6C6MQ5Pw==
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="275977859"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2025 22:36:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 29 Jul 2025 22:36:16 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 29 Jul 2025 22:36:13 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <ryan.wanner@microchip.com>, <broonie@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH 1/3] spi: atmel: simplify MR register update in cs_activate()
Date: Wed, 30 Jul 2025 11:05:59 +0530
Message-ID: <20250730053559.261866-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

simplified the MR register configuration by updating only the PCS field
using SPI_BFINS() instead of rewriting the entire register.
Avoids code duplication.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/spi/spi-atmel.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 89a6b46cd319..409f544d8983 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -397,20 +397,10 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		 * on CS1,2,3 needs SPI_CSR0.BITS config as SPI_CSR1,2,3.BITS
 		 */
 		spi_writel(as, CSR0, asd->csr);
-		if (as->caps.has_wdrbt) {
-			spi_writel(as, MR,
-					SPI_BF(PCS, ~(0x01 << chip_select))
-					| SPI_BIT(WDRBT)
-					| SPI_BIT(MODFDIS)
-					| SPI_BIT(MSTR));
-		} else {
-			spi_writel(as, MR,
-					SPI_BF(PCS, ~(0x01 << chip_select))
-					| SPI_BIT(MODFDIS)
-					| SPI_BIT(MSTR));
-		}
 
 		mr = spi_readl(as, MR);
+		mr = SPI_BFINS(PCS, ~(0x01 << chip_select), mr);
+		spi_writel(as, MR, mr);
 
 		/*
 		 * Ensures the clock polarity is valid before we actually

base-commit: 4b290aae788e06561754b28c6842e4080957d3f7
-- 
2.25.1


