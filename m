Return-Path: <linux-spi+bounces-8713-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AD4AE3916
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jun 2025 10:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7567F3B48B0
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jun 2025 08:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24F5234971;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m75xei8C"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3D233733;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668809; cv=none; b=eEuY/ejx6iqSu4CQm1jn6uF/dxIqDsT5ZVGQOcogsC7rkY3XfwLHI6bhftP26QzmUklFt1lAdDAAGb9AamyC6TaNvTQD/KRkPd8F1cSGc83iDrITFHv7kiBQhVJJtnJg7R+2CdMdsvNG9uy6wyL7jK1teSmKQGs4FY+ufbTA6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668809; c=relaxed/simple;
	bh=AHNWpwAy8MJW09iklYohLLBu2hUWRyvFhy9O91s9sTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=clyrnM5d25KSngpNqi3lRLuUr9Eui6b8oKdf8NZawmwbD0k1XOvh43ru22ba2K3T9nHr0G1bG9EY9BoAj9F9p53e/xi/Ok71kxl4NhfQbb01OnZDl0gnZ2s1/6kN0lL3d/Zhx5bg2fGg4xYtCi+sCIEfeIIKq6lmVDKSVLzTZ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m75xei8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5589CC4CEF1;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750668809;
	bh=AHNWpwAy8MJW09iklYohLLBu2hUWRyvFhy9O91s9sTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m75xei8CnbYbmiE3p9TkDEs0JHF7xKcHeAHdxrwnd0MfBtzRlDgQVA1qu3aK//m0X
	 7cSy/oRuqdyEKYk1tnxp6O8ckEY9FuZ54fFP556cuPrdmR8KLEQGkAJpZ0XNmbgWO6
	 FvkuR2gli3zxqPNSqDpKeOzz95g+SOozuAZinz4ZGXZRXwPUZ6mobK64ez8F+fHN5d
	 vs9uImnewGUJsFakSZtznXBk1n4Ph6eq1UL4Nx5mLMhpUjECyk0uEl1t77jEu834hv
	 b485em+JEkWLDm/gD8EgtqS58HcxAGUdk8oJohx9+ms9iaZZ0J8Z1DDgR/0t50yowM
	 w5pzK3jUwqRXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF5EC7115B;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 23 Jun 2025 16:53:27 +0800
Subject: [PATCH v3 1/3] dt-bindings: spi: Add binding document of Amlogic
 SPISG controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-spisg-v3-1-c731f57e289c@amlogic.com>
References: <20250623-spisg-v3-0-c731f57e289c@amlogic.com>
In-Reply-To: <20250623-spisg-v3-0-c731f57e289c@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750668807; l=1879;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=13MP5z5DFFJsG8DGKO1bHTVm7KiuWGBoe/rppEzsqCI=;
 b=b/wq+TddKbNmrGl9KidTJei3VmEY0V1Sb4mLMBADfIkMl9mazUWzmmnQunyUUQys4THlvLKzD
 adFlc5DBETjCKWN/zwL97YEpAKhwD/udfruKCzuxR0fU4TEmhzQh1M9
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
 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
new file mode 100644
index 000000000000..8d4d4606ff48
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
@@ -0,0 +1,55 @@
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
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: core
+      - const: pclk
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
+    spi@50000 {
+        compatible = "amlogic,a4-spisg";
+        reg = <0x50000 0x38>;
+        interrupts = <0 183 4>;
+        clocks = <&clkc 37>,
+                 <&clkc 93>;
+        clock-names = "core", "pclk";
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };

-- 
2.37.1



