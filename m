Return-Path: <linux-spi+bounces-6136-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D661B9F9B75
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 22:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66A21897C46
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 21:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBA1227BA5;
	Fri, 20 Dec 2024 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Rz19taM2"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1B1225A36;
	Fri, 20 Dec 2024 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734728953; cv=none; b=pBPfbr/muOny2i83hCYLdBREWMAfiNeJLnfTl1x7Mh0iAs65mPt8MCrcmcD0qQmPWq/RLcdA70xUmFUq1Jrw6aQvgbwxrD16AtcroL57ph+jR4KqvoVYfQDVj3UVcAp5CrjURjxM+O8jwkVixVHW/4jMTjemBQ/t0lhotN6WBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734728953; c=relaxed/simple;
	bh=T+l6OVVT45tzMYV8TY6DeZg93MwIQ0gaakx3sxA0rT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9FVFWCvSjAhPy0MkYeTqHNYoeOpzgQPMch8YIlWzLDaZfNEHv4G92jW2PixbhuWkaF6ek0mH0cGTMmyuXHesuzR7+P91is1vxG4zZ5ETK4pbiYrz8sD0WNuLHJNF6Gi4UfK6IOWq5PxHGAQKK9hEMOFVRczggqZpYDXr0nHR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Rz19taM2; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734728951; x=1766264951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T+l6OVVT45tzMYV8TY6DeZg93MwIQ0gaakx3sxA0rT0=;
  b=Rz19taM2rEfeHFQi5ohdkICarj6vXLMvWkw37RafqwZmiQh8DGgCjK0N
   0tBjmPTM7Ic8aEI7wKf0ujf59ByaENqJHpcYwPa5V74JoXFQiXIT/Nwhg
   YjNum1gbMujmwAcGIHn3ACHGJOfkuz9ofh8IHhjkRyIO9ultHT/B0HscM
   tL8YI9e218ZoUGx9xMHvspzJTxO3suDOt/CWd+BB2GPJVXP+eUfFY07jo
   hNCeJehCGleRxh72IeWBIdX9OoyfbfxkRHetQ/w1knwg9LvPpvYlJzsJK
   3ongGPQCUiqRzumYbzPzLL7qixVQVyWdssYLKWblmutpx/nB7k41k5jtc
   A==;
X-CSE-ConnectionGUID: 6Xn2bQedQHqhtDmL7ky2MQ==
X-CSE-MsgGUID: Ox9v++T5QtWfQ8w6Q+5SwA==
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="203274643"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2024 14:09:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 20 Dec 2024 14:08:43 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 20 Dec 2024 14:08:43 -0700
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
Subject: [PATCH v4 04/13] dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
Date: Fri, 20 Dec 2024 14:07:05 -0700
Message-ID: <7d2bf43095dd5b8784ec53a45d5f07f3f0481b0a.1734723585.git.Ryan.Wanner@microchip.com>
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

Add SAMA7D65 USART compatible to DT bindings documentation.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index f466c38518c4..087a8926f8b4 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -26,6 +26,7 @@ properties:
           - enum:
               - microchip,sam9x60-usart
               - microchip,sam9x7-usart
+              - microchip,sama7d65-usart
           - const: atmel,at91sam9260-usart
       - items:
           - const: microchip,sam9x60-dbgu
-- 
2.43.0


