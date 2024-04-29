Return-Path: <linux-spi+bounces-2574-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F1F8B52DC
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 10:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C829B1F212A7
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 08:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC71171A2;
	Mon, 29 Apr 2024 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci4vcR6Y"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66F715E8B;
	Mon, 29 Apr 2024 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378406; cv=none; b=RHNNCCbWEYse3azv7OrgCptUQb1kBcAzXw1aSGGbZAlYuaRUrkyDrWc90m2AszxG7Jf1oROVmVu2ZRBjWmWVy8oMdOUzhO8xIHdWYUB6ojQI4uMI6r4qgoC/YBescO4yRWDXHEtnxjdR/z4w3JnT+C/Q8l1fyWBqlzLkWjz+L00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378406; c=relaxed/simple;
	bh=iY2dL5xoLp/bLN5x3MRBL4P5AoBE7pfXdViPo/W70D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoS8/WyfGK89qd18JyJUZez0M1C4eQBOtA9ypqMe1oq19VtXTiIgzLTfJXENBvfFFxeobwbvO1ZdFhTnnselbhxuAtHrxbxBj7RqVVw5GGhTTV2cMn961vpWWCdgUQgS4s4W2upLk18qVXfEp2h/qA6IDHXZD4DqmT6CgFHSeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci4vcR6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B6EC113CD;
	Mon, 29 Apr 2024 08:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714378405;
	bh=iY2dL5xoLp/bLN5x3MRBL4P5AoBE7pfXdViPo/W70D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ci4vcR6Yt0rOe94zQtbpcDLe7XSCPttciPF19IgoD+gPq5Ko/ZZXDPeN4PTfeoSuA
	 Srs9BhbLqxNNiPFEDREc/1eEpRnoq9HgZ+7mfbCpoUaFmEij49AsR7dwvXEQfChFMV
	 ZCq1vKXB9nQGD+emOY2H6+p0Sb1uuJQnLyq8FIvHiWxe4yiIzxZvhRuoGmY4JGOGk0
	 OxN9leB5DTS5/PvAQeorX6ZAybkjovIdJ31qVBQ8aQRhoLRNi0te3re0vSesKYBlEM
	 5rDDRaS29mIgSDBVl3ofNTnGMjC/6V6WAoHnnx1AGfPWnEbi0YdcXnmHreiL4EnxLe
	 kT79NyT2FAAOw==
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
Subject: [PATCH v5 1/3] dt-bindings: spi: airoha: Add YAML schema for SNFI controller
Date: Mon, 29 Apr 2024 10:13:08 +0200
Message-ID: <f3377b323f00589e6b7ed7950c4840d18129238b.1714377864.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714377864.git.lorenzo@kernel.org>
References: <cover.1714377864.git.lorenzo@kernel.org>
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


