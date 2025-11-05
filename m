Return-Path: <linux-spi+bounces-11031-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E36C3534C
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 11:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7155D4200DF
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 10:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06830B52F;
	Wed,  5 Nov 2025 10:44:00 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15037307AC8;
	Wed,  5 Nov 2025 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339440; cv=none; b=udSZpYGhrigMQ6CfSMymty2RhIeLLIUsKhWieqmBSOIBkgZ+B4vhk4bCDI2aPMR9xa09rXpc6BmIGs4LpDM2IgT3E+KvrXNWPuT8JFGiUqELT7FpZZAI7KRBlH3T2jdS2Dj7IZEJtxm59gXZS8IepGFHPM6I2qlE79lALIvzrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339440; c=relaxed/simple;
	bh=et5x65Xq8bvIrKcyd7rqaqh+jC2DI9Dy1zV0u/idnJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+n84KXqO9Jejyu38AIgqcxmVo6L0l1ZyvRCjec7PDARr0T3XTmzTK9Zp71+h/h/xRGHgTCI2l4/EHxzgnggZaCjMMvysp8mlJMc2f5pIamR/oKhBaxA7RCnmN50MMFJ9I6bCnLuM2t5XWKqhipRo0jZ3/QyvR7SutLrF7S971M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 6J/BdRNyQWKvaX7V07jlfA==
X-CSE-MsgGUID: sSESA+aVQnC4GMnVwDwf1A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Nov 2025 19:43:57 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A40B24001DCB;
	Wed,  5 Nov 2025 19:43:52 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 11/14] dt-bindings: spi: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
Date: Wed,  5 Nov 2025 12:41:48 +0200
Message-ID: <20251105104151.1489281-12-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251105104151.1489281-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251105104151.1489281-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have four SPI
peripherals.

Compared to the previously supported RZ/V2H, these SoCs have a smaller
FIFO, no resets, and only two clocks: PCLKSPIn and PCLK. PCLKSPIn,
being the clock from which the SPI transfer clock is generated, is the
equivalent of the TCLK from V2H.

Document them, and use RZ/T2H as a fallback for RZ/N2H as the SPIs are
entirely compatible.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 65 ++++++++++++++++---
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index ab27fefc3c3a..a3940ec025e2 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -9,12 +9,15 @@ title: Renesas RZ/V2H(P) Renesas Serial Peripheral Interface (RSPI)
 maintainers:
   - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
 
-allOf:
-  - $ref: spi-controller.yaml#
-
 properties:
   compatible:
-    const: renesas,r9a09g057-rspi # RZ/V2H(P)
+    oneOf:
+      - enum:
+          - renesas,r9a09g057-rspi # RZ/V2H(P)
+          - renesas,r9a09g077-rspi # RZ/T2H
+      - items:
+          - const: renesas,r9a09g087-rspi # RZ/N2H
+          - const: renesas,r9a09g077-rspi # RZ/T2H
 
   reg:
     maxItems: 1
@@ -36,13 +39,12 @@ properties:
       - const: tx
 
   clocks:
+    minItems: 2
     maxItems: 3
 
   clock-names:
-    items:
-      - const: pclk
-      - const: pclk_sfr
-      - const: tclk
+    minItems: 2
+    maxItems: 3
 
   resets:
     maxItems: 2
@@ -62,12 +64,55 @@ required:
   - interrupt-names
   - clocks
   - clock-names
-  - resets
-  - reset-names
   - power-domains
   - '#address-cells'
   - '#size-cells'
 
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a09g057-rspi
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+
+        clock-names:
+          items:
+            - const: pclk
+            - const: pclk_sfr
+            - const: tclk
+
+      required:
+        - resets
+        - reset-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a09g077-rspi
+              - renesas,r9a09g087-rspi
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+
+        clock-names:
+          items:
+            - const: pclk
+            - const: pclkspi
+
+        resets: false
+        reset-names: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.51.2


