Return-Path: <linux-spi+bounces-6135-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B902D9F9B73
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 22:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60A957A4AFB
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 21:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78423227566;
	Fri, 20 Dec 2024 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OI0a0dhl"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EC22236EB;
	Fri, 20 Dec 2024 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734728952; cv=none; b=NnUgGtaQSVoaebnS5DQSAbY3QTv6M2Newl6z5g79ax3SAZf3jT7Ws7RIySOdt+u6Rbouw9ZsneAePL4fXNcYP3hXRRxoDDw0fnm+EsRRzLRK6W1gBeSsaqaPQovscUSpIkx/eosRIp0tox593UE1P45oOCWrBfQXYfRfAy1bwOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734728952; c=relaxed/simple;
	bh=+dtBRZeHFyP3XZQ1AAiTs38oeMsV33YqGXeuMNNfu7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0lIuu4ZloYGwO2atUZfbAcXfZRt7cbpruuut1NtSpZZlV6nqQOGYWw24Fs06usAh3DWBgvC24kBGxKCTL7yeVfTWehB97z3fLLOybNyl64W7Davd/BPHZ7t7o8q48+J3Ll3/n7rw/aj3u2QyR0iN/cwHVLoUdBfMZYq8FlM4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OI0a0dhl; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734728950; x=1766264950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+dtBRZeHFyP3XZQ1AAiTs38oeMsV33YqGXeuMNNfu7Q=;
  b=OI0a0dhl5vkBGxasiVNgtrEzfuMZFcDn+dd+8AAd4oWF17HfXkMTaXxA
   xpeP3lUtvOiqdfB/olBNvryyHg0sha5UwP/2XZQmbfhAKSgehFmPcCVd7
   V4h77830BJhchCXyFvsnPso/RF7/P1WBORq6ehxTsguHmxCg7/P2BAGPT
   DJW0S1WDOp9MTV6Vdyp+58o4IUvoeMf/RDZVK96Co82pmB4XhiIeYPCl8
   4eN6aEl+sIM4PLUu/3EIlCg2d60wWxhDs3heUAhPnNWWcaq6aRQ9zXteQ
   6ug34/qNgjBEa4lafxdLgYB1+gGigxJ5l0D0kCrAedb5l0/pEG8kVLIOH
   w==;
X-CSE-ConnectionGUID: 6Xn2bQedQHqhtDmL7ky2MQ==
X-CSE-MsgGUID: S6aaqUoKRfCZPf7fVqHNVA==
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="203274641"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2024 14:09:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 20 Dec 2024 14:08:42 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 20 Dec 2024 14:08:42 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<arnd@arndb.de>
CC: <dharma.b@microchip.com>, <mihai.sain@microchip.com>,
	<romain.sioen@microchip.com>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH v4 03/13] dt-bindings: atmel-sysreg: add sama7d65 RAM and PIT
Date: Fri, 20 Dec 2024 14:07:04 -0700
Message-ID: <c1b5b4a13f31bd465b69547f29e3ed6f616b2e76.1734723585.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734723585.git.Ryan.Wanner@microchip.com>
References: <cover.1734723585.git.Ryan.Wanner@microchip.com>
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
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/arm/atmel-sysregs.txt      | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 76e2b7978250..1a173e92bb13 100644
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
+			"microchip,sama7d65-uddrc", "microchip,sama7g5-uddrc" or
 			"microchip,sam9x7-ddramc", "atmel,sama5d3-ddramc".
 - reg: Should contain registers location and length
 
-- 
2.43.0


