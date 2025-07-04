Return-Path: <linux-spi+bounces-9054-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509A8AF97FA
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 18:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4415A6A8E
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9822DC33B;
	Fri,  4 Jul 2025 16:20:51 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B612C08D2;
	Fri,  4 Jul 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646051; cv=none; b=oBLzMAF992FogQQXBlAh79LywRsHOxBz5zXUYBnE1A+i+zouR9jFVS+is/1J6PmDEHO5pyG13Tj1zX0IhTInO3wNvI5LdwcqcNxBaF9BpCl82mumYEMXIXRtV2sWAiCP/dVCS/zS/3Wtz4hbnko4envnIlPoreHNUBXYiw0C/ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646051; c=relaxed/simple;
	bh=wnPo5QfvMFuJ9H49cRALkthwe/cpH84E8S2Oe46WGgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/MYMGEmiSoM6X8AtulgFeY54AEFAgpoQ3wIf1UDU33f1xeerDQam6Ohz36v7zh8B47GraIhCwx+ncVnUgM45/T5ZolnKejcGC50yJJbESECtk2NkAg4Fz3SzkhvwKBlJJXqBQNnrKbgednP3SkH/4wyOun4SSI/OJEfM3trRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 3rbYz1O7R5yXLtV9CRY9BQ==
X-CSE-MsgGUID: JLdWwdMbRoSVMWD93H9i7A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jul 2025 01:20:48 +0900
Received: from mulinux.home (unknown [10.26.240.6])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1A030401DDF3;
	Sat,  5 Jul 2025 01:20:43 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/3] spi: dt-bindings: Document the RZ/V2H(P) RSPI
Date: Fri,  4 Jul 2025 17:20:34 +0100
Message-Id: <20250704162036.468765-2-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704162036.468765-1-fabrizio.castro.jz@renesas.com>
References: <20250704162036.468765-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for the RSPI IP found inside the Renesas RZ/V2H(P)
SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
v1->v2:
* Collected tags.
---
 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
new file mode 100644
index 000000000000..ab27fefc3c3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/renesas,rzv2h-rspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2H(P) Renesas Serial Peripheral Interface (RSPI)
+
+maintainers:
+  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: renesas,r9a09g057-rspi # RZ/V2H(P)
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Idle Interrupt
+      - description: Error Interrupt
+      - description: Communication End Interrupt
+      - description: Receive Buffer Full Interrupt
+      - description: Transmit Buffer Empty Interrupt
+
+  interrupt-names:
+    items:
+      - const: idle
+      - const: error
+      - const: end
+      - const: rx
+      - const: tx
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: pclk_sfr
+      - const: tclk
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: presetn
+      - const: tresetn
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/renesas-cpg-mssr.h>
+    spi@12800800 {
+        compatible = "renesas,r9a09g057-rspi";
+
+        reg = <0x12800800 0x400>;
+        interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 504 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 505 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "idle", "error", "end", "rx", "tx";
+        clocks = <&cpg CPG_MOD 0x5a>,
+                 <&cpg CPG_MOD 0x5b>,
+                 <&cpg CPG_MOD 0x5c>;
+        clock-names = "pclk", "pclk_sfr", "tclk";
+        resets = <&cpg 0x7f>, <&cpg 0x80>;
+        reset-names = "presetn", "tresetn";
+        power-domains = <&cpg>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.34.1


