Return-Path: <linux-spi+bounces-5229-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1101199D526
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 19:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9A71F21183
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D912F1AD3F6;
	Mon, 14 Oct 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJwgO812"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FFB29CA;
	Mon, 14 Oct 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925332; cv=none; b=FY718Y7ikKrFm1WcrPWDdjY3ZfNL0VjRCTIYT0BGoogEYRloWlq0ENNzDOhOp98RpjfWdmAxEaWzeaLlj/GFW3TlV0bXQjf6B78jY2YtuPWFuNne/+o2E5gUcP28QsUzrF+pS0flBwC2MutxndYabCBfYcUmIrCZBu0DwnL1v2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925332; c=relaxed/simple;
	bh=uZqm/vVvL62S3Ei5w3HeKSAwjQt1+NE5f4nmgTdVDDs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y/bH5/exUB6XabeLXPfxSr4e8SntZqfM/yKpaLASO7gSVD/axque6IDlJ6lRFJQ55YrvGM8mJfp6lnMVxXHyLy0vdb8p6xch8PtDZ0NhM3ybXy9z43A01YRdP0ivFMtxePBvWO8Ca/DXpx0DVyNZKDeIoEuFOlJGs9gd+ks5jAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJwgO812; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso31946495ad.2;
        Mon, 14 Oct 2024 10:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728925330; x=1729530130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxg86KR6sOyXP7avilmE6FsFPoosRZPYDwPpN3nt2Uc=;
        b=PJwgO812AOPqmOKrDQ156JE2MsyUyNB/D17BX1zL4CvSN0JHXyzYlm//YttQX8zK7l
         iL4lAQa1NjIAyitoubdZsp5p7TDmbLfGq6pLwt+8QjqnXOWcTxneQ+baXbRJ6myDpUho
         IY1oI9zYhDrwEE4/cR5Ia7PuU2+Nyfo4nRI5wZpHHK3z3ydV1uuX5B9sZCa+JREr9f1d
         4qrvXQEIKqA+x/62MDRYvvIML4JX8Ae3YC02+H/+f+tpNzp1daBjDuURYypn9tgJ81iM
         yxxOtSbrkAJTixE2KD4l11KmKo3o7fH56M2Wbi8F+0mdXTh3nFNhVxHSpR9jEzvqwj4e
         9WhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728925330; x=1729530130;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxg86KR6sOyXP7avilmE6FsFPoosRZPYDwPpN3nt2Uc=;
        b=Z0N32X5NXQiYx+rrFo2n2XhfADVBux+kn+cKmwWoUBUdRdTnvi+LIEFCYKV79N+8El
         daRhxaiQReG9BMjcFVtzlBf+rqF4b+EUGGjZ/IaT10CUrODGWFqG6zREQsyFDS5VS48n
         Yk3lPVm/8PZRKZ0XD68Ngn5Srg8g/hLkAWD5TXvBZ//9+LU0gG2gNGDJPyrOjRUyMMDp
         CWq3Tvq0A0LXXpNojrOUcduXEivRfg678PXYeeu8peFXqXxNg4DnBjIEbmSjyZUtIzMh
         u/yFrm60ngAXokjX5f4yMknK4Lr6rv5rgfg61Jd2DRLNPThwmvEz82CJK+ErPp3GF6Mt
         bPeA==
X-Forwarded-Encrypted: i=1; AJvYcCWBDzjL3Tq5cCo2hFFmZZRs6/m977a/c8h0gsv9NiCU7/5IMipvpYXaFafS9voX1oLX3cOOZr/ZZf/fn+6V@vger.kernel.org, AJvYcCWvjbjfRx9r8DJYObyS99gUs3pHET26P3VpQeRMz4XS1iNcMIV9W9jyVg/iEoNipXktOMDjkThWtpax@vger.kernel.org, AJvYcCXRfx2UG/i/zQDEb4fOX4JLvCqRQLLGbz6mOm/mv0C1w7bFYI4zYFGWOYYyE0rYL0ZED7fRaxFUoTBh@vger.kernel.org
X-Gm-Message-State: AOJu0YzJDhOmug6Q2gHzGI6G2Zvi+NGKpontHre9bdyY/5QF5NmT8wsc
	Vi1mpeaJHKeyWtmdHpGtkuoYtZhciNB6J0Tan16aisDY01FG7IQA
X-Google-Smtp-Source: AGHT+IGrNaPDXhQd14eA9GwXNdIBi1lCohPeL2NTT8DoIcvH3Sksioy2sSVKcUB2GhWas7pIiNADfg==
X-Received: by 2002:a17:902:ccc6:b0:20c:9eb3:c1ff with SMTP id d9443c01a7336-20ca170f318mr153969845ad.59.1728925330247;
        Mon, 14 Oct 2024 10:02:10 -0700 (PDT)
Received: from Emma ([2401:4900:1c96:4540:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c34aaaasm68567345ad.290.2024.10.14.10.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 10:02:09 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:02:07 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Karan Sanghavi <karansanghvi98@gmail.com>
Subject: [PATCH] dt-bindings: spi: Add bcm2835-aux-spi.yaml file.
Message-ID: <Zw1Oj1utiBJ9Sosg@Emma>
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


