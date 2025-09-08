Return-Path: <linux-spi+bounces-9933-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE97B48332
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 06:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E30189B0CB
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 04:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE2D1F78E6;
	Mon,  8 Sep 2025 04:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MwMnNg+8"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BC01E990E;
	Mon,  8 Sep 2025 04:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304927; cv=none; b=oWuNOeFGQ/a0SE5qqqFlmiUBINSaBDpiyr2amR0w7M6eLtiOZ8NBH0ZYLzGCP2/pEhT4hMiOAH3IUGK4chvj7aTm893O/Xh3enp2T2PGDV35MTc6gc2vu/N5YOIyj1MPR8HmPmCIxPO66IbrvZFj1f+yIB2PbELe8teYoaROsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304927; c=relaxed/simple;
	bh=8vcpSjNT1k5A4ehuUfwjip6OpA9XYu1lbAAriuBL9r4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OKsAE1N8vmxRe1y5ngxr1eskYdqga78WFx2+Pj1O7/u7vkyh+dEPa1YGrqxs1ZjWyEeeOZJfM2hDojWD6tB91nFc+QsBqB59VPVaSePpTxVjtoJ5NXpGmVBpQWQ3ISAi82V5rrA/M8XMxEpwXLPH49wxfNLwPD7/AdqmxdGQhV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MwMnNg+8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757304925; x=1788840925;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8vcpSjNT1k5A4ehuUfwjip6OpA9XYu1lbAAriuBL9r4=;
  b=MwMnNg+8dtVI8wBnDG2+zuWp4q5ki7Pmyil8WMyewcQXp+UcD0aA8Fct
   K/vIZj1+MMf6WVu7kFA4I5CDTxSCtsazAqpoUFhP8n3UeAjdDW3TbWBRa
   jK6T0WoGRSLbapvH+Aan3Y6IHUHIr0BCkDsNamASLTYT7Hgseywpybg0V
   N4f3+PlUlU799gNvmNW8QOE99yJacgPa3Xl6gSgTsZ3bV+TYlObuddX3r
   nRmsfH3WpPY96e7ae/g1zPPeCE8lUb3qrqFsfqG7sq1h3Yr2BPrVJCwkD
   ndBCx5Ss8ZtpAU9xSHvhc6iD/5OuYqiWt0J2XaymKdmwcjlQHMJGHPU4L
   w==;
X-CSE-ConnectionGUID: q/SJvp4uQvCY0cG18DoX1w==
X-CSE-MsgGUID: cfbswviiQeitLmdrMu/BIg==
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="46742455"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2025 21:15:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 7 Sep 2025 21:14:51 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 7 Sep 2025 21:14:45 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Mon, 8 Sep 2025 09:44:19 +0530
Subject: [PATCH v2 4/5] spi: atmel-quadspi: add support for SAM9X7 QSPI
 controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-microchip-qspi-v2-4-8f3d69fdd5c9@microchip.com>
References: <20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com>
In-Reply-To: <20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>, Varshini Rajendran
	<varshini.rajendran@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757304860; l=1692;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=f7DOA5wDFdEWR6ikCwi4zK/5qKnnx4GBTbYYi9JaLJw=;
 b=QWZQc/2bKKOSQPBR5mGGCLwOKCSMrVZSDACQTUrUEup4zCt8TwjUc+WAgX+v4459P9KgEk+34
 MqFWLf/rikaDsUQmMqRiuUIUXRFIyjg4tHN074oxyt7swTFwJtncRwD
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

From: Varshini Rajendran <varshini.rajendran@microchip.com>

Add support for the QuadSPI controller found on the SAM9X7 SoC.

This controller does not implement pad calibration. It supports
operation up to 100 MHz, and requires the GCK to run at twice
the data rate.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 83cea5faff78..342cdd6e8d64 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -63,6 +63,7 @@
 
 #define SAMA7G5_QSPI0_MAX_SPEED_HZ	200000000
 #define SAMA7G5_QSPI1_SDR_MAX_SPEED_HZ	133000000
+#define SAM9X7_QSPI_MAX_SPEED_HZ	100000000
 
 /* Bitfields in QSPI_CR (Control Register) */
 #define QSPI_CR_QSPIEN                  BIT(0)
@@ -1627,6 +1628,16 @@ static const struct atmel_qspi_caps atmel_sam9x60_qspi_caps = {
 	.has_ricr = true,
 };
 
+static const struct atmel_qspi_caps atmel_sam9x7_ospi_caps = {
+	.max_speed_hz = SAM9X7_QSPI_MAX_SPEED_HZ,
+	.has_gclk = true,
+	.octal = true,
+	.has_dma = true,
+	.has_2xgclk = true,
+	.has_padcalib = false,
+	.has_dllon = false,
+};
+
 static const struct atmel_qspi_caps atmel_sama7g5_ospi_caps = {
 	.max_speed_hz = SAMA7G5_QSPI0_MAX_SPEED_HZ,
 	.has_gclk = true,
@@ -1660,6 +1671,10 @@ static const struct of_device_id atmel_qspi_dt_ids[] = {
 		.compatible = "microchip,sama7g5-qspi",
 		.data = &atmel_sama7g5_qspi_caps,
 	},
+	{
+		.compatible = "microchip,sam9x7-ospi",
+		.data = &atmel_sam9x7_ospi_caps,
+	},
 
 	{ /* sentinel */ }
 };

-- 
2.43.0


