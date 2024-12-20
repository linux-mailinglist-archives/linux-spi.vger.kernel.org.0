Return-Path: <linux-spi+bounces-6137-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 042E89F9B7D
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 22:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6FB1897E53
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 21:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF932288E5;
	Fri, 20 Dec 2024 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TO0gscoe"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA4226529;
	Fri, 20 Dec 2024 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734728953; cv=none; b=MVOdE2Z49ZxnYE6ojGgRYf6FetZ260wwDqrNWrUMufXpPSAq1Y+gZ4wFVsTsjO3GoGKlN6OS8v0p310JQSZ4mIVyHHW/+hav2B4vGnJNENy09uCDpmUW3YWUF7a/AwEw/15Q/PCxvVS1mOO7LtQhM9JIwyBNv5Ev+hOtoJsZAvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734728953; c=relaxed/simple;
	bh=+pQbU9KrAaqj8DThvbCwesXrXr/EK9f9JQYXh+Yd3Hk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPC3ykZuz4r9iTWayZyJcyAKny/82GCbi3b4vLpYjJ9qGb/Qu183g+KmVamLBJzWhcSeAWchO5TjICnZ8WQmWfFeeXHlI63eD8fpYI/dM6QGAfn0iNlDNoWuBOHf3XztGYjv74fy5C/wgmwMyuFlXv9D9jQk+BUe4CyKHBjhH9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TO0gscoe; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734728952; x=1766264952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+pQbU9KrAaqj8DThvbCwesXrXr/EK9f9JQYXh+Yd3Hk=;
  b=TO0gscoeW1jxW+wkL5Xatp2b+GEQjD3E0LlZvzs0oRovr4EN7AMnC8nc
   fOJr52hCVEKGc0jpWfIlpxaWBHPDpjaihKwG3zJUwFRwJr+DHYHRl7VUC
   s1g+AjBC8jRgGhxlUUrNMztRiJ8Y41VgEBP+cDvk7/qE3YShSFL9bOEtj
   AALDOaY46qW+dC8OA8vx79+kXLp26qwPCdt2wxwcAjzUzXFyjWq46loox
   /sZJHrrERqAPvhtQh27nQepbMpZ/8cufNcAP2tx/PY4+GeGB0Lz+Z2u4K
   ZIDtm+u0py4qxi4B7TNNEklIIO24V7LHzipbsg4roXj1OjnxkJ7+6/1Uj
   A==;
X-CSE-ConnectionGUID: 6Xn2bQedQHqhtDmL7ky2MQ==
X-CSE-MsgGUID: I/MC5/adRJa8THr6LZiYTw==
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="203274644"
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
Subject: [PATCH v4 05/13] dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
Date: Fri, 20 Dec 2024 14:07:06 -0700
Message-ID: <6ec5d56d36c64b7a29e043cee0b5a6c035c0d85c.1734723585.git.Ryan.Wanner@microchip.com>
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

Add pinctrl bindings for microchip sama7d65 SoC.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


