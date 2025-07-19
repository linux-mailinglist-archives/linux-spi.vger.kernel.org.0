Return-Path: <linux-spi+bounces-9127-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D95EB0AE31
	for <lists+linux-spi@lfdr.de>; Sat, 19 Jul 2025 08:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC65584CA7
	for <lists+linux-spi@lfdr.de>; Sat, 19 Jul 2025 06:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9DE22DFA6;
	Sat, 19 Jul 2025 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="hp6+YCbj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF12288F9;
	Sat, 19 Jul 2025 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752906873; cv=none; b=ZukzXx5RfjiRizclJwsUFoOHii5W+1p3QYbZYjI0NriYwh6jQ8cCtlLMt8P8HrrULuIPYcRFrN93VeEStxQdDC+1mM4PMUvQVBgUPG6rpBqiIx259D2toB5Gk3Y6jCMtvGdbmh4X9qMp54zpm3RA9w4uD1TxHEqkRCAijiGvoII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752906873; c=relaxed/simple;
	bh=Cts4p0Q/oHC3LzZpBAvfSy4d3fhXG/mDthrN8Ts63fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=clRQW9LYMl5SNjMJ2Vy3NlJPOaTJ7MPxhNdlfnYtMsoYw8TumTU+K2qcikv552DKQ4fZJFygGCC+KLLMLYMIUh3QgVbg1IEsVERWFdjPqrZu9lI5rqHzOrcF050Wy6puJg46PywnWS2wrO6dINVYJ8jTRRc8NmBbqk+O7GiWYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=hp6+YCbj; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 526971026E9A1;
	Sat, 19 Jul 2025 08:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752906870; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=YPr66/zoW/Ul/rXlgG2lDYhfvi+t7ldJNuTap5nuaxU=;
	b=hp6+YCbjFFY2U5Gwhax9VTCclYxIMm0AKxAahjJorZwCA7MTaTgi0KmfOFLpukgPfr4iM4
	ABAEcvMXuiiYX44WKPFY3Gq267xJKc1n+8Zqg0+BlYS7pBDsDBqMPDvEwbfY6dIJhiacS5
	8e590CPgoRwpnyzkTDCXMt79ux5JV0F2GxzI1uGuLeI0cktXiFekcc82PIrzynzrwWoM0u
	CLR29A8d8+inoIGGu5HyLhPCCA2rzFWvd68lZo4FbNY2UxHjEdTMvzytZe6O7MvAfby1J4
	9emCzF6cnbdWFqHiLK4UNcspLQkKFqWBiqvzmmNK/v656z7rfwNaU8I6swLWjA==
From: Heiko Schocher <hs@denx.de>
To: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Schocher <hs@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 3/3] arm64: dts: imx8mp: add ABB spi sensors
Date: Sat, 19 Jul 2025 08:33:54 +0200
Message-Id: <20250719063355.73111-4-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250719063355.73111-1-hs@denx.de>
References: <20250719063355.73111-1-hs@denx.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

add for the spi busses the ABB sensor trivial compatible
entry, so they can be accessed from userspace.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 .../freescale/imx8mp-aristainetos3-helios.dts | 28 +++++++++++++++++++
 .../imx8mp-aristainetos3-proton2s.dts         | 22 +++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dts b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dts
index a4e649a8239b..b6ba6229acd7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-helios.dts
@@ -52,6 +52,34 @@
 	};
 };
 
+&ecspi1 {
+	spidev0_0: spi@0 {
+		reg = <0>;
+		compatible = "abb,spi-sensor";
+		spi-max-frequency = <54000000>;
+	};
+
+	spidev0_1: spi@1 {
+		compatible = "abb,spi-sensor";
+		reg = <1>;
+		spi-max-frequency = <54000000>;
+	};
+};
+
+&ecspi2 {
+	spidev1_0: spi@0 {
+		reg = <0>;
+		compatible = "abb,spi-sensor";
+		spi-max-frequency = <54000000>;
+	};
+
+	spidev1_1: spi@1 {
+		reg = <1>;
+		compatible = "abb,spi-sensor";
+		spi-max-frequency = <54000000>;
+	};
+};
+
 &ethphy1 {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dts b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dts
index 2a736dbe96b4..e804688b2e74 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-aristainetos3-proton2s.dts
@@ -28,6 +28,28 @@
 	};
 };
 
+&ecspi1 {
+	spidev0_0: spi@0 {
+		compatible = "abb,spi-sensor";
+		reg = <0>;
+		spi-max-frequency = <54000000>;
+	};
+
+	spidev0_1: spi@1 {
+		compatible = "abb,spi-sensor";
+		reg = <1>;
+		spi-max-frequency = <54000000>;
+	};
+};
+
+&ecspi2 {
+	spidev1_0: spi@0 {
+		compatible = "abb,spi-sensor";
+		reg = <0>;
+		spi-max-frequency = <54000000>;
+	};
+};
+
 &ethphy1 {
 	status = "disabled";
 };
-- 
2.20.1


