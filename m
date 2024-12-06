Return-Path: <linux-spi+bounces-5934-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4B99E7987
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 21:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5802C16D932
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 20:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C242163BC;
	Fri,  6 Dec 2024 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bKwYRjCE"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1942135DF;
	Fri,  6 Dec 2024 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515286; cv=none; b=EuMMAgbVDmDxn8+VvJ6+I6fyd8+Qk95ntT0EnV9b2/bvMC5DpJKr+ws7EzwBBY5NLL4M5SPJcJWrWgsFPaYvk3awlb3X+K4rZDko5NaS25Ad8npCaKDLFjroBvvvlBCx72CBK6uLEYKEHF4cDhdEF/Q+PpesqQvNYlh6rehZwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515286; c=relaxed/simple;
	bh=BCyeqOoY+YLc7OOTB+1JsebdSOtDLOPlnU8NaRAIflg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnQTQUcIULtKcGbfjG/mp1foO+EM85W2JFuMoJR0YemXN+os6HJho0sn9wFjGwfxmTjxQV/Y6NuyYY/rDoo6ZHI3rHvB69YRpbw/cSVDpl1yY03Njg4ZakyoH7k6HZoG/IZjoBwv1YfuLJVWr83OlqlEWqrBakcKH+Q0giVpwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bKwYRjCE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733515285; x=1765051285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BCyeqOoY+YLc7OOTB+1JsebdSOtDLOPlnU8NaRAIflg=;
  b=bKwYRjCELedX+4xsMQEWNKQ9LhjPa8X4jfiGlzk2zmqgqRAQE+rxxKGD
   Yt4A2gez+SkjxWW8lQkqMk7GO4Q/Ow9kgz5X+5uOv2UJNBHHyI7ZYM34I
   tTk1lgaoEmF25qDmGEKhk1JQI74w+7ok2hsHzUCGPSlS6WMuQ12T/aY0Q
   jcknBJuIpTPnz8f48Wd7P+DKMwUUnkzWZ/t7ej4PnLcr+WLLrlcYqHSKb
   B58TCc874aJ0c6+PQE9ahdTUXSVEUAoVlEYNCkckD3cu0lkNN1o0eOEWh
   2dmWX5mIz8knP1TJ9GuBm3Mp7xgkJ1ubCXyf5jh2g2/VdxgvMTX1CMF/+
   w==;
X-CSE-ConnectionGUID: wHv5dacKTzaP3KMzdbJ8Aw==
X-CSE-MsgGUID: NjvV5IrnTPebvbUWN1E1iA==
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="202686985"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2024 13:01:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Dec 2024 13:01:09 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Dec 2024 13:01:09 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<arnd@arndb.de>
CC: <dharma.b@microchip.com>, <mihai.sain@microchip.com>,
	<romain.sioen@microchip.com>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
Subject: [PATCH v3 03/13] dt-bindings: atmel-sysreg: add sama7d65 RAM and PIT
Date: Fri, 6 Dec 2024 12:59:48 -0700
Message-ID: <96e64f01eee264ad0ac4c720a7a1cab4f95c206b.1733505542.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733505542.git.Ryan.Wanner@microchip.com>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Dharma Balasubiramani <dharma.b@microchip.com>

Add SAMA7D65 RAM controller, PIT64 DT bindings.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../devicetree/bindings/arm/atmel-sysregs.txt      | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 76e2b7978250..93c2a5a341f3 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -13,6 +13,7 @@ PIT Timer required properties:
 PIT64B Timer required properties:
 - compatible: Should be "microchip,sam9x60-pit64b" or
 			"microchip,sam9x7-pit64b", "microchip,sam9x60-pit64b"
+			"microchip,sama7d65-pit64b", "microchip,sam9x60-pit64b"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt for PIT64B timer
 - clocks: Should contain the available clock sources for PIT64B timer.
@@ -27,12 +28,13 @@ Its subnodes can be:
 - watchdog: compatible should be "atmel,at91rm9200-wdt"
 
 RAMC SDRAM/DDR Controller required properties:
-- compatible: Should be "atmel,at91rm9200-sdramc", "syscon"
-			"atmel,at91sam9260-sdramc",
-			"atmel,at91sam9g45-ddramc",
-			"atmel,sama5d3-ddramc",
-			"microchip,sam9x60-ddramc",
-			"microchip,sama7g5-uddrc",
+- compatible: Should be "atmel,at91rm9200-sdramc", "syscon" or
+			"atmel,at91sam9260-sdramc" or
+			"atmel,at91sam9g45-ddramc" or
+			"atmel,sama5d3-ddramc" or
+			"microchip,sam9x60-ddramc" or
+			"microchip,sama7g5-uddrc" or
+			"microchip,sama7d65-uddrc","microchip,sama7g5-uddrc" or
 			"microchip,sam9x7-ddramc", "atmel,sama5d3-ddramc".
 - reg: Should contain registers location and length
 
-- 
2.43.0


