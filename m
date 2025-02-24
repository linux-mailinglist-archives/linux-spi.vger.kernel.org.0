Return-Path: <linux-spi+bounces-6889-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C83AA41A86
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 11:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3AE1638AF
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F70224BC1E;
	Mon, 24 Feb 2025 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANhZ/cMv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65EE24BC0A;
	Mon, 24 Feb 2025 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391992; cv=none; b=uY7oopoNL6/cAS2ZpquEeM+E2DzwNASk4zOk35EnkIN29ysGFmYyy7lpeGPubsC60ToEYyaeef1iwiWnkAVXk9YD2LJlmeZ7R6EjeREqCZLKrHdf2IyCvCyT/rfTJ/8cwto5fU1xcVtFGe8Vrcs6iIAmpAvmo37kI3VV0/Ydsv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391992; c=relaxed/simple;
	bh=DI/yU4Ha2m1hI+3q6R4XXFjNeHmAswCQiwUL6XQGzvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6tJlMVf4oCABlT8aJvmvRzwI5kN5Uxot4A+r80KSG14WjXWvloD9XZE0MoycajPSJCoUaqD536z2uKeKJUboOeU2y444M+aZwIy4O7LYZ0jm8eHAt8XcN2xyFa7FG0o/uHYSNBpL2hMWGZDgcl/OuKqGDA3kyvSvOazD63KMHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANhZ/cMv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220c92c857aso70403905ad.0;
        Mon, 24 Feb 2025 02:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740391990; x=1740996790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHH1Bo2ngh238ZBojTHJqWRsImuzKw7MT/RetGGhdDs=;
        b=ANhZ/cMvZ1icLHUAXCg5sBBZhh1Pz6FcKQtbDxhm5w8tyIftjY82UPQU3XSUUw8onI
         bfsYCtubJPzXG3N7fNRqW9uWQg13wV3NWI6sFIr5fYti8FRhnMrC7ZyRMgFwIOMY3VNy
         S7rLWQ8oNabPSLpHSzKzlnl8jX1cBxkjP5l/WEI1UbKY2J7uAUqkbupvwxddl+JwdY5U
         IwtOG5UhVh6kqkX9nqXbzM0fyyy7aZ1N42L67GYNMUdR1t8I7nuXi+RCgFWeqGoV3GLL
         WJ763RFfIAsNq8xeD1JBMK9AMzf+Xj7p90/nX5OBY34BXoaF1eMZiwKMFeGpPbMYdLOC
         zJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391990; x=1740996790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHH1Bo2ngh238ZBojTHJqWRsImuzKw7MT/RetGGhdDs=;
        b=VGy45ci9GYa9yf9s9bWDfUXtYfLyk1gUAO+FwrzdvFWcn3AwTfTFnqMUS2C6vi+9DH
         vbzAnby9ob4ZbiOtlz3xZQwN65IAXsdSGFKr/EhH+jjYcdxZF+KX4ISU3J95fSWiYB02
         Y4vVQnpSc1uSuFIOP068weE+HWUKUbc+V4Ns8t0/k+EqG6G1Krd0Y8cwkLXeFe9Bo2lH
         iehF5UQvrH0FJ2kKZp6ohb74rIYQYlf79rJWi4c2M0ZZxYTb+JWauO2noV1J/srRK5QS
         i7/q0ee0ZGGGzMXsEAtkVgu2jx6tG337Gpsklif1ZGkmtbCZZ8I9L58/pMQe//MVKm0R
         qgDA==
X-Forwarded-Encrypted: i=1; AJvYcCWX97s2tya25EUAVGiGoONgungrEn/gho4stETH+kxCVRoyGM1BU7TfQwkVMrkYlAbBDHFuBu7zo5ha@vger.kernel.org, AJvYcCWw8eB/BhU8g+JiXhAcx12P2tB9+zpmpMmiDFTYHjreDwGe19jOLCCr9QeQRSmJW7PwjtnxV8YcqE0u@vger.kernel.org, AJvYcCXAr1HB9Zt9gcU0CYU2qw9mMSyatt9CBU8OctZWZikaTKkCsy6V7+j1x+6xSAW3N+CPn9TSO/FIKbqPHJlC@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQ3bRYpiciAFAAN5HwC4Rwy0bAHUlA48td4ERV8kWZ1QUSBna
	GVRxa79Bgbo0Gj/SUX+Jgiq30QlQM2WXMvfkCoYb4qF0sg28zPwp
X-Gm-Gg: ASbGncvyzBbLByd8Z1TjPnisJq0E57L0AaStLlC3nvdCZGa2C8fqZJOPefGqcRkY/UG
	nvYLVOBikb+NFuDx41j4v2zmQC+9fKtkoRyzc5hq9dEeTl5k3A1e96HAkXy2oXljezE5Dbcs+t2
	MJQw6CgKGouCDQntpSTRqF5GyJi1FvNn0uZkttay2UB38aDCMIwbS/1Zs9lNZ3G5y90N1xuQREJ
	Zj/1aVs7DSGwssjr2yVLcaqlruSUDyCpb2JFrWTsMaXceWiCjsodwwGFqupKaX5wz8SnWmBVsPE
	ofgHciH99zgv/hCV+aeL
X-Google-Smtp-Source: AGHT+IGtCyZFRUi+gbIX4aSNZJGXzCxJh7yxdOzB199I7UFF6fkdtprcsgYmp8oGaKiLKViiu8/0JA==
X-Received: by 2002:a17:902:f547:b0:215:6c5f:d142 with SMTP id d9443c01a7336-2219fff87c0mr224305655ad.20.1740391990140;
        Mon, 24 Feb 2025 02:13:10 -0800 (PST)
Received: from cu.. ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d7a464f1sm173274365ad.206.2025.02.24.02.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:13:09 -0800 (PST)
From: Longbin Li <looong.bin@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Longbin Li <looong.bin@gmail.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 3/3] riscv: dts: sophgo: add Sophgo SPI NOR controller driver
Date: Mon, 24 Feb 2025 18:12:02 +0800
Message-ID: <20250224101213.26003-4-looong.bin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224101213.26003-1-looong.bin@gmail.com>
References: <20250224101213.26003-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SPI NOR device node for Sophgo.

Signed-off-by: Longbin Li <looong.bin@gmail.com>
---
 .../boot/dts/sophgo/sg2044-sophgo-sd3-10.dts  | 18 ++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2044.dtsi        | 24 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
index c50e61a50013..9c634920f37e 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
@@ -80,6 +80,24 @@ &sd {
 	status = "okay";
 };

+&spifmc0 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+	};
+};
+
+&spifmc1 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+	};
+};
+
 &uart1 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
index 6eaf92dd0a90..e45f7218de04 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -33,6 +33,30 @@ soc {
 		dma-noncoherent;
 		ranges;

+		spifmc0: spi@7001000000 {
+			compatible = "sophgo,sg2044-spifmc-nor";
+			reg = <0x70 0x01000000 0x0 0x4000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clk CLK_GATE_AHB_SPIFMC>;
+			interrupt-parent = <&intc>;
+			interrupts = <37 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_SPIFMC0>;
+			status = "disabled";
+		};
+
+		spifmc1: spi@7005000000 {
+			compatible = "sophgo,sg2044-spifmc-nor";
+			reg = <0x70 0x05000000 0x0 0x4000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clk CLK_GATE_AHB_SPIFMC>;
+			interrupt-parent = <&intc>;
+			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_SPIFMC1>;
+			status = "disabled";
+		};
+
 		dmac0: dma-controller@7020000000 {
 			compatible = "snps,axi-dma-1.01a";
 			reg = <0x70 0x20000000 0x0 0x10000>;
--
2.48.1

