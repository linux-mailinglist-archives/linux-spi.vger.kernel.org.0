Return-Path: <linux-spi+bounces-6315-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5ADA095A6
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 16:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB847A12C8
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EA72135C6;
	Fri, 10 Jan 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hRA0fMXK"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E350211700;
	Fri, 10 Jan 2025 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522826; cv=none; b=qX2B7Vdtf+RhyQGIY5r1Wc91RvfEk0ftIuUnpIj/69jP+6iSgqGOxOZP76FMpsBTIXwNYU9SmIByHhfwBfo8Sa2rWQESD3zvToZeHPYorgZz4WqrSuDPSLP5zWMFgMPxDVOA5Bh+znnRsf/sSeWgdy7zd/PzvoREkI0zWY6TWJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522826; c=relaxed/simple;
	bh=tkTOYHY7R/B78zoatm15ZoMCaySho/QN7uoUcwZA5m0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0+0qvrP3pHly67RRQuA1bsukKTsM4x+o3WcQYNLToZTfaPWy2LghZCEtJa42haMxNniGQgt/KHfKSz17xYeFBAjTL2UU37hs6nkZUh8oqTmACipjkGWZwnnLtuEUaQqZf3lIqfbnHH/5TiaWr5M7oqYlSS2iBTqS9QZWohuMYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hRA0fMXK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736522824; x=1768058824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tkTOYHY7R/B78zoatm15ZoMCaySho/QN7uoUcwZA5m0=;
  b=hRA0fMXKDUSdDep6+m1hhX29w7qO2H29bDUqQ59QXA2bEhii0sy7bypT
   UkhSTbQmg33VjHkNtsif1QUt52q17kW6RvuxNVJZ6/3IggqpV/C/Ya39f
   LeEA5U4JoT1VpRo7mIcZddikOTvv4jJ6LJUTIIhlPJPCW8ovZsqe1uEi0
   6/Z+akRc0JO1DHFkeHCIJgFWwo8UAf3/813/Eax3ryB3QKSsgt0910haI
   HTbYmYnxGIZZhbRQ0Q6uwrlE8mG3mIfHdlK6Ui6lojo8ds+utA+rCGJoc
   rU73eWzqJ96Ed885/NjEyCeDO1U/8APQ/tF2pGLZmPET5qvnqlz3tM3Q4
   w==;
X-CSE-ConnectionGUID: EfVstCxrTPeDtavimu1NHw==
X-CSE-MsgGUID: 52MgwlluTxOOs9zroo6fDg==
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="203886132"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2025 08:27:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 Jan 2025 08:25:52 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 10 Jan 2025 08:25:52 -0700
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
Subject: [PATCH v6 2/3] dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
Date: Fri, 10 Jan 2025 08:25:41 -0700
Message-ID: <821255840c09d8d9cebbb1f2daaedd8a7c138875.1736522006.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736522006.git.Ryan.Wanner@microchip.com>
References: <cover.1736522006.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Dharma Balasubiramani <dharma.b@microchip.com>

Add pinctrl bindings for microchip sama7d65 SoC.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
index 774c3c269c40..81a05a09f19f 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
@@ -6,6 +6,7 @@ configure it.
 Required properties:
 - compatible:
 	"atmel,sama5d2-pinctrl"
+	"microchip,sama7d65-pinctrl", "microchip,sama7g5-pinctrl"
 	"microchip,sama7g5-pinctrl"
 - reg: base address and length of the PIO controller.
 - interrupts: interrupt outputs from the controller, one for each bank.
-- 
2.43.0


