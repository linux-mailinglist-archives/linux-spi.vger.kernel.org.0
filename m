Return-Path: <linux-spi+bounces-3689-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E87891D02F
	for <lists+linux-spi@lfdr.de>; Sun, 30 Jun 2024 08:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77E8281ED7
	for <lists+linux-spi@lfdr.de>; Sun, 30 Jun 2024 06:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E98139FD8;
	Sun, 30 Jun 2024 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJgUA/s3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB539FD0;
	Sun, 30 Jun 2024 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719729537; cv=none; b=q0IAaqYZsVxNVY2k3r06fuMFQH3D4r+DRfHhpeSdJhl/k42CtIhVLvOVTSYLFpelyj9e2nJCVbNnpbl4zIOyEPRFTryVkGS4K4HznuplbYTxsVnD7tWufszMERJlqW7cp1BxZu97Hx5vcruiBX9ok/1bB5JlU7r9PqIxD3LsVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719729537; c=relaxed/simple;
	bh=WbPqT2wpd4+ZeKcUAwbmkkoCmR6ML4SAFPLKfk61mbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gn/JpZA0esyM4CUrjV8C42outy/Tk1rAY87Sufz00boqHaFQ/6AyRRs7FvAxh+C5nlXRldC2W73mC6H/d6qoU/pJPCzAMZ3gEHc0qjtLA8nvEkGuSgvWXyYm5UcMSK/1dbJRuXU+XZgMuHjbbedWhoARC/WomvoEr7OQRL5uAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJgUA/s3; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24cbb884377so1189253fac.0;
        Sat, 29 Jun 2024 23:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719729535; x=1720334335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QcY18BrD0/gIItoUlZh8XyBfrX5yv5R+UNZ4yG5hJ04=;
        b=IJgUA/s3NhU7hp8fpfn1W71leordKftmNUayhZGMaaynrH/uFDVJh3LWFZSbOet1Bd
         Ed+TDQjsTwPkH6IAVBbbKxiDN6s3Qmpgff/kPm7n+id59a+XQKuJfFUMIoFMX6qxf2LO
         bJSzE/7E5nfye1JwPKrY0hY9L0P4KtPb75CMWnE9fw7n+n+x1qTfrBNc1N7Kb9fjdpbk
         pyJ08wib4xVfjMO7V93DDhTCZsyY9FKmFf/17pJahfituL0GNK6y5SZNLIM8T+oey5tQ
         zigTcOgGxymmytTngypt7x7FQrZbBAX2snzM4YHlh/BHiZe0mUWDLiQ4UNtpwT4Tg4p2
         bfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719729535; x=1720334335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcY18BrD0/gIItoUlZh8XyBfrX5yv5R+UNZ4yG5hJ04=;
        b=ahxTajR8d4ggZgJDm5a2csyEjndja+O3YGmJ9AWWKjwgKCzjA0X3hpqFVnv7LD41vg
         cjgbbrODABdrjhgcFs9U9oiXpH7FarolpiG6WVTlsTKJMBGPSstb7q5xXoRQrwnIxrJk
         QYwwatY/u8z75eAg9ZbNJaqUE7rdmW2Ighi3969i/KTNxhAdm6A2zRFGJF0/mV7iT7lX
         i0Js2L8OMlUITv8YEbNjPVbHR6rUSuukSQHJwP7qIp4A4s372ojlJj7oq857H+8K4zLD
         +UxHp9n8G5sCwpytHmMyMKBuENPfZO8STOUUO+VHhR10Cj1D1xDG1w24pORkb3Mjy3YS
         UUhw==
X-Forwarded-Encrypted: i=1; AJvYcCUCCdSCE6RRvB61pnR+zxf+4NYwNMWxEMv9rQuRdj+dsHMcBzZ/2rBZuTJQgmVMS/VBA0ByoOSuNdTxM175xtgDh17ma4v8yse6UDP/obXES/47ATBPiVT1hqL3S9oE5KEAKiWqrnhV1JVvX2gq6LEBUoGfmMoSf0SHRlLMm7D5XsyXcw==
X-Gm-Message-State: AOJu0YwQu/r4k3+8UCHB5mTg1RCsHfAANFlnHJ1Ys+XXgQZD+P8LY4CM
	JXe2bQyN3ZJmKsC+yPNmYUgmX+XyAiIvRZ8iANi4NvcwMUVc8nH8
X-Google-Smtp-Source: AGHT+IHV1EFyJxWJPau3gYXlLOEE5X8O10yturZa5h2xV6cnNt8lNgwXIjAPH9L3av1Etv9r9X8Qcg==
X-Received: by 2002:a05:6870:d6a5:b0:254:a217:f8b9 with SMTP id 586e51a60fabf-25db344283dmr2390728fac.31.1719729534620;
        Sat, 29 Jun 2024 23:38:54 -0700 (PDT)
Received: from ga401ii.. ([2401:4900:1cc9:59f2:a68f:8261:cbcf:3139])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70804989399sm4164149b3a.193.2024.06.29.23.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 23:38:54 -0700 (PDT)
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
Subject: [PATCH] arch: riscv: thead: implement basic spi
Date: Sun, 30 Jun 2024 12:08:20 +0530
Message-ID: <20240630063845.116307-1-kanakshilledar@gmail.com>
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


