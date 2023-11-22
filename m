Return-Path: <linux-spi+bounces-19-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500EC7F40D7
	for <lists+linux-spi@lfdr.de>; Wed, 22 Nov 2023 10:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC531C208FC
	for <lists+linux-spi@lfdr.de>; Wed, 22 Nov 2023 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4633D38D;
	Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIp+wyxx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DFC3B7B4;
	Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DA75C116B1;
	Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700643675;
	bh=0RqHB9PnuVV/vsO87D5tAkCkE4lheAOLKkN4oxERFro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JIp+wyxxepTQ3404MSlH8/Scmym+54L1VqfOXQcrJfR7gjb+Zbi+kgfjFNMhMXdgj
	 WcMEyUjNVBRhkQ9Izu1woQojtj98q0WMCaJTP2a4McaOmnq1s+tkAWCiHuTGVuyTei
	 E5G/so+3Rqpiyq8LlnUC7G1jjjhvkjm6z3fr6TfeTgbpsmMwTrVrw12oEhJqT+gm4+
	 /PSciPmlDoQaTFWQsr5WlF5SCSNv7Ep9QPJPnXI0Z5fuiMKa1h/1kxFtLeQje/ZXL+
	 TIPNflpgZQ2aIF2skyEgsTX8oxlkVABENTVemAoxyeiaaWPOieEYIz2bVbsjg36NED
	 GptsaZVRC9hZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08696C61D92;
	Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Wed, 22 Nov 2023 11:59:52 +0300
Subject: [PATCH v5 14/39] dt-bindings: spi: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-ep93xx-v5-14-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
In-Reply-To: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700643671; l=2249;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=p8nigAGltJtSlh1QYGLdck6FshaUl1GLyOnIiPiTqq0=; =?utf-8?q?b=3DGqeMvj/fL+0Z?=
 =?utf-8?q?b0bHD46t00H7ox+nn5GeqsnFa7eq2RFx5yvCzSQQLuH+nZu525ZGdYt/IrZuyly0?=
 jA/04TUoB4p+F4D7Lt06bA3tXhRM7HDOcotKVF6Sx3QqSEU3+qKE
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ep93xx SoC SPI.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../devicetree/bindings/spi/cirrus,ep9301-spi.yaml | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cirrus,ep9301-spi.yaml b/Documentation/devicetree/bindings/spi/cirrus,ep9301-spi.yaml
new file mode 100644
index 000000000000..ba249840e7e5
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
+    #include <dt-bindings/soc/cirrus,ep9301-syscon.h>
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


