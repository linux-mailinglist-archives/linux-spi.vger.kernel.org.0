Return-Path: <linux-spi+bounces-2457-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE358AE1E9
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 12:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 852A0B210FB
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 10:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC8460DFB;
	Tue, 23 Apr 2024 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk96B/1Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0334556772;
	Tue, 23 Apr 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867413; cv=none; b=NC+h8zoqlQMc2EYXLaywWPho56YhAWgSicHLCRenlADr7wF3+N81J0HewGPQu358UGQ+M0XUGni3tROymsfIhzvI9WOG5L7e4DcjR75K6WXPsLgNyyZcbraFB2ZPyft/wzFCSw1CohNzsqmWSoDR6fwkhlK+qekW2aCczJ7rIOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867413; c=relaxed/simple;
	bh=+r+6soKFTTPbt/cEXkRsDhPUcjBnbpGC6PLACvxQwGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TenxddBG8QF++RJJTPMzP7TcRyCfPhOfWtBT8vZAccjH876FtvpKjjnhJq5cg2eRl0qBCSkU8Qk+z9BFdcXL+d2E71BZO/pnsCKdE6lLocPEzHeerNc0nDblWP+B+F9hkf+tz8YHuXQJ+MegA9Ch9FmhJQiALbhH5A7ucgIQ6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk96B/1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FDDC116B1;
	Tue, 23 Apr 2024 10:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713867412;
	bh=+r+6soKFTTPbt/cEXkRsDhPUcjBnbpGC6PLACvxQwGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kk96B/1QQ1wjbNJorVRsXE0SRUVSR3Ae9wFw0gGEwC+AuWiBk2a5FKPTDe4yEllvx
	 4pRJlDHaRts4lOQxV7QoqElESSlus+CkyDtSUINfQUz1Stq80CQ4k9QueYWNqIemOo
	 RkyK7x5BMdGP20W4k5wcUTZqf1CFGpc5l3YFO8Igv+R2zsPFG9R62lnFhwQ89Q9urC
	 UbGKkgpdPG5c2mJ+7V3VAlUgEf5IW4m0jhafPA+mis+VB+Ze7G1TM4q9CxmXtLSZ65
	 tzrJC7QbjjO7jyZ7YmuZcswEc/Wj7sayASwr7EeyfFyMvlkpFhrWiJbdhRKX8VtQJm
	 Q4FQG23Oq1iBw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-spi@vger.kernel.org
Cc: conor@kernel.org,
	broonie@kernel.org,
	lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	nbd@nbd.name,
	john@phrozen.org,
	dd@embedd.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: [PATCH v3 1/3] dt-bindings: spi: airoha: Add YAML schema for SNFI controller
Date: Tue, 23 Apr 2024 12:16:35 +0200
Message-ID: <a4ebcf779496200cb44844c5b203ed9399afa6ab.1713866770.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713866770.git.lorenzo@kernel.org>
References: <cover.1713866770.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Airoha EN7581 SPI NAND controller binding

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Rajeev Kumar <Rajeev.Kumar@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/spi/airoha,en7581-snand.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml

diff --git a/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
new file mode 100644
index 000000000000..b820c5613dcc
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/airoha,en7581-snand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI-NAND flash controller for Airoha ARM SoCs
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: airoha,en7581-snand
+
+  reg:
+    items:
+      - description: spi base address
+      - description: nfi2spi base address
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: spi
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/en7523-clk.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      spi@1fa10000 {
+        compatible = "airoha,en7581-snand";
+        reg = <0x0 0x1fa10000 0x0 0x140>,
+              <0x0 0x1fa11000 0x0 0x160>;
+
+        clocks = <&scuclk EN7523_CLK_SPI>;
+        clock-names = "spi";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+          compatible = "spi-nand";
+          reg = <0>;
+          spi-tx-bus-width = <1>;
+          spi-rx-bus-width = <2>;
+        };
+      };
+    };
-- 
2.44.0


