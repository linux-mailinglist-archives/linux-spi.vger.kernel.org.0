Return-Path: <linux-spi+bounces-8600-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B12EADBC85
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 00:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4940189300A
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 22:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E4119F42D;
	Mon, 16 Jun 2025 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F91ClS5f"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63C420E01F;
	Mon, 16 Jun 2025 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111278; cv=none; b=FUc+e2Af9DyW7dta2ukupmefEsLHHh+WQCWEFSofvKUUf/dYR+O5i+b6ozliQsPv6MaKkS+tFIRqR+s9258GE8TVvIWvkbxJVNAucPa0moQzE9ImlEoqlKMlIwKILPdgSpHWFpi60Wa6R1HvTJGlV6f+ppQVW+WmI1YsB4Y76Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111278; c=relaxed/simple;
	bh=Vhfy//Tt2j7qdqBp2swhp7LRoCz7fTH1cTzQHky6pzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CsmkiUiIav5+91Iho7eH+Om1gqPO042+Ls5acO+jShZmJnEGbucW8t86WRI6TRaqrp19CDsIkB/poH+yT+ivLQ8AzRpHnGvuAz/AG+c2LSjxSCBHpqtLOydIQGse86xpY+GBmFAXtC/cOp5Q+P1mwFu+agelEUoEjU3uHyq++xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F91ClS5f; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750111273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYNxKYy9tzRuJkdjCisZbvAuwLPriCoPPBBF8f3Xfak=;
	b=F91ClS5fDbY1agTH3+ZLkRlkBQZ4vz/bewBbT8pDW2tFKLX+Y9kaJNWbl5+/LuIdyC1lUV
	lIk4woGYrtDdmMW0/XhZ4A4XlBJ+fXUd/N2Gw7nB+NjzKOqa2n4U36ldOOO1ZA3587NDOl
	lk32sZWaPPtxaE824aC68ydUaZkfA9M=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/9] dt-bindings: spi: zynqmp-qspi: Add example dual upper/lower bus
Date: Mon, 16 Jun 2025 18:00:47 -0400
Message-Id: <20250616220054.3968946-3-sean.anderson@linux.dev>
In-Reply-To: <20250616220054.3968946-1-sean.anderson@linux.dev>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add an example of the spi-buses property showcasing how to have devices
on both the upper and lower buses.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- New

 .../bindings/spi/spi-zynqmp-qspi.yaml         | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
index 02cf1314367b..c6a57fbb9dcf 100644
--- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
@@ -69,7 +69,7 @@ examples:
       #address-cells = <2>;
       #size-cells = <2>;
 
-      qspi: spi@ff0f0000 {
+      qspi: spi-controller@ff0f0000 {
         compatible = "xlnx,zynqmp-qspi-1.0";
         clocks = <&zynqmp_clk 53>, <&zynqmp_clk 82>;
         clock-names = "ref_clk", "pclk";
@@ -77,5 +77,25 @@ examples:
         interrupt-parent = <&gic>;
         reg = <0x0 0xff0f0000 0x0 0x1000>,
               <0x0 0xc0000000 0x0 0x8000000>;
+        num-cs = <3>;
+        cs-gpios = <0>, <0>, <&gpio 5>;
+
+        flash@0 {
+          reg = <0>;
+          spi-buses = <0>;
+          compatible = "jedec,spi-nor";
+        };
+
+        flash@1 {
+          reg = <1>;
+          spi-buses = <1>;
+          compatible = "jedec,spi-nor";
+        };
+
+        flash@2 {
+          reg = <2>;
+          spi-buses = <0>;
+          compatible = "jedec,spi-nor";
+        };
       };
     };
-- 
2.35.1.1320.gc452695387.dirty


