Return-Path: <linux-spi+bounces-8268-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A0FAC2192
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 12:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1801B679F0
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F1C22B8B5;
	Fri, 23 May 2025 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V21Ei/RU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7CC22A7E4;
	Fri, 23 May 2025 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747997718; cv=none; b=E3jBXJdZgOI5pBIneE6vuQnn8bEWO0VtMeZAq1l3pZdlci1xTH3XJ/RGvkeKZ0CyTAFx3IogyujwBy7B+LpdjD/mDFoDEV+NCqI1790lRgBs4nwHfqhGZVD17VIMrqhBg6dME2wzUNPgUP9ARcilyzkvUQYyXbCD3XYsoJwczcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747997718; c=relaxed/simple;
	bh=1GDh0zAEry6mVGUqkPUqxMLAqpRze3QvTZVNyNvZNiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LxWWle7PHDNMHuGoOv9OmzSvgGafmOqNzeqGoDQsykT8NdZfRIPgFFKw+542MwHXDTTcACZIK4nToGt3ZDSDkjr9h/Jvy6M/dM5yCnV+yvy+gc1NSaU2wHjiGSbi8vzrHdqBw7lFiypPODafPreGMEZJXwn9N77xnEdalQqfRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V21Ei/RU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742caef5896so5085214b3a.3;
        Fri, 23 May 2025 03:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747997716; x=1748602516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxmiZPl5Ck8pukdGXQ0/lqOM6oa5lUIp5yTgqKF3faw=;
        b=V21Ei/RUHx9+smTsfT7IvRx//r91JDI4bbrQivUxDzfjnn2JXCMCD3A8pj39vBm9AF
         ax3LUtJoboNxkXwzSQ0+AdnXSVLiqoRlr85/z8Wbzs5vsJVN2eVcv7MAIt4PRKY3lAF4
         LBGWrwzg0bMGjht7+6h6k8FiNVYzh8cNLWPd4w9FqOaOwkbFWA77BvRV4NbFB+IyoQ30
         P5214JsdncoYy4f334y8uNpanUBszkuAcIgWBt/s0lOQ1NRjh2YGwVNit2PcEMWyScyj
         ZMXKDkEMMiUUelVanusBaZfJh8bu2DfhYWxFI+pXDfPAsEQedLEqEfHO4DAUZ14OJGnj
         Ed3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747997716; x=1748602516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxmiZPl5Ck8pukdGXQ0/lqOM6oa5lUIp5yTgqKF3faw=;
        b=I46jOJdViU9CTFxprFwlOF33LlJIEu3JuBhj+NCP2hQSKqklNxy5iLXD0wHpOfV9yq
         Ha83cnNLwd9VeXalLVcP0FGY976gWLYb2vRmMHF4trL4l+83MBelDPNNuIkPvfiKfW1Z
         K5egcV2t4O6epTnXuw+EgnanBLRWPwYYAIQPVAtN2TpvEbX90ON3GAMhI/MN90faaaF2
         s9PY7SypXOIZdrol7INTQ9+zR8GarOw/H4zj81UqcrOAmIF6gu/Gve0YnwOSlmnPkSCn
         AH+6zDUNYNH0AknHGZ7/Cxc8iOyMcywJuTJ+r3wNvI2gH0PaYPCExnXot553UaMrjlIh
         6AyA==
X-Forwarded-Encrypted: i=1; AJvYcCUNCmNU4JFD/rPJZc59+8ygv09EObYwlUI/oYsLWZ1uTuobKnPmAr2531tr7NkpJx5dGunUe8XGx3vM@vger.kernel.org, AJvYcCV1q9Dn+pCe8jvQ0pgTqvW0YiPzi0T9GoSkZ7C4ZRCRauubqCWiTERIpCpROg8ifXxbFzG+wDDERhQfMX5R@vger.kernel.org, AJvYcCWonPIkIb1HyYPD2o1QHe/rGA/655gz3M/rXEE2IcKFE37X1VSIvdVMoFSfvbk6LqBAsuvzRWj2uB9V@vger.kernel.org
X-Gm-Message-State: AOJu0YzSJ7o1BOYZt0G1V+Y6S0FRz0540XW7WNjbC4f4/nCx/LiLuVcP
	yuFJtghrYZYySxEN0QilBrG5m9hpxklII0kOfkKSHDOFtyZIWxfnbn3P
X-Gm-Gg: ASbGncueQdXj610+l6fORVTAKuXz0vr7Q877v4J0975CR0EF3UeNTd2gP8W/gRY3qgL
	AlxNxjgFJ8doqRwE0lvFri5c6PM7nMzDHasvj2KcfDdogf20ew5HSiJu1Y+jnauCJsEe0jSSDUp
	J8YBBrVBty5PANws+XVV9FgpRjxaYZYNir9vH848loUOIwtjuAIknGfOReUyI8cxLmdDoUVv3hx
	G+U3Lk/YLV/s5uN9O6aPuEn2J7SJHLQ4hofHMhQOoYz9F73BTjaMuXlvEH/NJ1avy3ilA/f6MvA
	cwfXZtlARi1fpr/b/O7WWEKV0bsyck1zEvSPGUUgtG++WwDde5BFAA==
X-Google-Smtp-Source: AGHT+IH4Nepegl0mcTej89S8M81vz2ympEfH22RcRGrsFdndLJpdaWHD3e9xghthl+2Ys9cAmW6dww==
X-Received: by 2002:a05:6a00:198e:b0:740:91e4:8107 with SMTP id d2e1a72fcca58-742a963242bmr40755354b3a.0.1747997715930;
        Fri, 23 May 2025 03:55:15 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::3fc8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739cdesm12623687b3a.82.2025.05.23.03.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:55:15 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Fri, 23 May 2025 18:54:51 +0800
Subject: [PATCH 3/3] riscv: dts: sophgo: Add SPI NOR node for SG2042
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-sfg-spifmc-v1-3-4cf16cf3fd2a@gmail.com>
References: <20250523-sfg-spifmc-v1-0-4cf16cf3fd2a@gmail.com>
In-Reply-To: <20250523-sfg-spifmc-v1-0-4cf16cf3fd2a@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Longbin Li <looong.bin@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 dlan@gentoo.org, ziyao@disroot.org, Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747997691; l=2232;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=1GDh0zAEry6mVGUqkPUqxMLAqpRze3QvTZVNyNvZNiQ=;
 b=ggUaIaLAnq0XDvfVdPu0NfePlrDLY2dn8MKJT0iKXUMiF1MEHy/syRdJlgoTBOGeUSfm4YIlT
 KSDFwsD6mtwDCqBFTgLW6Ay7wnXJkzFi/5pSIsZelDxnHN+TG3McRkL
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add SPI-NOR controller and flash nodes to device tree for SG2042.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 18 ++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 24 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index 34645a5f6038389cd00d4940947c6bb71d39ec6f..c59a819e35d3201c484bf98392aec14392a7eb04 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -68,6 +68,24 @@ &sd {
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
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 212a3edc73fd654de59e10fab2094af2fec7f88f..06b433d5949bcc2374ea90223ff2d81434fad2b5 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -83,6 +83,30 @@ soc: soc {
 		interrupt-parent = <&intc>;
 		ranges;
 
+		spifmc0: spi@7000180000 {
+			compatible = "sophgo,sg2042-spifmc-nor", "sophgo,sg2044-spifmc-nor";
+			reg = <0x70 0x00180000 0x0 0x1000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clkgen GATE_CLK_AHB_SF>;
+			interrupt-parent = <&intc>;
+			interrupts = <108 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rstgen RST_SF0>;
+			status = "disabled";
+		};
+
+		spifmc1: spi@7002180000 {
+			compatible = "sophgo,sg2042-spifmc-nor", "sophgo,sg2044-spifmc-nor";
+			reg = <0x70 0x02180000 0x0 0x1000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clkgen GATE_CLK_AHB_SF>;
+			interrupt-parent = <&intc>;
+			interrupts = <109 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rstgen RST_SF1>;
+			status = "disabled";
+		};
+
 		i2c0: i2c@7030005000 {
 			compatible = "snps,designware-i2c";
 			reg = <0x70 0x30005000 0x0 0x1000>;

-- 
2.49.0


