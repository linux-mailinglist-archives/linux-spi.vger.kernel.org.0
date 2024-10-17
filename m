Return-Path: <linux-spi+bounces-5249-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EDC9A25F3
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2024 17:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7994D2835D1
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2024 15:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C971DDC32;
	Thu, 17 Oct 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsq2WW3U"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531DF1BFE18;
	Thu, 17 Oct 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177346; cv=none; b=g8SP5ioRjGMrDHt+lUTgAHVniIwTNFFaHzUqRufiflOCubmr5YtCTWCKakcCd0ni+orTZIuW2O2vHHPyMPRUFm763D+iHu2xj8LFz/I8k5rlojOCRGNGBRZWRfOV1DQGx2GALoElf8ED2mpqESOaMOXa0nzbaFxWr1en/dNpRGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177346; c=relaxed/simple;
	bh=maVqKFchcKc6Nh4ZD/SW3IcciAmTUh1JeZhmxEcLEkg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iqeB7BFC0V+SRymLCHsP05ipyD1sAgk/tIuzbd4wedX2aWVTGLOmOScB0gN0LQSHYP8WCS97qVnbUTNWhYAyuknH5hsTQMkowWk1aV9vAD5X88N4h76Kz+3QNfCEg1dwaVhfyjj3utT06h33h6oCHNL7PxTSZZ1OqsyAff0mtDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsq2WW3U; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso775541b3a.2;
        Thu, 17 Oct 2024 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729177340; x=1729782140; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbTepaupxmjTIi44JHiVOejj/VBl6pEdVxqjDmlhRUs=;
        b=dsq2WW3UONPd9I54efgFEzyIY3oZOIAbMxl9jHHaLNR+TEYv+2/9ZFjnksfNZE6mUO
         np6qLDO0pcCH66tjj7+CoBK+oDg6UXGWt5gz8ZbSEaZz1BbUnWNxR9SiElzLnfWmqAHn
         7J5TSeKvQlCJpINBTpfUtHfds2dBwant2pdd1lEOvNl5qvv6R8iLkDwmsFrapO1FrUGW
         ix78nsPxrNVS0qkLx91UXr9RTqTrLRZwevXuU2Uq4KVQ1ER8PD6BELkMABhD1i2sViJj
         mQ6x/PPIPNYKhDsr0H0JyWxaVZFxhdFQlRzakdbZdFhBmVZwwH4UHYO+LnlAKV5ETyyR
         Ojcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729177340; x=1729782140;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbTepaupxmjTIi44JHiVOejj/VBl6pEdVxqjDmlhRUs=;
        b=HwxvGyTCmsCjRUYwcFRvsQNvGDUbMeiOYV0yPJNm/DhfH4EaONJgTs0v+ses7MsTvy
         FB8iQRUgBvSXiO04dG/pqx15tZ5E1xxp4M3vj6pUsWCtaVDt8udC4soa/d423+sqwB5T
         lP/UuCYq5u177RILdwdCShVms+LnuBV3L55sYdo5xHxel1Y94qGDZcZj5QDCpTLe1qos
         I+LihG0PhJtsP1kjvKA/G2JpXi+FSLQl48embwxUACU3gr9nVVlR8iuIAQGfUoVb36+f
         8fGuWx8GN5XW8rX9agqFTmBJR2Ra96v1eeb8sBM3USlu9Rom1KmY907eRgGDla8cqv9b
         aVSg==
X-Forwarded-Encrypted: i=1; AJvYcCU4S5KkTj2hr1flD6VvEtjrwTc+UwM1vSjDSM5kTuWLPZtDSb2ytvA4CKb/cUduqKhA65uACKB3awTb@vger.kernel.org, AJvYcCU4cdomp/YKurvQYkHO4npzrwpVAMduXvR3BRyJ+UKfr9QTIPcFcUX8jnBAqnfC25vMZ5hMvZxn4cuo@vger.kernel.org, AJvYcCXAvZb9pgNgl4wE3YhN1goYd3XgjAHj3TCAFG2naIjHdCI1KaDsADtaYxS82jx8btTqsa6JoCWP4BEUNh9P@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6V9F0CvPzRFVAijclFvAkcgqVUB0jBDjQ9APURZUrnZTkisSy
	1DnIrKdhlq419S+3e/MYWW/+Pa1UtOo8AJ9KeE1Htw+3Hv+wHqJ8
X-Google-Smtp-Source: AGHT+IFsfvLVFEbRGcztXFhYtd+BhQrK0AtsjOFGGM8AyzG1oCWj10f8ehC+PZ4ZYN6vG21JfEzzUw==
X-Received: by 2002:a05:6a21:6b86:b0:1d9:a1c:70a7 with SMTP id adf61e73a8af0-1d90a1c71a9mr8497972637.48.1729177340206;
        Thu, 17 Oct 2024 08:02:20 -0700 (PDT)
Received: from Emma ([2401:4900:1c97:c88d:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c715d7dsm5049956a12.88.2024.10.17.08.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 08:02:19 -0700 (PDT)
Date: Thu, 17 Oct 2024 15:02:16 +0000
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
Subject: [PATCH v4] spi: dt-bindings: brcm,bcm2835-aux-spi: Convert to
 dtschema
Message-ID: <ZxEm-H-PjlQyXeOH@Emma>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert bcm2835-aux-spi binding to Dt schema

Changes since v3:
 - Updated the patch subject line
 - Reformatted the description to fit within 80 characters

Changes since V2:
 - Modified the Patch subject
 - Removed unnecessary description and example

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/spi/brcm,bcm2835-aux-spi.txt     | 38 -------------
 .../bindings/spi/brcm,bcm2835-aux-spi.yaml    | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 38 deletions(-)
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
index 000000000..6df060778
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
@@ -0,0 +1,53 @@
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
+description:
+  The BCM2835 contains two forms of SPI master controller. One is known simply
+  as SPI0, and the other as the "Universal SPI Master," which is part of the
+  auxiliary block. This binding applies to the SPI1 and SPI2 auxiliary
+  controllers.
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


