Return-Path: <linux-spi+bounces-5582-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C549B931A
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 15:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A683283221
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C331A4F12;
	Fri,  1 Nov 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZT8hNhM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D8184542;
	Fri,  1 Nov 2024 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471119; cv=none; b=sSrEw7lGMMw383F79yuEvv9QurPl5E8PEerSgcrBKVpELHxfdfcewa/x596GpvaCd864SV5Pte9L9C4X93Rd0QMHDmo0kYEX628jmnwz885g5CejwGaDzH43Qg6Zp4HVoSpVRoxO94e86a498CAXK4acZbbCNFe+mM9pFP+/DOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471119; c=relaxed/simple;
	bh=Dne8V2QfqkzN1YBXZsevP5jkNB9Lrxzwn56NCsyipPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NnZJIZw1C/OZLmj5qxS/+boVXt3p+bVmAhTqMSndPKxCu1tWR1dCmCnmJ3KrSmGYW8SDj1QTelLo9fc9MeBd0z6xfDZX47wWEFpqqUqXtv5MIIuI5llSFYcL5VI6so/1zCnaUcZhFpzjqEbVxE1ZAYjKoIEWwM+eXF0+/FWH2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZT8hNhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8230CC4CED3;
	Fri,  1 Nov 2024 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730471118;
	bh=Dne8V2QfqkzN1YBXZsevP5jkNB9Lrxzwn56NCsyipPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kZT8hNhMeuQgUAvsSiCso93KI2QxkMTedkDLuEkkOFeDIpwCrqppsYrfvu30cIezv
	 spw0AmoVDkrxqm6E/TA60ErVd5CeRNoKPQP7ei5MC5JSYPivzV/poKbfs8bcoDIl/8
	 o126ZjkOZFKWpf1jxE/tnxZSt6tm1v4SbPAw7mCWvB0mkNG/lObYfJTyYAKwdOEmZs
	 HZEa8UR5NeRdp4ZWRvrFgtryxu/s8qNoVg8mAORluxaPzmW5BrWecJJxhEfJLxwSOc
	 xmSajcueNgXvEUyu74rsACtBnpYyOgo5TUS75omkCFPx17Ycr73bg/EwI5SqHkPkTe
	 1O/uK5xWeRYVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6542BE6F061;
	Fri,  1 Nov 2024 14:25:18 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Fri, 01 Nov 2024 15:25:03 +0100
Subject: [PATCH v2 1/3] dt-bindings: spi: apple,spi: Add binding for Apple
 SPI controllers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-asahi-spi-v2-1-763a8a84d834@jannau.net>
References: <20241101-asahi-spi-v2-0-763a8a84d834@jannau.net>
In-Reply-To: <20241101-asahi-spi-v2-0-763a8a84d834@jannau.net>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2079; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=/RFcpEoBMNWg7lClrxLf6RcMZcKkYFii4Yno81onXTg=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnSVJ2eqaw7b7b0V2myXWnAmeqbrv0Ole50l0tc99d39a
 fOvw5FHOkpZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAEwkTZ6RYYmA1bKPOavc2p1D
 22ub5t2c8n7uwlvXTDetrM3pU8yKeM3wh2fHlIV3lTyOyvrW/egU3rGE9cb2eyJLvm5+JMXjwvB
 Vmh0A
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
Signed-off-by: Janne Grunau <j@jannau.net>
---
 .../devicetree/bindings/spi/apple,spi.yaml         | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/apple,spi.yaml b/Documentation/devicetree/bindings/spi/apple,spi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..0f280370cca9d82ce7ce72da53a144b257f7bdc2
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
+  - $ref: "spi-controller.yaml#"
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
+      spi: spi@39b104000 {
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



