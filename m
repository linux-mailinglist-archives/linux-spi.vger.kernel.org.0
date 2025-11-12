Return-Path: <linux-spi+bounces-11175-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EE5C53B5F
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 18:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9BF1345116
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1984337BA6;
	Wed, 12 Nov 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W78qEqSp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD91A345731
	for <linux-spi@vger.kernel.org>; Wed, 12 Nov 2025 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968822; cv=none; b=KKlD4Z+SNUxq/hdd/f1MPUAirN10ZMvfTIt2AHE0G1iO2z+pQYmG7TLqKQ/gXNZ0s1i3xoPahz0ceU63phB1ZMd5wpCbCrC9oGGSjCtJSSayhOPCM2BUIId8GesFZlBQK+rXxYDotVABOANA9vvXT0Hj3HCKnqi25nKPVXyGh88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968822; c=relaxed/simple;
	bh=L/oKLVeai+77dmSJ2udu0Pkh34+umH9uQu66eO72Chk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IIWBpJaz0toidXZGKPMXbeH0Mkejh+5BJkhTa0Z1lpr2BkjERxeLWek8gLG3RBHe2jY/LtrvarFZj1ovejutxze2F/rwCDZUPe8fomExZWAksu7FNyoAtcjs3cGEqoOf9HPEaNulGAfxUyZ0SaP29Z+CMcYNrcvMYz3MNgSggWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W78qEqSp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so657292f8f.1
        for <linux-spi@vger.kernel.org>; Wed, 12 Nov 2025 09:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762968819; x=1763573619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=44Kc/j2JhoyAbLrRyX1QwglgFc2dUpdlPh4jWhsbUTw=;
        b=W78qEqSpk1iKBvAcYBqowsJwoqaH5iYa8ckaDIcWv+VvbZW1OS36L8S1cjVsDp4lpQ
         Ypx6jUihWNbz9VP3R5Ymu5QfvtLyCMBZBayum27++0NkgJFE7O6LsvObx/QAB0SlK3vn
         fxGftT5sTpMk0jYSIEm/VBzIl2vefyufameWquQAPDGgUBfqnkyPNM+JxEhw2QSLf9D/
         AImltIhkFaeER9RnvY5/YZqlKOTI/+68a4jBuOnJ0e4BMsyQbYcCDgYivdFvDXsyystG
         /GltREopbXXS2KgFsRocFolR3NmA6g1uq80N+SKjKpsjJqA71r2SClzbVQAJ94rzyVnj
         bUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762968819; x=1763573619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44Kc/j2JhoyAbLrRyX1QwglgFc2dUpdlPh4jWhsbUTw=;
        b=aLFiSjdF6e68SW/OBTWbzeA2kSSsh6gHAbl0XDWVb/z+tiDoFqdvIuubR6tnZEVo2Z
         kZj38i0o2m3cN7hC7ExcMy8Jj7V4tOpRdn6uNH5DJmSmZOQH/3fiSy2nrR8JQXgm8ytM
         eu3viBgWKHqUwknwZxRc8K/0zNlimGuXa81JMqAIBIKEOgXvYGK4HYJVS9Y0CRbsoVIS
         /IppUhM4LNe2R2/GGoIVF11Gx73p4NuPexPVnSmEbSOsDC+XKwF5CxAjiaOR8JdUqKxf
         DLRP2Vk0t+B+9GFUxKbfYOKXLMqRm8YqxKFbLmLWkqIOxCwyFEFbLO9YhhGJB9tLwATn
         XHVA==
X-Forwarded-Encrypted: i=1; AJvYcCXgIkXXNG9Ae5uI7LNQ9unvw2LUfvOqHbdxONiJSVRc087fgmpeQ1VKZiyRMrd34GR08/ppplQ5hsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtpLWvSbnC8w3ko9UVP5EZJS2FqXryomvOqlJUuwR9kj+NCa7o
	hF3Ef6XnZEbB2SblB93bEHWTfmMmmHPtQssr1n4tHIND+UqgMgK8DaxG
X-Gm-Gg: ASbGncuXpgx/KgMhqLgnsvll+iTAWyUwW7DtpuFqZgga3NIRBjyMUebxp2NxN0TeG0n
	sNmYAJ/vfdTQWd/QRqlaG+AJSw8vEjSm2etK5fPs5555Rn2PijQK5gcbEylYcHAgwDgaY7cF7ht
	f/XLxn1M2QYjJ1TOromBalM7K3XFSjamNPnKAUGIhBZDU6wJm3ewnQjDu/87nAl7JhS8i9TjeA1
	T5KW4VH40+zMrk31wYBYI5uPvzn8DHEt+x/akDnVGYERVzkk0h6QaSs7ylVnqKENO914PLrZ8l3
	McWLzrlMU9TxKPadm+UW8wGCDAxWgKgB8FfnQLuJdw4oYo7yYoZMH2WoeYv6pEkh2sr91r+ldwI
	gtdgQAiIfPOI1FB5qEjKyHvHU1n5/Qxm9uIz31mwm8/nAMpy2FO9gqioO7mzdo407vONRpgJIlh
	QVQYLZwg+vS/+LAql8L0PESQ==
X-Google-Smtp-Source: AGHT+IH6Qjzo8T7i3m2l3eXDsCIqvaE7ouHOEbD83pVacao2ZlOAWd37u6dKpswf2G543Njjogyyhw==
X-Received: by 2002:a05:6000:144c:b0:42b:3bee:a7ff with SMTP id ffacd0b85a97d-42b4bb95233mr3102189f8f.24.1762968818723;
        Wed, 12 Nov 2025 09:33:38 -0800 (PST)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b29e4b9bdsm31970655f8f.32.2025.11.12.09.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:33:38 -0800 (PST)
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
Subject: [PATCH v1] spi: dt-bindings: nuvoton,npcm-fiu: Convert to DT schema
Date: Wed, 12 Nov 2025 19:33:14 +0200
Message-Id: <20251112173314.1751671-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Nuvoton NPCM FIU binding to DT schema format.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/spi/nuvoton,npcm-fiu.txt         | 58 -------------
 .../bindings/spi/nuvoton,npcm-fiu.yaml        | 87 +++++++++++++++++++
 2 files changed, 87 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.yaml

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
deleted file mode 100644
index fb38e96d395f..000000000000
--- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* Nuvoton FLASH Interface Unit (FIU) SPI Controller
-
-NPCM FIU supports single, dual and quad communication interface.
-
-The NPCM7XX supports three FIU modules,
-FIU0 and FIUx supports two chip selects,
-FIU3 support four chip select.
-
-The NPCM8XX supports four FIU modules,
-FIU0 and FIUx supports two chip selects,
-FIU1 and FIU3 supports four chip selects.
-
-Required properties:
-  - compatible : "nuvoton,npcm750-fiu" for Poleg NPCM7XX BMC
-			     "nuvoton,npcm845-fiu" for Arbel NPCM8XX BMC
-  - #address-cells : should be 1.
-  - #size-cells : should be 0.
-  - reg : the first contains the register location and length,
-          the second contains the memory mapping address and length
-  - reg-names: Should contain the reg names "control" and "memory"
-  - clocks : phandle of FIU reference clock.
-
-Required properties in case the pins can be muxed:
-  - pinctrl-names : a pinctrl state named "default" must be defined.
-  - pinctrl-0 : phandle referencing pin configuration of the device.
-
-Optional property:
-  - nuvoton,spix-mode: enable spix-mode for an expansion bus to an ASIC or CPLD.
-
-Aliases:
-- All the FIU controller nodes should be represented in the aliases node using
-  the following format 'fiu{n}' where n is a unique number for the alias.
-  In the NPCM7XX BMC:
-  		fiu0 represent fiu 0 controller
-  		fiu1 represent fiu 3 controller
-  		fiu2 represent fiu x controller
-
-  In the NPCM8XX BMC:
-  		fiu0 represent fiu 0 controller
-  		fiu1 represent fiu 1 controller
-  		fiu2 represent fiu 3 controller
-  		fiu3 represent fiu x controller
-
-Example:
-fiu3: spi@c00000000 {
-	compatible = "nuvoton,npcm750-fiu";
-	#address-cells = <1>;
-	#size-cells = <0>;
-	reg = <0xfb000000 0x1000>, <0x80000000 0x10000000>;
-	reg-names = "control", "memory";
-	clocks = <&clk NPCM7XX_CLK_AHB>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi3_pins>;
-	flash@0 {
-			...
-	};
-};
-
diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.yaml b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.yaml
new file mode 100644
index 000000000000..b12676da7426
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nuvoton,npcm-fiu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Flash Interface Unit (FIU) SPI Controller
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+description: |
+  NPCM FIU supports single, dual and quad communication interface.
+
+  The NPCM7XX supports three FIU modules:
+    FIU0 and FIUx support two chip selects
+    FIU3 supports four chip selects.
+
+  The NPCM8XX supports four FIU modules:
+    FIU0 and FIUx support two chip selects
+    FIU1 and FIU3 support four chip selects.
+
+  Alias convention:
+    The '/aliases' node should define:
+      For NPCM7xx:  fiu0=&fiu0; fiu1=&fiu3; fiu2=&fiux;
+      For NPCM8xx:  fiu0=&fiu0; fiu1=&fiu3; fiu2=&fiux; fiu3=&fiu1;
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-fiu # Poleg NPCM7XX
+      - nuvoton,npcm845-fiu # Arbel NPCM8XX
+
+  reg:
+    minItems: 1
+    items:
+      - description: FIU registers
+      - description: Memory-mapped flash contents (optional)
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: control
+      - const: memory
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  nuvoton,spix-mode:
+    type: boolean
+    description: Enable SPIX mode for an expansion bus to an ASIC or CPLD.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
+    fiu3: spi@c0000000 {
+        compatible = "nuvoton,npcm750-fiu";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0xfb000000 0x1000>,
+              <0x80000000 0x10000000>;
+        reg-names = "control", "memory";
+        clocks = <&clk NPCM7XX_CLK_AHB>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&spi3_pins>;
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+        };
+    };
-- 
2.34.1


