Return-Path: <linux-spi+bounces-8059-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7052AB252B
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 21:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343BB1B66466
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 19:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7858F28153C;
	Sat, 10 May 2025 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYDPvW8d"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77F27603B;
	Sat, 10 May 2025 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746906201; cv=none; b=UlqX76vujFoNTpDbTjN69Gheb1JSU2mut5HFVzPIbzuDDhm5d92EisTaUfKIjiUjE1pwun0qnjV2DcwCh1yyv12rG+KBnRFQM0SaMJDG823nZN3KY0kP41nIX5B6cfsFK1Qwb/XUdgnRxsqhLd+7iw2iNJyj9hsXkXJeE3PEUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746906201; c=relaxed/simple;
	bh=AqqaMB30uWeNBPi6eapQMsRaWN5WUqUZI3tfXltWrtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FN7H/2ZcI+gJ6LpVLLr6Bs6jFGAx/xlscGAcERsdmEc4P82DSaFjDpB/6/0CafGf1a8xvKWKOme77YUnUrxRPPu3ssCexIWXYSqKT98q4st2mPo3VAQF2G5ARLwZikb7PIN81OUSRf8g2QJ80tNZ3Srb+DdM9wOv9wKzK26ePoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYDPvW8d; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso724070b3a.2;
        Sat, 10 May 2025 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746906198; x=1747510998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRddgwOHN1Vyi2V2faPWngR/Eu23tCZlOEXW/jSpDeM=;
        b=KYDPvW8dHCCnjT2x4U66zgGTc2ydNmAZPkmYnymaOldOyViGgBRgemyPMjVKOTC65P
         imq0E4DhwTh/rO5q5ZrvjwrKwRhdzLiKKZb4IDjgDb+An6WLQNijxbNDviMCHItlWCNj
         Mn2ZYS13R6QhlWv2LgpE03g0TH6uuLxeJLzn/vRYKyViixjVAAK7igPPi74orbnRCFnz
         YSoJkRePmLROVs+m02o9AzDDxk8BXiALE2T1VhPOWGynco56E3PTPVJu8f9enHgeupt5
         BsgNevLpk+qJffQFMy7xor/I/ieShd1578ftx3UqnrvZCkpdku06/LJd+78SRwV8FDx0
         xfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746906198; x=1747510998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRddgwOHN1Vyi2V2faPWngR/Eu23tCZlOEXW/jSpDeM=;
        b=VOf3vxPXjg+l9GKhv1a48vz3NKTeFY4tZCbZgFWAX6CIDZ64S2U8DarKZb8YphduGs
         7EJ0jcaf/BT5OaBcxbtPVxPctgrcpz7FUetH1qkMxoj9HtA2DBtHW8Pq/lzRgu8JU6QJ
         pMPxeyWsM5a2pLCJqbTNRF6nKWbOG15HLCvpWx/8sKsHmwuhV1aGme8VDz8UR0jAZjc4
         fNi9xVlFYtGFFRex+pj4kfbdkDH8/5RESGyNQAa+rMNmdLj/q/9oRwIlzewibryzemh6
         zckC1mVhpe3rW6d05a8pX98Dz2DDmRV7+F5GFVVNNEn1wKYkCGJeF9bSoVcUEfIeMaLE
         jWhg==
X-Forwarded-Encrypted: i=1; AJvYcCWH/2JKkigPbmjs3bCpbIsy7MJ7TC3lXvnU5leSue+UVSzLq0aq8vVYER5LZh9U2s7FV4xbvUeDXLpL@vger.kernel.org, AJvYcCWScKZ763j0laDeUE1R2YLTLHIZOB3zBtthJX91KhNxVCvOQu8HmDzKqOcNzhQKRV41wbiuwMGtVZK67XwO@vger.kernel.org
X-Gm-Message-State: AOJu0YzcvjSJyO1zWAjGQ2LzrRsHw2lwwBqt9nILB4B8ekVqT7baei98
	YvgwPqQt4Qe4iIEQh29Nc78cpBa5Y+I+hi0mOeLCibkhxo9Jngi6
X-Gm-Gg: ASbGncup83+NoQ1YTqwcfUr/Msl0IOYkFniuMh29hylpzH1itFEkmGlTkKEn5n1p/P3
	M/EOS9NdYPEZ65Z/CPhQJwADw6IAaSqRTQm4iVkTW8M1z+kf28sZwVPqleh83gTD3yaGS1D0k2a
	okjickdJRE0gq8hUh2jqT+FG/Tn4LsNArOQ2AnABRnzxPs3p4NOE95nMM+paIo+Xj2V8LhIImmx
	liBY+io3f5Ea+amlPVPNrChhac0NEMzSfj7HSDV+kqXeJA8GT62TEZW3Taqnu3E+ls8dX9WLhmi
	szDjOhfkby/RU1AFfGmV72Uw50h55eLBc6McTTeNAzEMMwQpHqeHs5GYdFhQDwg=
X-Google-Smtp-Source: AGHT+IH053WbjA3cvqj9iQ8a7h5v+mWrap4AkYe2w2/EzsXrjAunLV+dXYcLOr/NytKnX5MMq0uq+Q==
X-Received: by 2002:a05:6a20:e68d:b0:1ee:8435:6b69 with SMTP id adf61e73a8af0-215ababcab7mr11814578637.1.1746906198481;
        Sat, 10 May 2025 12:43:18 -0700 (PDT)
Received: from NB-GIGA003.letovo.school ([5.194.95.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2523e67d53sm2223670a12.19.2025.05.10.12.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 12:43:18 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Sat, 10 May 2025 23:42:23 +0400
Subject: [PATCH 3/3] ARM: dts: vt8500: Add serial flash controller and its
 clock
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-wmt-sflash-v1-3-02a1ac6adf12@gmail.com>
References: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
In-Reply-To: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746906149; l=13606;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=AqqaMB30uWeNBPi6eapQMsRaWN5WUqUZI3tfXltWrtU=;
 b=9HbS2d3KP67QxcLBqUs+Dm8Msny0saXPEgDQmen+dSuDYtQ20sj7w1/xe9rRlJJ9Pq67aMgon
 FcjxhBj1ydjDOsdRKTsBdSXp5hOVWTQJQ+SRtcLotX7oLt+TcTEnOcn
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

The serial flash controller resides at the same MMIO address in all known
VIA/WonderMedia SoCs, and its clock uses the same enable bit and divisor
reg on all SoCs, feeding off PLL B.

Add respective DT nodes using SoC specific compatibles for the controller
to make it future proof in case any differences in behavior are discovered
later on.

All known boards boot from SPI NOR flash, so their flash chips are at CS0
and mapped by the boot ROM at the end of their CPU address space. Add
respective DT nodes in board-specific dts files too.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm/boot/dts/vt8500/vt8500-bv07.dts     | 37 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/vt8500/vt8500.dtsi         | 34 +++++++++++++++++++++++++
 arch/arm/boot/dts/vt8500/wm8505-ref.dts      | 37 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/vt8500/wm8505.dtsi         | 21 ++++++++++++++++
 arch/arm/boot/dts/vt8500/wm8650-mid.dts      | 37 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/vt8500/wm8650.dtsi         | 21 ++++++++++++++++
 arch/arm/boot/dts/vt8500/wm8750-apc8750.dts  | 37 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/vt8500/wm8750.dtsi         | 21 ++++++++++++++++
 arch/arm/boot/dts/vt8500/wm8850-w70v2.dts    | 37 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/vt8500/wm8850.dtsi         | 21 ++++++++++++++++
 arch/arm/boot/dts/vt8500/wm8950-apc-rock.dts | 37 ++++++++++++++++++++++++++++
 11 files changed, 340 insertions(+)

diff --git a/arch/arm/boot/dts/vt8500/vt8500-bv07.dts b/arch/arm/boot/dts/vt8500/vt8500-bv07.dts
index 38a2da5e2c5d64477f04e1da9d98cb97be0d95e4..c3c5ba3ac014cc49bee8c2b9e6c7b25225d4d5fe 100644
--- a/arch/arm/boot/dts/vt8500/vt8500-bv07.dts
+++ b/arch/arm/boot/dts/vt8500/vt8500-bv07.dts
@@ -30,6 +30,43 @@ timing0: timing-800x480 {
 	};
 };
 
+&sflash {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "U-boot";
+				reg = <0 0x50000>;
+				read-only;
+			};
+
+			partition@1 {
+				label = "U-boot environment 1";
+				reg = <0x50000 0x10000>;
+			};
+
+			partition@2 {
+				label = "U-boot environment 2";
+				reg = <0x60000 0x10000>;
+			};
+
+			partition@3 {
+				label = "W-load";
+				reg = <0x70000 0x10000>;
+				read-only;
+			};
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/vt8500/vt8500.dtsi b/arch/arm/boot/dts/vt8500/vt8500.dtsi
index 2ba021585d4889f29777a12473964c29f999f3a0..7ea115576c69b517cb2a08206638062f22c976a0 100644
--- a/arch/arm/boot/dts/vt8500/vt8500.dtsi
+++ b/arch/arm/boot/dts/vt8500/vt8500.dtsi
@@ -74,6 +74,19 @@ ref24: ref24M {
 					clock-frequency = <24000000>;
 				};
 
+				ref25: clock-25000000 {
+					#clock-cells = <0>;
+					compatible = "fixed-clock";
+					clock-frequency = <25000000>;
+				};
+
+				pllb: clock@204 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-pll-clock";
+					clocks = <&ref25>;
+					reg = <0x204>;
+				};
+
 				clkuart0: uart0 {
 					#clock-cells = <0>;
 					compatible = "via,vt8500-device-clock";
@@ -105,6 +118,15 @@ clkuart3: uart3 {
 					enable-reg = <0x250>;
 					enable-bit = <4>;
 				};
+
+				clksf: clock {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&pllb>;
+					divisor-reg = <0x314>;
+					enable-reg = <0x254>;
+					enable-bit = <23>;
+				};
 			};
 		};
 
@@ -114,6 +136,18 @@ timer@d8130100 {
 			interrupts = <36>;
 		};
 
+		sflash: spi-nor-controller@d8002000 {
+			compatible = "via,vt8500-sflash";
+			reg = <0xd8002000 0x400>,
+			      <0xff800000 0x800000>,
+			      <0xef800000 0x800000>;
+			reg-names = "io", "chip0-mmap", "chip1-mmap";
+			clocks = <&clksf>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		usb@d8007900 {
 			compatible = "via,vt8500-ehci";
 			reg = <0xd8007900 0x200>;
diff --git a/arch/arm/boot/dts/vt8500/wm8505-ref.dts b/arch/arm/boot/dts/vt8500/wm8505-ref.dts
index 8ce9e2ef0a81097e7143a5392ee5b42bf8028ec1..b037f9d919fb51a527f35276e2b8601f3f3d8505 100644
--- a/arch/arm/boot/dts/vt8500/wm8505-ref.dts
+++ b/arch/arm/boot/dts/vt8500/wm8505-ref.dts
@@ -30,6 +30,43 @@ timing0: timing-800x480 {
 	};
 };
 
+&sflash {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "U-boot";
+				reg = <0 0x50000>;
+				read-only;
+			};
+
+			partition@1 {
+				label = "U-boot environment 1";
+				reg = <0x50000 0x10000>;
+			};
+
+			partition@2 {
+				label = "U-boot environment 2";
+				reg = <0x60000 0x10000>;
+			};
+
+			partition@3 {
+				label = "W-load";
+				reg = <0x70000 0x10000>;
+				read-only;
+			};
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/vt8500/wm8505.dtsi b/arch/arm/boot/dts/vt8500/wm8505.dtsi
index 99c064c916b2279797f71261ca9306e9dcd4bbd8..bf9ba4e99f86d1bf41c4e4bfe8b4f71ad162be4f 100644
--- a/arch/arm/boot/dts/vt8500/wm8505.dtsi
+++ b/arch/arm/boot/dts/vt8500/wm8505.dtsi
@@ -203,6 +203,15 @@ clksdhc: sdhc {
 					enable-reg = <0x254>;
 					enable-bit = <18>;
 				};
+
+				clksf: clock {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&pllb>;
+					divisor-reg = <0x314>;
+					enable-reg = <0x254>;
+					enable-bit = <23>;
+				};
 			};
 		};
 
@@ -212,6 +221,18 @@ timer@d8130100 {
 			interrupts = <36>;
 		};
 
+		sflash: spi-nor-controller@d8002000 {
+			compatible = "wm,wm8505-sflash";
+			reg = <0xd8002000 0x400>,
+			      <0xff800000 0x800000>,
+			      <0xef800000 0x800000>;
+			reg-names = "io", "chip0-mmap", "chip1-mmap";
+			clocks = <&clksf>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		usb@d8007100 {
 			compatible = "via,vt8500-ehci";
 			reg = <0xd8007100 0x200>;
diff --git a/arch/arm/boot/dts/vt8500/wm8650-mid.dts b/arch/arm/boot/dts/vt8500/wm8650-mid.dts
index 7977b6c1e8ebf215df210dee703e470b9159d329..d3c8b7b99706603bab5aa8dad1165edb3763c2f6 100644
--- a/arch/arm/boot/dts/vt8500/wm8650-mid.dts
+++ b/arch/arm/boot/dts/vt8500/wm8650-mid.dts
@@ -31,6 +31,43 @@ timing0: timing-800x480 {
 	};
 };
 
+&sflash {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "U-boot";
+				reg = <0 0x50000>;
+				read-only;
+			};
+
+			partition@1 {
+				label = "U-boot environment 1";
+				reg = <0x50000 0x10000>;
+			};
+
+			partition@2 {
+				label = "U-boot environment 2";
+				reg = <0x60000 0x10000>;
+			};
+
+			partition@3 {
+				label = "W-load";
+				reg = <0x70000 0x10000>;
+				read-only;
+			};
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/vt8500/wm8650.dtsi b/arch/arm/boot/dts/vt8500/wm8650.dtsi
index 0d6c7bd87f7dcce0eef056d04c38ab1de5d52639..972b61d2437b1da9ce765b65f844872e8df4da1d 100644
--- a/arch/arm/boot/dts/vt8500/wm8650.dtsi
+++ b/arch/arm/boot/dts/vt8500/wm8650.dtsi
@@ -175,6 +175,15 @@ clksdhc: sdhc {
 					enable-reg = <0x254>;
 					enable-bit = <18>;
 				};
+
+				clksf: clock {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&pllb>;
+					divisor-reg = <0x314>;
+					enable-reg = <0x254>;
+					enable-bit = <23>;
+				};
 			};
 		};
 
@@ -184,6 +193,18 @@ timer@d8130100 {
 			interrupts = <36>;
 		};
 
+		sflash: spi-nor-controller@d8002000 {
+			compatible = "wm,wm8650-sflash";
+			reg = <0xd8002000 0x400>,
+			      <0xff800000 0x800000>,
+			      <0xef800000 0x800000>;
+			reg-names = "io", "chip0-mmap", "chip1-mmap";
+			clocks = <&clksf>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		usb@d8007900 {
 			compatible = "via,vt8500-ehci";
 			reg = <0xd8007900 0x200>;
diff --git a/arch/arm/boot/dts/vt8500/wm8750-apc8750.dts b/arch/arm/boot/dts/vt8500/wm8750-apc8750.dts
index 136e812bc1e498d48c7fc61154bc66a48888b117..4465946cfe44e82db1cad14c1f81237e1ccc0e67 100644
--- a/arch/arm/boot/dts/vt8500/wm8750-apc8750.dts
+++ b/arch/arm/boot/dts/vt8500/wm8750-apc8750.dts
@@ -24,6 +24,43 @@ i2c: i2c {
 	};
 };
 
+&sflash {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "U-boot";
+				reg = <0 0x50000>;
+				read-only;
+			};
+
+			partition@1 {
+				label = "U-boot environment 1";
+				reg = <0x50000 0x10000>;
+			};
+
+			partition@2 {
+				label = "U-boot environment 2";
+				reg = <0x60000 0x10000>;
+			};
+
+			partition@3 {
+				label = "W-load";
+				reg = <0x70000 0x10000>;
+				read-only;
+			};
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/vt8500/wm8750.dtsi b/arch/arm/boot/dts/vt8500/wm8750.dtsi
index 0158c0ba5dd110957eac38775d3bf3ebd2ab4154..d6b4e4463fae1e8a0a3cf0feecce7125b4a67f5c 100644
--- a/arch/arm/boot/dts/vt8500/wm8750.dtsi
+++ b/arch/arm/boot/dts/vt8500/wm8750.dtsi
@@ -240,6 +240,15 @@ clki2c1: i2c1clk {
 					enable-reg = <0x250>;
 					enable-bit = <9>;
 				};
+
+				clksf: clock {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&pllb>;
+					divisor-reg = <0x314>;
+					enable-reg = <0x254>;
+					enable-bit = <23>;
+				};
 			};
 		};
 
@@ -256,6 +265,18 @@ timer@d8130100 {
 			interrupts = <36>;
 		};
 
+		sflash: spi-nor-controller@d8002000 {
+			compatible = "wm,wm8750-sflash";
+			reg = <0xd8002000 0x400>,
+			      <0xff800000 0x800000>,
+			      <0xef800000 0x800000>;
+			reg-names = "io", "chip0-mmap", "chip1-mmap";
+			clocks = <&clksf>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		usb@d8007900 {
 			compatible = "via,vt8500-ehci";
 			reg = <0xd8007900 0x200>;
diff --git a/arch/arm/boot/dts/vt8500/wm8850-w70v2.dts b/arch/arm/boot/dts/vt8500/wm8850-w70v2.dts
index 5d409323b10cb94a5694722de1e31cff5be390ce..d2638a204579d3dff477bb7f458438037e08019b 100644
--- a/arch/arm/boot/dts/vt8500/wm8850-w70v2.dts
+++ b/arch/arm/boot/dts/vt8500/wm8850-w70v2.dts
@@ -42,6 +42,43 @@ timing0: timing-800x480 {
 	};
 };
 
+&sflash {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "U-boot";
+				reg = <0 0x50000>;
+				read-only;
+			};
+
+			partition@1 {
+				label = "U-boot environment 1";
+				reg = <0x50000 0x10000>;
+			};
+
+			partition@2 {
+				label = "U-boot environment 2";
+				reg = <0x60000 0x10000>;
+			};
+
+			partition@3 {
+				label = "W-load";
+				reg = <0x70000 0x10000>;
+				read-only;
+			};
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/vt8500/wm8850.dtsi b/arch/arm/boot/dts/vt8500/wm8850.dtsi
index c4bfb4d30aad0358b39cbf30edf0c63e32167bbd..6837198de2508536eef52537a7f451679d36c38b 100644
--- a/arch/arm/boot/dts/vt8500/wm8850.dtsi
+++ b/arch/arm/boot/dts/vt8500/wm8850.dtsi
@@ -217,6 +217,15 @@ clksdhc: sdhc {
 					enable-reg = <0x250>;
 					enable-bit = <0>;
 				};
+
+				clksf: clock {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&pllb>;
+					divisor-reg = <0x314>;
+					enable-reg = <0x254>;
+					enable-bit = <23>;
+				};
 			};
 		};
 
@@ -243,6 +252,18 @@ timer@d8130100 {
 			interrupts = <36>;
 		};
 
+		sflash: spi-nor-controller@d8002000 {
+			compatible = "wm,wm8850-sflash";
+			reg = <0xd8002000 0x400>,
+			      <0xff800000 0x800000>,
+			      <0xef800000 0x800000>;
+			reg-names = "io", "chip0-mmap", "chip1-mmap";
+			clocks = <&clksf>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		usb@d8007900 {
 			compatible = "via,vt8500-ehci";
 			reg = <0xd8007900 0x200>;
diff --git a/arch/arm/boot/dts/vt8500/wm8950-apc-rock.dts b/arch/arm/boot/dts/vt8500/wm8950-apc-rock.dts
index 58b3c8deb4f20ae072bf1381f1dfa5e5adeb414a..647fdcccdbbd680276af1fa30363e09bbeb5ad16 100644
--- a/arch/arm/boot/dts/vt8500/wm8950-apc-rock.dts
+++ b/arch/arm/boot/dts/vt8500/wm8950-apc-rock.dts
@@ -16,6 +16,43 @@ memory@0 {
 	};
 };
 
+&sflash {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "U-boot";
+				reg = <0 0x50000>;
+				read-only;
+			};
+
+			partition@1 {
+				label = "U-boot environment 1";
+				reg = <0x50000 0x10000>;
+			};
+
+			partition@2 {
+				label = "U-boot environment 2";
+				reg = <0x60000 0x10000>;
+			};
+
+			partition@3 {
+				label = "W-load";
+				reg = <0x70000 0x10000>;
+				read-only;
+			};
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };

-- 
2.49.0


