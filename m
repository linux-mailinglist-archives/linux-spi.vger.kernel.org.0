Return-Path: <linux-spi+bounces-8283-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 944B8AC354D
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 17:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7E51891D96
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1F81F8BDD;
	Sun, 25 May 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPhV+bou"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40AD1F8F04;
	Sun, 25 May 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748185192; cv=none; b=WuRL7QToKudW9Q5No4KjQMGlfUaKqS/3pHd7EdOzZraQ7ByaIQ8RIkuAh7h5fc91T7a0kCGdSOwedUqccV412MMSgGItpzBCkwP6QxfDmAGORmONdM19cmm1nYIXlekAuVKTB+iWs4tvoFLKGY6EZ9a0mksoP8IY+RwDYuVbVxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748185192; c=relaxed/simple;
	bh=1GDh0zAEry6mVGUqkPUqxMLAqpRze3QvTZVNyNvZNiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=teFEu3aIJXg4V7t7S+po50hvuZHycFxZz9oaa+I9LgnXIZleDKK1Rqysr5OBRohA96OSiRGqiCQHZXgf6vwm7hPsTSvIiAIeY7t6rcQ7UwmVk1BJAYGaaJhVAANGhQE2ZF8VOpJkPm7B4AjsEFc1vhi8pPnF8UfldTjnTJoa0mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPhV+bou; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b26f5eb16a5so984111a12.0;
        Sun, 25 May 2025 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748185190; x=1748789990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxmiZPl5Ck8pukdGXQ0/lqOM6oa5lUIp5yTgqKF3faw=;
        b=KPhV+bouIRcQp495+5mKGITEDr8f+PWZS7HntVg/xmPNgYyEr0OyFiFGYK9oO8L1eL
         VajYWzeVVsfiA8xH/032fTxKVlYrxBv78PNioGMEyvY5f1SlWh0GAzUEYEyOKTsfv9Bd
         uDlcN2jlmKx2KeNvn2MB2lOxhqxayXdS93fju5ZWs+P3RB04/EEgx8/JOUUdljrthoe9
         Lqdju1tOtRkzFvW7cr9gFYUhJcL2KNANEcOT5xKxlxfX8O/NhnASj00GAOjZns9DTM6x
         dKewjfzWm4nb13ISWem3jvESoZ5MqPQcSbooMv/8zsjRMUagGnORiv7aryumErd3HUaV
         oKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748185190; x=1748789990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxmiZPl5Ck8pukdGXQ0/lqOM6oa5lUIp5yTgqKF3faw=;
        b=tTL+fb3/kWbX7/8H9NAZJ/aNyiGwP01uRnMv50JfvtbZ4DMj/FDQim8XlUwT+ulNOh
         97gdgdnSP47pQII8dcf8t/2GkmHdPZFC6AwswYrlWa8W+ny0qV4np88ZXXvScTM+Pg1w
         QI8Ld4eqM4Eue84loZwpM1mrp1mhKAMk1SNnDGzsEYin6GgQwipmYg0tAhnfEB7TTVOV
         4XN5du6KLk3igsCRxbBvuVLAMWPsdLEJaETJzILhhP88bHexey6CRbcUmayoDgISynSS
         L+oqa/p8DUKJWN8M6rpxeSfjRznKctc4QyGLrX8I7hr3lUbZEynUZgNfQjEt5R22940b
         elZw==
X-Forwarded-Encrypted: i=1; AJvYcCUuV8gRrZXLPo8HgdCmf/eb8AoIQJOCvbYufCsZZoUhprs86Ls8aIJbjDhZfFza/D1ASARvmct6ccX9Ld3V@vger.kernel.org, AJvYcCXEQYR2DwuNXH3jmDqgS2s0NaZcaJmoCfNTge/6Z/vcNEjc63URahSz1z6KWtJguE+kfjlqhEfQzM5f@vger.kernel.org, AJvYcCXNCSnTn7VC1VnfWzq4Wyh5zvxF+gtsKcwveKarzFdfX1XmsXK87X/1fBJS5MVsdv150lK1P5pkN7SD@vger.kernel.org
X-Gm-Message-State: AOJu0YyaNNG9tLp/5LKepPz/kz0NS6a2oLx5bLOCbXtNYpKw3N9W6UZ4
	4wWhCzBVLCY0OJaJayGOIGELz9aSbGmkICYUw9h5VLb2KdfuVYi8Fb3O
X-Gm-Gg: ASbGncs27d/EBJ7cRMJRh9GkIFUe/+rRCRPLRpQVNy8bPSmMJq92ngpoGmqzAmJv0xX
	AK/KMhlXS245SUl3DZ9q0GHVB/ysQqGKBd7/pZp2EvrjLy/XzOh9RAZqxMBK2IlYEkIjdhlJZPo
	D3K1RFZaTJbLhKS50NXNcxUHBHeEQeN7Yq+ZvD+OkIn68uMq40685fysGA7EFcjWDkdwlcO889T
	1EnBwnKx+rw7gzI0oarXNLRjwGierE4wRiuP1Hb8vHM+D/lnKHuy8BdVEoVxsH3vbI+bw6RORaQ
	dWWnlSIXHm4GsAhnFp704gPwZYLyUvEAtTEPWuboPv0=
X-Google-Smtp-Source: AGHT+IGunpP59ynpyV2hBlZb/lg+XTXK4YdN1s4v9vrB00vwAMIKxbDWsG2m36xfm44uu5CUSMBefQ==
X-Received: by 2002:a17:902:c94a:b0:22e:23c1:d711 with SMTP id d9443c01a7336-23414df58fbmr94181685ad.16.1748185189378;
        Sun, 25 May 2025 07:59:49 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::3fc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2343f8e2fbesm12204845ad.250.2025.05.25.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 07:59:49 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Sun, 25 May 2025 22:58:43 +0800
Subject: [PATCH v2 3/3] riscv: dts: sophgo: Add SPI NOR node for SG2042
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250525-sfg-spifmc-v2-3-a3732b6f5ab4@gmail.com>
References: <20250525-sfg-spifmc-v2-0-a3732b6f5ab4@gmail.com>
In-Reply-To: <20250525-sfg-spifmc-v2-0-a3732b6f5ab4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748185167; l=2232;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=1GDh0zAEry6mVGUqkPUqxMLAqpRze3QvTZVNyNvZNiQ=;
 b=pAjTR2y1Jyl1kOT2HIrGue4nOoASxsqz3sFfNJmHw8RhUwHa6kMtiZX2u+s8DVtmQlF8uG2Vd
 gFPcGRCfky+AG7+eNwNKD529Vou0ucmxp82i1NihK/sy7VEEbG43NqB
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


