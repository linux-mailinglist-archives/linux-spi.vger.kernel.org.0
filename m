Return-Path: <linux-spi+bounces-3727-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE46925888
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 12:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA08528CE55
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C374416DC2C;
	Wed,  3 Jul 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OKjcONkG"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9660156F28;
	Wed,  3 Jul 2024 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002436; cv=none; b=KftILbeyW1yq+p3n/inD0QWUkTP7ULS1kCPj6NcrR41o8TdEzcaB9MCA5iY4/hnsYBWOwJAVy2tIVkMDonkfv3nPow1gPAgp4QbbzA7JcKjtGzAWfIUxCSEGy9wSv4344iWZ3uFK24R3W+HO30xRO3zfqQ+S8fRYtm4gWz1q8GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002436; c=relaxed/simple;
	bh=CFC7z8WmsZSF958vPpbokrnZvgzbxwMA/ZoZqH+Ywdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIIGyAdN0+trO9gyj70Q87MWerBsxCMoVt58ikoCHOC5xyKd5VdlOFNEV8DpDVK9ZBj+/Tea7QPHGGnwwyv3zHVLaCpo2yXwpqf2HCF+5qWH8XjZQ40kqpUWg29cJrilrLezkVqtm7ytimc1wWg+DGlS6H54865VOBEyGADy7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OKjcONkG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002435; x=1751538435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CFC7z8WmsZSF958vPpbokrnZvgzbxwMA/ZoZqH+Ywdg=;
  b=OKjcONkGY4C+S9PqeXUtlNFafYuCBOzdwuiUVM3GCrNI3Tq1WeXn/1PS
   K1TXcghMg32mjTRGAJcShayIc1ADZtBVibu7Sw0xyTmJ8fHQmrD7Hoh2P
   fzMpUl86BV1ZIOt9u4tELph2ljzCdccJYZIaYvZGRO2JXRoZJrmSIeJKF
   8TNEgwVMHs/sbO/YyqsNzqSy3iVPb/vbmSl9jgteqZaTx7k8cozJ1uYm6
   F2+0ncGJn9BOZG87oOgP3qhELyF7o6ZmuBLu2njVbiNq6eWfMSbNgnroD
   FvDYvYz7y+XDCdWVxLp267OW2Q28pdzhyGExZwhhe3WhBKIor3CCUAL5o
   g==;
X-CSE-ConnectionGUID: O6jm4qbsRBydYsAuvGKY7w==
X-CSE-MsgGUID: gkzCGrK9TGucj+i2z/6ZOA==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28772333"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:27:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:26:52 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:26:47 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <radu_nicolae.pirea@upb.ro>, <richard.genoud@bootlin.com>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v5 03/27] dt-bindings: serial: atmel,at91-usart: add compatible for sam9x7.
Date: Wed, 3 Jul 2024 15:56:40 +0530
Message-ID: <20240703102640.195431-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703102011.193343-1-varshini.rajendran@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add sam9x7 compatible to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v5:
- Corrected the order of bindings.
- sam9x60 bindings in the dts and dt documentation in future series.
---
 .../devicetree/bindings/serial/atmel,at91-usart.yaml     | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index eb2992a447d7..f466c38518c4 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -23,13 +23,20 @@ properties:
           - const: atmel,at91sam9260-dbgu
           - const: atmel,at91sam9260-usart
       - items:
-          - const: microchip,sam9x60-usart
+          - enum:
+              - microchip,sam9x60-usart
+              - microchip,sam9x7-usart
           - const: atmel,at91sam9260-usart
       - items:
           - const: microchip,sam9x60-dbgu
           - const: microchip,sam9x60-usart
           - const: atmel,at91sam9260-dbgu
           - const: atmel,at91sam9260-usart
+      - items:
+          - const: microchip,sam9x7-dbgu
+          - const: atmel,at91sam9260-dbgu
+          - const: microchip,sam9x7-usart
+          - const: atmel,at91sam9260-usart
 
   reg:
     maxItems: 1
-- 
2.25.1


