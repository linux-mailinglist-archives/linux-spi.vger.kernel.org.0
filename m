Return-Path: <linux-spi+bounces-9761-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6A4B3B255
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 07:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E25716C069
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 05:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10420B80A;
	Fri, 29 Aug 2025 05:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2aPmzrC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9E58488;
	Fri, 29 Aug 2025 05:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756444580; cv=none; b=KB3FlUHMbl2Mfgr4kCkZlu939uAkCEUjCpCmk6lHc1NjIOLkHp2ENMtbJWUHBXlbxjgOoQNLoWn4njNNUYLfWRgI3R04Lw5yF00uh+mVUIrpD97TwdLHF1q9iPSn12X50lJ6Y/XFs/CbRayMbp6CW9V8y6beGarT+OFXFbO+my0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756444580; c=relaxed/simple;
	bh=lIZTwa6utMS8ZN16/Gpyy3DO/ILiJsjYyK22sUh8K6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HYDUkyByU5zaa/nHW269EYjYmQrAj9ZZrdZRsUh1OXZrJ0LZt0deMMnzSv8ZN5GGEwTR6mUm6lL54WXxI6MfN/ydrpjZ4uqQctiISVimUmh03sOBoypjI5DbIpR0jDcDSRXfOcBBh4BqWlDBZW0emlij9W0DagtwWVMYHsMsOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2aPmzrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36DFDC4CEF4;
	Fri, 29 Aug 2025 05:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756444580;
	bh=lIZTwa6utMS8ZN16/Gpyy3DO/ILiJsjYyK22sUh8K6U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e2aPmzrC2sxj75mPvq3CTEuxLXhdNz08cXwdPPaaQ1IKSK4Ervy8AI9zO5egYNc7J
	 w/z73kdpkqaLtX0KEwuQEFZ4jEaeqDLv5hoCf582a7+2TEAM0UHgHa8m/0OezGUnPr
	 ubQUkFZ2EjSJeFuhTigFXkJiHK79B30Ti2CZ/A5lqPkB6CeaACF3Y3Eqqx6R4JdooV
	 2I25lyGbfe2X7FDx7auZjgMRhtEpjROJTMlBmYAb3P0eUHEOJEfS+CW9C1u9oz2UYB
	 bPOQHj/SuaYek+OfjEQB+HUoK+YzHDhbbq044MpF1m89uhP7m9R2FqWQKV7G/hWd8Q
	 Ct11kmhv3TIqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223DACA0FF0;
	Fri, 29 Aug 2025 05:16:20 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 29 Aug 2025 13:16:13 +0800
Subject: [PATCH v4 1/3] spi: dt-bindings: add Amlogic A113L2 SFC
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-spifc-v4-1-1e57fd39f584@amlogic.com>
References: <20250829-spifc-v4-0-1e57fd39f584@amlogic.com>
In-Reply-To: <20250829-spifc-v4-0-1e57fd39f584@amlogic.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756444577; l=2865;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=9fvNf0gnqsPZj5pbSaN5sASQ2RjSd/OTNrUg3zl92/k=;
 b=s2PlpVWyRtQJwyUb/TTf8cQB7jhHRCVBm9leQv8rQCUFYbKpu/x9OnOPO349+i/87hiwkQxKT
 PE85Mf9l1opDiCu938sE4Nuf73SKSFFkHErldgKvSjQGAcJi6X0ynSA
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
 .../devicetree/bindings/spi/amlogic,a4-spifc.yaml  | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
new file mode 100644
index 000000000000..b4cef838bcd4
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
@@ -0,0 +1,82 @@
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
+  The Amlogic SPI flash controller is an extended version of the Amlogic NAND
+  flash controller. It supports SPI Nor Flash and SPI NAND Flash(where the Host
+  ECC HW engine could be enabled).
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    const: amlogic,a4-spifc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock apb gate
+      - description: clock used for the controller
+
+  clock-names:
+    items:
+      - const: gate
+      - const: core
+
+  interrupts:
+    maxItems: 1
+
+  amlogic,rx-adj:
+    description:
+      Number of clock cycles by which sampling is delayed.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
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
+    sfc0: spi@fe08d000 {
+      compatible = "amlogic,a4-spifc";
+      reg = <0xfe08d000 0x800>;
+      clocks = <&clkc_periphs 31>,
+               <&clkc_periphs 102>;
+      clock-names = "gate", "core";
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



