Return-Path: <linux-spi+bounces-5263-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BD19A55C1
	for <lists+linux-spi@lfdr.de>; Sun, 20 Oct 2024 20:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B611F2144E
	for <lists+linux-spi@lfdr.de>; Sun, 20 Oct 2024 18:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FF6198A17;
	Sun, 20 Oct 2024 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f028NmKr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6590E197A81;
	Sun, 20 Oct 2024 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729448521; cv=none; b=ZwVTfz0Flc/w2EXbNYsJpPkNkd0Dj9jxkwq/0YYvXuwLYazCYtM2JwXlv0KlTqnjSdoD1v3gEUT6uXuilwBJwfNNMEjh220Jb8DfXEjuq5a4Aff1gBNRIiiHCcuwYoK0Dz66eoYX/k6l4ssoXOnZa9TZSAeSXzy4AENIZBurI4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729448521; c=relaxed/simple;
	bh=Owgw5vMmpv+QSuNxHW76hpQPPLHvuGsaZd0es3OPokE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHyQa/2/8R6me8cmf+cQmDr+QWyNiMaf2i/W+f2qp4tGhB+6T55oIhw/S0/kHvugvm48RrowAzC5DpvU/K/ad1bUsUGj397Is1oM1PekW2krl0Lg95ebRXrVgs+0t0JDya/oaIvt69SMzo9e2QG6lv3AYOurkAT9MX+8N9lsI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f028NmKr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d41894a32so2391428f8f.1;
        Sun, 20 Oct 2024 11:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729448517; x=1730053317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YB/d8ya+iA886QHQfDVagGNmaaeyxRfUU+uDgU8KNSI=;
        b=f028NmKrYmmfIO4Z+6DnPlbQ9Vmu31G1CfXjXtNirt0+cYxrdiOOBUH7ct+vql0Cxd
         uTkRFn23bXNsFdz3zcD/yGbPzH41ai91HSziPivc88EwRA32AW7ii1A3qKDzcHem50JZ
         1vJiMJhDf0NNJE4VSIIZ6xBD7vKsoMRCFfgUGBsNO2NbGfzLCnDzR+R1YmCX/Qp4bqo/
         ibmATFYLnsvvoE/NcE1RrYMe12m3tRCxoNRlnkX1Jtmo4VFoxbWYICDxUPMK58X9NOhT
         a6cVhbbCWRiOHpLDXUGevuE9Dpahvsh7YhK8EAEHNdpEdTC6uVzENjUZmW3uLhnLwGAY
         bHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729448517; x=1730053317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YB/d8ya+iA886QHQfDVagGNmaaeyxRfUU+uDgU8KNSI=;
        b=Fv7NRMrk8s4tn4BQWIc/Odh/A4vWgqRtO7ldlTBsilimL3ZooVdYvPgCDqwbb/I8uj
         uUYO6elUvfqJgo/3Vp1fYyVJJ9YHSdgo35o7Lt0xqopn0Sxi347PbGEG1fJt+XNeBIVI
         8X9WjRvdK3QuG2SzJO8d5wky0ODa+b4a1AcvAFNDNrN92j+6LRiTVkAPFM6dS4Ass0dj
         yuTT/L56af+MQ37GoMxNOlaWRrMAXhqFOokHufH9RGbQ66XR4oQymsU7CKOXzXumxKDu
         YXxB3YBGOo2k/b+bPKcmw4vnYYAowWf5phikVixXCbJkJD7r+Nn8NWe2zAJVbNxRRu2V
         yk0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNtgvkBtdI7SG70+ICBFtsf6tFIAUeLXdXAKUWXVHLLjg4SVItzup2RzGv3bqwwp5RIAlwF7j8izTfvQmaP8NGcBg=@vger.kernel.org, AJvYcCW7YMwj2CykXJlNtMVRba6DppmtaYtbX4l8yyq/yOFG8IOPdcjmwA14+FWRbrKm5TWS77CVcs6dNhEV3KDM@vger.kernel.org, AJvYcCWQoupG3qkR3TeYQwDEZMJ8Jy9t47487EqZZmkgvByuahjOjLtCWaqD+4A1OPbaNJG2i3KQYo8Fv689@vger.kernel.org
X-Gm-Message-State: AOJu0YweaLU3Bx41kjhTdNLBjFXw/6DEJmjjT5sAdNvH0/rf2b0KX1hD
	kxs4YlUNo9i97HyO2jx6JOXSnRKGtvcpbF7V50GsWYUM5EZDwn9oEY8dflTi
X-Google-Smtp-Source: AGHT+IGugZhfDYe/BbnZuzhu75x/LfLnNt9NNzUAVI8e+4gLSVOjfsqQBBgKKgOE12vwsXyIiSmRbA==
X-Received: by 2002:a05:6000:183:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37ecf08650fmr5774026f8f.29.1729448517433;
        Sun, 20 Oct 2024 11:21:57 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a48903sm2276459f8f.37.2024.10.20.11.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 11:21:57 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] arm64: dts: exynos: Add clock management unit nodes
Date: Sun, 20 Oct 2024 21:21:18 +0300
Message-ID: <20241020182121.377969-4-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241020182121.377969-1-ivo.ivanov.ivanov1@gmail.com>
References: <20241020182121.377969-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clock management unit nodes for:
- cmu_top, which provides muxes, divs and gates for other CMUs
- cmu_peris, which provides clocks for GIC and MCT
- cmu_fsys0, which provides clocks for USBDRD30
- cmu_fsys1, which provides clocks for MMC, UFS and PCIE
- cmu_peric0, which provides clocks for UART_DBG, USI00 ~ USI03
- cmu_peric1, which provides clocks for SPI_CAM0/1, UART_BT,
USI04 ~ USI13

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 arch/arm64/boot/dts/exynos/exynos8895.dtsi | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895.dtsi b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
index 223ebd482..802e135c4 100644
--- a/arch/arm64/boot/dts/exynos/exynos8895.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos8895.dtsi
@@ -5,6 +5,7 @@
  * Copyright (c) 2024, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
  */
 
+#include <dt-bindings/clock/samsung,exynos8895.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -159,6 +160,15 @@ chipid@10000000 {
 			reg = <0x10000000 0x24>;
 		};
 
+		cmu_peris: clock-controller@10010000 {
+			compatible = "samsung,exynos8895-cmu-peris";
+			reg = <0x10010000 0x8000>;
+			#clock-cells = <1>;
+			clocks = <&oscclk>,
+				 <&cmu_top CLK_DOUT_CMU_PERIS_BUS>;
+			clock-names = "oscclk", "bus";
+		};
+
 		gic: interrupt-controller@10201000 {
 			compatible = "arm,gic-400";
 			reg = <0x10201000 0x1000>,
@@ -173,24 +183,93 @@ gic: interrupt-controller@10201000 {
 			#size-cells = <1>;
 		};
 
+		cmu_peric0: clock-controller@10400000 {
+			compatible = "samsung,exynos8895-cmu-peric0";
+			reg = <0x10400000 0x8000>;
+			#clock-cells = <1>;
+			clocks = <&oscclk>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC0_BUS>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC0_UART_DBG>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC0_USI00>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC0_USI01>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC0_USI02>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC0_USI03>;
+			clock-names = "oscclk", "bus", "uart_dbg", "usi00",
+				      "usi01", "usi02", "usi03";
+		};
+
 		pinctrl_peric0: pinctrl@104d0000 {
 			compatible = "samsung,exynos8895-pinctrl";
 			reg = <0x104d0000 0x1000>;
 			interrupts = <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		cmu_peric1: clock-controller@10800000 {
+			compatible = "samsung,exynos8895-cmu-peric1";
+			reg = <0x10800000 0x8000>;
+			#clock-cells = <1>;
+			clocks = <&oscclk>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_BUS>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_SPEEDY2>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_SPI_CAM0>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_SPI_CAM1>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_UART_BT>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_USI04>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_USI05>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_USI06>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_USI07>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_USI08>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_USI09>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_USI10>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_USI11>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_USI12>,
+				 <&cmu_top CLK_DOUT_CMU_PERIC1_USI13>;
+			clock-names = "oscclk", "bus", "speedy2", "cam0",
+				      "cam1", "uart_bt", "usi04", "usi05",
+				      "usi06", "usi07", "usi08", "usi09",
+				      "usi10", "usi11", "usi12", "usi13";
+		};
+
 		pinctrl_peric1: pinctrl@10980000 {
 			compatible = "samsung,exynos8895-pinctrl";
 			reg = <0x10980000 0x1000>;
 			interrupts = <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		cmu_fsys0: clock-controller@11000000 {
+			compatible = "samsung,exynos8895-cmu-fsys0";
+			reg = <0x11000000 0x8000>;
+			#clock-cells = <1>;
+			clocks = <&oscclk>,
+				 <&cmu_top CLK_DOUT_CMU_FSYS0_BUS>,
+				 <&cmu_top CLK_DOUT_CMU_FSYS0_DPGTC>,
+				 <&cmu_top CLK_DOUT_CMU_FSYS0_MMC_EMBD>,
+				 <&cmu_top CLK_DOUT_CMU_FSYS0_UFS_EMBD>,
+				 <&cmu_top CLK_DOUT_CMU_FSYS0_USBDRD30>;
+			clock-names = "oscclk", "bus",
+				      "dpgtc", "mmc_embd",
+				      "ufs_embd", "usbdrd30";
+		};
+
 		pinctrl_fsys0: pinctrl@11050000 {
 			compatible = "samsung,exynos8895-pinctrl";
 			reg = <0x11050000 0x1000>;
 			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		cmu_fsys1: clock-controller@11400000 {
+			compatible = "samsung,exynos8895-cmu-fsys1";
+			reg = <0x11400000 0x8000>;
+			#clock-cells = <1>;
+			clocks = <&oscclk>,
+				 <&cmu_top CLK_DOUT_CMU_FSYS1_BUS>,
+				 <&cmu_top CLK_DOUT_CMU_FSYS1_MMC_CARD>,
+				 <&cmu_top CLK_DOUT_CMU_FSYS1_PCIE>,
+				 <&cmu_top CLK_DOUT_CMU_FSYS1_UFS_CARD>;
+			clock-names = "oscclk", "bus", "mmc_card",
+				      "pcie", "ufs_card";
+		};
+
 		pinctrl_fsys1: pinctrl@11430000 {
 			compatible = "samsung,exynos8895-pinctrl";
 			reg = <0x11430000 0x1000>;
@@ -213,6 +292,14 @@ pinctrl_busc: pinctrl@15a30000 {
 			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		cmu_top: clock-controller@15a80000 {
+			compatible = "samsung,exynos8895-cmu-top";
+			reg = <0x15a80000 0x8000>;
+			#clock-cells = <1>;
+			clocks = <&oscclk>;
+			clock-names = "oscclk";
+		};
+
 		pmu_system_controller: system-controller@16480000 {
 			compatible = "samsung,exynos8895-pmu",
 				     "samsung,exynos7-pmu", "syscon";
-- 
2.43.0


