Return-Path: <linux-spi+bounces-5632-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DA29BDFBD
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 08:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFCC1F24926
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 07:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9C21D1F56;
	Wed,  6 Nov 2024 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0+vbyNt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B17C1CF2AE;
	Wed,  6 Nov 2024 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879665; cv=none; b=s/rBjzD4SnjcoqNhgTD+SDAbJ4Buo8lkmI9kzWT6znGrgbwsXyMR4y/ZJUC4nOKjx6MCI0uCcJIej9XFH8FzD4wBmJvRnPulwbo4pnY9+6JCG5akjXMSr3FtS+cdHt0aTOV2uhw6Mb28rjz5+u/1MMdiXVfSwSkoAYp1b6iDHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879665; c=relaxed/simple;
	bh=4CxI9hvqy+T0MQp7ejsVaS+wjhKMAoO93q+j3nHoUH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xwcb0vCrAqLw9A+x2eSjwv+lkM8+8hM+u42ilR/1ESgMGbJuCthV0uhEiCHb3Td54K72jkKnTR9gKA4XvcFplnuYCqmPfWAse9Q6SeDjgc5QwzPHcn8x3o1Veg1Y1Ff9x917o8b/5DQPLMMvI2B34F6cQ+QVUa7EPWBlilhBmpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0+vbyNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D32E1C4CED3;
	Wed,  6 Nov 2024 07:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730879664;
	bh=4CxI9hvqy+T0MQp7ejsVaS+wjhKMAoO93q+j3nHoUH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W0+vbyNtK0fmXOzDVhfAGCF0Ic+GhcetALnCsK/b1vlS/Qcio+fYGqhglIvRu12GU
	 +YEVjIQHpvNor3WRoqavLw+qTuSBhWZRjWeBV6tTj/mFSA2lVr5Ord743Bvg4CUwoR
	 gBpz9t5NA+DBRm4c/aiaduiNYJQtlbdk/ZjCfVfomKUpFZiewM899gW05TLhP2gi8K
	 1JKM6AeVfXEBnIxbhvk+RxcyHu7f6MBjTpV/1euFyAopJ2/amZLQbTnwi9vOVnNP2r
	 i46qC/KPB+8C6SGhRYZz/N5pqHDrG9dXUzMQ2MnADVgViD1ucVvElu5e6Wr4otvefw
	 u+3zLywlzkqTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD6CD29FB3;
	Wed,  6 Nov 2024 07:54:24 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 06 Nov 2024 08:54:00 +0100
Subject: [PATCH v5 1/3] spi: dt-bindings: apple,spi: Add binding for Apple
 SPI controllers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-asahi-spi-v5-1-e81a4f3a8e19@jannau.net>
References: <20241106-asahi-spi-v5-0-e81a4f3a8e19@jannau.net>
In-Reply-To: <20241106-asahi-spi-v5-0-e81a4f3a8e19@jannau.net>
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
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnRthfVLjea1h21MsuPzsJYXPcTB//xyaH9ikdqMJc6zZ
 f7tPfyxo5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwEQCWhj+yvp692/VeRPIIDP5
 L7OVWARfz9bksjPC7rOYCu/630lYzvCLaZJ279Fp2ornv6uZKT/9Em/0VPaDdsMNzuUMSqtLGCO
 ZAA==
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



