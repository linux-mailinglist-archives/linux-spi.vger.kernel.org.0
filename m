Return-Path: <linux-spi+bounces-9571-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3C0B2ED7D
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 07:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524F81C83E8F
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 05:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAF0288C0E;
	Thu, 21 Aug 2025 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eevl5KZk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAAE26FA5B;
	Thu, 21 Aug 2025 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755753440; cv=none; b=n6qAHdQ3375DNgbv9LmHqI9LXNOniB1CZ11rlsvUfF9Y/bL9mpE+wUxUdcncCh3KaBxVM9nGxMyqrn31Vwb52Jp0ADqm4qLsjMquCqmdjc35XLd9rlohnJ1hDGj+cTJN7/hooslwWdE8HZW/e3Cef+s/yPyiif2lYhbhwpgNQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755753440; c=relaxed/simple;
	bh=fRTLO7YvtkPz/px3hGxGsrnMiNr1N9JdcyylPiUyXEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oqUYPpkZGrcIlqXuGflbt2ly4NJWA4KVi70HRSgghXU+iIyaXVUKfbdqzrkkfRd2S6AaF6ClxveLllJzWmQ6gsy4ZoG8CFrhZrSdmYufVO0P0WIFrzZj6CrvV3ndyGZN1IK0l4hzi22zUGuGLDOj18P47TWehqZ1/hNjtamOPV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eevl5KZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F35EC113CF;
	Thu, 21 Aug 2025 05:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755753440;
	bh=fRTLO7YvtkPz/px3hGxGsrnMiNr1N9JdcyylPiUyXEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eevl5KZkcH49fy1Odft2J8NrduisMNpRHb6PG/J7lJKUzxIUtN2gliFC23LLo9m6e
	 f+Ln7o+ri+FQh6F6QqPj0F22xzykZJAChG85xUUV+XKTcjyl1i55StTgkwLfLZy5yi
	 upRDVypSIH2ifHtkUXOArULndY5GA8W0xIAOfIh0P65VF7FZYupRK8bWG2V6BH96wD
	 pvYT+Nf7Y54YwW0vqO561eiXm2D2a1JPvrsVoHlIZ0C+nvuWypbMGLshtOS8g95tFv
	 GbNi0RDyyki5Xnw7eX5fpfLe5OPRVKEaNMBaaA7uafX3po/bD5TtLTN5uK5q4fpf+T
	 EyoamnbF3RQOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEA1CA0EEB;
	Thu, 21 Aug 2025 05:17:20 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 21 Aug 2025 13:17:15 +0800
Subject: [PATCH v2 1/3] spi: dt-bindings: add doc for Amlogic A113L2 SFC
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-spifc-v2-1-b119f64b5c09@amlogic.com>
References: <20250821-spifc-v2-0-b119f64b5c09@amlogic.com>
In-Reply-To: <20250821-spifc-v2-0-b119f64b5c09@amlogic.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755753436; l=2630;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=ndM0RuS9Iy+AH7FPsVlMIRmNDvN+z9IxzpvR1HkVPW8=;
 b=JkegV66u7xZMeyn9fyPZbTHVPT6qqeuVmStwxqw1DB+Kw+JuGboz4/fpjcWrE9evwp8Hv9owG
 C+ZXBQaD5MZDQg+oKtADgkIv9IH3luKOXs/AqNnMZ9Kqy5Wm9FQzNr6
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Feng Chen <feng.chen@amlogic.com>

Add bindings for Amlogic A113L2 SPI Flash Controller.

Signed-off-by: Feng Chen <feng.chen@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/spi/amlogic,a4-spifc.yaml  | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
new file mode 100644
index 000000000000..80a89408a832
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
+      Adjust sample timing for RX, Sampling time move later by 1 bus clock.
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



