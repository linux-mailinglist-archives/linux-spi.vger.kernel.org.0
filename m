Return-Path: <linux-spi+bounces-9121-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E008B09963
	for <lists+linux-spi@lfdr.de>; Fri, 18 Jul 2025 03:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC2CD7B21C2
	for <lists+linux-spi@lfdr.de>; Fri, 18 Jul 2025 01:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1994617C21C;
	Fri, 18 Jul 2025 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLJhIMIp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115C52F88;
	Fri, 18 Jul 2025 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752803540; cv=none; b=g3PkTmFDjPqJAuRKfzrD88XDNmhkR/PfBqZ5QrAC60jEenF1xDIwdcTB5r+VTpCPCiNxlKanDTY2ABFx++fS+C1YG+0HUx/7F/Nxz2IUaoMsTIqWy8ledeO1vULtr+sUen6Qzf/C9YfMflBOXy73VXmsw4FeoILk2EPUXU7Pn/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752803540; c=relaxed/simple;
	bh=HE+QQyQASQhlwMh647dt8HO00YDtO4Uo+20sLmuAsfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BsDN+Nidu12d0BHi8niz9rlGOJkPm4dVzFPV1UI6qu2PeKbRskU/UUVVsbpFYtMDfgPDK/w2glcc+xiABmu5U1v3fwSoGQwDapBQyp1iuBb4eChr1fkiET0KHpdn2gKnL43OsY7Q/g17psH4EpflYCOCrxexKRmHb6kT+jagkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLJhIMIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA6D0C4CEF0;
	Fri, 18 Jul 2025 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752803539;
	bh=HE+QQyQASQhlwMh647dt8HO00YDtO4Uo+20sLmuAsfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tLJhIMIpPMkhIF6YwAP9xDx0FmzSoMDT/a7aXN07g/RyfFRN8NLGMj4uW7vOX/xwo
	 fTXndc/A5Ry84i0J22OABSZpF/Ko8P52i1Jb3KrpKG3OKZD8L72TTD7n4oG+XLDbUK
	 weIe0MrwMC1GYok1gDG2dqxWf9bDufFyhAK7zMtbqp2TnTEr8qKKPtA83LCTpSmI73
	 F29VLkoqQlinnq9uQQrLXUUXVbO660/vrur8R6Pf0DzcBAZe7MKafUfR9b140W73DF
	 HbOchtVH9yLsvuvcu7SQHGZStu9RQAshGoe5NN+IW9YRWO6K7+ccmLwzM1pG7LdqT3
	 KP1KX6RwBhJ0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A372C83F34;
	Fri, 18 Jul 2025 01:52:19 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 18 Jul 2025 09:52:16 +0800
Subject: [PATCH v5 1/3] spi: dt-bindings: Add binding document of Amlogic
 SPISG controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-spisg-v5-1-b8f0f1eb93a2@amlogic.com>
References: <20250718-spisg-v5-0-b8f0f1eb93a2@amlogic.com>
In-Reply-To: <20250718-spisg-v5-0-b8f0f1eb93a2@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752803537; l=1996;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=IHQOnKrg7npxbLs9TpeLcto9ZcmGHjz7nxGFh2mfna0=;
 b=QItDgLJRXMpbE+E2/D88SywXqnLg9DSQ4FOxzlbAB+LRK2KcSZ6CyBUwU+GzW66YXRsm/gG+M
 A5w4GFXkVAzCxwIa0O0D5IJuG1OhtFJhseb1mSC/QAnEpNBA/1WTMcC
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



