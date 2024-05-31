Return-Path: <linux-spi+bounces-3172-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 250278D61BC
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 14:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9E61F276EE
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 12:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D061158206;
	Fri, 31 May 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCbOfWAv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632C142E90;
	Fri, 31 May 2024 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158613; cv=none; b=UitnJAwQuXnE18zLtkOCgr8wpe/ByP30CoKMqlYSIGkf5LdZO3KLwQWFaIqA98bYY0CHWmwFCh0qiYVedpYTOaw19m8A+qoyl6cRdb0ilIWfXtQfNStbBqXdaRFhNV8aDizRPAwHQLxbmOBXrEcxSr8W1HySN6YtW8FEsF6WxWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158613; c=relaxed/simple;
	bh=BKqXlZK7XF1UJpzIlE4H+vLXVZQDJHc91wlqO8+Qta4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dB89G+LFTH4Nzbr58o/ghQ0FrEcPr4AqolC5gH/KWvUShLv56qlXowgPuwWC2R1792g/nFfrpzl8HC95EzI69AxdLZquYIA1OxbeERk652RPIzY4qBjf2ThOm3Elk5gFdc9syd1vSyaG4sNF3dZIajlJvAsUiupoLicr1kvFQpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCbOfWAv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f8ec7e054dso1505793b3a.2;
        Fri, 31 May 2024 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717158611; x=1717763411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=forXuWPFy2XsVfocDJuDgmCjaOGTlPxEs7gWnYosGQU=;
        b=VCbOfWAv5HAjKMSduSiicoUrrSfl+0KNea+HySys2ems0r+eZbg0UUuqg64b5oYpo8
         5sXTWbHslsEkAGGkaLkZ+cMrq7gsrG0uOdBW/bsl3oOKrpakBKq4Hwr87dp1/E2PawB/
         3TBdjgcgRisKm+/289qYFmMnpHFi6QHv7+mcoV0Uz0RWTXWKzd/uERAZVauPyZMLEfuT
         NWFwyTyDjfqRuPLZHV7HmH1Ffns9qmPNCG158SyK1zif6YbHZFPlqNsn6fAHqmfsfN3z
         DfMpmRiqjOPq2HqKMqcV1e1X8mpPJZYuEaRhYq/Od5Rs5F2Zyy+1UFj395NPlgCNyPRV
         8BJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717158611; x=1717763411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=forXuWPFy2XsVfocDJuDgmCjaOGTlPxEs7gWnYosGQU=;
        b=c0wP7qpxV5dSkUDiQ1/MzvYslFjZoW/eI3D2lfcEoZzptKGv0u6fn5RV1IGGBTqNNT
         A76t36ZeuM1rPR5Ki/+R/NCxmHJnKL8twXlvM5gE4sgZY8cihwAJLU3U52vnNiMpMXYi
         /WtKktXB9ANk1TN8mftg+VjxRftrxS/EW71tvxFYh7uknD8HGBmdN0I6tgp67j0S7HF2
         L+FPvPHyqh72bNZ1q8QNrLVt3fzlI7F3awYuUhHDSrwYh2AEX02Sx89Or0JztEkmfBBZ
         vt918esJnwKkcDYJZeKEHrzvI6HcpvdaRJsvGvRvFtwOanulILxnm1eta5bTSzKi30hI
         La1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAbAl8dtXrjKXvMSug+pCCoGSN6CjE5qZ8hfBMEUomPzHKE3bj6bHPtAifrT64J5UUzCZaoNVfego9uN1ytmuFUL1Wt+EXkJkBTWAhv2H1c3PC0vt3onkH3EeOe95qdHMTJwNs+hGwbvaDSHS/BhNAlL6dDhykDscE70ChBSk+nBS9SA==
X-Gm-Message-State: AOJu0Yycc6kraZFbJff9nnvXwvKdIrufC2DELczAU4HN9h5AqpsgXD6l
	x+DH1zq8GXXybyf4n6xjp3Ks7/sAKzGTjAE520r7xtKZ6448d0J2
X-Google-Smtp-Source: AGHT+IHrSpIGiBHstlMPdxkIWgAD6jVOeR2hwOCG67G+LZyMrCJvZ6auiVBIez1jv5QaTvEr+Bv3AQ==
X-Received: by 2002:a05:6a00:1a91:b0:702:3174:c03d with SMTP id d2e1a72fcca58-702477bd7aemr1741085b3a.7.1717158610682;
        Fri, 31 May 2024 05:30:10 -0700 (PDT)
Received: from localhost.localdomain ([223.178.85.118])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70242ae88casm1280863b3a.125.2024.05.31.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 05:30:09 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
X-Google-Original-From: Kanak Shilledar <kanakshilledar111@protonmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar@gmail.com>,
	Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND v3] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema
Date: Fri, 31 May 2024 17:59:37 +0530
Message-Id: <20240531122941.3524-1-kanakshilledar111@protonmail.com>
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


