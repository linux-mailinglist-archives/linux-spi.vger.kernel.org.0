Return-Path: <linux-spi+bounces-6247-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65E6A0458C
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 17:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892511885FE1
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 16:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CC41F4E42;
	Tue,  7 Jan 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nFIbfIMa"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F771D8A16;
	Tue,  7 Jan 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266123; cv=none; b=cJ/gnvuVVg7mxb8yNgYry6bD85xEiky8aiy7o2sPPdMNotE56dnaXMBbAO30J7yj6/VVKhGwNjvMK2knNet8P0babGOLFvJ3I+pLvFVu7t2SN9aWNzftUJuHz0CPGIclWPps+C5jpZfeaVix397Ea0vraNSyHkE23+K+3Vw43z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266123; c=relaxed/simple;
	bh=PH4rUN/rnjax/mDGGIYBtSheO/61fSdwRtwLQU4elCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhdrRqC9ZvFwcLetHirDpvTFXVBYQEX+ZmdboCYsSEDaF31xbQqdUBbFAjPzu8BMxFrQnYwg3iWswLiAJyKLAH5snEYhfKzpi6UwstaxEr0CpxBnXVFs8+aYLbrN48PllxNms7O3inLBnA/wmGM+DvN+x+anLpwh4GpfIHYj0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nFIbfIMa; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736266119; x=1767802119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PH4rUN/rnjax/mDGGIYBtSheO/61fSdwRtwLQU4elCQ=;
  b=nFIbfIMadkmcj/nc1iHvqv390MSRguhbR1CpfbOgwvRzER3Hui1IAYUt
   BX2MkgXYBsv0iQ+gwUG41auBJC8bPZgwJM8xYDATQpT+5VKfWEpxQStCn
   LDeRA3ZQ4aAYeJs47qa4x0WlPNkBS7WWELkZYpgGqFV9mUES6uQLYgaF9
   wMpb5/Asv/MZhrb+thX5dzIK1PuSdqYJ7eQa08rO9VpQLBNGp9lmU2Gkj
   yE59IqV8fiEvJ9NZ1cEUT3edpqOlE405Vy1sCqs5oUPcsy23vhECaotBJ
   2mfCEH69NCzeK35Z2kib8CYc0RKDqwpotdwJmukmQBQsokUOoK9aE+Ck2
   Q==;
X-CSE-ConnectionGUID: lqpfnJzJQpCXzb9QKpQeRA==
X-CSE-MsgGUID: K4H+nriUSkCBJNw9ScA8Kg==
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="40091253"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jan 2025 09:08:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 Jan 2025 09:08:18 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 7 Jan 2025 09:08:18 -0700
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
Subject: [PATCH v5 3/5] dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
Date: Tue, 7 Jan 2025 09:07:25 -0700
Message-ID: <20250107160850.120537-4-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107160850.120537-1-Ryan.Wanner@microchip.com>
References: <20250107160850.120537-1-Ryan.Wanner@microchip.com>
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
 .../devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
index 774c3c269c40..4b9f3373503d 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
@@ -6,7 +6,8 @@ configure it.
 Required properties:
 - compatible:
 	"atmel,sama5d2-pinctrl"
-	"microchip,sama7g5-pinctrl"
+	 "microchip,sama7d65-pinctrl", "microchip,sama7g5-pinctrl"
+	 "microchip,sama7g5-pinctrl"
 - reg: base address and length of the PIO controller.
 - interrupts: interrupt outputs from the controller, one for each bank.
 - interrupt-controller: mark the device node as an interrupt controller.
-- 
2.43.0


