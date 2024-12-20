Return-Path: <linux-spi+bounces-6134-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BAA9F9B68
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 22:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69E01897A57
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 21:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CC6226194;
	Fri, 20 Dec 2024 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="v36SLeZp"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1C422144B;
	Fri, 20 Dec 2024 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734728951; cv=none; b=KMBowfniyzddSSO9L7eHO3NwG4qN8bD2LXPU+qffm8ta32n9xTlHnQkiLBS/wOwExx8RIM76l7u6bstEn9RpbMJUgk/riFJCiVqUIHNEwKOkxwyFcqz8cXuWP/elD49Bze0aHaI1zM8xzLNfITc45OYUz/0Bra9STZKiL6tnJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734728951; c=relaxed/simple;
	bh=So/Nxhxmf5OjkDlEr9qmVGJaHBrSosIJeOjBNusjAwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeZgpQuOTev8Snq7H8GxvYnzCcCZCHzCGfM0u5XFqCQXJzihTwFoq3nKtxoGF8QaKjHWU7+qOzZytqYKILkEIdky/3Zch18HClOQTqDfGQwml99P7pWbX1MoY53ovWtlg80+e8bhKaXQyqWJjqZ/8MGCgc8bJzsl8P1tE9Th4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=v36SLeZp; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734728950; x=1766264950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=So/Nxhxmf5OjkDlEr9qmVGJaHBrSosIJeOjBNusjAwQ=;
  b=v36SLeZprt0xQOgfopknyRTq+/PFJT47etFCLreDuioHUMV3d50V2Mjw
   2w7twwsjDUm5uuDi3aNqx6dT6Quecot1FO687fvTf9ujZznuVeHMA2sM7
   jF2nIL2scILF1HsKICFQgITCbeI+ZJFEwfh8ApPeMqjIRLRIrwmNE6YV9
   rU0IAohqwnfvQaUax9DivW905wQ2SI3G9B5jRR+JgXUBCuSowiQnX2KYC
   LibRLAJcj5CHMmEi2+9FKFPg4L03bFUfpReqWFSjm41OSfxYHPwV7Vuck
   2wlN6H/K5xL2q8GnyFr17tIeF19y2zN0t2X4shLw9E6S/wbeeagJZhlMd
   g==;
X-CSE-ConnectionGUID: 6Xn2bQedQHqhtDmL7ky2MQ==
X-CSE-MsgGUID: sCW+yjseQTiWN2nJedTZWg==
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="203274640"
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
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 02/13] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,sama7d65-flexcom
Date: Fri, 20 Dec 2024 14:07:03 -0700
Message-ID: <3586d64e42b569c881a53a4ce06f09a9139c6b10.1734723585.git.Ryan.Wanner@microchip.com>
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

Add flexcom binding documentation for sama7d65.

Consolidated entries into one enum to match proper coding style.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml   | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index 0dc6a40b63f4..c7d6cf96796c 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -19,12 +19,11 @@ properties:
     oneOf:
       - const: atmel,sama5d2-flexcom
       - items:
-          - const: microchip,sam9x7-flexcom
+          - enum:
+              - microchip,sam9x7-flexcom
+              - microchip,sama7d65-flexcom
+              - microchip,sama7g5-flexcom
           - const: atmel,sama5d2-flexcom
-      - items:
-          - const: microchip,sama7g5-flexcom
-          - const: atmel,sama5d2-flexcom
-
 
   reg:
     maxItems: 1
-- 
2.43.0


