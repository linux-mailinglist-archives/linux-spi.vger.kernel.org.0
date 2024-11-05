Return-Path: <linux-spi+bounces-5624-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 099AC9BC7B2
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 09:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03D21F22C0D
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FDF1FF03B;
	Tue,  5 Nov 2024 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfbtNqBz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69301FEFD5;
	Tue,  5 Nov 2024 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794125; cv=none; b=SDKKlBjZdS7fUaaWxkcso9uDdYMRDTuNOY7DtIV1lo3dWOHufFdEFr2M5TKuv6KSV3zA1ArixttZXc5z2tZGcBND2uopZFnK1GCXbkWDc+EvMG/eVIWVCZgcAjWtpGSMt6o8dtrpVa53oLtZIwcsPBJ1aRynwYzqidhKcBNi6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794125; c=relaxed/simple;
	bh=4CxI9hvqy+T0MQp7ejsVaS+wjhKMAoO93q+j3nHoUH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQ3MtmvGc0M5SENBEylNCwSquBms6W4TCiavBSpadliE6U+9l9R4ibzxD/dB2352lHHxlphAI2jU/8r+n4hhGpAbq4kqeCgJz1FzR3mFNTif/gNx22l1lk8n8/pFb5O8Ug1HqAeML+GOlixs9HonZbaNs4BftwwAlnPZ9vBTcho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfbtNqBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7064EC4CED4;
	Tue,  5 Nov 2024 08:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730794124;
	bh=4CxI9hvqy+T0MQp7ejsVaS+wjhKMAoO93q+j3nHoUH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LfbtNqBzblOaof4O2CmjLQ6bmCxGRjHvkMy53Pn0AOhRZsgjMOwcFYyKDqIpUb9gi
	 ysxnVZOTfeEY9c396N/WZeSR3zcG7O3hQ7pt14iUZYauiItnZ3Y3ouoG2chCeIijdS
	 QxrAoeCUM/gE/8JkJ1dbgbVf5hRe5ZlOigdX4xTvj91ZMz3QeLLt2/IPX94apcps2F
	 srlMK7NYHDhWfTIjgGZ1wnEEiTHVLTqLG213F+5apsl9wggdzsLfb2nXBl624LAP8/
	 1eq6j8i7X6ds9PsAkNF5aqbIpdYwgEUUszlomoifqfPttXHuhn5hpDxSE9cysVdv1i
	 wCjYMvL0Z7oiw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B16DD12660;
	Tue,  5 Nov 2024 08:08:44 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Tue, 05 Nov 2024 09:08:29 +0100
Subject: [PATCH v4 1/3] dt-bindings: spi: apple,spi: Add binding for Apple
 SPI controllers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-asahi-spi-v4-1-d9734f089fc9@jannau.net>
References: <20241105-asahi-spi-v4-0-d9734f089fc9@jannau.net>
In-Reply-To: <20241105-asahi-spi-v4-0-d9734f089fc9@jannau.net>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 Nick Chan <towinchenmi@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=O9OlA0s3DQ4s9BDbe1rexPnrtmgzE8wHs1clsQ1vxYw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnTNS13XVpvPeRp/qnz6ic/byz60LP4msHX97wkN9T7Lm
 yOZCqce7ihlYRDjYpAVU2RJ0n7ZwbC6RjGm9kEYzBxWJpAhDFycAjCRglKG/6k6xcl8f48+np97
 MdTqUeX12+XLCpfdL16z792Gme4yE6czMiyofXEnP0TkE9Nd7tDvU7e+12nvEW+/cP6BztQJVxn
 FvvEAAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

From: Hector Martin <marcan@marcan.st>

The Apple SPI controller is present in SoCs such as the M1 (t8103) and
M1 Pro/Max (t600x). This controller uses one IRQ and one clock, and
doesn't need any special properties, so the binding is trivial.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Nick Chan <towinchenmi@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 .../devicetree/bindings/spi/apple,spi.yaml         | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/apple,spi.yaml b/Documentation/devicetree/bindings/spi/apple,spi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..7bef605a296353a62252282af4ba45a71b20b7b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/apple,spi.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/apple,spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple ARM SoC SPI controller
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-spi
+          - apple,t8112-spi
+          - apple,t6000-spi
+      - const: apple,spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      spi@39b104000 {
+        compatible = "apple,t6000-spi", "apple,spi";
+        reg = <0x3 0x9b104000 0x0 0x4000>;
+        interrupt-parent = <&aic>;
+        interrupts = <AIC_IRQ 0 1107 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&clk>;
+      };
+    };

-- 
2.47.0



