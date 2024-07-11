Return-Path: <linux-spi+bounces-3835-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E092ED1F
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jul 2024 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8A91F233EC
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jul 2024 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3C016D9C1;
	Thu, 11 Jul 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TmcQYI6l"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C8416D4F4;
	Thu, 11 Jul 2024 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716881; cv=none; b=tvOgGcbM6kiL/D+/dluTFLXCQQSaLn3WQZcU3TCFvT3pqU6lDGVIDoHQE9L9K3BC6IrlPSa8C3aCTvqDCKBc/3XU+QwyP8qg5yLDW7QH1Gr7+VRpKsPhyVxne1oEAbY3LrquCagAXG9ZcCqJz1L4EFvf/cHlp8t603r7MMKGHXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716881; c=relaxed/simple;
	bh=AFmcG/KEvllGzTWGQ+DiPSWbg3J8mbUzRHD1iS4cnLs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EokYA3TOmcpQxxxorPI9Qv6u0hHxmuYxRia5g8wfWLeIMthTh2whvssn191HQxCW/wu9obmH256h2clIfD4oTHD6Ecl840sDz7SmOUqAy7N2vNC+h7jvk7/iDUiGkfQYXxMw13GlnxPGEDNYOXQRbYbjp1v70LSOMjj6yfY+w7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TmcQYI6l; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720716879; x=1752252879;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AFmcG/KEvllGzTWGQ+DiPSWbg3J8mbUzRHD1iS4cnLs=;
  b=TmcQYI6llWwxM96yjBctQbxFREFCpqOOb20BMRbvlfYZ0UEyiTjPiJKG
   ory1r9dWZn/pLufOAz5EdZPFZfyEhyLNZKey5t4bgD/v/m6NsOWlH6fIV
   UNclTbiEpl1U0cVuSV6ivUitqqKWQZcKUVUCCBU2Jwx/VSMuHPlNZTUB8
   lO2SgxFIJ/G8z0qDkgWi6c+koPgVrf/FZW0N/XCIzwuBET5ql28o0Br4p
   I5dFpvZsw4q5pxrGukJhaCESpehhXF4A4sLPDoZ+4WrkoTWnijCikTO1Q
   vWrqXHj7vYDM1D9QQ54xXe812dEZHiyqIVYJ7JnAM2/gnelFkT9PfJGG1
   Q==;
X-CSE-ConnectionGUID: zM8v1C8oQ/SssnAxM3eiww==
X-CSE-MsgGUID: hgIhfGcaQyqkhzbrf/VsWQ==
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="29772050"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jul 2024 09:54:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jul 2024 09:54:01 -0700
Received: from ROU-LL-M43238.amer.actel.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jul 2024 09:53:57 -0700
From: <nicolas.ferre@microchip.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, <devicetree@vger.kernel.org>
CC: Tudor Ambarus <tudor.ambarus@linaro.org>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>
Subject: [PATCH] dt-bindings: spi: at91: Add sama7d65 compatible string
Date: Thu, 11 Jul 2024 18:54:02 +0200
Message-ID: <20240711165402.373634-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add compatible string for sama7d65. Like sam9x60 and sam9x7, it requires
to bind to "atmel,at91rm9200-spi".
Group these three under the same enum, sorted alphanumerically, and
remove previously added item.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml     | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
index 32e7c14033c2..d29772994cf5 100644
--- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -18,10 +18,10 @@ properties:
     oneOf:
       - const: atmel,at91rm9200-spi
       - items:
-          - const: microchip,sam9x60-spi
-          - const: atmel,at91rm9200-spi
-      - items:
-          - const: microchip,sam9x7-spi
+          - enum:
+              - microchip,sam9x60-spi
+              - microchip,sam9x7-spi
+              - microchip,sama7d65-spi
           - const: atmel,at91rm9200-spi
 
   reg:
-- 
2.39.2


