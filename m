Return-Path: <linux-spi+bounces-9930-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 377A2B48321
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 06:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7C23A1E7C
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 04:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CA921FF3F;
	Mon,  8 Sep 2025 04:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BazBsN1F"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE321C19E;
	Mon,  8 Sep 2025 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304895; cv=none; b=hZUDMuwYDn7je8bQ1IFV8u8WtP8NBhuHVgmRG3QgkjCiU2K3HQJ4mibLbhG+ZOR8rugUUkzczTBLh0BmEs4luBVqPE9C9WId/QRNLOvIgITXOTRcn+TwO8csJbDZVaVfJPkFTSZDYg7sXHNiQXMOqwLEYclv70tyg1wf07Q8i5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304895; c=relaxed/simple;
	bh=TaxTNHBdSP7EOxa2FDGkct94U6DiFXOc0lCmhlPSLXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gdHWp48/Oi9tCkKYQ7kCncQmHeNs+5WeTQUUR4Id4SO6/aHxoLuA/id2151uSipMdxmrc0aGDktxPAGDkzjZToFFsfvBLwR6nuOYu+jLFpHpwLJiomm1JRcK2NWnP/qFNrBhAXuoySgLHO+2Jql2SxEk2q0HY2sNCt2TpBPkafo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BazBsN1F; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757304893; x=1788840893;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TaxTNHBdSP7EOxa2FDGkct94U6DiFXOc0lCmhlPSLXo=;
  b=BazBsN1FWfhz8N7Nm5MxJjgOX/2qjFMhJrFcrZnsBoAV9e2cWQFP2d6D
   u1ovrGApo68BklNWNcmcRcnWMlkxAD6zK8/nwc/afe5ZZ2u/Xp3qfxhkZ
   1Z1GwuQSLAms9EwwNASZY2hCkwlPouCA8+a/8TKweXEihW2DA06C6HRUJ
   kqcaoOKjgi/y6I8ViUBhVFeHO7HwreBLAe8TRJOVVOhlu1VvcSCsoqFWe
   g3LgsgFi3LQFlySOkh3Klpc52Rb9w9M7aDqprnR3XEFjJSLon4k1zc+YB
   bLjQmnxk7w+CqF0Sfowt+4JoB7HsBByyseyuUYHxfkVOSWfVRi7VGJ99l
   A==;
X-CSE-ConnectionGUID: YPpoJm/ATHeRsyPuBZAjnw==
X-CSE-MsgGUID: iE5TQrUwRqSlvvSizkydqA==
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="213580664"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2025 21:14:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 7 Sep 2025 21:14:31 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 7 Sep 2025 21:14:25 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Mon, 8 Sep 2025 09:44:16 +0530
Subject: [PATCH v2 1/5] dt-bindings: spi: Document sam9x7 QSPI
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-microchip-qspi-v2-1-8f3d69fdd5c9@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757304860; l=877;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=TaxTNHBdSP7EOxa2FDGkct94U6DiFXOc0lCmhlPSLXo=;
 b=DLoXyTlSpsFareduqI73PqFwjH7aGX3JHj6RS6MuMTORSH6v5mlfGLJRzb8RKkbOLr9UMNHYY
 xlfR6JbXnskAqNPvAb8UNDD1Z7bZH3nbQ9t+5keQ6R3jSxNKRz9daKH
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Document the sam9x7 quad spi that supports interface to serial memories
operating in

- Single-bit SPI, Dual SPI, Quad SPI and Octal SPI
- Single Data Rate or Double Data Rate modes

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 Documentation/devicetree/bindings/spi/atmel,quadspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
index b0d99bc10535..c17114123034 100644
--- a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - atmel,sama5d2-qspi
       - microchip,sam9x60-qspi
+      - microchip,sam9x7-ospi
       - microchip,sama7g5-qspi
       - microchip,sama7g5-ospi
 

-- 
2.43.0


