Return-Path: <linux-spi+bounces-3688-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6775591D02B
	for <lists+linux-spi@lfdr.de>; Sun, 30 Jun 2024 08:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51AE281E9D
	for <lists+linux-spi@lfdr.de>; Sun, 30 Jun 2024 06:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D800E38DF9;
	Sun, 30 Jun 2024 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6USyfI9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487CF38DD9;
	Sun, 30 Jun 2024 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719729374; cv=none; b=LHOwD4u77ShX0STVvWKayYZkWZWPaZOthbM65t0V4M1OjDfaquKiNw7R4QbrzQhoRtJXF8fxOw4PudH6GcgWF0C6YTMS7GlZ615UEpDXyuXlOh61uVSLeE6wu3MmAbK7/2PP9C/pXwqEQBZoBCTN0/Msl3BCIpCgSyMuVLMDuqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719729374; c=relaxed/simple;
	bh=WbPqT2wpd4+ZeKcUAwbmkkoCmR6ML4SAFPLKfk61mbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkoTmcP0tq6fIjff1dxzQS+ojMILsEUld+ORODZxQgiYDP4EumN9ZZpK+TyIanbCMCB/28+854OXgorZookM+uNQSCCxl2LTGW2bvCjJdKgdfR/kCiaPOQZZn3pX3prct8oqwouQ6K/Q86xLiP1ai7IddeYwd98ZkPwGvweFibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6USyfI9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9c6e59d34so15105015ad.2;
        Sat, 29 Jun 2024 23:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719729372; x=1720334172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QcY18BrD0/gIItoUlZh8XyBfrX5yv5R+UNZ4yG5hJ04=;
        b=Q6USyfI9CL3qsNub2TuT24SbIA9cyh0gXSrTQD6nxVxvDpuLlwvMXyIi0QeQseAaEk
         y38SLJUwUBbECYC4D3ZVI7vGboUtmTiOkJ6uRkDmc4TzXENgMGl91m9ksvWvjBlzfUYw
         6HmXMrugcqWbi30J2JPYqiZpxPLBtzztjJZK0BWQW2KCgNGP8xKalFThoIDE75EUE1fa
         7BrC/0Mm35DnjqDweXet8o/6ZpXmL32rVn4SPth98hkF/zu5bzSXeVAlDDF41yh/P/Qm
         DY+dhhxkLDqzD9Pf1jn7FYzKBx7IX1A5EawdYi3FlPOrgJFVPexR9bti7zeUDQb1KatV
         HxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719729372; x=1720334172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcY18BrD0/gIItoUlZh8XyBfrX5yv5R+UNZ4yG5hJ04=;
        b=lzX4zoLdFcRu5V+Yh2tXHEWbjdmD1KGxAGYExsIq5j5Jvch2X5qK5eKVafKD05qY/e
         l1PPhNiyBog4W+8JSE5dToihtYIfzSu9+K9n3v40DTguHk0nyhljjBllx2RZh8SXQKqV
         6E/25+5ffCKraan/8+9h57cuWY1z48G2hjtBBMJs7NhG89bjm5WZoQxxxEyoTbuVbwY8
         I9bQdIlwIQbN4hALbtbggOUgSbIxO1vT/qSd8/YdL8Vmk51Mka66JpqWbS0M0++Wh6hI
         +QZbokNt8WMozg+sgCFFrgpnLto9202M0Vt6e6X5HVtxQnScL5k1LagySxlIBTC8j1DW
         CoWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsqaCBcO1rjpg1scfipqCWlN599TkaYYOXVNddBQUzELezCxphPFp8xB0uiXDgU4VsPEOrIhaEIZ72A7kAUEi2ZUcH2GV3LFh1h2bZ0drkBkVSwX5alLyTacYMe0gsX5r1oSkJi01TJDuHR+Ejh5DZRSAHtNYJrbbsIPj9iAqR2skgjQ==
X-Gm-Message-State: AOJu0YyBel23mnFPLBIg7QOW5VEK45ijc2+ZRBShlcL54NQuO+IS+1Rn
	U3WOVR2LBdINVAlayL+HyMaPZVepv2JtW0v2Kn0n2Pg5d4YzisXS
X-Google-Smtp-Source: AGHT+IE8yebFjC0WOZuqWWT6VmnzC1kB3+fdYIoJd1m5PkeCFVi/btZzICJa9As2qUt+igNxcU/aNw==
X-Received: by 2002:a17:902:aa85:b0:1f7:22bf:57f4 with SMTP id d9443c01a7336-1fadbcf338fmr20187525ad.55.1719729372416;
        Sat, 29 Jun 2024 23:36:12 -0700 (PDT)
Received: from ga401ii.. ([2401:4900:1cc9:59f2:a68f:8261:cbcf:3139])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fac1538a1asm41180575ad.150.2024.06.29.23.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 23:36:11 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: kanakshilledar111@protonmail.com,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 1/2] arch: riscv: thead: implement basic spi
Date: Sun, 30 Jun 2024 12:05:41 +0530
Message-ID: <20240630063543.115754-2-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

implemented basic spi support for TH1520 SoC.
created a fixed clock and a simple spi0 node.
updated the matching binding to include thead,th1520-spi as compatible.
added a spidev device in devicetree which will utilise the spi0 node.
this is usually reserved for a SPI NOR flash which is left unpopulated
underneath the carrier board. I performed a SPI self loop test using
tools/spi/spidev_test.c and tried sending `\xDE\xAD\xBE\xEF` and verified
it is being received correctly. i updated the of_device_id struct in
drivers/spi/spi-dw-mmio.c to include "thead,th1520-spi" as the compatible.
this patch also adds basic spi support on beaglev ahead which shares the
same TH1520 SoC. i have only tested on LicheePi 4A.

Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
---
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml |  4 ++++
 .../boot/dts/thead/th1520-beaglev-ahead.dts      |  9 +++++++++
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi  |  4 ++++
 .../riscv/boot/dts/thead/th1520-lichee-pi-4a.dts | 10 ++++++++++
 arch/riscv/boot/dts/thead/th1520.dtsi            | 16 ++++++++++++++++
 drivers/spi/spi-dw-mmio.c                        |  1 +
 6 files changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index fde3776a558b..bccd00a1ddd0 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -88,6 +88,10 @@ properties:
               - renesas,r9a06g032-spi # RZ/N1D
               - renesas,r9a06g033-spi # RZ/N1S
           - const: renesas,rzn1-spi   # RZ/N1
+      - description: T-HEAD TH1520 SoC SPI Controller
+        items:
+          - const: thead,th1520-spi
+          - const: snps,dw-apb-ssi
 
   reg:
     minItems: 1
diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index d9b4de9e4757..3103b74e0288 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -17,6 +17,7 @@ aliases {
 		gpio1 = &gpio1;
 		gpio2 = &gpio2;
 		gpio3 = &gpio3;
+		spi0 = &spi0;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -52,6 +53,10 @@ &sdhci_clk {
 	clock-frequency = <198000000>;
 };
 
+&spi_clk {
+	clock-frequency = <396000000>;
+};
+
 &uart_sclk {
 	clock-frequency = <100000000>;
 };
@@ -79,3 +84,7 @@ &sdio0 {
 &uart0 {
 	status = "okay";
 };
+
+&spi0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index 1365d3a512a3..6939bd36560c 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -33,6 +33,10 @@ &sdhci_clk {
 	clock-frequency = <198000000>;
 };
 
+&spi_clk {
+	clock-frequency = <396000000>;
+};
+
 &uart_sclk {
 	clock-frequency = <100000000>;
 };
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
index 9a3884a73e13..26f82fe91489 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
@@ -14,6 +14,7 @@ aliases {
 		gpio1 = &gpio1;
 		gpio2 = &gpio2;
 		gpio3 = &gpio3;
+		spi0 = &spi0;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -30,3 +31,12 @@ chosen {
 &uart0 {
 	status = "okay";
 };
+
+&spi0 {
+	status = "okay";
+	spidev@0 {
+		compatible = "rohm,dh2228fv";
+		reg = <0>;
+		spi-max-frequency = <500000>;
+	};
+};
diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index d2fa25839012..f962de663e7e 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -140,6 +140,12 @@ apb_clk: apb-clk-clock {
 		#clock-cells = <0>;
 	};
 
+	spi_clk: spi-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "spi_clk";
+		#clock-cells = <0>;
+	};
+
 	uart_sclk: uart-sclk-clock {
 		compatible = "fixed-clock";
 		clock-output-names = "uart_sclk";
@@ -183,6 +189,16 @@ clint: timer@ffdc000000 {
 					      <&cpu3_intc 3>, <&cpu3_intc 7>;
 		};
 
+		spi0: spi@ffe700c000 {
+			compatible = "thead,th1520-spi", "snps,dw-apb-ssi";
+			reg = <0xff 0xe700c000 0x0 0x1000>;
+			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&spi_clk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		uart0: serial@ffe7014000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xe7014000 0x0 0x100>;
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 819907e332c4..39e3d46ebf5d 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -419,6 +419,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
 	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
+	{ .compatible = "thead,th1520-spi", .data = dw_spi_pssi_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.45.2


