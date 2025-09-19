Return-Path: <linux-spi+bounces-10168-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB4FB8A789
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 17:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727FF587A11
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A8D320A29;
	Fri, 19 Sep 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="hIba/qvU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE931FEEC
	for <linux-spi@vger.kernel.org>; Fri, 19 Sep 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297566; cv=none; b=RX5meHqUp6wJkZ1XVffr33ybLOjVlE/17xkmSejkMiuoS76EU7XMpeLrHz9g1b1hvJFPhO3C22NrBwQf6ZmbIhdbTpahyD5AnxExDTrTqxKbhXbZTSZamm6LMdh/ueRlD1gdR7lPUXA4pIse1PAoszEFzbPzh0N6UlrkjGpld/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297566; c=relaxed/simple;
	bh=NlMkLdvD64IRA/MwFZvIoBYriU4Nid/OitYs5+FRBUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOHYNetWrFRhpXr7s9o/wIYT1/Jy3DZ8rpMiGY2s3fKqoR1vKxrhEfpU37fGe4g/O1eSg4j4r3z5Us4lmM/CvsLAwQlMQibGtB2az/zts6HLf2zy0JECtk/9x/1GesYkrEkdixS+f++cPrSXQcIa/LQ6wmJ0qkeNDx8PcGp/HD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=hIba/qvU; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4248b13dc1eso1365615ab.3
        for <linux-spi@vger.kernel.org>; Fri, 19 Sep 2025 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758297563; x=1758902363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oo7s49MWiPP0XpbU9jJjL7SpuVNC45j91Je82FzACGw=;
        b=hIba/qvU9jPG2mLC86wu4sLVoK7VbCJibIkixSqa6F6tzSbpIyq0ZR8A6svQzqFQnC
         GNN/aijr3a26oe9k/JIaldh8tW+ENCK/cbJVgDGCzp0V7f64qpELN7KFMlnIO0frmf7c
         khWz40qeAYc/W8Db8KcS4KQpYBjSyJmzycXw2S3Eb6DRgR76RdwVG9L2t7fYBX8itstE
         H3op3/V+iOv4CrMZtwstDlPwVeVyi/oICgjChjqiWo6NNXzBSp2k6m0Gz7uRaiNkN3j8
         utPs70cZGC5dX7yhXyeRtVYW+WHxeZT+FQdNIHbXhTiCLfCLSeE3Fz2bOV9iXkpIHP3E
         aJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297563; x=1758902363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oo7s49MWiPP0XpbU9jJjL7SpuVNC45j91Je82FzACGw=;
        b=oqQt6j4eptEPLLvRsd4Jx3VwQiu1fnrfVMXDQCgJvHsmUAJ3CkCu4wLeSygst15jq+
         cZRtI5MdB1fZssDEaMJ8KUAvrw3djh6ULQXWg74ORmRZpXRuMV361tXWKpF3xqPelQeN
         SShJzJBmG721Izz73sBysAPquYl3XA03e4gDV6Vi9nL4VzOTWzuWf57SGnj4nIvbcwUb
         ATXvTwd8LYO8Zz3OHLdGypWG+1wlS4gFTCEdMYCh7gHQgmin7BW3WMMJehbTwVj6mJBg
         K39wbXIb/8CBT0l+MTNERn8hBC/5ElRUDREtH//aa5KbfkO53aKa2rWEYVowPfw2++jy
         fv6w==
X-Forwarded-Encrypted: i=1; AJvYcCVO2XeC9Mw80D8nEi1ZwJk+47T60C1b8W8LhegnjbsZkuvBndKRCx3PjxAZ6BE12ad8cF3FBukBZhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/R3VMl9/edL7N0loymDcPbit5Dqm+ty8oHwLLd1xw9rjQe9jX
	GpLUkpXHy7wcJ/t0EQCWG2cmn7Ah8Pum6O10/lajjlEeWoxY7WANBO1TbiugHVQeulU=
X-Gm-Gg: ASbGncsYaPP4WVmmdkpnx1bbRNn7yY/9qi5XLGqbYctHa6CCweJuXPA+rXw++hlJpM/
	QgR2QcVodU5+X+9tCfvZuJ/6Hw+YEJvwGCxSON6D8Vo9HQgGsxyki1hAmOj3nD8L/YeLk4dgmfz
	aIxhVq3OMrR8e/iub9/OI+SVIamAgOGug/zRhzFjSA8XYd7y451V7keCLiSC1uxs3r5HzKNbO0z
	cgxnHlSUaJ/K85ckRU/nKYbDyJm7vXhauU/FNbtIPsL2sgyxp9uYkL1WGiyDzb6ze4hpLN2VT8j
	oOLDEzpCr1PFfqDH4EuqvaP/i5dPVJeXOYjuNarxcf38T1msvhLhm1vE+q/kETj5YtAjZkYZ+uU
	vdFN+Y/SRNZltV1bIl+7YYRrvxdO94FldkMxnLkYBJi+U3FbCJrR0w1KZ0l0N0/MGZg==
X-Google-Smtp-Source: AGHT+IGv8Gt7EaPcdotr9gY5Yd6METFFETdEj+xRnRLa13tdcKb2eRmmBl1GTwt/NGaaW1sg3ZmbBQ==
X-Received: by 2002:a05:6e02:258a:b0:423:fdc4:4e35 with SMTP id e9e14a558f8ab-4248197e1b4mr55249165ab.24.1758297562539;
        Fri, 19 Sep 2025 08:59:22 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d50aa460bsm2250898173.52.2025.09.19.08.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:59:22 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	ziyao@disroot.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] riscv: dts: spacemit: define a SPI controller node
Date: Fri, 19 Sep 2025 10:59:13 -0500
Message-ID: <20250919155914.935608-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250919155914.935608-1-elder@riscstar.com>
References: <20250919155914.935608-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a node for the fourth SoC SPI controller (number 3) on
the SpacemiT K1 SoC.

Enable it on the Banana Pi BPI-F3 board, which exposes this feature
via its GPIO block:
  GPIO PIN 19:  MOSI
  GPIO PIN 21:  MISO
  GPIO PIN 23:  SCLK
  GPIO PIN 24:  SS (inverted)

Define pincontrol configurations for the pins as used on that board.

(This was tested using a GigaDevice GD25Q64E SPI NOR chip.)

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - DT aliases are used rather than spacemit,k1-ssp-id for bus number
    - The order of two pin control properties was changed as requested
    - Clock names and DMA names are now on one line in the "k1.dtsi"
    - The interrupts property is used rather than interrupts-extended

 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  7 +++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 20 +++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 +++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 2aaaff77831e1..d9d865fbe320e 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -14,6 +14,7 @@ aliases {
 		ethernet0 = &eth0;
 		ethernet1 = &eth1;
 		serial0 = &uart0;
+		spi3 = &spi3;
 	};
 
 	chosen {
@@ -92,6 +93,12 @@ &pdma {
 	status = "okay";
 };
 
+&spi3 {
+	pinctrl-0 = <&ssp3_0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index aff19c86d5ff3..205c201a3005c 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -76,4 +76,24 @@ pwm14-1-pins {
 			drive-strength = <32>;
 		};
 	};
+
+	ssp3_0_cfg: ssp3-0-cfg {
+		ssp3-0-no-pull-pins {
+			pinmux = <K1_PADCONF(75, 2)>,	/* SCLK */
+				 <K1_PADCONF(77, 2)>,	/* MOSI  */
+				 <K1_PADCONF(78, 2)>;	/* MISO */
+
+			bias-disable;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+
+		ssp3-0-frm-pins {
+			pinmux = <K1_PADCONF(76, 2)>;	/* FRM (frame) */
+
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+	};
 };
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 6cdcd80a7c83b..f8c37d16968e4 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -856,6 +856,22 @@ storage-bus {
 			#size-cells = <2>;
 			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
 
+			spi3: spi@d401c000 {
+				compatible = "spacemit,k1-spi";
+				reg = <0x0 0xd401c000 0x0 0x30>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&syscon_apbc CLK_SSP3>,
+					 <&syscon_apbc CLK_SSP3_BUS>;
+				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_SSP3>;
+				interrupts = <55>;
+				dmas = <&pdma 20>,
+				       <&pdma 19>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			emmc: mmc@d4281000 {
 				compatible = "spacemit,k1-sdhci";
 				reg = <0x0 0xd4281000 0x0 0x200>;
-- 
2.48.1


