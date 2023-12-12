Return-Path: <linux-spi+bounces-223-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F1480E5CF
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 09:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4D56B20C0A
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 08:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCADB21373;
	Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA5J6IPV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833DB199B7;
	Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BC4EC116B3;
	Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702369325;
	bh=VNwPggiAWASAvwqtJd7Wj3ItapLp0dhIgz2LnHUWvFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pA5J6IPVLRR0NA9SUqxNr+DL7rpwy2rVPnaJeMyYIgt9y9nMfa70PSPL6A6bTWGKJ
	 83qmLFbT4IcwuPnGBstDCYZeNGu8xRXUGtOTfsFbcBmztDA7rhvuIzYiNAz7VC1dML
	 hB9FWB5VDLZi1yIc4BrXiVXEyKBxE+w1D9c/12fUj4Qo7/PI8y5ezKY53BJL6VaQCe
	 ocegP+Vy5eU6w3cWp3B+iOMOUn4Ye1smcpVm45UO/q5AbRyY9KhA0XudKENPrpGGyI
	 e2ZuRINDbq8zwYaP4JUJ1YZVx8wwmlSf3ZLegJIEz3R6DA6MNye8fVuGtMl3M5CxdU
	 sWZcUeYxbBtaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA2AC4167B;
	Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 12 Dec 2023 11:20:32 +0300
Subject: [PATCH v6 15/40] dt-bindings: spi: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-ep93xx-v6-15-c307b8ac9aa8@maquefel.me>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
In-Reply-To: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702369322; l=2297;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=eohxXtWd+HuVJyaYSL1l5VkylPnLSM7yKMq6Kko41cI=; =?utf-8?q?b=3DlXF4u5RJQUO9?=
 =?utf-8?q?k1c/73N9EGH3qHbYS2ClWcSCBcYU7oAMndw5RK/HH8R/BhXtcDLJjTOz8VB+VAU/?=
 2q6bP5LBDwc8p+UoqHwmMEOYdOFe4AawrqizlSt5eRp3r+vjs4XI
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ep93xx SoC SPI.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../devicetree/bindings/spi/cirrus,ep9301-spi.yaml | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cirrus,ep9301-spi.yaml b/Documentation/devicetree/bindings/spi/cirrus,ep9301-spi.yaml
new file mode 100644
index 000000000000..73980a27dc00
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cirrus,ep9301-spi.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/cirrus,ep9301-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EP93xx SoC SPI controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-spi
+      - items:
+          - enum:
+              - cirrus,ep9302-spi
+              - cirrus,ep9307-spi
+              - cirrus,ep9312-spi
+              - cirrus,ep9315-spi
+          - const: cirrus,ep9301-spi
+
+  reg:
+    items:
+      - description: SPI registers region
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SPI Controller reference clock source
+
+  dmas:
+    items:
+      - description: rx DMA channel
+      - description: tx DMA channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/clock/cirrus,ep9301-syscon.h>
+    spi@808a0000 {
+        compatible = "cirrus,ep9301-spi";
+        reg = <0x808a0000 0x18>;
+        interrupt-parent = <&vic1>;
+        interrupts = <21>;
+        clocks = <&syscon EP93XX_CLK_SPI>;
+        dmas = <&dma1 10 2>, <&dma1 10 1>;
+        dma-names = "rx", "tx";
+        cs-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+    };

-- 
2.41.0


