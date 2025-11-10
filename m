Return-Path: <linux-spi+bounces-11141-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F7DC4553A
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 09:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5B73B2C89
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 08:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA542F7ABA;
	Mon, 10 Nov 2025 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD440Zws"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F512F693D
	for <linux-spi@vger.kernel.org>; Mon, 10 Nov 2025 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762507; cv=none; b=dug/uEhX474P5qmWlrzlpzAW/UH2LXw6djbk7W6fIYScfnVFHy8iUg9hgRhcLpWaf0SpDnnxMc6H34l+niPA1hJfc3CAmssKfj/L4H7C51/56F07vhKifEGK4jwuj1I9i2uCsISpNRElkajjl5/uQxQGHeJstsSQqilEAI5ax58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762507; c=relaxed/simple;
	bh=QA8cAA/NzrSavT8e8+Q7msp+Jrq09DSxAcdCNmENL24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MvCmshkF4h6+yfbWyaFm6g+t9tnGgBgnn9ho4OOuUOUfuJLJizp6fgulbWLZHfFuJbpCXOYUm08ozKlx02RN6yuDyNl601vOiN9o47m+0bZgieIBc65aTs7g40SYpwqRHjHHnYXK4E+EZTnS7bQhaujLgJusW6FtLrG3VXaSc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lD440Zws; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b32900c8bso605959f8f.0
        for <linux-spi@vger.kernel.org>; Mon, 10 Nov 2025 00:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762762504; x=1763367304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SeRemWdOh6BINm57bAExN2qF+KGtIQQ7kG3okdFAQq8=;
        b=lD440Zws6dIkqPeowWwMazCERaA0Pt91WCQrInTGJNqF60WihVEoVmPI+SzEDuEfz+
         hYOgS64A0Uqu/AQuhtP2m1NaXYT/HcvR6QS98Xt85aWqPf2mi525EKHZkvYAiTXk2gx6
         Mqt0S2+ujNHultvxPKvb2Ot4tbYsUYTEnAlNVlt8pV8sKh7VmUYWleiBeMwQ5aXHQO5W
         5rM3gtjmt0ssAgdICYB2PU5HA2lkfwnoLXff/I0JNRPQ4iKQh7jR9/vUn+FnhLheN55P
         +2eHstvcdosstYwVUOSGgJTx3sXQsa3LA98wz0wG1HyBLdPfgEDFnl3ey8/Db7aic01w
         IoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762762504; x=1763367304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeRemWdOh6BINm57bAExN2qF+KGtIQQ7kG3okdFAQq8=;
        b=jcvKYG/eVINOx3cgEgSlLwu9QkaEPLqy7Poly3ZPw5u/pmOtlm5Ka9HUlLwJng5ABe
         +yWC9lC9iGN+o9vMc9dz3xqY8+JNm0l8vJuytDn31p28Zh9u/oOZ8xTMbHNTmYm36tcH
         Tfhwp2EmdXiRmHsEFgVu/HYIMagxL7DK758PICV/Sx1unM5bTCO+lM/t+Nzr2SalkoAI
         8mKXhsXvIyKtRZjGs9ciYQpZU3YSf7/7+G/9szvEqIfs/X4XBFmeYvR0lqfZAM9IoJVH
         BQl3T87I2oZGxE+V9WCsFdWM1Maz5AObFVmBAJ8HGzCZ39U7t/3uxPB0c8WTKTy/FEkr
         KU3A==
X-Forwarded-Encrypted: i=1; AJvYcCVWenXA2gCWxrYzdt6pNR1Vec8t60fvIMHoZUxx6bT2e9gm2nFIUHkRLIreiJNQbNltqgQCQzFZ+pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAS73g7A+nAW+sI4pt/tgylOz+tCdepb6dvxQCQHAWWQjFLCsR
	I+DBPFY75k/mOLYZobzKPQtBBgh0CBeW1OvaS7Pa9Wfi8PPbd4p6Jfap
X-Gm-Gg: ASbGncsuROKbYxpDByJv4qOhMhL9Zm/+SMbguzCCFGu98aouInxVva/uLkhBMhAZLbH
	BLHIuOdYhAbETmQanRzUzr3AtNHCz+FjjlogizEGxRqHhh4mC1rUMEIl74fJ8qFXmdbbzV4hR5o
	Vr4++DWHx1q9VLl32f+H46SrNoCCCNWTcPXFNd4V5zq97xhZyTJrEvvhqKK54eH9N+y20GMhTr7
	N77wFD0KSk4zULOg7L1vWpfRghPzasPYkMMtOTli+sieO50tlSMZ0txumkixWMsl2+7Uro5Esdy
	xj5wsyTnYTiVO0//CoN+Y1kNF2epp+V2iXKuFOURNDacfdxIArUQKjORkCEINCMf8h5nW/L1W0T
	ARpNMuS/DZvQRpNghpCzeG9BlADlhfHD+2eDQvWbFUNOVhYpqGr0AnNcW425B0QBhtirYX2LzVL
	InJtrE9+Dwm7ENU0o1cI8mwQ==
X-Google-Smtp-Source: AGHT+IFPRvflcsKqu7bHRXK/JyFHX+r+ojZOUJvTf4Pg77kTUGLJ4kifZzrUVNK8QvjfDeCXTC/ucQ==
X-Received: by 2002:a5d:5f86:0:b0:42b:3e20:f1b3 with SMTP id ffacd0b85a97d-42b3e20f52bmr530612f8f.9.1762762503585;
        Mon, 10 Nov 2025 00:15:03 -0800 (PST)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679214asm22324568f8f.38.2025.11.10.00.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 00:15:03 -0800 (PST)
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
Subject: [PATCH v1] dt-bindings: spi: Convert nuvoton,npcm-pspi to DT schema
Date: Mon, 10 Nov 2025 10:14:57 +0200
Message-Id: <20251110081457.1008316-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Nuvoton NPCM PSPI binding to DT schema format.
Remove the clock-name property since it is not used.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/spi/nuvoton,npcm-pspi.txt        | 36 ----------
 .../bindings/spi/nuvoton,npcm-pspi.yaml       | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 36 deletions(-)
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
index 000000000000..65ad40292408
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.yaml
@@ -0,0 +1,65 @@
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
+  resets:
+    maxItems: 1
+    description: PSPI module reset.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/nuvoton,npcm7xx-reset.h>
+    spi0: spi@f0200000 {
+        compatible = "nuvoton,npcm750-pspi";
+        reg = <0xf0200000 0x1000>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pspi1_pins>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk NPCM7XX_CLK_APB5>;
+        resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_PSPI1>;
+        cs-gpios = <&gpio6 11 0x1>;
+    };
+
-- 
2.34.1


