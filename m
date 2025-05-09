Return-Path: <linux-spi+bounces-8026-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E2AB11B7
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C2F3AC282
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828872920B5;
	Fri,  9 May 2025 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KfmUwLzB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E728FA91
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788838; cv=none; b=duLA9kIngCbmPzwIqNF14U+oCtULukpXEKT2Yg9aQ8hrsEhoydbDql/KGHO3idX3gOLVZshfywpPUAt+M5xVIYHdTW99jrItYZAVvxnL4jDz3yXMjofOHjXcpRsAfWzX6+PPDvA4xF4OEQfk8731VUX4ippPNv0K2F6GsPpElXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788838; c=relaxed/simple;
	bh=P6hkWNIB9LIlNth1/4VZQEEC7u2gPfD4GAPBE8iKT9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EtoIq8Kzxj7PtEINDm/34MnULy/KA8OT+5JBvu7gEciPHX28egU1D+azawh3IWaVYgRGfx7VMl95WOUBx8FGLOiAkU1DCxye10LyBKB9cuz7kRj055R3eqtebGkctLxvvvGKC3SNV3qsDT6mqenL1I5YRjkZtoUZBfgklQOnhwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KfmUwLzB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a1f8c85562so362620f8f.1
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746788834; x=1747393634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfDBCe28zl/SAg4VVune9XblDhv/fAFglHkb6WzJx6s=;
        b=KfmUwLzBjHPC5pi0gyAJTSo2qDdDWUEh84r/rIc+89q53TycDQVZ9aMPy7kah64Lp5
         tHV0sz30+TDyc6nMLwio20CITy81jWuiqI+eOf2QLTOI3jszwpkt8f++AQqUTBl7wJqb
         qPSAVl+lblsQhrqVGFY9LxWe68VKr9rA7OeWZo+7LSBiNALivryQNj5aH+K4W0+vkS1z
         Hao1fvljukhjns1z8XTCbqdLd1I0EjVa6IZfyT51cT7JSgN34252CjwGGPPX86IIkOo7
         nKC713yeHvMmIiwd58vxpw2b0NKqebzDBQ6FDRziGtjS8vVm6xdWdY8bw+TvCOa35QsK
         spLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788834; x=1747393634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfDBCe28zl/SAg4VVune9XblDhv/fAFglHkb6WzJx6s=;
        b=Lk4qeOGHuAxO6+I1dpolMYCu+A7nGfM4K1+uBptqHEIrkMp1FDUIux4cqLgfArTe5o
         mCnGaKfEEXLJ8cidSqZPagc9tS1BJzkP+BzR5YQQMTNKD2RS3NMS2/tMU/iHPlku6Xe4
         dBxMq/qyCe4wxkhBiFIxL70Rm13PSs/H1Fp3MEY/iTfHqRQLFKFMKfce6g4W3ZaC+rnF
         E3Ug2kHi3x+CXBmHMj8srbFys7C4GcP+8k9raePrD4kwLH8diYQQQ8Rf8fHsrh6ptooh
         nPgjSP45Wziu+Me6H9wC1Bx8HFBro/1zL4++qMaNmtE2ZibFn57sjmL/mbNui82KXQAl
         rReg==
X-Gm-Message-State: AOJu0Yw7J7/4KiFMVKCnpqNzlxJAylQOozPgYmvoQSWBiC3U4EtVcjCo
	fHWaZNfV2YFV6PnAcc+u2g+35S9Xtg1PoHoX75Hh6UmDfFcGdbOAe4RwonV+Qa8=
X-Gm-Gg: ASbGncs57I+wDhkDIH8Qjvhv5I5NLquCz5LP5CDtf6c31hbQg9MyMx2iNNkP2kaqMuc
	ZRMvO07gshYAfkVm6/T26TyQFVu+0YLHPDrXFlu8tYlh69uCk/zkb7m75b6WIVL5xwvX94YItma
	QACs82/8yMqeZSBCieLImmIf8UOXzD2huqx2tfXs3GvrT7s1RwRDKgkrtrxipEfFh0/aGLcF40C
	xp9L05Zdl8R6xXpVmKzUWLyjvGklJh13IWWrgYPV1byxuJsYsHrEy+MN93FOFOKNIFxENkVTRz1
	K/BoEXbtwPcEktzI8Dlv5e9M1DkyYtPk7paekZ6iOIY0Vmc=
X-Google-Smtp-Source: AGHT+IEp3NLHKI4dsaZ2CvQTR4HmXAVodEDvfdIyQ8so2a8K6UPoMQBnrE+k8vgABY+2kwMQFLPTVA==
X-Received: by 2002:a05:6000:4304:b0:3a0:b294:ccf2 with SMTP id ffacd0b85a97d-3a1f649cc02mr2743451f8f.52.1746788834336;
        Fri, 09 May 2025 04:07:14 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm2914797f8f.22.2025.05.09.04.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:07:13 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 09 May 2025 12:06:01 +0100
Subject: [PATCH 14/14] arm64: dts: Add DSPI entries for S32G platforms
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-james-nxp-spi-v1-14-32bfcd2fea11@linaro.org>
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
In-Reply-To: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com, arnd@linaro.org, 
 andrei.stefanescu@nxp.com, dan.carpenter@linaro.org
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>, 
 Larisa Grigore <Larisa.Grigore@nxp.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

S32G3 and S32G2 have the same 6 SPI devices, add the DT entries. Devices
are all the same except spi0 has 8 chip selects instead of 5. Clock
settings for the chip rely on ATF Firmware [1].

[1]: https://github.com/nxp-auto-linux/arm-trusted-firmware
Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi        | 78 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi        | 78 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi | 87 +++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi | 77 ++++++++++++++++++++++
 4 files changed, 320 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index ea1456d361a3..68848575bf81 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -376,6 +376,45 @@ uart1: serial@401cc000 {
 			status = "disabled";
 		};
 
+		spi0: spi@401d4000 {
+			compatible = "nxp,s32g2-dspi";
+			reg = <0x401d4000 0x1000>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 26>;
+			clock-names = "dspi";
+			spi-num-chipselects = <8>;
+			bus-num = <0>;
+			dmas = <&edma0 0 7>, <&edma0 0 8>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		spi1: spi@401d8000 {
+			compatible = "nxp,s32g2-dspi";
+			reg = <0x401d8000 0x1000>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 26>;
+			clock-names = "dspi";
+			spi-num-chipselects = <5>;
+			bus-num = <1>;
+			dmas = <&edma0 0 10>, <&edma0 0 11>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		spi2: spi@401dc000 {
+			compatible = "nxp,s32g2-dspi";
+			reg = <0x401dc000 0x1000>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 26>;
+			clock-names = "dspi";
+			spi-num-chipselects = <5>;
+			bus-num = <2>;
+			dmas = <&edma0 0 13>, <&edma0 0 14>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 		i2c0: i2c@401e4000 {
 			compatible = "nxp,s32g2-i2c";
 			reg = <0x401e4000 0x1000>;
@@ -460,6 +499,45 @@ uart2: serial@402bc000 {
 			status = "disabled";
 		};
 
+		spi3: spi@402c8000 {
+			compatible = "nxp,s32g2-dspi";
+			reg = <0x402c8000 0x1000>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 26>;
+			clock-names = "dspi";
+			spi-num-chipselects = <5>;
+			bus-num = <3>;
+			dmas = <&edma0 1 7>, <&edma0 1 8>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		spi4: spi@402cc000 {
+			compatible = "nxp,s32g2-dspi";
+			reg = <0x402cc000 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 26>;
+			clock-names = "dspi";
+			spi-num-chipselects = <5>;
+			bus-num = <4>;
+			dmas = <&edma0 1 10>, <&edma0 1 11>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		spi5: spi@402d0000 {
+			compatible = "nxp,s32g2-dspi";
+			reg = <0x402d0000 0x1000>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 26>;
+			clock-names = "dspi";
+			spi-num-chipselects = <5>;
+			bus-num = <5>;
+			dmas = <&edma0 1 13>, <&edma0 1 14>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 		i2c3: i2c@402d8000 {
 			compatible = "nxp,s32g2-i2c";
 			reg = <0x402d8000 0x1000>;
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index 991dbfbfa203..4f883b1a50ad 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -435,6 +435,45 @@ uart1: serial@401cc000 {
 			status = "disabled";
 		};
 
+		spi0: spi@401d4000 {
+			compatible = "nxp,s32g3-dspi", "nxp,s32g2-dspi";
+			reg = <0x401d4000 0x1000>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 26>;
+			clock-names = "dspi";
+			spi-num-chipselects = <8>;
+			bus-num = <0>;
+			dmas = <&edma0 0 7>, <&edma0 0 8>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		spi1: spi@401d8000 {
+			compatible = "nxp,s32g3-dspi", "nxp,s32g2-dspi";
+			reg = <0x401d8000 0x1000>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 26>;
+			clock-names = "dspi";
+			spi-num-chipselects = <5>;
+			bus-num = <1>;
+			dmas = <&edma0 0 10>, <&edma0 0 11>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		spi2: spi@401dc000 {
+			compatible = "nxp,s32g3-dspi", "nxp,s32g2-dspi";
+			reg = <0x401dc000 0x1000>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 26>;
+			clock-names = "dspi";
+			spi-num-chipselects = <5>;
+			bus-num = <2>;
+			dmas = <&edma0 0 13>, <&edma0 0 14>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 		i2c0: i2c@401e4000 {
 			compatible = "nxp,s32g3-i2c",
 				     "nxp,s32g2-i2c";
@@ -524,6 +563,45 @@ uart2: serial@402bc000 {
 			status = "disabled";
 		};
 
+		spi3: spi@402c8000 {
+			compatible = "nxp,s32g3-dspi", "nxp,s32g2-dspi";
+			reg = <0x402c8000 0x1000>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 26>;
+			clock-names = "dspi";
+			spi-num-chipselects = <5>;
+			bus-num = <3>;
+			dmas = <&edma0 1 7>, <&edma0 1 8>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		spi4: spi@402cc000 {
+			compatible = "nxp,s32g3-dspi", "nxp,s32g2-dspi";
+			reg = <0x402cc000 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 26>;
+			clock-names = "dspi";
+			spi-num-chipselects = <5>;
+			bus-num = <4>;
+			dmas = <&edma0 1 10>, <&edma0 1 11>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		spi5: spi@402d0000 {
+			compatible = "nxp,s32g3-dspi", "nxp,s32g2-dspi";
+			reg = <0x402d0000 0x1000>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 26>;
+			clock-names = "dspi";
+			spi-num-chipselects = <5>;
+			bus-num = <5>;
+			dmas = <&edma0 1 13>, <&edma0 1 14>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 		i2c3: i2c@402d8000 {
 			compatible = "nxp,s32g3-i2c",
 				     "nxp,s32g2-i2c";
diff --git a/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi b/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
index d26af0fb8be7..812b37b0098b 100644
--- a/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
@@ -173,6 +173,77 @@ i2c4-gpio-grp1 {
 			pinmux = <0x2d40>, <0x2d30>;
 		};
 	};
+
+	dspi1_pins: dspi1_pins {
+		dspi1_grp0 {
+			pinmux = <0x72>;
+			output-enable;
+			input-enable;
+			slew-rate = <150>;
+			bias-pull-up;
+		};
+
+		dspi1_grp1 {
+			pinmux = <0x62>;
+			output-enable;
+			slew-rate = <150>;
+		};
+
+		dspi1_grp2 {
+			pinmux = <0x83>;
+			output-enable;
+			input-enable;
+			slew-rate = <150>;
+		};
+
+		dspi1_grp3 {
+			pinmux = <0x5F0>;
+			input-enable;
+			slew-rate = <150>;
+			bias-pull-up;
+		};
+
+		dspi1_grp4 {
+			pinmux = <0x3D92>,
+				 <0x3DA2>,
+				 <0x3DB2>;
+		};
+	};
+
+	dspi5_pins: dspi5_pins {
+		dspi5_grp0 {
+			pinmux = <0x93>;
+			output-enable;
+			input-enable;
+			slew-rate = <150>;
+		};
+
+		dspi5_grp1 {
+			pinmux = <0xA0>;
+			input-enable;
+			slew-rate = <150>;
+			bias-pull-up;
+		};
+
+		dspi5_grp2 {
+			pinmux = <0x3ED2>,
+				 <0x3EE2>,
+				 <0x3EF2>;
+		};
+
+		dspi5_grp3 {
+			pinmux = <0xB3>;
+			output-enable;
+			slew-rate = <150>;
+		};
+		dspi5_grp4 {
+			pinmux = <0xC3>;
+			output-enable;
+			input-enable;
+			slew-rate = <150>;
+			bias-pull-up;
+		};
+	};
 };
 
 &can0 {
@@ -220,3 +291,19 @@ &i2c4 {
 	pinctrl-1 = <&i2c4_gpio_pins>;
 	status = "okay";
 };
+
+&spi1 {
+	pinctrl-0 = <&dspi1_pins>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	spidev0: spidev@0 {
+		compatible = "rohm,dh2228fv";
+		spi-max-frequency = <4000000>;
+		reg = <0>;
+		fsl,spi-cs-sck-delay = <100>;
+		fsl,spi-sck-cs-delay = <100>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi b/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
index ba53ec622f0b..798b58fa9536 100644
--- a/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
@@ -127,6 +127,77 @@ i2c4-gpio-grp1 {
 			pinmux = <0x2d40>, <0x2d30>;
 		};
 	};
+
+	dspi1_pins: dspi1_pins {
+		dspi1_grp0 {
+			pinmux = <0x62>;
+			output-enable;
+			slew-rate = <150>;
+		};
+
+		dspi1_grp1 {
+			pinmux = <0x72>;
+			output-enable;
+			input-enable;
+			slew-rate = <150>;
+			bias-pull-up;
+		};
+
+		dspi1_grp2 {
+			pinmux = <0x83>;
+			output-enable;
+			input-enable;
+			slew-rate = <150>;
+		};
+
+		dspi1_grp3 {
+			pinmux = <0x5F0>;
+			input-enable;
+			slew-rate = <150>;
+			bias-pull-up;
+		};
+
+		dspi1_grp4 {
+			pinmux = <0x3D92>,
+				 <0x3DA2>,
+				 <0x3DB2>;
+		};
+	};
+
+	dspi5_pins: dspi5_pins {
+		dspi5_grp0 {
+			pinmux = <0x93>;
+			output-enable;
+			input-enable;
+			slew-rate = <150>;
+		};
+
+		dspi5_grp1 {
+			pinmux = <0xA0>;
+			input-enable;
+			slew-rate = <150>;
+			bias-pull-up;
+		};
+
+		dspi5_grp2 {
+			pinmux = <0x3ED2>,
+				 <0x3EE2>,
+				 <0x3EF2>;
+		};
+
+		dspi5_grp3 {
+			pinmux = <0xB3>;
+			output-enable;
+			slew-rate = <150>;
+		};
+		dspi5_grp4 {
+			pinmux = <0xC3>;
+			output-enable;
+			input-enable;
+			slew-rate = <150>;
+			bias-pull-up;
+		};
+	};
 };
 
 &can0 {
@@ -155,6 +226,12 @@ pcal6524: gpio-expander@22 {
 	};
 };
 
+&spi1 {
+	pinctrl-0 = <&dspi1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &i2c2 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&i2c2_pins>;

-- 
2.34.1


