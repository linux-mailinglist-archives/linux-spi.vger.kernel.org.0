Return-Path: <linux-spi+bounces-6381-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2B8A1456A
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 00:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45648188B1B6
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ED4242244;
	Thu, 16 Jan 2025 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uZ29omjN"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301BB22CBDA
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069695; cv=none; b=bUjoDX2mDI/50N5+2UFC6+FDnbGCHPcf/hn+s7QZV67koAODhi1W6V++ZQRJ6LaWExJa6/N5/blFXSIm4WG/I7MPVlAxENX3TCW28FAZa1JJVHNfrfxU9yrePh0ifmnZvruXcxuAR8xLBD3JirtmSxAEWHBRfXeXMV2q9uuiZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069695; c=relaxed/simple;
	bh=GrQ1dOEYG/QwkhK9cDDIQ/lwHCD2HXQ+Be10NTa2QtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oXqm+71Pv54uYs7q/tfdgvIrCja1XILATuACNHilRjoWQMJZr1gl5TcgITsff18oe4QdosqP4cdX4mU5+o0+Jfgl4BjeRcfbtLyul29zJL9m5XEsEv485RpXcTU/aL9H6fF+V2/cvvtWWk1NBnh6NksdjCP6Rv7Owh0YqbrkCC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uZ29omjN; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737069691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7PJS6kM+DJ2GGwqhWw1shA8+yZPnGkjZF8pz2SUSzfI=;
	b=uZ29omjNcU4UbYfhIsF0VAP9GJd018ZmYttfHmmZNzR1FIOC3X6U+Ii7BkAzAI1EUTCAJW
	MCcAyP7yvKL6rQ6AjEcLJNvDpRI0AdQQF4CEnS9BddjgAETgDn5wrADuaE/4/xCo51+h7P
	nBy/dHyVn8tBKSr5Tgr/U6a/Hru5OxM=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: spi: zynqmp-qspi: Split the bus
Date: Thu, 16 Jan 2025 18:21:11 -0500
Message-Id: <20250116232118.2694169-2-sean.anderson@linux.dev>
In-Reply-To: <20250116232118.2694169-1-sean.anderson@linux.dev>
References: <20250116232118.2694169-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This device supports two separate SPI busses: "lower" (SPI0) and "upper"
(SPI1). Each SPI bus has separate clock and data lines, as well as a
hardware-controlled chip select. The current binding does not model this
situation. It exposes one bus, where CS 0 uses the lower bus and the
lower chip select, and CS 1 uses the upper bus and the upper chip
select. It is not possible to use the upper chip select with the lower
bus (or vice versa). GPIO chip selects are unsupported, and there would
be no way to specify which bus to use if they were.

Split the "merged" bus into an upper and lower bus, each with their own
subnodes.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 .../bindings/spi/spi-zynqmp-qspi.yaml         | 43 +++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
index 901e15fcce2d..12c547c4f1ba 100644
--- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
@@ -39,6 +39,18 @@ properties:
   resets:
     maxItems: 1
 
+  spi-lower:
+    type: object
+    $ref: spi-controller.yaml#
+    unevaluatedProperties: false
+    description: The "lower" bus (SPI0). On the ZynqMP this uses MIO pins 0-5.
+
+  spi-upper:
+    type: object
+    $ref: spi-controller.yaml#
+    unevaluatedProperties: false
+    description: The "upper" bus (SPI1). On the ZynqMP this uses MIO pins 7-12.
+
 required:
   - compatible
   - reg
@@ -50,8 +62,6 @@ required:
 unevaluatedProperties: false
 
 allOf:
-  - $ref: spi-controller.yaml#
-
   - if:
       properties:
         compatible:
@@ -75,7 +85,7 @@ examples:
       #address-cells = <2>;
       #size-cells = <2>;
 
-      qspi: spi@ff0f0000 {
+      qspi: spi-controller@ff0f0000 {
         compatible = "xlnx,zynqmp-qspi-1.0";
         clocks = <&zynqmp_clk QSPI_REF>, <&zynqmp_clk LPD_LSBUS>;
         clock-names = "ref_clk", "pclk";
@@ -84,5 +94,32 @@ examples:
         resets = <&zynqmp_reset ZYNQMP_RESET_QSPI>;
         reg = <0x0 0xff0f0000 0x0 0x1000>,
               <0x0 0xc0000000 0x0 0x8000000>;
+
+        spi-lower {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          num-cs = <2>;
+          cs-gpios = <0>, <&gpio 5>;
+
+          flash@0 {
+            reg = <0>;
+            compatible = "jedec,spi-nor";
+          };
+
+          flash@1 {
+            reg = <1>;
+            compatible = "jedec,spi-nor";
+          };
+        };
+
+        spi-upper {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          flash@0 {
+            reg = <0>;
+            compatible = "jedec,spi-nor";
+          };
+        };
       };
     };
-- 
2.35.1.1320.gc452695387.dirty


