Return-Path: <linux-spi+bounces-9931-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C710B48325
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 06:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7593A65CC
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 04:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EAE22129F;
	Mon,  8 Sep 2025 04:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XdAUPq0o"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20D21D596;
	Mon,  8 Sep 2025 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304895; cv=none; b=TUZDQG/HAzuKDhHDsuPkw1KIfj9tWJsyMARWQtBg/SZPrmNIsJkCEBwtG2vxY/oxvkAMyqOzqhWWjBT2mex6OGvbti2TKJsGqNMQfw/oXVIv4kDxBWsTIqU1p5PfB/e+5H8O8EO36tnZvxguqBGf13Uw4TEX2WbZY4dx9PL0u5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304895; c=relaxed/simple;
	bh=e9VWFRSwNpYXqnNmw9kbScIHMnZuxvIjyF1UMqscb90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YhnulC8GL/+Ze0JA+67z7FtRvq10WhNgnOa5znvGSv+rfSzoSqNw/BnnNs3iA0nAOgc3uC0JYranjVxtGxBXyPjyn1oLk5X1UUg56h7rk+QsaqeJeqLPXz3XWQ6RtzbTuah09iMQJYRT2W4sC24yI8deomoVodttVMvAnOqZxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XdAUPq0o; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757304894; x=1788840894;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=e9VWFRSwNpYXqnNmw9kbScIHMnZuxvIjyF1UMqscb90=;
  b=XdAUPq0oubTCiYk4Y0c4T2WSJvr/IACpulj5dUaMkUccvvNv9ewQelkm
   t+8ix1PjZ8oqiouyNX7wyA/DW2wP3sNH/Z0qNNraOIfM2vn7A06lKVzpZ
   GMBJmvBhQH7AYcC3q3S4PDBxJUGXhpO/fL7GOD4xzzONEroOfo1+S+Pu1
   3/XKB5gOCwB21mI0dkyNLy3M0GTSQyqsOgggkiaQkdrKoyn/KRErD5AMH
   pZl4U+ynB1f5C/M64RoMcn0ONWAp/F9aUbHgWOY09BEpGCmzaDrcZF7Bu
   CngBQjvalnWmmxhiRZGOMsfaodk6ivDLfEss6q8YVaaYduVV+ILvwzB/C
   w==;
X-CSE-ConnectionGUID: YPpoJm/ATHeRsyPuBZAjnw==
X-CSE-MsgGUID: 4Igph96/SsG5PGgXO/ZyWQ==
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="213580665"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2025 21:14:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 7 Sep 2025 21:14:37 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 7 Sep 2025 21:14:31 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Mon, 8 Sep 2025 09:44:17 +0530
Subject: [PATCH v2 2/5] dt-bindings: spi: Define sama7d65 QSPI
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250908-microchip-qspi-v2-2-8f3d69fdd5c9@microchip.com>
References: <20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com>
In-Reply-To: <20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757304860; l=1008;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=e9VWFRSwNpYXqnNmw9kbScIHMnZuxvIjyF1UMqscb90=;
 b=6jOxPORoqvCAYlEQ2RH11LrjiHEQFOayPVVeqs6SddsJiROpczeZmNLAGV8voKzkBebeQND/V
 5yUM/g0bDFfA6ZsMtqIqwfhw6zGMOxnJ3DwNLIxVJ+30TDbCw31CRlR
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

sama7d65 has 2 instances of the QSPI controller:

• One Octal Serial Peripheral Interface (QSPI0) supporting DDR. Octal,
Twin-Quad, HyperFlashTM and OctaFlashTM protocols supported.

• One Quad Serial Peripheral Interface (QSPI1) supporting DDR/SDR.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 Documentation/devicetree/bindings/spi/atmel,quadspi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
index c17114123034..30ab42c95c08 100644
--- a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
@@ -18,6 +18,8 @@ properties:
       - atmel,sama5d2-qspi
       - microchip,sam9x60-qspi
       - microchip,sam9x7-ospi
+      - microchip,sama7d65-qspi
+      - microchip,sama7d65-ospi
       - microchip,sama7g5-qspi
       - microchip,sama7g5-ospi
 

-- 
2.43.0


