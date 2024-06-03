Return-Path: <linux-spi+bounces-3199-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997948D87F6
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 19:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFFD28A5F8
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 17:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D86136E28;
	Mon,  3 Jun 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWST56TI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6248F14294;
	Mon,  3 Jun 2024 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717435866; cv=none; b=nYdrHoY3KTNS/7bOcD+C4jfM1bbFXGH5Ci1Xig8PBTRk8x6kJE+mbopQeZznjCx/aenIVxCugxLiyryZnLcOf/cQT25XhidbD10Yvz4P3PDYqvx0VDPhbeZllk00I5HqudBo61BnpZfgx88Xtkx5Fp5Bfwse44bBPUexTSzziy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717435866; c=relaxed/simple;
	bh=pwSV0zPCmCA2tn7dOrG5bx7PQ9nHY8IAveWJEcyA5FM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o3XdcLD85tGKCHMCuHhpZWaT0nKRMZrvlBMvXyHNOPzBAwRIoUbPWUqKViPRwPdDNPv2zAUd7B+qQGFameNO7MxinJXaRCSOCn11qAbTAoZc96GCNrRO8kP/XDwYBzwhfgJ3Lj5+MH32GMtxGlkro/tanKfcsa+JQM0hAgQTmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWST56TI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f48b825d8cso1749075ad.2;
        Mon, 03 Jun 2024 10:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717435863; x=1718040663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BlqejD3GqjO+jh/6mutibFwYSOg/CEmaS2z9WmEzOgI=;
        b=PWST56TIq4r8Q5gT2ot1cZHCH73wSVMLyrX/ch3Zkinqo7SDs3cN2sfBXb+xh4Okti
         C0C6XzvY7kHDMLhZ06ngPiv2nVnbL5ARayvckC2oYefcnTdv/JR0iX5UJsemm7RDBBn6
         elnFeWObvFHv4gxfVKdPTg//tR68OPmVaLMxDtUOIt+oYnK66AlL8BrOPsZqIgfTgW9n
         EjY6i5qdDlVDjtxmMviwtCkxWGgdmdqbs03uXm+861+KmG3RsZ66QMVyjF3CGnLrG6Bb
         TRcl0XFsspt1Wcz45mIk22rvtdDgwIO4Uxf8IMI+snYku/pf6Gz9FXkrNp3araLwYWsO
         uV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717435863; x=1718040663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlqejD3GqjO+jh/6mutibFwYSOg/CEmaS2z9WmEzOgI=;
        b=kVKHl0M/1VN8UhI54TzCO90uMJCnS3l8o5xXW56ndJ2b8QJPWS8BO/4faGFULBXzZi
         EyUv06gqsQWhNIGC16snraTbjFVrwVTwwYHVhEuU3GWVZbR8P/221bfDuo3lqgxfFYHC
         tf5ALxrcwqU3KSoQvdGnhZXk4KtKsSqBQwRYc+JuFLQ+CDphZV5Iic6oqfqlFa11JlSv
         UCCP2Ym1MmlMsGfNKwEFlscjNfBiUDmcGylH5L+1XZ7kVcmlYkDSvhW8bVQ9wW45dOZk
         z5VXpWw/JBZQSwWBsassvLR+zVdRogxAzY8N8ubYuwvHDZUZlMGAmQTFmqV8a1LeIveq
         f6ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXTIbLEA5MS1btZgSfPyeAwYDM5+uK+pirXVEhwSWdgyexnUMqgfY7XMQal+KF3DN11IU66t4JeyuiZ05cIAZozmLRiT5HFbVsAAvc6rKJFMw+JnADLj+ALW3bWIBffO8MCE9otW7GwAaV7n8irTrIC8olqWO9hSCEUV4kNE/NtG/UVyA==
X-Gm-Message-State: AOJu0Yzq1q4P5Po4V/xIcadQCyJN+QNQ8hPOtyjaY+YICw9VYTyr6KSM
	Sg4na8IDb3bBRBhjt3079Ci+WQVEL5vjOQkrKRqEE+2Zfdt8l4Q8
X-Google-Smtp-Source: AGHT+IFuMod0eixSR8fmXTpn1C9vn/hUhfkZtnab8m1tGC1c71CU5vfPjYQlBFE59rUzGaq7KoRiRw==
X-Received: by 2002:a17:902:ea02:b0:1f6:6a9c:895e with SMTP id d9443c01a7336-1f66a9c8c1bmr55707485ad.65.1717435863352;
        Mon, 03 Jun 2024 10:31:03 -0700 (PDT)
Received: from localhost.localdomain ([223.178.83.142])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f632338ca4sm67272015ad.50.2024.06.03.10.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 10:31:02 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
X-Google-Original-From: Kanak Shilledar <kanakshilledar111@protonmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND v3] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema
Date: Mon,  3 Jun 2024 23:00:23 +0530
Message-Id: <20240603173028.2787-1-kanakshilledar111@protonmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kanak Shilledar <kanakshilledar@gmail.com>

Convert the Broadcom BCM2835 SPI0 controller to newer DT
schema. Created DT schema based on the .txt file which had
`comaptible`, `reg`, `interrupts`, `clocks` as required
properties.
Added GPL-2.0 OR BSD-2-Clause License

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Kanak Shilledar <kanakshilledar111@protonmail.com>
---
Changes in v3:
- Updated DCO email address
Changes in v2:
- Updated the maintainers
---
 .../bindings/spi/brcm,bcm2835-spi.txt         | 23 ---------
 .../bindings/spi/brcm,bcm2835-spi.yaml        | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
deleted file mode 100644
index 3d55dd64b1be..000000000000
--- a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Broadcom BCM2835 SPI0 controller
-
-The BCM2835 contains two forms of SPI master controller, one known simply as
-SPI0, and the other known as the "Universal SPI Master"; part of the
-auxiliary block. This binding applies to the SPI0 controller.
-
-Required properties:
-- compatible: Should be one of "brcm,bcm2835-spi" for BCM2835/2836/2837 or
-  "brcm,bcm2711-spi" for BCM2711 or "brcm,bcm7211-spi" for BCM7211.
-- reg: Should contain register location and length.
-- interrupts: Should contain interrupt.
-- clocks: The clock feeding the SPI controller.
-
-Example:
-
-spi@20204000 {
-	compatible = "brcm,bcm2835-spi";
-	reg = <0x7e204000 0x1000>;
-	interrupts = <2 22>;
-	clocks = <&clk_spi>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-};
diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
new file mode 100644
index 000000000000..94da68792194
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/brcm,bcm2835-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2835 SPI0 controller
+
+maintainers:
+  - Florian Fainelli <florian.fainelli@broadcom.com>
+  - Kanak Shilledar <kanakshilledar111@protonmail.com>
+  - Stefan Wahren <wahrenst@gmx.net>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm2835-spi
+      - brcm,bcm2711-spi
+      - brcm,bcm7211-spi
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
+    spi@20204000 {
+        compatible = "brcm,bcm2835-spi";
+        reg = <0x7e204000 0x1000>;
+        interrupts = <2 22>;
+        clocks = <&clk_spi>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.34.1


