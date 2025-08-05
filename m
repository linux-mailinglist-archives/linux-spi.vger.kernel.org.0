Return-Path: <linux-spi+bounces-9289-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDADB1B1F7
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 12:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D80D1813DA
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D2426FD87;
	Tue,  5 Aug 2025 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QaQOyQka"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E5926C3A0;
	Tue,  5 Aug 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389605; cv=none; b=q3vBrvA65x9AgqaW2jpPC0kRG9HG2nu3cjFuK05ND/Dc8PCLJPjoNCIelMtVNQ3LF0vxuxuiZLEC7NkkC838fjHIRzTOEmQxlBJa8l1hMBz+nfgm+D8vywK2v0YKlumeXJXPbDbONIJXHV826STgAbT2NjeWbAcrr45IWnnqb7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389605; c=relaxed/simple;
	bh=jcHluiS23Qnyxsx+eLhpXfKCtwkHXmfK8TuIezg/KNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q80bE/dNZipVoyPsdJShMejaABDgHFj+Ddsocqz3ur73z03AiGQL8YSI2SlkzaHvCrQx6amL8fr4DFlf4o8oxN02h6eguBrEvtxrj6+ZyahOjhjhfsP/FKkhf7sBn6GTZsdmL8Ye88BaQSHKUYvLy778+3YLJnBn2AStGz6n5HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QaQOyQka; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754389604; x=1785925604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jcHluiS23Qnyxsx+eLhpXfKCtwkHXmfK8TuIezg/KNo=;
  b=QaQOyQkad7wnVi9WDs4LKNfByUkQ3aEIQyxUYzCHitRq40ZjjnAODpWi
   oIS5y/WnqirB0T8VcUk8l7jlBGVN/IvvBV9HJ2UEkfg0Vzrnekh3V6Wws
   jX1j1rkcQyyZ3jf57/ptn02dZG3HhTqDfkP/6FGDpOvZDCL7GuEbvqdPj
   DIrFtjdtg+cLzle6p2UcE4C1fVMs0eagEdmOQ8OBPX7SClVDJA6Lgx6Y6
   2zdykS8CQbVp+pCIdDgnhyXaHpx5JZ6CeICvNn/P5QdTXxXCQ6gRg18ih
   uKzMLS4AN1rN0+fNnLEyaKsn70jPqQy0O/QIEqPNMasl0nsj2Hea8hSub
   Q==;
X-CSE-ConnectionGUID: 5giYSL7rQRGsqPqo2rqYFw==
X-CSE-MsgGUID: K2sezLbaS86OHGPP6tSfdg==
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="212248019"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Aug 2025 03:26:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 5 Aug 2025 03:26:20 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 5 Aug 2025 03:26:15 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<ryan.wanner@microchip.com>, <tudor.ambarus@linaro.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v3 2/3] spi: dt-bindings: atmel,at91rm9200-spi: Add support for optional 'spi_gclk' clock
Date: Tue, 5 Aug 2025 15:55:09 +0530
Message-ID: <20250805102510.36507-3-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250805102510.36507-1-manikandan.m@microchip.com>
References: <20250805102510.36507-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The Atmel SPI controller supports both the peripheral clock and the
Generic Clock (GCLK) as sources for SPCK generation. On platforms like
the SAM9X7 SoC, the peripheral clock can reach frequencies up to
266 MHz, which may exceed the maximum value supported by the Serial
Clock Baud Rate (SCBR) divider, leading to SPI transfer failures. In such
cases, the GCLK can be used as an alternative source for SPCK generation"

This patch updates the Atmel SPI DT binding to support an optional
programmable SPI generic clock, specified as 'spi_gclk', in addition to
the required 'spi_clk'.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
index d29772994cf5..11885d0cc209 100644
--- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -31,11 +31,16 @@ properties:
     maxItems: 1
 
   clock-names:
-    contains:
-      const: spi_clk
+    items:
+      - const: spi_clk
+      - const: spi_gclk
+    minItems: 1
 
   clocks:
-    maxItems: 1
+    items:
+      - description: Peripheral Bus clock
+      - description: Programmable Generic clock
+    minItems: 1
 
   dmas:
     items:
-- 
2.25.1


