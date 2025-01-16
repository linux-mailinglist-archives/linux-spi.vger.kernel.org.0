Return-Path: <linux-spi+bounces-6376-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFAAA144DA
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8994188A3B8
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 22:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9363C22F3B4;
	Thu, 16 Jan 2025 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G5ILOaLW"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11EE18A6A8
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068140; cv=none; b=f+FBeD7DATfv7mgSkNmpm31fOVd69oZJim1Zp/f0aGtYaJDvoi9iF3ssaYfmN9CtchyZHoDcQ5nSCClFwNhSROR37yzRgEFZL1oXjxT2l+onwy72OIfDDrm/6BY6h+qMC/4jIgz4sxpR38Rs/Ha36FD65BuNAm2vrAmbZhsp9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068140; c=relaxed/simple;
	bh=hUXs6LILra9jbW4eVbc1ZvdB/92/mHOgKG067hYliAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q5lhhTmydDiaFRo86SWKA1kbLDnVYldX2A6ImHD/n29K+v4Znjv0kkedQicZvUn2II6ebysOEJRxmON0FE+wgor4kjRlrtVPJsWCPWQU2tOVgT0LABIBlHGarez1reZclj0SCSfeBf7f1bn0MFIYZ+b9mTkS9Vkpajil8mjAbX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G5ILOaLW; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737068134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SzhM/Cr/Vt/YQ+Zr0i1+zKtZFp4IFfQdz9T0ezUL7Xo=;
	b=G5ILOaLW37eG2x8g9HsqxICmTElAyMnTR2Jl+XD+EYxSkDF9IRY4XsRCMro0vtN8h4NkL7
	gvlxUfET2ipfpkFMv+0UZ4d+a58V2kHh2k+trC6Y0vz2T3ZNCiQJJFD0mk0+uFNoWELZ7i
	J+emAHK3hJNGhg5794Hs++Ny7F6Tk04=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: spi: zynqmp-qspi: Add reset
Date: Thu, 16 Jan 2025 17:55:17 -0500
Message-Id: <20250116225521.2688224-2-sean.anderson@linux.dev>
In-Reply-To: <20250116225521.2688224-1-sean.anderson@linux.dev>
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a reset to help recover from cancelled operations.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
index 04d4d3b4916d..901e15fcce2d 100644
--- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
@@ -36,12 +36,16 @@ properties:
   power-domains:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
   - interrupts
   - clock-names
   - clocks
+  - resets
 
 unevaluatedProperties: false
 
@@ -66,6 +70,7 @@ allOf:
 examples:
   - |
     #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
+    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
     soc {
       #address-cells = <2>;
       #size-cells = <2>;
@@ -76,6 +81,7 @@ examples:
         clock-names = "ref_clk", "pclk";
         interrupts = <0 15 4>;
         interrupt-parent = <&gic>;
+        resets = <&zynqmp_reset ZYNQMP_RESET_QSPI>;
         reg = <0x0 0xff0f0000 0x0 0x1000>,
               <0x0 0xc0000000 0x0 0x8000000>;
       };
-- 
2.35.1.1320.gc452695387.dirty


