Return-Path: <linux-spi+bounces-9844-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B3AB3F4D4
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 07:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6241A858D0
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 05:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF82E283E;
	Tue,  2 Sep 2025 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ka2UTFXy"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3632E1EEE;
	Tue,  2 Sep 2025 05:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792385; cv=none; b=Ku0iyFkLM6L+MPDXM+fH9qvswQBDaRf+HdPO9rauUGlakT/MJjdSPRZocZ+4iBQmvaTV8XgySV+QQiLCYKoGdEf/eoGtJxS5S3kqcnr4bj7f/sDeZZpGQ8z5ttnLC5ABdJdRM9CMKBi4T5Q1i+5oB+axrNWAYUp0cEGdKhnw4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792385; c=relaxed/simple;
	bh=vx2kNy0+HhAu9oJXF7h1H6iRH7NO2rPLGfr4zC9bQyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WhcKTQ2R6j/e3yaHx7pNtfPB4UtpOA7qSPbuA65vs52+qPlrJSkXbuhglRq/3TpUWqqjPcPEd37ZurTo7kOitqCGw6w+0o8i/EAYSGlAWOL6v3iw8wxxFL+9yQhSZ+Ah1JwsQwQnkmbzcDrUV0UaAaWbnIZW/Yh/UxsquWGHhq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ka2UTFXy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756792384; x=1788328384;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vx2kNy0+HhAu9oJXF7h1H6iRH7NO2rPLGfr4zC9bQyA=;
  b=Ka2UTFXylybRyRpkbxufWOtgWuiQSUTBVf7ff8Ydcit9Ycx9+vNZhcJZ
   Hh5RjBbuorZ944UChCqI/7BPdzLYtQWnteUgJuYMae3bxCzUOsPAy8d68
   CWy0rzjm619S6FmqfIu8KKUW8r7xeMejr90so31cTIPnQ2VRiij8OO/Vr
   SdswzvTEg7PckF3alvLFn35J0jytmdMLTChuSWhB77tHrLi91CW7Asrgu
   BlloKCyTDJxTKUO6nhyH91aNVqs4sOGrtFxjwESZqEY0sZR15eBPj1TYh
   rDDdfaadgUFh1wq19d+6adfUhgn/8+bO+q2Td7fmqlsEC/1pLSBQjjIXu
   g==;
X-CSE-ConnectionGUID: Yz3ewosWRva47VEyLax1Mw==
X-CSE-MsgGUID: zPPrgAImQ6WqKihVnphDpw==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="213332113"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 22:53:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 1 Sep 2025 22:52:56 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 1 Sep 2025 22:52:51 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Tue, 2 Sep 2025 11:22:22 +0530
Subject: [PATCH 5/5] spi: atmel-quadspi: Add support for sama7d65 QSPI
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250902-microchip-qspi-v1-5-37af59a0406a@microchip.com>
References: <20250902-microchip-qspi-v1-0-37af59a0406a@microchip.com>
In-Reply-To: <20250902-microchip-qspi-v1-0-37af59a0406a@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756792344; l=1545;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=f0BEjRg0ecgW3mbWEOamZAvt1r/7v97MsNFu6rAL6n8=;
 b=KmbhvXvmgW8U/7xZW5mTNMEm/DMGTIOv8a+kUdEn+t0dzTGnHnQetDBdEepFTJaa0BW9OCgtp
 JKeFRkYi6icCnPqSnrWzbpG+No0okW9MP4ad9W2lz7+H1j32OfD7HCl
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


