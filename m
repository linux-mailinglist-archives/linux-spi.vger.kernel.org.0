Return-Path: <linux-spi+bounces-9136-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEE9B0B443
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 10:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DD73BE15B
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBEF1E5207;
	Sun, 20 Jul 2025 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+DcllOp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04181E51FB;
	Sun, 20 Jul 2025 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753000406; cv=none; b=OkKqsfeiCbwNjo9J1qyJquRKry4+3OAlIdTRjejYmWasLZ+ptcLSCB0h5GLmHodl7T0aKJ/9DYoFuuMu33LnKWrVn2OU/499NOGx1moPOI5xY720d4nvaMWLCdx5n7Tfr5f3NobSHYME0HHur8CXmgrXfk0tVXP/89+neBfhjyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753000406; c=relaxed/simple;
	bh=TvdO4gaLKUzOJEi1aNELCkM4P/gdBzPDf2IOJYLCNW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8NBIC0n2vlQiZAEZ/zjZGHwzDqRzAQu9lhM55mX2tV1kZ2KOkxSORTy0VA/Fb5UovQ1xUdDLPnasviA/J6dQB0NAiWqNCN/powtYKPWfKewfdkkzsC1IsxgWb95hm/VNWibA721JP3eP+62+9i4cRhttfw/HryAR5H/exx5LLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+DcllOp; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso2508324a91.1;
        Sun, 20 Jul 2025 01:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753000404; x=1753605204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vk2QbpeYdfxireOkVMTO8TaReVM+NxnLECNCVQYv1vc=;
        b=I+DcllOpYvs4+8QqaFxgRRZmUx4uemJNeM0jnfFyzodXiBpdLKp17Hcm7cOkpLcWCz
         blsCiZglOyEPCspFNZf1SlEFEoSMJCijW+TxKEKkhsFwYh1lk7xKLHjDruQ9XgfygsXc
         FN1wl5e50EhcMF+CNdGcBA/CgtQ26IO/l1tzpyo78kJiaiJ8EaYEiie7ZOAo8falQRIQ
         sjkB2s7XRIZg0cVUxUagFxgcHcIdxhsv1koMQU6e5CTNb4Pe/BSLrY9GN2dqXAo/gmxS
         0ZRjjTTKFYknxPo3FvoP1kAh+vww3zLkayo1RO0O9dMlDmtRcaDImfGcvoU+9Ifph5N4
         iPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753000404; x=1753605204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk2QbpeYdfxireOkVMTO8TaReVM+NxnLECNCVQYv1vc=;
        b=LfJnsmhPaRB/1uW3TESgzl91CjTTVaqDnv09WS6UhfPiT1rg3mrQeon2JJYAtDERU5
         O4F7A+ERovslbYndgwkIzKE72mVzwuboNSrShJittkFA1SffJ8bep7ES74frBiMrpVKm
         5Tox8dUwuo8F/W2a27fwprcHPuoEoE5J9Av1r4WtLTvK4hzxkRzqE9ggPloMIrCFHyQb
         aNNTleuc63EVh1gw/iIdN/mFOUiSi0p6A9gOg6swKmeM92jbW4T/ZOlrQ/mhB0LRNRn3
         eDFZB4YqhULy9fZBB1v9AJdaDwm5zLfl1HdAvTKbOmee4bJ8Ws3MGFFxFy0kjpOwUqyG
         ND1w==
X-Forwarded-Encrypted: i=1; AJvYcCW1EzZb5dSuWGYhOWKuEzjWvXvpcNusUbdtCeD4rjWHywhohpi52BV+T3YLUaDMXekPsQLO+jEdc9qfCkdX@vger.kernel.org, AJvYcCWmWtQ4P8aNBYnl7MwDV+GGRiDSGATrrmz6U/hT4+Y15zPJY0CY1KCQXSuuqi409WYdsStGFiTrQ36X@vger.kernel.org, AJvYcCXzcI5tAm5X41A/Si3n87qsReeWAypvgdGCBj0Kd9FmDtBFCNhqr1dYahvLNtsUwJvzuyrW6l+w4uzx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Mlw02ZkrDvfdOwTRTj7q/pltr662pgrywFzjzVbzio8McU77
	EZrAJ9Cx8LvD4kQZSnO5vqJ4gJdRwBcnPwg1v2htlAco4Q2lQ0OZgHpaWR34ujA/0g4=
X-Gm-Gg: ASbGncupLbv/hC+qjUGZl+fh7vhoYYSR9r/Le+GKqj6TB4DqdWn4hiT6bRpNe2ux43Y
	ER8A3Q9Gr9NlMeYqZ3exl9pKnPx8MgIVZTFAhca+c024Fp7MjSagnI6eQtB5nsli8fQ4/BMmAEU
	v4ADuCdk74/8mNH5q9nF2gx0nJmtSb8AD7TjBL/8jQc0whoK098JsKkx6M8KFO5wKeZv7N/pmXl
	u6fCETMtDDIwfGVNzFZz39RWL907reb2GV3kimt535kMBYuD5T3te1cLwD5YU/KviekIJq9pRdo
	MiAzgDz3YZTEkvyAVzw+wUW1jp5ETZEYMr+O/VqXNRy7v8m3EcHWSF3fqPS4Q6K8VqMTzXlOddw
	coG9vRK2a62zkZGoGID4VfMmi
X-Google-Smtp-Source: AGHT+IHQ6aqsMzWnYc8OhtpmX48954oW5ZQ+i2KvLoOdJi5CschQ3b7WowKF1it0RnWS+9kS3TgT1Q==
X-Received: by 2002:a17:90b:4a8d:b0:311:eb85:96f0 with SMTP id 98e67ed59e1d1-31cc25e80b9mr13870327a91.29.1753000403406;
        Sun, 20 Jul 2025 01:33:23 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1002::1d55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3f46b97sm4079721a91.41.2025.07.20.01.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 01:33:23 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Sun, 20 Jul 2025 16:31:46 +0800
Subject: [PATCH v4 4/4] riscv: dts: sophgo: Add SPI NOR node for SG2042
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-sfg-spifmc-v4-4-033188ad801e@gmail.com>
References: <20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com>
In-Reply-To: <20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com>
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
 Conor Dooley <conor.dooley@microchip.com>, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753000358; l=2404;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=TvdO4gaLKUzOJEi1aNELCkM4P/gdBzPDf2IOJYLCNW8=;
 b=lksiYwk8mrj89e55V3la17CqB//aoirRCF4dGn/kRQVvc4FfgGgqWzJjjN7U9PCxlzb/HE4sL
 Ep2vwiJTSS8CDJasYtL7IvN2wVCJy850Qx3X+F2AUBsS4K41YfhCVqW
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add SPI-NOR controller and flash nodes to device tree for SG2042.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 24 ++++++++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 24 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index ef3a602172b1e5bf3dcf54a8cacdad5172b7f50e..554ec14d58453a44a02a82da40a7aedb80d61dc9 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -138,6 +138,30 @@ &sd {
 	status = "okay";
 };
 
+&spifmc0 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&spifmc1 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_cfg>;
 	pinctrl-names = "default";
diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index b3e4d3c18fdcf94c2294a56ed6ad866fc59a6adb..0f7d8a3743c35046ceec902902af2b8d3ec8e6bd 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -48,6 +48,30 @@ soc: soc {
 		interrupt-parent = <&intc>;
 		ranges;
 
+		spifmc0: spi@7000180000 {
+			compatible = "sophgo,sg2042-spifmc-nor";
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
+			compatible = "sophgo,sg2042-spifmc-nor";
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


