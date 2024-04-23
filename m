Return-Path: <linux-spi+bounces-2470-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1318AE42E
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 13:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51253B21577
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 11:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C3084A2E;
	Tue, 23 Apr 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b="AUxcy6v1"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE447C6DF
	for <linux-spi@vger.kernel.org>; Tue, 23 Apr 2024 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872152; cv=none; b=BcfSZXr/XBs9ZBeJN99pY9Lt2aHRteuUZDtbKBI+A4rfRfqAc04KkmBj0cjQRKFwvCMxSepuNgnZHp/Fd5kLt4Rh4mRNwo2YOhi18KKJyuFBa7sG9v+tV3v2xjoYBblKP5aHnc+h8PL4DPgCbHaNQncjNLWByBbuD2tWPmKj/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872152; c=relaxed/simple;
	bh=ki//Tt205CP3YcLxLRsMRa+b8m19nQ1T9y6zr7KpK04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=huqFRlBpNxhHogfZeVgyl/nBAM7R+FdUj1W6Q1PaMxrYpIyHTNcaJQACzqvhaB3Km3zPnV91EpUw3PESNOoPvDBUg1LfSNENAKKa+TQ7/uN2dZtkJb0f84vApjX292c5/LRDygjtigZipRa0H6xqsVC/2xk612AH4SWjmTuY4cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk; spf=pass smtp.mailfrom=pqrs.dk; dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b=AUxcy6v1; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pqrs.dk
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
	t=1713872147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBFOR6K3nryIYvB1WHqkFDTsIb/yzyHQ+hBKBc86J5I=;
	b=AUxcy6v1mcV8Q23klVD/k0SYtmUfCbYAlb5Fi/g2laDbaZ3/UcLrrAaZnglqLU8vsboOpY
	Oz+TyFsDctq2V6EKfVQ2lYN5KtIEuexFtgGGWuKs61V4S4lkgeuyDptZwOC7gWB/hOo5PW
	P7IvedaOTyuRnL/HxxrjKqActog+hmeIE/r1qciUiyCwHIjpPwcjZ4EajYXD2wwQda/uQI
	z3O143bsl9prKdVvkxJ7P4Bc/dLt7750X0dbLCPHMhNeHVbcjOUT2sCxw0N3y9LAbvAiUv
	gWk3m5GPPeEsfMiKxZTmC89CdRxw1RccWRNww0RL6DBco7l/InhCkxHx2GzglQ==
From: =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date: Tue, 23 Apr 2024 13:35:30 +0200
Subject: [PATCH 1/3] spi: dt-bindings: nxp,sc18is602: convert binding to
 YAML
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-sc18is606-v1-1-094ef37d5a59@bang-olufsen.dk>
References: <20240423-sc18is606-v1-0-094ef37d5a59@bang-olufsen.dk>
In-Reply-To: <20240423-sc18is606-v1-0-094ef37d5a59@bang-olufsen.dk>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Migadu-Flow: FLOW_OUT

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Convert the txt binding to YAML. In the example, the node name was
changed from sc18is603@28 to spi@28 to conform with the standard
$nodename property in the spi-controller.yaml schema.

Make myself maintainer of this binding, since nobody else has
volunteered themselves.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 .../devicetree/bindings/spi/nxp,sc18is602.yaml     | 59 ++++++++++++++++++++++
 .../devicetree/bindings/spi/spi-sc18is602.txt      | 23 ---------
 2 files changed, 59 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/nxp,sc18is602.yaml b/Documentation/devicetree/bindings/spi/nxp,sc18is602.yaml
new file mode 100644
index 000000000000..5b34fdf6148a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nxp,sc18is602.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nxp,sc18is602.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP SC18IS602/602B/603 I2C to SPI bridge
+
+maintainers:
+  - Alvin Šipraga <alsi@bang-olufsen.dk>
+
+properties:
+  compatible:
+    enum:
+      - nxp,sc18is602
+      - nxp,sc18is602b
+      - nxp,sc18is603
+
+  reg:
+    maxItems: 1
+
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      External oscillator clock frequency. Only relevant if the chip has an
+      external oscillator (SC18IS603).
+    default: 7372000
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      not:
+        properties:
+          comptaible:
+            contains:
+              enum:
+                - nxp,sc18is603
+    then:
+      properties:
+        clock-frequency: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      spi@28 {
+        compatible = "nxp,sc18is603";
+        reg = <0x28>;
+        clock-frequency = <14744000>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-sc18is602.txt b/Documentation/devicetree/bindings/spi/spi-sc18is602.txt
deleted file mode 100644
index 02f9033270a2..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-sc18is602.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-NXP SC18IS602/SCIS603
-
-Required properties:
-	- compatible : Should be one of
-		"nxp,sc18is602"
-		"nxp,sc18is602b"
-		"nxp,sc18is603"
-	- reg: I2C bus address
-
-Optional properties:
-	- clock-frequency : external oscillator clock frequency. If not
-	  specified, the SC18IS602 default frequency (7372000) will be used.
-
-The clock-frequency property is relevant and needed only if the chip has an
-external oscillator (SC18IS603).
-
-Example:
-
-	sc18is603@28 {
-		compatible = "nxp,sc18is603";
-		reg = <0x28>;
-		clock-frequency = <14744000>;
-	}

-- 
2.44.0


