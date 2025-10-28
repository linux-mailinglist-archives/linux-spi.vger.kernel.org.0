Return-Path: <linux-spi+bounces-10886-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A460C14E79
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 14:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D22704EC674
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A16336EE2;
	Tue, 28 Oct 2025 13:33:41 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370AF3346A4;
	Tue, 28 Oct 2025 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658421; cv=none; b=RlhWM3oEDVdo3d95FBtXtNJAaivdaTKOTd4bhZF5ksv9pnzrwJQj80iuprJlIN7g6vpk1PUnHa8coFh7WJ874T82P1uAmW9rknm53CYFORluBixtrmhcvwu2l3PCo/F6x3mQIOz9s9FQesTcYBFpaI0THvFsY0C26Bi5RE/ejKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658421; c=relaxed/simple;
	bh=J4Wd7ryXstDk7QxS0KeHk4uJjVShInZv0MqGFZPdGPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+CNNfArDqLczTjnwmqB7vl3ANFSQ6ieuu9SJsaQ+6Zi2IqEg+yaWrAwedBFDAsYdGbyhDpsny0hjJM0QEiAoCQ27QoUS9Pyx/qd3cqnZgJH2bWIMBhov2ORAqfT6wcQjlVQ6LntHG8BADcmOeFH6uEQrXH+STMFvUxBP64Z5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: f2vG5bvgRQ2NzC+jX3wjpQ==
X-CSE-MsgGUID: VxK2Sv1rRWula3DkYfJTZg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Oct 2025 22:33:38 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.5])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1167141B6443;
	Tue, 28 Oct 2025 22:33:33 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 11/14] dt-bindings: spi: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
Date: Tue, 28 Oct 2025 15:31:42 +0200
Message-ID: <20251028133151.1487327-12-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028133151.1487327-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251028133151.1487327-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 62 ++++++++++++++++---
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index ab27fefc3c3a..65ba120a6b23 100644
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
 unevaluatedProperties: false
 
 examples:
-- 
2.51.1


