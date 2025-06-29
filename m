Return-Path: <linux-spi+bounces-8862-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F33F9AECBBB
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 10:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A43189077F
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 08:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20769214813;
	Sun, 29 Jun 2025 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVvGITSk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1A1FBEA2;
	Sun, 29 Jun 2025 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751185444; cv=none; b=gos8+jQgJkVUQMEEFlWH+4aOEnGTVL80KywJIXkkbw7ZVbzowQu6zVeoGsQH2goUfN1lMEtyb/Rhw9MT5qd/0NLHmthzY3ZZLYkGmCOi2FMhhz2nHnGiSbBYDmRvppRecDJStn2mISFvvFfswCajIsaQ0XKWt1uV1t/u9rR+Zx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751185444; c=relaxed/simple;
	bh=b+ls9Cn6mM3MfOnV5MwzeFfnl2Z8gVpyt1s6gAiujiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGdROZfx0RKB6f8EWKpzpNa5kIlk365fHzvIBxB6Vm2tP651urh3M9D04GxqH/rIrnTckNXHblmDaFVhbbmx2RUbiARNFdhehvVz8UC77af2v0VoBTkYS2guTdaQsRlulC3I1L0jz7GxRPbUVFPmBUh8xUZAljxyjG4pJOWwh/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVvGITSk; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313154270bbso980812a91.2;
        Sun, 29 Jun 2025 01:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751185442; x=1751790242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97fxYmkEtlOpyahoQx4M5It56A2ScDgvjgQGcXq1u+M=;
        b=BVvGITSkN5crkaTLxMw3x8D0IPeIl/nf0rjo9D87pvIsz3ok9gHK8LIu4JjeFJnM2+
         XJtwL+je74UPcU6wuJNVlBjfK9R+psw3E3eFcqwt5OpEzdhCUZarLlUKtyjkcCDZUv7b
         nMybZjzx3jVKNQ/VOfsZOwfwlYcCzav6GXzqXiGPmSS17fQx9IGA3Q82AAq02M6ruf4S
         ZOadRd+3UDHET/sko80jkl58ZXOWSxCRtoDwX2pCUV1LtCTds2MAWIxdsXqaL3jAjm61
         OU6BGwUo0Du9mipMaifvyXlcRJezYxZYvHQGyKCNrjx5XrhHAtJFI1Nv5FP4hgqmzA1k
         gB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751185442; x=1751790242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97fxYmkEtlOpyahoQx4M5It56A2ScDgvjgQGcXq1u+M=;
        b=MScRdTw62dFD7FnbkB8vPBe1RWbFdBlSAarNT++eeQjMZlugM07X7ktoUpUihAlsza
         mPT5PS0pOwCyrRSQ8gJbOdicuR4EZYUUw5EhLA1stzLJ+GCosX6qzp6jih0tH4U3B6oT
         dJFjq8f49FJ/HrA0C49d6sRovpm4NHsbyXh08jfyXA+8DRNVHSH5Qv0LyHAK0vJeBLod
         8RTnOSBj1CmV14BoFmTi1Jlpi1xTqgbqNyPoMgk0QvHyBqANiNtWZwrCt476nIp+PBFQ
         cW3oSpvzpfmhbx6xvEjIDZc7197eK3kB5225p/zQUyY8QqvTBqYcRS4QOoDRq9NbbO43
         7H2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWY/FsQynoPaDIEZwpuqFAWOKUGg0i0tdz09ugFC9YneJNN3dTNTnsKAse/CHZNJjkUfANZpWV4O8zv@vger.kernel.org, AJvYcCWdnQzotnzUj9aEkwHRWsQveBfpt5j8PlQTSHE57eDjgv0lTZGkamteQNxWAOAjhWyCXXy0sTJResb2@vger.kernel.org, AJvYcCXnj440XiX+8EuIXtsxLa+6tq8/jBlP/erNuH9kUiZud3pequGx/+Py4Zubz53gi1piXebL7flX/vScK9Xe@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXOCusUgaHckJ7OBloyeWEMEtKvMk/LVWnvSTuQSewr14kZRL
	dAt8lmY6ov3NrjhPTBKLhNcAeswhUx8MT7+BaFQfds3wBGKuMOGBSnUmpcefKMCQJKA=
X-Gm-Gg: ASbGncuodVlkipp2WIJcbGrXHUCCFRxxCllRY1zRu3yiayYbgvGcYFAYfJYP1Amc412
	T88QcFcftuMrF0NoTDm45G299pPED5LAag1LYwBeh+dIcnkdOEvFyMbgQid2LZ7+b2NBu2XDn2A
	mMDRDoLyGguJ+QjKZ/l9J/5EyULKkumyU/9hb/IkVRy0QirBnMEeLXgxgINQMsoiDrvSnu2gWys
	9b4F60BomZ6ujETq613O6tDbbFsqD4FJsl5JwGIKUuPhZAqgpC+blLJYyXF9r8p4gSn0Hx11IYK
	Yzg7pfqRuE92uqbv05ZLHu4oymKwFpoV4DSu6wHQGxxBXhGX+wbfvw==
X-Google-Smtp-Source: AGHT+IHAI6D2+4NaOQwnBVFRV6TfBFP4M7lyDzfYRNJ5iP2pargoe20VvUzU6g8JZlrc4J5MmumIGA==
X-Received: by 2002:a17:90b:554f:b0:311:fde5:c4b6 with SMTP id 98e67ed59e1d1-318c8ecda6fmr14121094a91.6.1751185441085;
        Sun, 29 Jun 2025 01:24:01 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::168a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f542661asm10495839a91.26.2025.06.29.01.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 01:24:00 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Sun, 29 Jun 2025 16:23:13 +0800
Subject: [PATCH v3 4/4] riscv: dts: sophgo: Add SPI NOR node for SG2042
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250629-sfg-spifmc-v3-4-28db1f27e999@gmail.com>
References: <20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com>
In-Reply-To: <20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com>
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
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751185413; l=2460;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=b+ls9Cn6mM3MfOnV5MwzeFfnl2Z8gVpyt1s6gAiujiE=;
 b=qcKJ8A9MKl1P77tnPMI3NfkU32uwTXkSDZJvQfYIjdv1Qyo0isAzCFstxLD0cUiPLM5fWPmEW
 4K+vp3bYOuCC+x8B5wTmbP07YTNgDyop6esoGUoR3UyZXUwmcVKdIjv
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
index 85636d1798f11804546ed8606595ace1b4cb2a2f..0e1fcb54480af71147d0e71178a8eb08a31b75c3 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -48,6 +48,30 @@ soc: soc {
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


