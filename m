Return-Path: <linux-spi+bounces-6133-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD79F9B60
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 22:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F771897A29
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 21:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F338225A2E;
	Fri, 20 Dec 2024 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Pya7Eu/P"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E221CA09;
	Fri, 20 Dec 2024 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734728951; cv=none; b=W7YTsUgHpv7yfftQ5iPl0bptgnw6H6G7FB87iGuujgC7hG2gfop6KEsuzULfv8+aNjYcsPOyAvt+3cxqVSUwAGVCSWXPOXvN181yqjK6zIn/l+0HaJ+KTv6uOUMFKXHhFdgeqmK7Dznin8SXfBCZH9Xi82+3lte0Iy9h0OTigVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734728951; c=relaxed/simple;
	bh=VUT45XGlDSMQNHusgz0mY/5e3jHIdDXBnlb8O2girPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pH0e0nIO/g+e3xGAb9obpowtBzXuu7KHWc1BcJ6BwWWlG0aSODCtxOgAffrFTGwHParcNslYmgjfkwVHCOjq0/5fMjaIpP8IYuRdnMYefSVMtwmVhfrLeuRh2m3L/IZOoqGswSPnIx+kBdg05C/DfxP5aOVUah6jiFC5OKdFL2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Pya7Eu/P; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734728949; x=1766264949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VUT45XGlDSMQNHusgz0mY/5e3jHIdDXBnlb8O2girPc=;
  b=Pya7Eu/P5Z4IoURxvR18BXJtgpkHRN4YoyCqZbKqOHjtlKkHZzdOKJtC
   m7lDkengLfs0buTumfQQ8f74fajbu9KcUEXXVxQ2bKZ8aGmDsecuYESWJ
   bITdxZ/CFl9qDznjRVKZsRyDpJTlr/Gqqcm9K0nwRwFQZj62qkpioUUow
   78jNQecLiCTx/T82/ePez3p14vutg0M6DbpMv9Z2nFoh6D+v/UyMMmqvc
   ikoMwpDzqqAFv4p1isMx126CAQpvfeqD6tOgPJ507Flg9qACcggYXjR4M
   s7NFCuDz//S19HpcFQ/KU96pWjiaQTkGleYaq8wRTrYh8SR7DxQOl0TFI
   g==;
X-CSE-ConnectionGUID: 6Xn2bQedQHqhtDmL7ky2MQ==
X-CSE-MsgGUID: 3ZhaM57qSmG0+JvYfvcRiA==
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="203274639"
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
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v4 01/13] dt-bindings: ARM: at91: Document Microchip SAMA7D65 Curiosity
Date: Fri, 20 Dec 2024 14:07:02 -0700
Message-ID: <70d429086fd8e858d79ca2824ad8cc4a09e3fe5d.1734723585.git.Ryan.Wanner@microchip.com>
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

From: Romain Sioen <romain.sioen@microchip.com>

Document device tree binding of the Microchip SAMA7D65 Curiosity board.

Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 7160ec80ac1b..0ec29366e6c2 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -180,6 +180,13 @@ properties:
           - const: atmel,sama5d4
           - const: atmel,sama5
 
+      - description: Microchip SAMA7D65 Curiosity Board
+        items:
+          - const: microchip,sama7d65-curiosity
+          - const: microchip,sama7d65
+          - const: microchip,sama7d6
+          - const: microchip,sama7
+
       - items:
           - const: microchip,sama7g5ek # SAMA7G5 Evaluation Kit
           - const: microchip,sama7g5
-- 
2.43.0


