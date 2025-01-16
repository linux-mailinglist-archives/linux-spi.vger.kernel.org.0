Return-Path: <linux-spi+bounces-6388-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51C9A1457E
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 00:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB42A168056
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70E4244FB2;
	Thu, 16 Jan 2025 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I5ESkJp7"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5F0244FA9
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069707; cv=none; b=D4355yBAC0fdcxCz1OYit3FzxkVf2N2B1ewuSY5JebJ/19lcRZfI2g14mjvlhz+mxLQiS6JVhg4UbihfPH/qWpSm2uLC9C/CJUv7FNWkYVXF45/Wwn7lskB9JbIfx9Tjr2KEK+5z8K6cD5da+ikkAXpTcDyL2O5nT5YDVGIYbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069707; c=relaxed/simple;
	bh=UQpviLb6rFo0Nakm4Q7xmYgcU6KPPAhHi2AiICH1T/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zzvd+hs16bBMPV4GgpP9ehWwyzos8q60tmKvW0byyZIMnXtnupvXbriCzTEdGJX+620IQWNuSBk6FExWA6crIt9Li1Kj7nAnA6sv8R+RedjllaFLYyeZ7VGa9LCFOfOb/fiDxd7vqUC72/0nsfpAoKXEbVHMIBRpNNbEHLhgXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I5ESkJp7; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737069703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y9p6ibc/bj3AV8FXwHT1h+AI01HJG79MMwLbgeY3aY=;
	b=I5ESkJp7jccj+p7MTg/3SaqOFMdzqlC543kNhuKXyIO5ET2tSkUSKe4SclpJmgArTud0qH
	rVfVlL921C/RGjRtFB+PYcyrGq5sPHZbegg5CffrVDVyF1PVBsKx2d5Zk19i9Sa6UGtjgy
	8xPc/CE0qvORpLcVkAYDDRHzUhMCkZQ=
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
Subject: [PATCH 7/7] ARM64: xilinx: zynqmp: Convert to split QSPI bus
Date: Thu, 16 Jan 2025 18:21:17 -0500
Message-Id: <20250116232118.2694169-8-sean.anderson@linux.dev>
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

Convert the ZynqMP devicetrees to use the split QSPI bus binding. This
is pretty simple, since all boards use only CS0.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts |  5 ++++-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts |  5 ++++-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts |  5 ++++-
 .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts   |  5 ++++-
 .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts   |  5 ++++-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts |  5 ++++-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts |  5 ++++-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts |  5 ++++-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts |  5 ++++-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts |  5 ++++-
 .../arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts |  5 ++++-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi            | 15 +++++++++++----
 12 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index bfa7ea6b9224..64b90de5b4ce 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -35,7 +35,7 @@ aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &dcc;
-		spi0 = &qspi;
+		spi0 = &qspi_lower;
 		spi1 = &spi0;
 		spi2 = &spi1;
 		usb0 = &usb0;
@@ -129,6 +129,9 @@ mux {
 
 &qspi { /* MIO 0-5 - U143 */
 	status = "okay";
+};
+
+&qspi_lower {
 	spi_flash: flash@0 { /* MT25QU512A */
 		compatible = "jedec,spi-nor"; /* 64MB */
 		reg = <0>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
index 04079d1704f1..8927e0463cf4 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
@@ -19,7 +19,7 @@ / {
 	aliases {
 		serial0 = &uart0;
 		serial1 = &dcc;
-		spi0 = &qspi;
+		spi0 = &qspi_lower;
 	};
 
 	chosen {
@@ -39,6 +39,9 @@ &dcc {
 
 &qspi {
 	status = "okay";
+};
+
+&qspi_lower {
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
index 3dec57cf18be..da07b58706f0 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
@@ -20,7 +20,7 @@ / {
 	aliases {
 		serial0 = &uart0;
 		serial1 = &dcc;
-		spi0 = &qspi;
+		spi0 = &qspi_lower;
 	};
 
 	chosen {
@@ -40,6 +40,9 @@ &dcc {
 
 &qspi {
 	status = "okay";
+};
+
+&qspi_lower {
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index 6aff22d43361..ec570d68a4ae 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -27,7 +27,7 @@ aliases {
 		mmc1 = &sdhci1;
 		rtc0 = &rtc;
 		serial0 = &uart0;
-		spi0 = &qspi;
+		spi0 = &qspi_lower;
 		usb0 = &usb0;
 	};
 
@@ -354,6 +354,9 @@ &psgtr {
 
 &qspi {
 	status = "okay";
+};
+
+&qspi_lower {
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* Micron MT25QU512ABB8ESF */
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
index 6ec1d9813973..e1cfdc0db51e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
@@ -26,7 +26,7 @@ aliases {
 		rtc0 = &rtc;
 		serial0 = &uart0;
 		serial1 = &uart1;
-		spi0 = &qspi;
+		spi0 = &qspi_lower;
 	};
 
 	chosen {
@@ -172,6 +172,9 @@ &i2c1 {
 
 &qspi {
 	status = "okay";
+};
+
+&qspi_lower {
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 7e26489a1539..18e323e2aad7 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -31,7 +31,7 @@ aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &dcc;
-		spi0 = &qspi;
+		spi0 = &qspi_lower;
 		usb0 = &usb0;
 	};
 
@@ -953,6 +953,9 @@ &psgtr {
 
 &qspi {
 	status = "okay";
+};
+
+&qspi_lower {
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 16MB + 16MB */
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index eb2090673ec1..026053c4116a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -29,7 +29,7 @@ aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &dcc;
-		spi0 = &qspi;
+		spi0 = &qspi_lower;
 		usb0 = &usb0;
 	};
 
@@ -439,6 +439,9 @@ &psgtr {
 
 &qspi {
 	status = "okay";
+};
+
+&qspi_lower {
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* n25q512a 128MiB */
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index 4694d0a841f1..da56e532dc2b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -29,7 +29,7 @@ aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &dcc;
-		spi0 = &qspi;
+		spi0 = &qspi_lower;
 		usb0 = &usb0;
 	};
 
@@ -451,6 +451,9 @@ &psgtr {
 
 &qspi {
 	status = "okay";
+};
+
+&qspi_lower {
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* n25q512a 128MiB */
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 7beedd730f94..8dd73b035969 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -31,7 +31,7 @@ aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &dcc;
-		spi0 = &qspi;
+		spi0 = &qspi_lower;
 		usb0 = &usb0;
 	};
 
@@ -959,6 +959,9 @@ &psgtr {
 
 &qspi {
 	status = "okay";
+};
+
+&qspi_lower {
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 16MB + 16MB */
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index b67ff7ecf3c3..9ed7972c3b4e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -30,7 +30,7 @@ aliases {
 		rtc0 = &rtc;
 		serial0 = &uart0;
 		serial1 = &dcc;
-		spi0 = &qspi;
+		spi0 = &qspi_lower;
 		usb0 = &usb0;
 	};
 
@@ -789,6 +789,9 @@ &psgtr {
 
 &qspi {
 	status = "okay";
+};
+
+&qspi_lower {
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 16MB + 16MB */
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
index a38c2baeba6c..99d007b3bfae 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
@@ -20,7 +20,7 @@ / {
 	aliases {
 		serial0 = &uart0;
 		serial1 = &dcc;
-		spi0 = &qspi;
+		spi0 = &qspi_lower;
 	};
 
 	chosen {
@@ -44,6 +44,9 @@ &gpio {
 
 &qspi {
 	status = "okay";
+};
+
+&qspi_lower {
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor";
 		reg = <0x0>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 5dac0542a48d..470e0b90382f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -972,21 +972,28 @@ pcie_intc: legacy-interrupt-controller {
 			};
 		};
 
-		qspi: spi@ff0f0000 {
+		qspi: spi-controller@ff0f0000 {
 			bootph-all;
 			compatible = "xlnx,zynqmp-qspi-1.0";
 			status = "disabled";
 			clock-names = "ref_clk", "pclk";
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
-			num-cs = <1>;
 			reg = <0x0 0xff0f0000 0x0 0x1000>,
 			      <0x0 0xc0000000 0x0 0x8000000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			/* iommus = <&smmu 0x873>; */
 			power-domains = <&zynqmp_firmware PD_QSPI>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_QSPI>;
+
+			qspi_lower: spi-lower {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			qspi_upper: spi-upper {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		psgtr: phy@fd400000 {
-- 
2.35.1.1320.gc452695387.dirty


