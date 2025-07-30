Return-Path: <linux-spi+bounces-9229-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18253B15DDF
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 12:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713C1189FFB3
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 10:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4958B27FD40;
	Wed, 30 Jul 2025 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EVi/K4OK"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3415279783;
	Wed, 30 Jul 2025 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870274; cv=none; b=IljTL/mn75nCfZYLlGnYDSnd2LmtmVGKik9Mg0hTNbfuRvOc9ClZoUoSQ+ddzOfVcwlqCtdQ+6219ixhnHL1hk4oLHqICkYfKoDPH57+9R8HUgUNejaRar938YRBLMOV3tN+arH5Z9IHJOd/ZoLSsj4YknGaNg2yaGdzoIzMrto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870274; c=relaxed/simple;
	bh=lM6SLl/d3swseRYR2bai+1H7yO5nP0S+r0BY0IFolmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGjtcsm79z4+kgl3Arn15lAa1sNhZuj1E1pceUtBpvlwrH2k+Y+5FMCDkcII7TTL7uFcmbtOdb9E28RABP5Mot2WWlRUVHoedIBGH6QJO+qccJP8Ioa4Od8wYyvh66VWeQY4TX5A4Ue0fx2YpYNPu9H1b111YN8ymAsackJHxqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EVi/K4OK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753870271; x=1785406271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lM6SLl/d3swseRYR2bai+1H7yO5nP0S+r0BY0IFolmU=;
  b=EVi/K4OKqoJgsZgiC0KJnl7XxCBUFfIlDc6F/KTFxiEPKRHFVORbMnQ5
   YIl/cTwBmxvHPQPV5PgLveXpugRyKpdk6Ufy8kIbs18gC16c7a8EMb7TB
   HaCtdwv3QNP3D8AywCibDcmBAE4iE+5llZFsK/jnCd3DmnyXVS1fxrmGs
   h2ckJi5CrceRy7OY3kCxZ2IdUmWVwF3mThRqM2rzpEtcXjvnlUSS0DOhP
   WFLjqoVxd2i8ZgJ8SWXry4qinh41QOyxZM+OqhbfDS06fIyOrfUwQh4rz
   dRZCRlQLo5xCV4yvf8Axc4AqXhkXB2DH9cazKP/fN43pi84BXxdNiQmBy
   Q==;
X-CSE-ConnectionGUID: zjJ/PdTbTgKvrskxeKL28w==
X-CSE-MsgGUID: GuM9KhUkTWq6wEF9QKR17w==
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="49962575"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jul 2025 03:11:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 30 Jul 2025 03:10:34 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 30 Jul 2025 03:10:29 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<ryan.wanner@microchip.com>, <tudor.ambarus@linaro.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v2 2/3] spi: dt-bindings: atmel,at91rm9200-spi: Add support for optional 'spi_gclk' clock
Date: Wed, 30 Jul 2025 15:40:14 +0530
Message-ID: <20250730101015.323964-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250730101015.323964-1-manikandan.m@microchip.com>
References: <20250730101015.323964-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update the Atmel SPI DT binding to support an optional programmable
SPI generic clock 'spi_gclk', in addition to the required 'spi_clk'.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
changes in v2:
 - Fixed mail threading
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


