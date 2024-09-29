Return-Path: <linux-spi+bounces-5027-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1AC989378
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 09:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4708C2832FD
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 07:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FFD84E18;
	Sun, 29 Sep 2024 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEbv6UPB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13271F95A;
	Sun, 29 Sep 2024 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727595499; cv=none; b=ccfEjtcRQLlDondZsWQLJte9UMG/oB/QYUsA9h4Nrvs/7f++eiF9zbL0RzpK0pPKJnS94vSHUNKlNz04D41xw3s2ZSrcZcoiIOqqt76Z8Y5zp3RIFUonusZYTO7LoicVt3PJxk1amGlzTB5VQ4SgWdXINfKOrEGqphA70gbHky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727595499; c=relaxed/simple;
	bh=uZqm/vVvL62S3Ei5w3HeKSAwjQt1+NE5f4nmgTdVDDs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X9w2O1yHQqmTiUTJKOz2NmgaIQ7ub1HIvWoACbo2ES28ZxMpE4k/gnNXEe1jeXobAesuhGXMsagyc7Lv6CxTAekkPcv4JTiiWtVfnPSz8uEsY0g0JMz/LYVtG7zNmHNTGvRiQlwPzFmbD0Gy4pmHIhLFCOw3yJqOMUDjxpt5M80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEbv6UPB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2054feabfc3so32385505ad.1;
        Sun, 29 Sep 2024 00:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727595497; x=1728200297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxg86KR6sOyXP7avilmE6FsFPoosRZPYDwPpN3nt2Uc=;
        b=LEbv6UPBLVPzr1HT9FX/rAjAE24c5PnqpAQ8w+PY5h/Wbf+8etQuKfLPtn3a7FukYH
         LHI8L0rfeggFNkfliZvGaFvzJc4NtFM47yAK9ahYNeCb0p9W1kBKu/77QNwGpsMwm39k
         H+paBo896f4NM888YqDHK2rmWHREiTGsjMiwOsPm62F7dS9WhlzlgR33+riFlSO9hODy
         Jd3nNx3UItys1cfYrgDhTWU9aBU7eK3MvXVHPIYcH4PTftJMKMGWR4YDhl07hdizjhLu
         UObiQpOmfQX4bEep4C9JnFOnCQYJKXbHbO2ruqa0bA8e7WJxD7G0rWozNVLr+7apc6M+
         udyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727595497; x=1728200297;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxg86KR6sOyXP7avilmE6FsFPoosRZPYDwPpN3nt2Uc=;
        b=akgnYGcYZliiw3Zf2nn9Wm6qwff7zn4G8HTwFKXmIHiOb+z9BNXMe7nDeIpYdcQaxk
         7ySJahFJGSyFj1EWjOyiUXsAJ6xXos9er8CYX31mL3/lcpxYSHL7aMDkcADPvOqeIVQS
         fOWx28TMQsJ6AOcfsrk/1DJ8CQJkJU4UmJ6e0gdMEctnlvj9NZBnR4mkM0aK/kcM/DCF
         FksP22HhYgSklr1vclO1W7iep+D3MhqJ6iclp0GU/xNPyRkaAEmnolZ+NBDJUNrm/9V3
         qZlJT5dDjbtrXbCeGbHZVn0BpbHG0zzQolIe8ZUTPpDJcnoQdJTHU1johcJQlGubOGv6
         YX8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXfep4AEVH0635wFouqz+FLsk1ktvHEDnXQr77RTPPXrnZ+/KWTPDivc2+JYvxle+RpG9KaVrYbVHn@vger.kernel.org, AJvYcCW8gGq/wpOOpty/sGfYpPk/JHNT4Dpqc5FFygE2u8HIhNqv7NoSTO1pX4npo0YfUBVwD0lJBS9If5j+@vger.kernel.org, AJvYcCWrmjGiZ/F/gUQTSCH45O3TYRFe+qyaNQXjfBzhXhMVjWVB5qtOmrpZpuz6mqHZ/dmJ5y/zlTQyL6MjZaUc@vger.kernel.org
X-Gm-Message-State: AOJu0YxgQqtP4SxBCTk2TTuzxwi/r6kS8MbsSKyFyj3n31zhWzB/PeOl
	HMjCObEP+lmtzqbTD6YsAPJMIVaGA3v3YyqfWB55gl/qaiXesWNr
X-Google-Smtp-Source: AGHT+IHnOei7oW47GqQ4k3VZSvkF4bqNfH1Cv9JrR9elGwyRf8ai7bXn1hMNSk4j4aZ424fYn3rplg==
X-Received: by 2002:a17:902:f691:b0:206:ae88:417f with SMTP id d9443c01a7336-20b367ca60bmr151796385ad.6.1727595496728;
        Sun, 29 Sep 2024 00:38:16 -0700 (PDT)
Received: from Emma ([2401:4900:1c97:3972:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e577edsm35910455ad.263.2024.09.29.00.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 00:38:16 -0700 (PDT)
Date: Sun, 29 Sep 2024 07:22:37 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup <anupnewsmail@gmail.com>
Subject: [PATCH] dt-bindings: spi: Add bcm2835-aux-spi.yaml file.
Message-ID: <ZvkAPUoa96GHPnZE@Emma>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Converted the brcm,bcm2835-aux-spi.txt file to
its respective yaml file format.

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---

While running
make CHECK_DTBS=y broadcom/bcm2711-rpi-4-b.dtb,
I encountered an error related to the compatible property
for brcm,bcm2835-aux-spi. To resolve this, I converted the
text file to a YAML binding file and checked it with

make dt_binding_check DT_SCHEMA_FILES=brcm,bcm2835-aux-spi.yaml

and

make CHECK_DTBS=y broadcom/bcm2711-rpi-4-b.dtb

and generates no error.

However, I have a question regarding the cs-gpios property.
The BCM2711 datasheet mentions that each Universal SPI
Master has 3 independent chip selects. I’m wondering
if this means these chip select (CS) pins are native,
or if we still need to attach GPIOs to them.
If GPIOs are required for these 3 CS pins,
does that mean we also need to include them in the
device tree schema? and also as arequired property in
binding?

 .../bindings/spi/brcm,bcm2835-aux-spi.txt     | 38 -----------
 .../bindings/spi/brcm,bcm2835-aux-spi.yaml    | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
deleted file mode 100644
index d7668f41b03b..000000000000
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
index 000000000000..4c24cf2fe214
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
@@ -0,0 +1,66 @@
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
+description: |
+  The BCM2835 contains two forms of SPI master controller. One is known simply as
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
+    description: Broadcom BCM2835 Auxiliary SPI controller for SPI1 and SPI2.
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Reference to the auxiliary clock driver for the BCM2835.
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
+
+  - |
+    #include <dt-bindings/clock/bcm2835-aux.h>
+    spi@7e2150c0 {
+        compatible = "brcm,bcm2835-aux-spi";
+        reg = <0x7e2150c0 0x40>;
+        interrupts = <1 29>;
+        clocks = <&aux_clocks BCM2835_AUX_CLOCK_SPI2>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+
-- 
2.43.0


