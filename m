Return-Path: <linux-spi+bounces-8057-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5DEAB2524
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 21:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E93E1B663F8
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 19:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF92367B7;
	Sat, 10 May 2025 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt13jA0b"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4119B3CB;
	Sat, 10 May 2025 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746906176; cv=none; b=oYNGVBwzRcoaJ84NQLgkGbxqNjVCTVKbF4H5R7PL8am9sWzziDA4InfJbTRj/naKx+uXoljrGWSgkeoSyHZKSHY1tcpMnqYM7c/EHUyD59ni03Pgqxe3XNyt2vy3pk5WJMGjtgqej/NbEL4X90dT03NQjmGGj9u7lnhPbCZ5UIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746906176; c=relaxed/simple;
	bh=mMLcIpsEhoq8UdQQpLuognQnHIyH8ycLrQgiuLuYhxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JzU/bIt7g7J00vpyAzypdAPJA2XnYUqA2//09axiiSSXKte8N8+PRHMnwSoGiPsGbxaP9q0ustxE9TRJXEhnXN1gEWkTWfPFDozSG7NCJIVf4T5uzq8fGA26LqRCB50TxGZoIl9lt87eRapcEYw5Xe971lSeNP5hamjzePsHQ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jt13jA0b; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30a8cbddce3so2794177a91.1;
        Sat, 10 May 2025 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746906173; x=1747510973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajRywws6lD8KHlYjxWd9Od+zJbHSPGQcC6B7Bpdbzrc=;
        b=jt13jA0bt4V9AGLhS2Ln7jBlIxkYuGlgGTntKmn/fXu2uYUFIMn+SPKITi3Kqz37Zw
         OJra1FrU/4nicOoFQQ1wsgQVrttVR4xff2DyVYHfRS6ELe70cgSJZpXCnm7T2Nf0quHk
         bhYgzrSUvQbohk/B9qrhu/izl3AZGpU64fHvyFhfIX59R7I+Nl8ef6ttxzl1EyhJEHH4
         Ai/poxGnKyJkMj3eHLd2n8QqB3aGCxLomaJoMH+nYFTjeW/OCHgjvycrNX5JaTq1JCIt
         ZowkgDyHY7Lk2d6u5tOv5mzHUED+e9aXoDQyhM0KDWWaiThYy9LGdw3HkaMYvj86iJIJ
         A67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746906173; x=1747510973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajRywws6lD8KHlYjxWd9Od+zJbHSPGQcC6B7Bpdbzrc=;
        b=PedjOXczyvVtSciha7qvbvtoc/MGMnpzWXtAe44XdAthVE+PuOJX0V4Ag9B9M9m6zU
         J/wrJCE4fnGLAY7AI50h96dtufV7VHF1Utq112Tiv9KfIA8YcuWG4ItiN73+na8V3OVJ
         pReFJzT5lCnFC6Gqwt9wvLerORybyCRAU9PPvfS+L+GU4kBnO8a4X91wa04enVn5FeW2
         BqgSaPPcbIHJprxo10iAN+d1bXYMpUHY/T7sxkxmKOHsTrJci/Z9PblZK+BOUl4uDE/M
         i1SxUKbzCpuKEFALKAugZeEJ3CZ6PQsCc32nz/pt4QfmjZdcVJ8Ril2znDCnNOSrmea6
         aLVg==
X-Forwarded-Encrypted: i=1; AJvYcCUKPeU6piESBwerO+4A7UXT5Tqk3HQxQQsSVXMIDbp+GvDjoojCuI5MkgukaPrnYEVM6gWfCI2iiRFJ5Wvo@vger.kernel.org, AJvYcCXD5cviyJWXq8AeXKhxsscXzB76mV4e7wHQTZ+CKfjpush6j5SacxXjABcHlY/HMEf4MdH4ABNoWG62@vger.kernel.org
X-Gm-Message-State: AOJu0YwPifvzpXZZXnZcZQR7VIBCuDikNgTYvrKiL3UsDc9Mc+R2KUXQ
	nLlhsdONLVERkU2KqjZ9QC/RSvJ2eIpVgygg11A0zyvgOrZ8vcnf
X-Gm-Gg: ASbGnctM+8vAEtfDhAOD/g75dzv1m7BZcpB58GbcV58xxAjhUoio2DLy8vIvu4g2dSV
	zhZxmyujodFj6Bo+Pw2Te0a1yxHLEw7x/EaaO+6l750Pw8xb9qhpOnP9lfjgQKcKp2BQ2zMikwR
	D4eQVBUzNxwpqfl4hPK0mGXlZ1xHsa9gKfbAqHPoFArZIASXMzcQRomyEj9GY9kqLN9luvWuLuq
	cafN6tChPq4iYeeJIodBNhPYiEUy5D45AkrgXaLELaspBf0IQDlE0LHZk9lFnmBUoydHxYaI7QV
	dD7Ha3o3CKWLcpX0pHVpKTom+98+WgPHHVdcJAOahJbJppqjyJEHDOJ/VuKQlbU=
X-Google-Smtp-Source: AGHT+IHF/6vAuUa2FDr0Jh21aQSSYaG/h9piroxVtpPE5qcBaQXlPgMlxHqaDut6EeR4ncYQAZR0jQ==
X-Received: by 2002:a17:90b:390f:b0:2ee:ee5e:42fb with SMTP id 98e67ed59e1d1-30c3cff29ddmr12950783a91.13.1746906173489;
        Sat, 10 May 2025 12:42:53 -0700 (PDT)
Received: from NB-GIGA003.letovo.school ([5.194.95.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2523e67d53sm2223670a12.19.2025.05.10.12.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 12:42:53 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Sat, 10 May 2025 23:42:21 +0400
Subject: [PATCH 1/3] dt-bindings: spi: Add VIA/WonderMedia serial flash
 controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-wmt-sflash-v1-1-02a1ac6adf12@gmail.com>
References: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
In-Reply-To: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746906149; l=4940;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=mMLcIpsEhoq8UdQQpLuognQnHIyH8ycLrQgiuLuYhxs=;
 b=qVbf4RLXYHvpthPaLv01NOrHydUepNylWyn5bR8XeTaRW3QuUOwUcom2Wc7juU8PLY+eUEjZ3
 AzqsQn1ud4KD1jQxQL29PwhpRzDUazDtepjXqcyy8fbVOkMuAmp9j/c
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

Add a binding for the serial flash controller found on VIA/WonderMedia
SoCs, which provides semi-transparent access to SPI NOR chips by
mapping their contents to the physical CPU address space.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 .../devicetree/bindings/spi/via,vt8500-sflash.yaml | 122 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 123 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/via,vt8500-sflash.yaml b/Documentation/devicetree/bindings/spi/via,vt8500-sflash.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..d2ea0dacdd56118c0cb5a1cb510ceb7591e1e5ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/via,vt8500-sflash.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/via,vt8500-sflash.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VIA/WonderMedia serial flash controller
+
+description:
+  This controller is used on VIA/WonderMedia SoCs such as VIA VT8500,
+  WonderMedia WM8850 and similar. It provides a semi-transparent interface
+  for reading and writing SPI NOR chip contents via a physical memory map,
+  abstracting away all SPI communication, while also providing a direct
+  mechanism for issuing "programmable commands" to the underlying SPI chip
+
+maintainers:
+  - Alexey Charkov <alchark@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - via,vt8500-sflash
+      - wm,wm8505-sflash
+      - wm,wm8650-sflash
+      - wm,wm8750-sflash
+      - wm,wm8850-sflash
+
+  reg:
+    items:
+      - description: MMIO registers region of the controller
+      - description:
+          Physical memory region within which the controller will map the
+          flash contents of chip 0 for reading and writing. If the flash
+          size is smaller than this region, it will be mapped at its end.
+          Note that if this chip is used as the boot device (as is most
+          often the case), the boot ROM maps it at the very end of the
+          CPU address space (i.e. ending at 0xffffffff)
+      - description:
+          Physical memory region within which the controller will map the
+          flash contents of chip 1 for reading and writing. If the flash
+          size is smaller than this region, it will be mapped at its end
+
+  reg-names:
+    items:
+      - const: io
+      - const: chip0-mmap
+      - const: chip1-mmap
+
+  clocks:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^flash@[0-1]$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 1
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
+    sflash: spi-nor-controller@d8002000 {
+        compatible = "wm,wm8850-sflash";
+        reg = <0xd8002000 0x400>,
+              <0xff800000 0x800000>,
+              <0xef800000 0x800000>;
+        reg-names = "io", "chip0-mmap", "chip1-mmap";
+        clocks = <&clksf>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            reg = <0>;
+
+            partitions {
+                compatible = "fixed-partitions";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                partition@0 {
+                    label = "U-boot";
+                    reg = <0 0x50000>;
+                    read-only;
+                };
+
+                partition@1 {
+                    label = "U-boot environment 1";
+                    reg = <0x50000 0x10000>;
+                };
+
+                partition@2 {
+                    label = "U-boot environment 2";
+                    reg = <0x60000 0x10000>;
+                };
+
+                partition@3 {
+                    label = "W-load";
+                    reg = <0x70000 0x10000>;
+                    read-only;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 6dbdf02d6b0c9357ad1da520a0f6c16b7f38f879..f09c457bbfc5ef71a3f8379c111bac52b767cbbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3475,6 +3475,7 @@ F:	Documentation/devicetree/bindings/hwinfo/via,vt8500-scc-id.yaml
 F:	Documentation/devicetree/bindings/i2c/wm,wm8505-i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/via,vt8500-intc.yaml
 F:	Documentation/devicetree/bindings/pwm/via,vt8500-pwm.yaml
+F:	Documentation/devicetree/bindings/spi/via,vt8500-sflash.yaml
 F:	arch/arm/boot/dts/vt8500/
 F:	arch/arm/mach-vt8500/
 F:	drivers/clocksource/timer-vt8500.c

-- 
2.49.0


