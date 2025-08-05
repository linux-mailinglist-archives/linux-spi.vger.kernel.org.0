Return-Path: <linux-spi+bounces-9288-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4E0B1B1F4
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 12:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDAC17F0B6
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 10:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1412B259CB2;
	Tue,  5 Aug 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zd7ekgRm"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD95156237;
	Tue,  5 Aug 2025 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389604; cv=none; b=UgdjPmRI+PbD6MZCBP6TqruFB6roGr/lqceaEW2meqCfv7+zPY5qUCtAzR+ECdIOTFORFvkEJsktIO+CSTjtvo8P8mJ0D5rgTuoUFfRO75WXsyunN/5F7DKbRPyy6UoolJTmKLeSGAcBvEH/eakCLXtcqiZh2T5VP9x447u2wD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389604; c=relaxed/simple;
	bh=UGKP9T8n9F1kTUfGEGO7Etj36JCUlKzaZSO38heUsps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0bkh3f8nQK7U1uAyKP+aw/LVmUQ/iWh8tIk3xYZlltdCz7DpqVj8W6uz3vjy8PzjfnKMrb/JNMTuxFfxEJ1rszCuIS5bHxaJSZTzspUD7wqkadioPSpv0vNVdjVHpyabdD4KcuTm84nylBXqDQ/rWv6XMn/OByh37F7Gklks80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zd7ekgRm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754389602; x=1785925602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UGKP9T8n9F1kTUfGEGO7Etj36JCUlKzaZSO38heUsps=;
  b=zd7ekgRmqeaCVE2wDsmtPpGaVG6QIXlE9cBG8eaSZIOP6Vc6L/nFb3+5
   cq3NWkpemK8DGfsA8Txlcxwp3+AHT5y1UoeTDL1lyQuSlKTLrOkexxsYE
   IBpZV7x8zvh7D34aFiqNpw5OQv9H0EAj9M4fuB3BvzmhWfRpFTEZGLflb
   C+UtjtlVrwxhMZ7AtitJs1dINcn7QuZ3kdBblvhJ6YiWFewLiCx5DlkIs
   yBsEWJ9Q8qEGMdJ9EqeTbkX8jle8/Nijtde68c4W3qBBmBgNolbVrI4ya
   YD56qRYd3Y1KlNk/1so/7P6w4MVsXlktBQYanIC6T+Y8iNyM5Kk2OUump
   Q==;
X-CSE-ConnectionGUID: 5giYSL7rQRGsqPqo2rqYFw==
X-CSE-MsgGUID: BGUNfPdXQXCQ7IAYcw0lJw==
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="212248017"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Aug 2025 03:26:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 5 Aug 2025 03:26:13 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 5 Aug 2025 03:26:07 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<ryan.wanner@microchip.com>, <tudor.ambarus@linaro.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v3 1/3] spi: atmel: simplify MR register update in cs_activate()
Date: Tue, 5 Aug 2025 15:55:08 +0530
Message-ID: <20250805102510.36507-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250805102510.36507-1-manikandan.m@microchip.com>
References: <20250805102510.36507-1-manikandan.m@microchip.com>
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
-- 
2.25.1


