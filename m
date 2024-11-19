Return-Path: <linux-spi+bounces-5735-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479B09D2B3B
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 17:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAFD41F23C3E
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96051D151F;
	Tue, 19 Nov 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Idupk5nv"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA521D0BAE;
	Tue, 19 Nov 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034476; cv=none; b=sVo0dZIftwFJZx20jd3GHpICEGd9D08mQfTSxCXYVdBMP+/+2QmffJU/QIde/SfrzHqd7meWdS9Fc3cRxXAas7YEV5Qk0QnWTcITkv6aKbANPla1fBjKfsGiMRiEcCfLX7T2AT5Cuwg6tmNhX58DxgnIHbh3NReEUBT3DiYX+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034476; c=relaxed/simple;
	bh=Nomp0y3IWPu5mrhOnyPqc6ct3IesvKLO2yuE2yCdDwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RigLEGw+1EBtFlFU/g8N7u6wBGjbIEGvavWajmFrwL9lociRUPn7WzOb02MbQYIaYx4sQ22hImdStaVqUVr75+7ik3SIGHFIO6UaYLkU+7eUKNOW1mq5n396F/FYhdp56AznS4FAD2m2UHMUrPmmZY3Hp7VI4v7D3i9ler0CNV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Idupk5nv; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732034475; x=1763570475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nomp0y3IWPu5mrhOnyPqc6ct3IesvKLO2yuE2yCdDwU=;
  b=Idupk5nvrijKDlV+22kiDnZp4RETaAIlltzG6VambjMWUhfete56roDF
   IuVfwZf8QLfp9uN9DLQUF2kqLq09/9KNxfCYWVDUT0b2KBL8TRKAC3JyZ
   DmIHVgFCl/ZAKeKaG0TDMSPT0XQ8VtvXiPzrgsIXh9w2gGz4TMDhB7uY0
   G2T/ssNALwhuwrthCs9iNJ5G9srdeHpEq2r3IcJG5rb7BgskXDbfZ3Pqz
   d1nDezPMVREunpzsQCiamDXLxtg+WE3QqR/7GvhLkxQtW34RQY/a46TW5
   krfudMvN2WVJ+5RrnSUZgt1lYGPgSlJkWOwgCSJlENlaSlOtmz90OsPIL
   A==;
X-CSE-ConnectionGUID: jnnvkeRdTYaD0RwnHEXOug==
X-CSE-MsgGUID: 6yPcMWbeTRi68yPOKxbpdQ==
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="35018889"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2024 09:41:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Nov 2024 09:40:53 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Nov 2024 09:40:53 -0700
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
Subject: [PATCH 03/15] dt-bindings: atmel-sysreg: add sama7d65 RAM and PIT
Date: Tue, 19 Nov 2024 09:40:09 -0700
Message-ID: <01cf1bbae5949cbceb2768f2044377bc2479986b.1732030972.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1732030972.git.Ryan.Wanner@microchip.com>
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
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


