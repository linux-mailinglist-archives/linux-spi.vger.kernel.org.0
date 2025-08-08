Return-Path: <linux-spi+bounces-9318-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79376B1E060
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 04:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E2B62711D
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 02:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B201188A0C;
	Fri,  8 Aug 2025 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfL82cMQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519B17A300;
	Fri,  8 Aug 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754618437; cv=none; b=Tlfr+jkNrdXSFLvQp2L4EHsFYc85aFrSAY0dUD1t1IalcYXXRilHK0vqtzrWXtu3m1jsxDiMmXMo5cneQwPpbr2VFkEPxFNCL+0pAoRJGCuXZ1Uylze5D9gEvDyG0YzJtKkTpXUXW+j71w+OZb0f/yqNpdOv1/RvMVN3wB++GdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754618437; c=relaxed/simple;
	bh=gtvsT1x6KL1WuqVo2r9Pv7p1UHA5wXGQdsrF0EprLAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnDtpFIO76NQLBL/MTNSqPqahFwJgz3XE5q9xegc1SHbazX5M7k5vjARNtOQRDsJ0JIpI2aMsElx6ogXTW6NJT47Z6ODAVtwUygAI6v/R3Gl0q6y+MyqrtUjNd+UNd1ymoJPRQ04pNx4s6s2ysfGqJ82zBi5/B3HsRdOUYh4JMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfL82cMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E0E0C4CEF4;
	Fri,  8 Aug 2025 02:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754618436;
	bh=gtvsT1x6KL1WuqVo2r9Pv7p1UHA5wXGQdsrF0EprLAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VfL82cMQEMJrREUNvoBvzRO+68hd8djtvU1WiwhedyshvRc43Sd4F1P0vA2vUudVD
	 /AMjaqihthghF1n1Z2sGgmZYIZ64rEMDpk6aDzfUhquPso131rat/K58JbFv4MOb/r
	 tHZO0D8/uswR8SjNlIC7a7Rf/L3scLCUfwIYbt4uykW3wTy45se3YWKGjBR5m9Xsbo
	 /O37l/cmYPNcQvFuQoug1U4vncQaIP73OAEXB4IW75iVbwzniFn6ddeUZ806wuFfg2
	 1BjyUFT3dWzxEvEza16YcukD4GT01ybMZHharWmCYdm+uA/K5biDMiZIECj0kAO2UD
	 EetANZx6IaRag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF12C87FCF;
	Fri,  8 Aug 2025 02:00:36 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 08 Aug 2025 10:00:34 +0800
Subject: [PATCH 1/3] spi: dt-bindings: add doc for Amlogic A113L2 SFC
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-spifc-v1-1-ff4e30e26a6b@amlogic.com>
References: <20250808-spifc-v1-0-ff4e30e26a6b@amlogic.com>
In-Reply-To: <20250808-spifc-v1-0-ff4e30e26a6b@amlogic.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754618434; l=3425;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=bLH1YCUDdwpRixxvKPG4oxzNBgBNJNrkBjlYrk9Mqmw=;
 b=gu7g30GKaG1N5QhYx3uprkNWWWZUpQ1YT+TRKt5aQwRTH9zrplfXfOCLLUmjTAGhPVpb50Ke2
 3ZErOJJYgH1ALW5FPI+6iz3oA5mW3DB4OHa2+f/8WkWRXGCk9YAQRbL
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Feng Chen <feng.chen@amlogic.com>

The Flash Controller is derived by adding an SPI path to the original
raw NAND controller. This controller supports two modes: raw mode and
SPI mode. The raw mode has already been implemented in the community,
and the SPI mode is described here.

Add bindings for Amlogic A113L2 SPI Flash Controller.

Signed-off-by: Feng Chen <feng.chen@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/spi/amlogic,a4-spifc.yaml  | 104 +++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
new file mode 100644
index 000000000000..712a17a4b117
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2025 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/amlogic,a4-spifc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI flash controller for Amlogic ARM SoCs
+
+maintainers:
+  - Liang Yang <liang.yang@amlogic.com>
+  - Feng Chen <feng.chen@amlogic.com>
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+
+description:
+  The Amlogic SPI flash controller is an extended version
+  of the Amlogic NAND flash controller. It supports SPI Nor
+  Flash and SPI NAND Flash(where the Host ECC HW engine could
+  be enabled).
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    const: amlogic,a4-spifc
+
+  reg:
+    items:
+      - description: core registers
+      - description: parent clk control registers
+
+  reg-names:
+    items:
+      - const: core
+      - const: pclk
+
+  clocks:
+    items:
+      - description: clock gate
+      - description: clock used for the controller
+      - description: clock used for the SPI bus
+
+  clock-names:
+    items:
+      - const: gate
+      - const: core
+      - const: device
+
+  interrupts:
+    maxItems: 1
+
+  amlogic,sfc-enable-random:
+    description: Enable data scrambling
+    type: boolean
+
+  amlogic,sfc-no-hwecc:
+    description: Disable ECC HW engine
+    type: boolean
+
+  amlogic,rx-adj:
+    description:
+      Adjust sample timing for RX, Sampling time
+      move later by 1 bus clock.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sfc0: spi@fe08d000 {
+      compatible = "amlogic,a4-spifc";
+      reg = <0xfe08d000 0x800>, <0xfe08c000 0x4>;
+      reg-names = "core", "pclk";
+      clocks = <&clkc_periphs 31>,
+               <&clkc_periphs 102>,
+               <&scmi_clk 13>;
+      clock-names = "gate", "core", "device";
+
+      pinctrl-0 = <&spiflash_default>;
+      pinctrl-names = "default";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      flash@0 {
+          compatible = "spi-nand";
+          reg = <0>;
+          #address-cells = <1>;
+          #size-cells = <1>;
+          nand-ecc-engine = <&sfc0>;
+          nand-ecc-strength = <8>;
+          nand-ecc-step-size = <512>;
+      };
+    };

-- 
2.37.1



