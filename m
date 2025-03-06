Return-Path: <linux-spi+bounces-7060-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B45CA5501F
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 17:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7351751E3
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805862135BC;
	Thu,  6 Mar 2025 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Wdt8JSwf"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C28321149F;
	Thu,  6 Mar 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277034; cv=none; b=EL4adsj4o/G+950FenSsgBJxmOLpUzCEq/9WtOhFBkrxCUdQIuI/T9yc9zCNQXKqYGp8nTXAUX4wlbB6l0yF3GlmWLkVBPdkaTKgARvRZjWMMG3KVDTo/EgxDmq/AXOeufBUplCFc+IpVnkDgq7pbjkKY97Wy4+EtIXoap/w3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277034; c=relaxed/simple;
	bh=tkTOYHY7R/B78zoatm15ZoMCaySho/QN7uoUcwZA5m0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgfW/rz2eQNHCY6HpadZVkPESPDrm1QflzR3Rg9QhP2Wq5fyDcLpC2n/cA9TeIyPua0M518XaJpIQGDILGmXnJUDoV7iD56WjqyeDSqkIvsWXWdxNfamUbGPniCtBbrgjPsV/4XQAeEi84PasUA1Jfq6Ei3sKnWWlqiWpRXl3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Wdt8JSwf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1741277033; x=1772813033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tkTOYHY7R/B78zoatm15ZoMCaySho/QN7uoUcwZA5m0=;
  b=Wdt8JSwfmIvG1uXH+o8iaFCz7PyzOgd6hRZdL+wm7VjnZvqSc8qZNFeE
   TTt63wkJ/6vvfO2C+9djlJ958Or0/ecPB5sYgcJh9n0eTs3kVEjSJB2+v
   Vu0Hv6kxO4pFQEpbMNURGn5nOxbrWqM2BPt8H4h1eTu/gdoFKN0SVxfv9
   sRgeH5E8vTcvxWAiJ5xwXrfFXRYWK320fqUM8sGlp2KdoZEnfONGxGAhe
   a09DMjVSZK/MwnJHHKMvhXBHDWMY8yC7Fs2VQXTYos/InpzoZBOyebSRz
   U9zzAOzHl5eGkHnsp7DjE4HHKfRDODfOxE3gPBqyKTlgEFZ7JfPYKyXfv
   Q==;
X-CSE-ConnectionGUID: Mtzc/U5nQtqKRw1uIzvygw==
X-CSE-MsgGUID: D+4/U7qNTAm+QfzadrmBBA==
X-IronPort-AV: E=Sophos;i="6.14,226,1736838000"; 
   d="scan'208";a="269901970"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2025 09:03:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 6 Mar 2025 09:02:57 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 6 Mar 2025 09:02:57 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linus.walleij@linaro.org>, <ryan.wanner@microchip.com>, "Dharma
 Balasubiramani" <dharma.b@microchip.com>
Subject: [RESEND PATCH v6 2/3] dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
Date: Thu, 6 Mar 2025 09:03:19 -0700
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


