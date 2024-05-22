Return-Path: <linux-spi+bounces-2997-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB818CC21B
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 15:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2421C20D36
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 13:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3215813E05B;
	Wed, 22 May 2024 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYkfFYb0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2AF442F;
	Wed, 22 May 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384547; cv=none; b=rEBPiNXC4sOdKmX93bM6tQvZJV4+2vgyAL0RFY65fAXe8Bsf4+Kd/dQF22UsXMkF2DU35OQ3zsJvEx4sgY2bxW9JMqWsl1SGllUBmYNgQNBH/hXgqDAWZ0G4i6sRanx7BW7cKiHoiixggDYHyCgcIcfAIVDAsoelox6OsgnFiMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384547; c=relaxed/simple;
	bh=wxaOmOUCkS1lix74mx1Jccpu5z2WpUnMXkHaPkATNUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNufGvdKR8rHyYsDudtuO5iGByOrKH4n85uW9PpS/UKX76ictt9bDqPGmZG53kJRh9nHMZ2Q8/GmSsmpUHIfFL7e1C0lrzww8IF0uTlzUE+PPF48aW64BbrWonq3ZTnXNbE0JJYotLBJU2pNNCRyRFY1w4HD6WML2iMr7jnRZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYkfFYb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAC1C2BD11;
	Wed, 22 May 2024 13:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716384546;
	bh=wxaOmOUCkS1lix74mx1Jccpu5z2WpUnMXkHaPkATNUI=;
	h=From:To:Cc:Subject:Date:From;
	b=uYkfFYb0u9vU3AUnhJ8XzskCsxvwQSvZnnnEDuWi/zm+NI93BcT5IRrJLwIB8sMVE
	 sTwme/G0E96z5rCwOQh96MgxPitB52A5xKKtF9zkFy0M7W7DOcEUBr2nqlaMlpN16T
	 czZLxAuMMOv4WlNtBRYOXBLrKClkzapSh178OEOSQQlUp3w6XlD8c0e8Gz5oTi9S5G
	 2/Qtb52JtM8xflVmzL4SF7RWk7Bqod+WijNWnBRC80bZk/lZPX+HQBhKgMlxP6rt9S
	 YyFzPUL4h+sgPoENpL+ihwp39ufuli9RGKS+nTUh7NsgfymT24laX4ZBwAd0Y+vh7l
	 Eo//B8KXerjYw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: marvell,mmp2-ssp: Merge PXA SSP into schema
Date: Wed, 22 May 2024 08:28:58 -0500
Message-ID: <20240522132859.3146335-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Marvell PXA SSP block is the same or similiar to the MMP2 variant.
The only difference in the binding is the PXA version supports DMA (and
that's probably a binding difference rather than an actual h/w
difference).

The old binding didn't belong under 'serial' as it is not a UART. The
SSP block also supports audio devices, so 'spi' is not a perfect fit
either. As the existing schema for MMP2 is there, just leave things
as-is.

The examples in the old text binding were pretty out of sync with
reality. 'clock-names' and 'ssp-id' aren't documented nor used.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/serial/mrvl,pxa-ssp.txt          | 64 -------------------
 .../bindings/spi/marvell,mmp2-ssp.yaml        | 35 ++++++++--
 2 files changed, 31 insertions(+), 68 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt

diff --git a/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt b/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
deleted file mode 100644
index d10cc06c0c37..000000000000
--- a/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
+++ /dev/null
@@ -1,64 +0,0 @@
-Device tree bindings for Marvell PXA SSP ports
-
-Required properties:
-
-	- compatible:	Must be one of
-				mrvl,pxa25x-ssp
-				mvrl,pxa25x-nssp
-				mrvl,pxa27x-ssp
-				mrvl,pxa3xx-ssp
-				mvrl,pxa168-ssp
-				mrvl,pxa910-ssp
-				mrvl,ce4100-ssp
-
-	- reg:		The memory base
-	- dmas:		Two dma phandles, one for rx, one for tx
-	- dma-names:	Must be "rx", "tx"
-
-
-Example for PXA3xx:
-
-	ssp0: ssp@41000000 {
-		compatible = "mrvl,pxa3xx-ssp";
-		reg = <0x41000000 0x40>;
-		ssp-id = <1>;
-		interrupts = <24>;
-		clock-names = "pxa27x-ssp.0";
-		dmas = <&dma 13
-			&dma 14>;
-		dma-names = "rx", "tx";
-	};
-
-	ssp1: ssp@41700000 {
-		compatible = "mrvl,pxa3xx-ssp";
-		reg = <0x41700000 0x40>;
-		ssp-id = <2>;
-		interrupts = <16>;
-		clock-names = "pxa27x-ssp.1";
-		dmas = <&dma 15
-			&dma 16>;
-		dma-names = "rx", "tx";
-	};
-
-	ssp2: ssp@41900000 {
-		compatibl3 = "mrvl,pxa3xx-ssp";
-		reg = <0x41900000 0x40>;
-		ssp-id = <3>;
-		interrupts = <0>;
-		clock-names = "pxa27x-ssp.2";
-		dmas = <&dma 66
-			&dma 67>;
-		dma-names = "rx", "tx";
-	};
-
-	ssp3: ssp@41a00000 {
-		compatible = "mrvl,pxa3xx-ssp";
-		reg = <0x41a00000 0x40>;
-		ssp-id = <4>;
-		interrupts = <13>;
-		clock-names = "pxa27x-ssp.3";
-		dmas = <&dma 2
-			&dma 3>;
-		dma-names = "rx", "tx";
-	};
-
diff --git a/Documentation/devicetree/bindings/spi/marvell,mmp2-ssp.yaml b/Documentation/devicetree/bindings/spi/marvell,mmp2-ssp.yaml
index 5f4f6b5615d0..0a1bada8f800 100644
--- a/Documentation/devicetree/bindings/spi/marvell,mmp2-ssp.yaml
+++ b/Documentation/devicetree/bindings/spi/marvell,mmp2-ssp.yaml
@@ -10,12 +10,17 @@ title: PXA2xx SSP SPI Controller
 maintainers:
   - Lubomir Rintel <lkundrak@v3.sk>
 
-allOf:
-  - $ref: spi-controller.yaml#
-
 properties:
   compatible:
-    const: marvell,mmp2-ssp
+    enum:
+      - marvell,mmp2-ssp
+      - mrvl,ce4100-ssp
+      - mvrl,pxa168-ssp
+      - mrvl,pxa25x-ssp
+      - mvrl,pxa25x-nssp
+      - mrvl,pxa27x-ssp
+      - mrvl,pxa3xx-ssp
+      - mrvl,pxa910-ssp
 
   interrupts:
     maxItems: 1
@@ -26,6 +31,16 @@ properties:
   clocks:
     maxItems: 1
 
+  dmas:
+    items:
+      - description: Receive DMA
+      - description: Transmit DMA
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
   ready-gpios:
     description: |
       GPIO used to signal a SPI master that the FIFO is filled and we're
@@ -41,6 +56,18 @@ required:
 dependencies:
   ready-gpios: [ spi-slave ]
 
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: marvell,mmp2-ssp
+    then:
+      properties:
+        dmas: false
+        dma-names: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0


