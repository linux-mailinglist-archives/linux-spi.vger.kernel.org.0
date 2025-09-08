Return-Path: <linux-spi+bounces-9934-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045CB48334
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 06:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4733A159E
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 04:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF2222129F;
	Mon,  8 Sep 2025 04:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sDinFn7a"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F59A21B19D;
	Mon,  8 Sep 2025 04:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304929; cv=none; b=Z7tKcLYkbuaXtD2WQcslB6RBKph7uHSFLJLSSSoTzSOGHE7kB/BVsN4gKyvi9wbKN88xDFcMV6QJ3j0E7ja/TFefuVcj5osNZddmUE7q4b3eivH/gyAF5orXrLyy+1iV7d6ldjBt76KoHFNwBbbfOAiz8LMDJu+QxNH2yGwJ14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304929; c=relaxed/simple;
	bh=vx2kNy0+HhAu9oJXF7h1H6iRH7NO2rPLGfr4zC9bQyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uTgFYXU2/pctYXaPiXzABkJsOccppY33jUIDAG9KN6nJ0zTXqLMSjx1xVgYfUHW8CJfDN4vqGcFWm1OKMKkw/qWOysB65hgOaW2uFHjJl+lDsswrCe3A4VH6GkyKDEmSSxDd0gLrcnygwCH0p6SXAl1ShP3423OcfgcypLJh6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sDinFn7a; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757304927; x=1788840927;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vx2kNy0+HhAu9oJXF7h1H6iRH7NO2rPLGfr4zC9bQyA=;
  b=sDinFn7aWVSSXiFbA2iG+fne536vUhAZtTy2w/JnOnS7Ul2wiScF+uHL
   PQ3b2Y/fcWeowFys/HVv0VRmMrd/8SFgUrduWhx7aIVTGq+5rr4ZHjfkw
   8lywOpxj8Codi/qvbJXf/6BPaH1IJtUaAZ1kHD4y66vtIIW+bY+7oHvii
   lL61g/eQ9qAIxgrppsvMjfzG5bgGp4pq+4Jr73h8R6EVl+gDkbtX/yRFw
   hlXmT9s1ebrt8hBPAZBpYUvEMRZkk7mDVcE9Iuo46Tus079UJColoCYJT
   6JT/s1ynhUW98TkmVcyxlwfhmdxprdtM0GOr/IAKErGiAR/iJGH+dN6oQ
   w==;
X-CSE-ConnectionGUID: q/SJvp4uQvCY0cG18DoX1w==
X-CSE-MsgGUID: ZJVDMuJtRJitEtb3JxJQeA==
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="46742463"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2025 21:15:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 7 Sep 2025 21:14:58 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 7 Sep 2025 21:14:52 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Mon, 8 Sep 2025 09:44:20 +0530
Subject: [PATCH v2 5/5] spi: atmel-quadspi: Add support for sama7d65 QSPI
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-microchip-qspi-v2-5-8f3d69fdd5c9@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757304860; l=1545;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=f0BEjRg0ecgW3mbWEOamZAvt1r/7v97MsNFu6rAL6n8=;
 b=00YL9K3Oot2eHMDWKTvLcLPGPfmcIclFGVvDwqZ2I+XnJFnXS2UbKtOsqxFGJmo9H+6F6i3TO
 rGVpcQg7n+0C48LlkIsVwYrLigv/DAIZ+NKDIiZnA4Itk2gfbvheFqX
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

From: Varshini Rajendran <varshini.rajendran@microchip.com>

Add support for sama7d65 QSPI controller and define its caps.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 342cdd6e8d64..d7a3d85d00c2 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1638,6 +1638,24 @@ static const struct atmel_qspi_caps atmel_sam9x7_ospi_caps = {
 	.has_dllon = false,
 };
 
+static const struct atmel_qspi_caps atmel_sama7d65_ospi_caps = {
+	.max_speed_hz = SAMA7G5_QSPI0_MAX_SPEED_HZ,
+	.has_gclk = true,
+	.octal = true,
+	.has_dma = true,
+	.has_2xgclk = true,
+	.has_padcalib = true,
+	.has_dllon = false,
+};
+
+static const struct atmel_qspi_caps atmel_sama7d65_qspi_caps = {
+	.max_speed_hz = SAMA7G5_QSPI1_SDR_MAX_SPEED_HZ,
+	.has_gclk = true,
+	.has_dma = true,
+	.has_2xgclk = true,
+	.has_dllon = false,
+};
+
 static const struct atmel_qspi_caps atmel_sama7g5_ospi_caps = {
 	.max_speed_hz = SAMA7G5_QSPI0_MAX_SPEED_HZ,
 	.has_gclk = true,
@@ -1675,6 +1693,15 @@ static const struct of_device_id atmel_qspi_dt_ids[] = {
 		.compatible = "microchip,sam9x7-ospi",
 		.data = &atmel_sam9x7_ospi_caps,
 	},
+	{
+		.compatible = "microchip,sama7d65-ospi",
+		.data = &atmel_sama7d65_ospi_caps,
+	},
+	{
+		.compatible = "microchip,sama7d65-qspi",
+		.data = &atmel_sama7d65_qspi_caps,
+	},
+
 
 	{ /* sentinel */ }
 };

-- 
2.43.0


