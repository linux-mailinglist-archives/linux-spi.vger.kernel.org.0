Return-Path: <linux-spi+bounces-5929-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6CB9E796E
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 21:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34A0162EB9
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 20:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBD3204563;
	Fri,  6 Dec 2024 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xshPHlfX"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDF41C54BA;
	Fri,  6 Dec 2024 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515277; cv=none; b=Nr3FNbB4wwGK1TUNUXBLX+R3HkmmhwdNPKDZ3TzbKCYGSpyMffvDalEEqg56reKg46PLiHaT3ZpJgCT8sept7aIlBpbHjpRYFd5XPJhV7xto7/aS4fERWDzMlH0btcsNTovkUZCfn9JjZnxjLInrvYEtzS7tySaZt4BKGxkhvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515277; c=relaxed/simple;
	bh=h8r9pGDF0wzJx+5ny3vfVXThrQSJXbj8ubP2ksqTc+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMW2otWAb74J8393pttDagygvlOVtEfZuDRwaJBzkiUioP/2Y9bifLqWPKJ1GSAWThjY9sujt+VHTnKe5uoMEG/oK35EQJbbe8Jp2Yz5pNUPB3Y2uPxM1l0PPKw2sGt85r1vQhTdtZYYgz+pYpla4weVksfuRgsP6iozb96Gmpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xshPHlfX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733515275; x=1765051275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h8r9pGDF0wzJx+5ny3vfVXThrQSJXbj8ubP2ksqTc+8=;
  b=xshPHlfXdHMvkp0eglaSAnMIu3YBpy2GlHqaKRTHeedI088n5f364IBi
   HwH/lXW9mAQplAxJ7DBGzuCkBcOCsmuHkjca+oopLI+n5xyWSR0zer9RW
   +67tK/uWvBwtSjZslHHiLo1gseioXeKWiW1l6Ba377Xmt2G6MtN0R9akt
   GDw+sGZF0AV2WR0/cN7LW3952ljK0g6Ir05abyBc4/oJNvPeHdhzsPRnh
   zHsW5/SzeN77pwlwNBq6KuObDlrdlvK1jwKwYf5V8+6jd24BuZlOtP15v
   cnaCD3azFqvOljDOUKQANsp8gKC+ParJs4bbxl9lV31Rql2FuvsjQuP4M
   w==;
X-CSE-ConnectionGUID: 9plLhrxgQXuYZUyQ8wJyMg==
X-CSE-MsgGUID: GKdtANrPRu6SvYOGXwuSGg==
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="34926406"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2024 13:01:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Dec 2024 13:01:10 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Dec 2024 13:01:10 -0700
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
Subject: [PATCH v3 05/13] dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
Date: Fri, 6 Dec 2024 12:59:50 -0700
Message-ID: <b41307089b72fd92f8e2d314e4750194df9c888a.1733505542.git.Ryan.Wanner@microchip.com>
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

Add pinctrl bindings for microchip sama7d65 SoC.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
index 774c3c269c40..a7d7d2eaf10f 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
@@ -6,6 +6,7 @@ configure it.
 Required properties:
 - compatible:
 	"atmel,sama5d2-pinctrl"
+	"microchip,sama7d65-pinctrl"
 	"microchip,sama7g5-pinctrl"
 - reg: base address and length of the PIO controller.
 - interrupts: interrupt outputs from the controller, one for each bank.
-- 
2.43.0


