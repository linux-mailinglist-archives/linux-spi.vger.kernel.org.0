Return-Path: <linux-spi+bounces-8753-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6A2AE6F79
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 21:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D54D1884E27
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 19:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD83C2EA490;
	Tue, 24 Jun 2025 19:23:29 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718432E92CC;
	Tue, 24 Jun 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793009; cv=none; b=lz3my+gAg8GNN9mRKSXVMnKm51qJwsU9NQaxl0+tkztiyv8FtovZPKZjdO4SCfj5mECZUtfddMovHLxMhJALirdnxXi3J/UMWUhFnUqw5fAC9xlz4OFt8+rKcNJx6HYRdzixMTymLzOQj6W3hXqL38aG9qwMiIxC7jYesLBOLfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793009; c=relaxed/simple;
	bh=4gcZEGeqCU5KH0mHQ8wH5/bHF4byvhYkk4/R2n/w+ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fCflTePQh0DpHI7lyFn+C9V0zW2UW7TM0w2zscuLqeBqVr6tHzWdm7R1/lVXwB9wvpqgCjlnBrfd4Q74sP3q0uH5/gCw9gianVWLAQN/KvdpDFodyDXhW/dpiGoZlx+LObDKiPD4fa11zgiLNgfmUsKhnLw8LIIbrJLArsDP2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: Co+196DCQ7iWD4psg4pROA==
X-CSE-MsgGUID: /iVkkYnGQRWFJ9DIHF3hJQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Jun 2025 04:23:25 +0900
Received: from mulinux.example.org (unknown [10.26.240.23])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 18137400F738;
	Wed, 25 Jun 2025 04:23:20 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/6] spi: dt-bindings: Document the RZ/V2H(P) RSPI
Date: Tue, 24 Jun 2025 20:23:00 +0100
Message-Id: <20250624192304.338979-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624192304.338979-1-fabrizio.castro.jz@renesas.com>
References: <20250624192304.338979-1-fabrizio.castro.jz@renesas.com>
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


