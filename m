Return-Path: <linux-spi+bounces-11171-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BCCC530BE
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 16:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F239235956F
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D98C33BBA5;
	Wed, 12 Nov 2025 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcidL/qM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B533B979
	for <linux-spi@vger.kernel.org>; Wed, 12 Nov 2025 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960201; cv=none; b=TrLsZhAgDeoBc/+2wbKybuXbUa++DdVmo1+DxynmTRS6NtWfZI3kbbHxPnaLqT+S532H/7DySb1AEZBtPUbuDfkm0tX2N3Nt39Lq5dCkdnTLXrrca5c5P5q1fKRFhG2QnXn6cEki2NNxRZKp8sPsEhxfD7ADSlgQLMyuhUeice0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960201; c=relaxed/simple;
	bh=aYSYBvNWA4f73tOvtgsvmHJY2eaF6RJXHjE/a9pxUbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QbNHwbaexW2wJjJKkxGYqkBD6EGZm2KN7PoUWlPPdwM3yTFF2CKqaLDEzADI0SIujNO0GO2K7G54osxcSNhQbj2QIVGxQevCbSopWL3t937aFYDH9uQzgmRPKSYXf85PveYp5Z3XJhWLafyGNCQ0Pj8CylXJ2isd88zjs8Smyyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcidL/qM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477770019e4so10782045e9.3
        for <linux-spi@vger.kernel.org>; Wed, 12 Nov 2025 07:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762960196; x=1763564996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DtGZMMsw8V99KZAgaHQJPZ8CoLj3tmmTUHgBPIq1Q90=;
        b=KcidL/qMT0dse2e+jDaZ9VSnJ77dfInWu01TM40OzrPmjmDB60Tks7QjmccoIPwhtW
         YVpuToj/1E7wlj3f5QtPTSztLLcMidcGvlaYLV2O8DHhCFSCO/LL9WD8ylLfzjpPFGa2
         kteQEMRJSTkJAGYV1xn2am270/mE1uRfVA896jJuECLSUc0P2P8G3OxpEuzKF7dA/uCL
         NcmtTtXHTZcbAxUKUK0jxkN4/vihQ8fU/de1EU81VyG/53wzpMTPyZkUGRlOq2kUGxkl
         dfvo5HNRhMA+hjlkBoKCanWzH0dpBm+eqJU/vkXyWIIYsu0eqj32kjdC2Re5p7Eb8JEL
         yAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960196; x=1763564996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtGZMMsw8V99KZAgaHQJPZ8CoLj3tmmTUHgBPIq1Q90=;
        b=PsJ0KcrznsQSy9j+TMeDDRTTdcBIy44LZEeu6CASvYQyEhFWbxFNubaNcdezVDjlaY
         CmJs2xJp96z5OmOlMDyKYCBOJtyYVEyV0tAHigA40hlMPFxc9sMJG/jH2yhCe2fptRQX
         d8iCBwkR3gvQYhw6D2edJDiKow7LTepcLPfyO+GxLVXiZb38yHalJdluPudHi4VoJXyk
         RAbGs8+wlE+4PP3G9Fac/QATjth0J3TF4u1Rbh5KBT+qnKp7CELn+MqeqC/mocwISlFu
         C6Fr04UWBokZiSHlgeGxM60dFkxpXTnjM8dQUOUoXJj6MKZmNHvFWKCJilDB6+Unk1bM
         VP9w==
X-Forwarded-Encrypted: i=1; AJvYcCUsjHv8AgkI3Q4jfxVfRRYBzCv8Df3NG2Zis4bVyirBP+P5uWOS7sH+fjdQmsfqhdZUTcIn8WouRgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC0acC4EtBNcxHpVHdU1EyjWJYsSGUoZjMJnGfhLUQ24VoHgwz
	CJ5/32za9RRZqcLbzuEj4rpS3PpTyG2vy0ThK/ho3dob4rE1OgLI+gA8
X-Gm-Gg: ASbGncscghqv35CSy+KpRV5aA3+PdyGfhW5Z9Jg+VEovMILQsSVTzOZZSXLz/pIUmgZ
	AbCvEaUO1fFRCjcc4e0Vo0q+rjHkaxOESevlvXPP7dUOLVdhWmay006Y6hSpc1I6aWyPJxOCDIJ
	SuyKkgIuKTMC6g/xhLee+xZKKvv3Lbh8ZIQeaq0ZLtW088gQF8eH3sIvnPG99ZZiBmGcf3XmLMP
	mT/WSJ1gfhsEdQjVMG6UEvG0XqdojeT6ELUWN3Q52zjXNIufsO153gAGXT/pictbsubVuxwZUfg
	64jzmSH5bNVJOUEQxeqKpFSEn+3ORXFucGYxgDZdvfxbjtIWmQI7zoAuAKi9HCJxD8xIPkS3B/Z
	5MFy9ev0kRWc+lKYJ10NiZ3/VVfv0PZQ4WB/cBrgoy9h23LMmhqrSGDj3Mts/vYug/f6qHmzbaZ
	9RpjPWTstcWZ0=
X-Google-Smtp-Source: AGHT+IGviozO1G+47njNKiErvjncEx+jjY7PIlVohsiPQB3KFMy0e3qBbtmFS5UVJasOoahpIh4XCg==
X-Received: by 2002:a05:600c:3b11:b0:477:6b4f:3fbd with SMTP id 5b1f17b1804b1-477870b935dmr27381355e9.38.1762960195571;
        Wed, 12 Nov 2025 07:09:55 -0800 (PST)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm33272447f8f.9.2025.11.12.07.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:09:54 -0800 (PST)
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org,
	avifishman70@gmail.com,
	tali.perry1@gmail.com,
	joel@jms.id.au,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	andrew@codeconstruct.com.au
Cc: openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2] spi: dt-bindings: nuvoton,npcm-pspi: Convert to DT schema
Date: Wed, 12 Nov 2025 17:09:50 +0200
Message-Id: <20251112150950.1680154-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Nuvoton NPCM PSPI binding to DT schema format.

Also update the binding to fix shortcoming:
 * Drop clock-frequency property: it is never read in the NPCM PSPI
   driver and has no effect.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
Addressed comments from:
	- Krzysztof Kozlowski: https://patchwork.ozlabs.org/project/openbmc/patch/20251110081457.1008316-1-tmaimon77@gmail.com/

Changes since version 1:
	- Fix commit subject and message.
	- Drop unnecessary description.
	- Use GPIO defines.
	- Add clock-names property.

 .../bindings/spi/nuvoton,npcm-pspi.txt        | 36 ----------
 .../bindings/spi/nuvoton,npcm-pspi.yaml       | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
deleted file mode 100644
index a4e72e52af59..000000000000
--- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Nuvoton NPCM Peripheral Serial Peripheral Interface(PSPI) controller driver
-
-Nuvoton NPCM7xx SOC support two PSPI channels.
-
-Required properties:
- - compatible : "nuvoton,npcm750-pspi" for Poleg NPCM7XX.
-				"nuvoton,npcm845-pspi" for Arbel NPCM8XX.
- - #address-cells : should be 1. see spi-bus.txt
- - #size-cells : should be 0. see spi-bus.txt
- - specifies physical base address and size of the register.
- - interrupts : contain PSPI interrupt.
- - clocks : phandle of PSPI reference clock.
- - clock-names: Should be "clk_apb5".
- - pinctrl-names : a pinctrl state named "default" must be defined.
- - pinctrl-0 : phandle referencing pin configuration of the device.
- - resets : phandle to the reset control for this device.
- - cs-gpios: Specifies the gpio pins to be used for chipselects.
-            See: Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Optional properties:
-- clock-frequency : Input clock frequency to the PSPI block in Hz.
-		    Default is 25000000 Hz.
-
-spi0: spi@f0200000 {
-	compatible = "nuvoton,npcm750-pspi";
-	reg = <0xf0200000 0x1000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pspi1_pins>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clk NPCM7XX_CLK_APB5>;
-	clock-names = "clk_apb5";
-	resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_PSPI1>
-	cs-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
-};
diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.yaml b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.yaml
new file mode 100644
index 000000000000..db0fb872020a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nuvoton,npcm-pspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Peripheral SPI (PSPI) Controller
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+description:
+  Nuvoton NPCM Peripheral Serial Peripheral Interface (PSPI) controller.
+  Nuvoton NPCM7xx SOC supports two PSPI channels.
+  Nuvoton NPCM8xx SOC support one PSPI channel.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-pspi # Poleg NPCM7XX
+      - nuvoton,npcm845-pspi # Arbel NPCM8XX
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: PSPI reference clock.
+
+  clock-names:
+    items:
+      - const: clk_apb5
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
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/nuvoton,npcm7xx-reset.h>
+    #include "dt-bindings/gpio/gpio.h"
+    spi0: spi@f0200000 {
+        compatible = "nuvoton,npcm750-pspi";
+        reg = <0xf0200000 0x1000>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pspi1_pins>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk NPCM7XX_CLK_APB5>;
+        clock-names = "clk_apb5";
+        resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_PSPI1>;
+        cs-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
+    };
+
-- 
2.34.1


