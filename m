Return-Path: <linux-spi+bounces-2802-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74B68C114C
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 16:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A7B1C21DE9
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE435286AE;
	Thu,  9 May 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhU/RhTs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A91BC4B;
	Thu,  9 May 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265340; cv=none; b=rvUavf+xCMb1JvToeGRNwhMIwlyrIvNG47zrhzOp5/p2aqoKPzVf7c5xAjWXzR0/qHXQk6J3nGSkOoyhU7emHSD74FceoojTxjsF3T/6vRGtgyLzLa416fY3gV6Kepw6+RO2h9OGCI3hdNjZz0QvYVyNcYfXX01zpBNBSN9C8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265340; c=relaxed/simple;
	bh=Xo/QXmrEJECpWnLF/8HMnjAV22IuIZrZBS2EqgpPeFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D/qq+qqW+eEvMpqog5ajSoIP5I2wVnO5Iu2GJ2HnD/BFZLBIEtsxPOS2AX0v56/q1Xo/f9y09bZei7HYGNn0eqWA25BtQe/KhaqufYRqHaANmzXrdx6r+EdiSMqRJdSB6dJfNWHAx1lAPnYCNFSc51ZL6z+WUO+Qw0hT3E2OTTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhU/RhTs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2b3646494a8so786229a91.2;
        Thu, 09 May 2024 07:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715265338; x=1715870138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gA0ogyTWt2fnJNAlv1nUD+2IHf95B8pfFbshR4GGuoc=;
        b=BhU/RhTs8v8jWozHpOT1uzBH3NDA5Ju+ItXoEG+PzH1+8kPKB+a5WeS22AhVvFPtOG
         pLNTTRdT7KhpSXzmvAUSRLm9OwD1lPj69qzuhlIMHxHKDOG7aWQ6kD4nrIK12/t/r1he
         WSwkPQvrvakgNsMvwpiU6A1MFo4lQyl0P1k9lIvq5zopazEsMa+R0ufIYyzAuVI2JsJ7
         ecr0FPNeHkKMHE7oTPs/w0zGYYvRTAUDPsHvUepjQicj8g4zF5Sb9z2lyojcZkR45Rbd
         CEF/MoDVkTjxUITGZl+P5bLnJmchZzhJK2NAUpC9+m/R6fbQh2EdJW1erRNn23dzlNFS
         lSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715265338; x=1715870138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gA0ogyTWt2fnJNAlv1nUD+2IHf95B8pfFbshR4GGuoc=;
        b=iLjZ87qUU7FSBUEa4r26QygX+6+O8UNSR7eIUtvgRuOzOYd/bqXS0Q0HoqdFcB4gUW
         MW7sIxBMXjv/MiZf03Ds3gWQwNqoLG1m+k2JH8/XJOv7BST0B/lcr5HhKR9YHltJCLBj
         w3YGYfafZlR1A42TzvS7PzgL9/nlrPXKOc7zvLdjOpDL/3rbb4GSOSuNY2qR/hGrGI+1
         99SWefTy6B8eeyFBuB0a/cEIzFghNEcp0ohFc3wftOtQV5C0tavmhnR/Om2HWXggDFWF
         COcOK5GA5Qzo7pM0x/GHTrBTSg9BsFzCvWvVHtWQ2LIMhoEdmYePpElNn2j/wf1qEXU7
         w3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX06YrN67+3frsLNOppHT9Snn2QhxazrbAZY/HXP8MwxxWN4s6jTsxdBogQ5T7FTcJYwza0Dw6khQoG1AmOr+ZdKgCJYbLpTFO3t+8OiVgWcUTQ6SbiUeZ9O195tgNNJ3HtdVCeCNuLR+oSMKuPx0+o6BvhypBFZOz0EiQtxSpM43bpbA==
X-Gm-Message-State: AOJu0YwCdP/+o+GYPZVNCHUJqtfrA7LoDqOJF5nnKt8ep8P32A3M4H30
	PSoyugQQQXbTk4v+1Xa6f4JJzMK78sp+to0+AqOoe2wXIHeGhKPe
X-Google-Smtp-Source: AGHT+IHhm0ViRq0bmlt+CSqxIwmixOItOKIiYTrSsyETMXUEBycXTkqIsYnk8EeMk8b9oY1LTKmyRg==
X-Received: by 2002:a17:90a:6406:b0:2b6:3034:4ae9 with SMTP id 98e67ed59e1d1-2b630344c42mr4556851a91.35.1715265338454;
        Thu, 09 May 2024 07:35:38 -0700 (PDT)
Received: from localhost.localdomain ([223.178.81.3])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2b5e02ba6dasm2799779a91.1.2024.05.09.07.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:35:37 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Kanak Shilledar <kanakshilledar111@protonmail.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema
Date: Thu,  9 May 2024 20:04:58 +0530
Message-Id: <20240509143501.510509-1-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Broadcom BCM2835 SPI0 controller to newer DT
schema. Created DT schema based on the .txt file which had
`comaptible`, `reg`, `interrupts`, `clocks` as required
properties.
Added GPL-2.0 OR BSD-2-Clause License

Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
---
 .../bindings/spi/brcm,bcm2835-spi.txt         | 23 ---------
 .../bindings/spi/brcm,bcm2835-spi.yaml        | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 23 deletions(-)
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
index 000000000000..bc11e6b65ff6
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/brcm,bcm2835-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2835 SPI0 controller
+
+maintainers:
+  - Kanak Shilledar <kanakshilledar111@protonmail.com>
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


