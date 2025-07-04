Return-Path: <linux-spi+bounces-9035-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7A0AF85D6
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 04:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A59F3B57E2
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 02:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D861DF756;
	Fri,  4 Jul 2025 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKR/XPnD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492391DDA3E;
	Fri,  4 Jul 2025 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751597974; cv=none; b=oPRCIYpDUdcfcbr28lFYmRnd/RBC5dP9xA8+y/3PziNlZaLZfv/gUNlTWOUxaeG1Xi49UAf/KtNnrHm8crvFgvJxDEq7K/AjKXXYekp3DfQT2xTFfv0+DSAbcARivnLLazKYZlZmS1Nij6YUogfldvfISYb55/sJzRiCmk9Mmt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751597974; c=relaxed/simple;
	bh=HE+QQyQASQhlwMh647dt8HO00YDtO4Uo+20sLmuAsfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBcx8jxAyfPZtjmBcoySmNinYtpTlFmJhpAK35Ww1PnALJIPIM5bfQrHWnVb0OkF/0ads39zyRxcnkPe41WjHCl0/ktq6f7/GemaIv3NV8j6oF9ikNYAoC03cYxymMy08F1BYtXEl/k0YVDH4JhbJ6xPCI6CrYOQk0WOoNNyV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKR/XPnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 170E5C4CEEE;
	Fri,  4 Jul 2025 02:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751597974;
	bh=HE+QQyQASQhlwMh647dt8HO00YDtO4Uo+20sLmuAsfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TKR/XPnDpQFYgF6qrseSFvtps8p8XIIHW8xL9Znw0DAhvu1y6xM8h4ObRL2QXJX0L
	 EvNK6HHV5y9Nv850pX6rZ3G0geZxFnKaLtLl7oIBQbVlR1AtwyBXhxvSZIupBHNWBl
	 v/ynul/VrabtsZk2ZxnLM1Rg2sz4kjEQ79iuv3oO9pMew00VqavkaVn99hob+6nexE
	 dQH3XXap8zKAMoz5RsfoGVZtO5IAdjREJf6AguPWz0gcB6JvaAY6502m2QtY5ZCs/M
	 D2Wlk+uB3kzrExyQtSV1Sm/N+vuCdqMSaxGg5yJuKWeotzzEGszeVm64PM5gNZh3np
	 x5CR8xVTql47A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06569C83030;
	Fri,  4 Jul 2025 02:59:34 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 04 Jul 2025 10:59:32 +0800
Subject: [PATCH v4 1/3] spi: dt-bindings: Add binding document of Amlogic
 SPISG controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-spisg-v4-1-6b731dfbe610@amlogic.com>
References: <20250704-spisg-v4-0-6b731dfbe610@amlogic.com>
In-Reply-To: <20250704-spisg-v4-0-6b731dfbe610@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751597972; l=1996;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=IHQOnKrg7npxbLs9TpeLcto9ZcmGHjz7nxGFh2mfna0=;
 b=IQdq1I0A/nxaoSC9PFdRfxrIi9GLilVkR76OMO3Nj+L40D88t+6EW6X8UJ7wD7DnpQuRQolXK
 BUbvoemWmK6DRlBqmggSd47SESbCRE04/Tb+baO7yg6SSy+o+tB2MIP
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Sunny Luo <sunny.luo@amlogic.com>

The SPISG is a new communication oriented SPI controller of Amlogic, which
supports PIO, block DMA and scatter-gather DMA three operation modes.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
new file mode 100644
index 000000000000..9bfb8089f7ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2025 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/amlogic,a4-spisg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic SPI Scatter-Gather Controller
+
+maintainers:
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+  - Sunny Luo <sunny.luo@amlogic.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: amlogic,a4-spisg
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: core
+      - const: pclk
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    spi@50000 {
+        compatible = "amlogic,a4-spisg";
+        reg = <0x50000 0x38>;
+        interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 37>,
+                 <&clkc 93>;
+        clock-names = "core", "pclk";
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };

-- 
2.37.1



