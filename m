Return-Path: <linux-spi+bounces-9846-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDA0B3F4DA
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 07:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF54485443
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 05:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547282E2667;
	Tue,  2 Sep 2025 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Xatb7pA0"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF7B2E1F0A;
	Tue,  2 Sep 2025 05:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792401; cv=none; b=SCxoPdNJvqaOA/qsSoogM1xbhC76GIDj3f0KUs+n2qzrHZSDqhM9yc2u9FYqYFNfGfBHUFLqbH5t2E9GZ6Hnh7fdszP4MsgR3xBrCFvBbevQJH1valNyJhhx2a6331npY2ajOiWGnSKLsiQQFc8dokTyt3v4lakJZyrktr+pdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792401; c=relaxed/simple;
	bh=f7DOA5wDFdEWR6ikCwi4zK/5qKnnx4GBTbYYi9JaLJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=F0xAkpAZ5/4iWr9QsBBzwZDwoZcsXsLAs5PeRPtNVhsFLHoEdKQTu5XDmzwROlD76Ddra17HfSG7u6b7NZzFIovfVuFH4Ppo/YYSeSluWc1TAY1CsM8oX6AL4pgxtTvxDIMEjGrvzV26A83eKb55+VAYkO9atuR0zrlVQUgoePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Xatb7pA0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756792399; x=1788328399;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=f7DOA5wDFdEWR6ikCwi4zK/5qKnnx4GBTbYYi9JaLJw=;
  b=Xatb7pA09Yb5c7/GCJ4F25VkRAKd6IKab/eSd9T5gWOvP8oamkI58ejd
   fv15XeOljrT5Nrpas8KDEPoWPGJsporNmqZCWz75S9zFFtw3fl8d7JKtV
   IGwL79mGlZXCgWWFjLRCRKobIhftQraHhyKkNK9fJamjNIZSyuUZRHuyo
   nORQcimHSqJFMQH2bhyRSEK8W2mc6SAGOnFU3/EINNT7GkruVD2mxhnoB
   3hTXjIZh/e/NNYt0RPDRVvE6m4nzHfDV8QAalMCRkcW80JP1nlCQDgl90
   RGwirbmpjRHPQtXPhbSe3HAiR0zUZoUskiUgPceDJLNbqr+Ej89YaOPpe
   Q==;
X-CSE-ConnectionGUID: gpCMy0YOQ3KnEotuUPEfLQ==
X-CSE-MsgGUID: vKmBLNbIQvGkTV7FOmwnCg==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="45366269"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 22:53:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 1 Sep 2025 22:52:50 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 1 Sep 2025 22:52:46 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Tue, 2 Sep 2025 11:22:21 +0530
Subject: [PATCH 4/5] spi: atmel-quadspi: add support for SAM9X7 QSPI
 controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250902-microchip-qspi-v1-4-37af59a0406a@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756792344; l=1692;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=f7DOA5wDFdEWR6ikCwi4zK/5qKnnx4GBTbYYi9JaLJw=;
 b=+go7VqpZKGWssX4BiHB4VD7oA4MOm2sbqhMKZvwE3v7H9D3JptWnXIujiVjp/AISEQOofGT7u
 2PTTzt9ftwLCZoZCuSVMZyzB3R7kmC5SGQsBZUz0msuKNGsHke0LbF+
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

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


