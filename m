Return-Path: <linux-spi+bounces-2538-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562008B32BE
	for <lists+linux-spi@lfdr.de>; Fri, 26 Apr 2024 10:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1218B28129B
	for <lists+linux-spi@lfdr.de>; Fri, 26 Apr 2024 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D92145339;
	Fri, 26 Apr 2024 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6oKiCE2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086013E886;
	Fri, 26 Apr 2024 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120269; cv=none; b=seVFDvTIXpyuU+yMeMWW4Cfr/pqJkVUilbX4ja1d3iEqVrn/N2g7MSqDGP5SiQTtUqSl8ikZ1KAWzsXsdbaMPe+KdLhrUlmKJc3VWoNOLfWYgfD0tdbWlAPQfPf/DCPgrGz3IhT7cKbEizXVTQ+xO9QWlksN8nmwdI52GW+/JZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120269; c=relaxed/simple;
	bh=iY2dL5xoLp/bLN5x3MRBL4P5AoBE7pfXdViPo/W70D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYkUPxlHIuoG/zCGVpU/j1bishQF5e7Y7kRdkWEkMhKiE32SnH4txAGH500MolVxqo19ngeeM3tlovVVcEt4OrbDb11WP/iqTbd5HjT5JLZ+iHMGQ9KQ344mi3K/Go9rHRRYX+T/g7xAe/KVW5aac9aTT6bzf4yEryTcvXRuAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6oKiCE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B8FC113CD;
	Fri, 26 Apr 2024 08:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714120268;
	bh=iY2dL5xoLp/bLN5x3MRBL4P5AoBE7pfXdViPo/W70D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g6oKiCE2Ep1PuwHjVhhZQVjRJ0tjujp4RhE5RzCCGcS2yBp4ZaM6ICAFMKhksadRf
	 5PPn8po1KSVMXhu7Ae+gf2Q3HyYFzdEaguZbGAIQc2cvFA7YkVvqZQMZXcf/ixyHIg
	 nF4qVBZyStqPolNsUfed2ScoXSyw9p/uWJhgpcpV5vYYEpFGlWK32uSobgre70kth8
	 dOazCtkaWSmuIMA/1dbZk06sAZ7KVdx6u0AMO8EGynmqoyuUzRMduQQeIozwsD1VXs
	 RU9Q/vQvY2m/EWcq6hTxYUVNFNN9UJdHSP8ReKRp7KT+XYBDFq8tDjGT4jab+pNd09
	 a85PapzsBYAng==
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
	angelogioacchino.delregno@collabora.com,
	andy.shevchenko@gmail.com
Subject: [PATCH v4 1/3] dt-bindings: spi: airoha: Add YAML schema for SNFI controller
Date: Fri, 26 Apr 2024 10:30:51 +0200
Message-ID: <5bda881f9344e1b885a7380c668e2665ac63a3e9.1714119615.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714119615.git.lorenzo@kernel.org>
References: <cover.1714119615.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Airoha EN7581 SPI NAND controller binding

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


