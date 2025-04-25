Return-Path: <linux-spi+bounces-7753-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6AEA9BCDE
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 04:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD62F7AE34B
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 02:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D95156F20;
	Fri, 25 Apr 2025 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia4Zbbq0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939921487F6;
	Fri, 25 Apr 2025 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745548141; cv=none; b=kGcsK6LHiMdvXL+KFsZGQzUXw80a/P5AhCvHkrZAY7OnMTjExvFbeMHqnt+lrkQTfS4J3QJSZssXqmbi4oiZK4OKsIzRu2wPUFY9XkG2C0wKvXlpOXeCTwoUjoM51/sANJuy8Gc2e3/ae9P2iGh46o2Q2r62BQ2Ot6jnFkK5xXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745548141; c=relaxed/simple;
	bh=bsOb61YGYomuONd3drp4jb88EZWek6I8D8vdw/YFqjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rh3H49vRk945uiigRpb2+nJd7/VJPlqq83/7Jd+w2es9+PywEgraAVxYpLY3c8BS0DgjkCOTbaDDaCzkpT1aKLPcCfowUDHBhD23aX+eWJw5LB/6I6iNEYMMPt42Hg7sNQsaa/FUI/dhiAnCefzsa95lVC8VkJjDVXFhWaXi6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia4Zbbq0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3035858c687so1434733a91.2;
        Thu, 24 Apr 2025 19:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745548138; x=1746152938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYhIc8nI7TQrbMQ5ehdUi9XRR8BUa9kFTApEz1i6px8=;
        b=ia4Zbbq0IHIPS4s48TlLwbwphEXCntwfkhmu7ggJSV6q4r3wMj991lLsE4SgeYYR02
         h5UlnSjToqn60W5oUSbcXV8RYYzRDpid9t+yD9dRHaSkPnTHegXzmwMdOX7Bb+f7Rvsd
         MoOhnp3zTTbF4RFjA0qb1QmqMOgv7QD/1GpGOmZFQ6VATpeOyGLNy24r7R1IqU3o51Cd
         ob6VwxLYNbDF3wssbGHsRe0T6S2k2+Eky7i4CBojrJB38KaiVvBUQDXVi9MxFJTCc5Bp
         4FfCUzQPHQ+qVh7bqYxr2YR8NWzN/PQge84OSDjglXz0NmZ5+0tRdsR26F8v42mDsHE4
         WwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745548138; x=1746152938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYhIc8nI7TQrbMQ5ehdUi9XRR8BUa9kFTApEz1i6px8=;
        b=m+QktRt71kMCrxQh8SqKpmDK/HjvNSvNQrvGYA6dQf6laB7E99lKItmmaUPdQY/1x7
         /SOfjo7kWAh1B9V9kwwF4FmuxUfrF2Yu0GStamVxIQPUdABz6WV++lLlKXoSp38uXOS8
         fZnH1CgyJmgRKvhqRlb4PWgAsqMCI6kzxwNwJzTzoSHKOK0QUc47Z6c+oFPjwDWJ/VGL
         nCq5/W0L8ail7EjLqnmUBtD1SKCbJXkqqlCGABsDA0Xt2pnY8yVwRsLt9pWk+dRas9/k
         Y927kGE2Am92khvJ5Atemj/4Cws1GVPnrU3hySfA8zLJOJIbbrfXsb8XR8O3b39w5/yH
         rpEg==
X-Forwarded-Encrypted: i=1; AJvYcCUr1TMlqz23hJ3WZ1qKDpsgFCD1H0G9i0xsR3gOptUCm0UcH+6UJQZ0PA/k9TF1Ily6DnF+STUPMaKIR8Fo7ak4SnQ=@vger.kernel.org, AJvYcCV+PUryZsyJanB6D3v26jt4Zm2UHA6rOojf2hq2z6w0x+Uu7Hi8CmqTESAdtjMpx3QbS5Zn0V+u1CY3PkM=@vger.kernel.org, AJvYcCXP3vSOr/cHAj4nANfxTVBndAm+0YeIZQmDN7ga4GeQjEKFUukgKJRg5MsSa9UyEnrhYPyVKB6agblM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+wN0KwR5ibVKT1aTwtkJBWlAQLXy90Twru5cNTVRMZ7ZV9HIY
	yejmmqo0mMKHTLVTOs2KRuWg/lKtfjZGwPLP869g0UUEuWSwoNLgDAF32uBr6jA=
X-Gm-Gg: ASbGncsyBxlZ0Zd/Q1MgeQ8PiZSdolK5/oFSpmfQCjiXqpy3nkxCWS5uuUKmctiYFcF
	6/O7kaW92NPrLdtgOWEQpmFMTxLamKhmjJwyaVIcp9ajVf5q3hNVfDpgFMsXkjzHK9cz2fLfo9A
	WQIf1wiy24PZys9uCAR6CWqEu6E6Zfe/DE0Y0M8QvTlaVkCKF9xF+Xc4plFxqv/8GMVMSwtF2LG
	gsLoLQoGLP/xUfPW7ZP1Xg/f0ckLvkLIIy2bBeo6uQrIdpVq3gZbqwOFrFsqqzR6UTSw/s3wwRl
	kizm5jP5P1D+NfCUNSpSvILVr0nu4pcbzDs8NeMOh1UOVA==
X-Google-Smtp-Source: AGHT+IFQ/ASdtiEJLWyy0JwXJvK9BuImD6nRYcmLkOuTSd7G4uxDP0nuVfFuf8LFPcPjATGegctLZg==
X-Received: by 2002:a17:90b:558c:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-309f7ea86abmr1328288a91.33.1745548137606;
        Thu, 24 Apr 2025 19:28:57 -0700 (PDT)
Received: from [127.0.0.1] ([223.80.110.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f782d4a9sm365455a91.30.2025.04.24.19.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 19:28:57 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Fri, 25 Apr 2025 10:28:14 +0800
Subject: [PATCH v6 3/3] riscv: sophgo: dts: Add spi controller for SG2042
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-sfg-spi-v6-3-2dbe7bb46013@gmail.com>
References: <20250425-sfg-spi-v6-0-2dbe7bb46013@gmail.com>
In-Reply-To: <20250425-sfg-spi-v6-0-2dbe7bb46013@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Mark Brown <broonie@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 sophgo@lists.linux.dev, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
 dlan@gentoo.org, linux-renesas-soc@vger.kernel.org, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745548101; l=1524;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=bsOb61YGYomuONd3drp4jb88EZWek6I8D8vdw/YFqjA=;
 b=0QyxC+63XX3Z4RcBnZwI+jfagaTUbfSPhQbRudW6e2AL4aoUOOld3mI48zwlew9sNlIgXaoqk
 YmltacDzoa4Aa3AoJ2E0K74/56hzddLfwyrfC7PxbezhYZU+k/gUfTg
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add spi controllers for SG2042.

SG2042 uses the upstreamed Synopsys DW SPI IP.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index aa8b7fcc125d71eec12b09493964d90f5dfed27c..ddde4c613c4734db191de500b016b322a9602efc 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -537,6 +537,32 @@ uart0: serial@7040000000 {
 			status = "disabled";
 		};
 
+		spi0: spi@7040004000 {
+			compatible = "sophgo,sg2042-spi", "snps,dw-apb-ssi";
+			reg = <0x70 0x40004000 0x00 0x1000>;
+			clocks = <&clkgen GATE_CLK_APB_SPI>;
+			interrupt-parent = <&intc>;
+			interrupts = <110 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			num-cs = <2>;
+			resets = <&rstgen RST_SPI0>;
+			status = "disabled";
+		};
+
+		spi1: spi@7040005000 {
+			compatible = "sophgo,sg2042-spi", "snps,dw-apb-ssi";
+			reg = <0x70 0x40005000 0x00 0x1000>;
+			clocks = <&clkgen GATE_CLK_APB_SPI>;
+			interrupt-parent = <&intc>;
+			interrupts = <111 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			num-cs = <2>;
+			resets = <&rstgen RST_SPI1>;
+			status = "disabled";
+		};
+
 		emmc: mmc@704002a000 {
 			compatible = "sophgo,sg2042-dwcmshc";
 			reg = <0x70 0x4002a000 0x0 0x1000>;

-- 
2.49.0


