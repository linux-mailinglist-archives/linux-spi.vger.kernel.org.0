Return-Path: <linux-spi+bounces-5247-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09589A1208
	for <lists+linux-spi@lfdr.de>; Wed, 16 Oct 2024 20:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6903B1F2199B
	for <lists+linux-spi@lfdr.de>; Wed, 16 Oct 2024 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB9420C009;
	Wed, 16 Oct 2024 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4dD2MHY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7E18DF97;
	Wed, 16 Oct 2024 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104848; cv=none; b=k+Ng1bNFrdEOUXkeU06K/xWpuAzH4TXpB0NHg3VnCkJ+je7sJSOgTAmNq6x1vk4FVKJhHcRmBD0f8VbCWso8al8zH0tK3EpplLbKBAmxdIYZun+MCSt9mu4zcgyxC0eTqT8/m/OYCC4Dtzd29sVKwOiF1nc7Sw15Sf2hgrU7SEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104848; c=relaxed/simple;
	bh=LauhmpdfjKVxohaWUWRIdDCAVcbZX4SRGZMXO5IqS/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jkp8u37Y4p0Tl5UNaNIWgfT1HSHXXJKcNcIHPxH+AJQnCo/jq/Ks/LU2uVWmRDU4JX1hZTZ85OCG6+bSHHMoF7cydV2GQwNboLJQqa53pa1t+1RllBm2FNwBX0r9l44eZiWHOYc0mWY31/egI5vgvxM3bdJVxOfUEXT22jOPP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4dD2MHY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c693b68f5so1551785ad.1;
        Wed, 16 Oct 2024 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729104846; x=1729709646; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1WEbBQ2/i7lkFW0aLtN2j+zp34lAewWd7prOWA+b1kM=;
        b=K4dD2MHYJVBqbdB9biaUDopgUeJD5RvYujLTCO3HFrTF4BTtB3N3vZb07e16Lm9kVq
         r36Bz2kF65QGCn0uW71BqJVeDkVZd/ggwmkwLByCNRZR7snfGOu+EgK6IFEyqklLFCua
         fMPTgFRs4pi9p0Oa73mMCBkr+zCsJKU8eGHq/XT1CWwcLgiNGWP48r9jT6CDe/1ymCTe
         PRZhGQr4pwtHnNUPG8F+j1Y2Ze9HGqsQRrBbedM/R+etVR68V0HDH5KFncKHVrWfav0w
         BAC0i3qmS2PQt0ymnWkGBzRgM6zguuTka6H+rqUHkDnzcFlIHxu5u45rlkoYH8esw7FM
         kfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729104846; x=1729709646;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WEbBQ2/i7lkFW0aLtN2j+zp34lAewWd7prOWA+b1kM=;
        b=eIWI8XgH0WnxIkiFeG2hXFmSadKy9PvyMT3aJlwkC81PIzgnp/+ifGzCfCFCeg2POX
         QadL4N8n4MCWDa93wC3ThhT9fj8warLCVBOW9k/b2F/LiNUmRLnDLAddXs5rQMNYWMGs
         3w5XXBYBi2BQT6RVBU7rhKS+KutzLhEN8UGbn55DWCQ5tsa/9X3kvlZ0wEtO0rEPYiFu
         ih4CWQg0rD0tg71jqCQR3oC/3qswdEVO4PC2IT0PhSGykFOa0LmSBK0jI4VgVUy0mjAc
         qqzrS7UP4BT4+S3P///cKn4hEpUlm5jf9SGtTd2gbYwUCs3haR+mJjRdeZrOJevTqwmz
         Chdg==
X-Forwarded-Encrypted: i=1; AJvYcCUCPd7+fitHC6J6b6qdvoQk21bWiiGBf9jxlqQrxzItw3GlJQLbv4vGPZMCYu2T4mpkgE0ltsoJuQilUBZf@vger.kernel.org, AJvYcCUEWRsVAZwNYRcbQkBGbq3qukwE4xGLZ2Rh3X2V3p4CVdfXdx+QlJpiBLLBeMWoreK1PTQZqUM2Vy2X@vger.kernel.org, AJvYcCUKCoTZVnhDb6sAWm0Dy9OUCi5yAc/sSIrxB9jo/XgOApG/DXg8H8rRWh/CDmSVTFa6ilNPoqVI+typ@vger.kernel.org
X-Gm-Message-State: AOJu0YyxXn5bzcFkdKkTEfoCdwQYwoc34mHWOXZdPRShxv8tL2D7TKyd
	+QGHNiwJJXIuRRl5M49gSa7+xE6dpB/N9xxSHIb0SLzVcJB0t1bk
X-Google-Smtp-Source: AGHT+IFNUMYvFYf4p3MkHE6cA9zg4WL2xzIDxgXIGOqB3badx678F5VvqdOq/3/xoTfYOzgxjR4ntA==
X-Received: by 2002:a17:903:120a:b0:205:3e6d:9949 with SMTP id d9443c01a7336-20ca16be7demr281535785ad.52.1729104846268;
        Wed, 16 Oct 2024 11:54:06 -0700 (PDT)
Received: from Emma ([2401:4900:1c97:c88d:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805e56bsm31733715ad.286.2024.10.16.11.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:54:05 -0700 (PDT)
Date: Wed, 16 Oct 2024 18:54:03 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Karan Sanghavi <karansanghvi98@gmail.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup <anupnewsmail@gmail.com>
Subject: [PATCH v3] dt-bindings: spi: Convert to dtschema
Message-ID: <ZxALy6p8m9eS9uIW@Emma>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert bcm2835-aux-spi binding to Dt schema

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---

Changes since V2:
 - Modified the Patch subject
 - Removed unnecessary description and example

 .../bindings/spi/brcm,bcm2835-aux-spi.txt     | 38 --------------
 .../bindings/spi/brcm,bcm2835-aux-spi.yaml    | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
deleted file mode 100644
index d7668f41b..000000000
--- a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-Broadcom BCM2835 auxiliary SPI1/2 controller
-
-The BCM2835 contains two forms of SPI master controller, one known simply as
-SPI0, and the other known as the "Universal SPI Master"; part of the
-auxiliary block. This binding applies to the SPI1/2 controller.
-
-Required properties:
-- compatible: Should be "brcm,bcm2835-aux-spi".
-- reg: Should contain register location and length for the spi block
-- interrupts: Should contain shared interrupt of the aux block
-- clocks: The clock feeding the SPI controller - needs to
-	  point to the auxiliary clock driver of the bcm2835,
-	  as this clock will enable the output gate for the specific
-	  clock.
-- cs-gpios: the cs-gpios (native cs is NOT supported)
-	    see also spi-bus.txt
-
-Example:
-
-spi1@7e215080 {
-	compatible = "brcm,bcm2835-aux-spi";
-	reg = <0x7e215080 0x40>;
-	interrupts = <1 29>;
-	clocks = <&aux_clocks BCM2835_AUX_CLOCK_SPI1>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	cs-gpios = <&gpio 18>, <&gpio 17>, <&gpio 16>;
-};
-
-spi2@7e2150c0 {
-	compatible = "brcm,bcm2835-aux-spi";
-	reg = <0x7e2150c0 0x40>;
-	interrupts = <1 29>;
-	clocks = <&aux_clocks BCM2835_AUX_CLOCK_SPI2>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	cs-gpios = <&gpio 43>, <&gpio 44>, <&gpio 45>;
-};
diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
new file mode 100644
index 000000000..351019d68
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/brcm,bcm2835-aux-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2835 Auxiliary SPI1/2 Controller
+
+maintainers:
+  - Karan Sanghavi <karansanghvi98@gmail.com>
+
+description: The BCM2835 contains two forms of SPI master controller. One is known simply as
+  SPI0, and the other as the "Universal SPI Master," part of the auxiliary block.
+  This binding applies to the SPI1 and SPI2 auxiliary controllers.
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm2835-aux-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/bcm2835-aux.h>
+    spi@7e215080 {
+        compatible = "brcm,bcm2835-aux-spi";
+        reg = <0x7e215080 0x40>;
+        interrupts = <1 29>;
+        clocks = <&aux_clocks BCM2835_AUX_CLOCK_SPI1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.43.0


