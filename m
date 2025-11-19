Return-Path: <linux-spi+bounces-11344-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E917FC70039
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id EBB3B24128
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D1A36923D;
	Wed, 19 Nov 2025 16:16:18 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086EA369217;
	Wed, 19 Nov 2025 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568977; cv=none; b=ur0v+EnItTuHLzWfa0JbDC7stssjQ+vBT9vajR2VikmjW+y30U6MAE8hkMwuH5bfYd6aVKWpOuy7N8e7WQLv5ILOgQm6YOFQCzFjxUJ3dx1D+6kzRErVBE7GLnJS2OnpUDM33Fr5elGiCy6jGLeX/PXupRqaqHcGs9uCTd5o+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568977; c=relaxed/simple;
	bh=8AxP0JwJqdUyJaFmNJcUiWHgeqBLwqhuVR4LIJTE8PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fxq6XFIExIgrCxlLftrq+80+ADYr8OHCiRnyQROu+W/qQGf784qOFtRBFGykzRH+HL6HKI7YQZqDrG3KX+ACi3oXVTGHcNJADQEHeRSbPi5RApu8cCykTst4MWe52ZO5kXu9wAImkE3u646T2kvy8urGjgPhUSkjBWz7gCZeWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: Hurlxm9RTnm4I3bJ6Rl12g==
X-CSE-MsgGUID: /K205EUTT7GJbSZ7HmGfcg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Nov 2025 01:16:13 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.87])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8B488406C471;
	Thu, 20 Nov 2025 01:16:09 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 10/13] dt-bindings: spi: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
Date: Wed, 19 Nov 2025 18:14:31 +0200
Message-ID: <20251119161434.595677-11-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

V4:
 * remove conditional minItems: 2 and maxItems: 3 for clocks property
   since it is already set to that
 * remove renesas,r9a09g087-rspi check since it implies
   renesas,r9a09g077-rspi
 * replace contains: enum: with contains: const: since there's only one
   compatible to be checked against

V3:
 * no changes

V2:
 * add resets: false and reset-names: false

 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 62 ++++++++++++++++---
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index ab27fefc3c3a..4331df3e3d47 100644
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
@@ -62,12 +64,52 @@ required:
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
+    then:
+      properties:
+        clocks:
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
2.52.0

