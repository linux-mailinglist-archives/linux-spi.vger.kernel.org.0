Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A26C2E872C
	for <lists+linux-spi@lfdr.de>; Sat,  2 Jan 2021 12:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhABLzM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 2 Jan 2021 06:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbhABLzK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 2 Jan 2021 06:55:10 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857DFC0613ED;
        Sat,  2 Jan 2021 03:54:29 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id r17so20984164ilo.11;
        Sat, 02 Jan 2021 03:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QIxNzOg49Ezkj2elfguFMTM+G9xMNVKyeVpYdfk4ojs=;
        b=UnLbBkf0Y5FmjlRfsDIC+HAnCQs1xJW+7TPTMINA4nHyHZGovb77DhUDpt2HnPZxy8
         wJDHV3S9fLsSTGSlyPSQpAugkaaT0drHmliPIFZLjxEMv1rRX9eA20ptPjBOd8Lf5ZHu
         FPlPEIqpOmXWPdzq7K4W/7UvQVH+t+Mdi05y9LqAy4yE46HEZKgpBmP5S1l8AL/sjI9l
         UuvM1ygHq5kLqFbWWKPvglepW+Ym8ub9bkYOPJ+noUY5DcicEsCHAimkv7FSzaN+lanf
         FioweL3TEZqywDKQTnEMAkjkFk96HcmX1bod+5cnJ+1zM2ZdgLI9llMW/eSoJNv3dF2O
         rWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QIxNzOg49Ezkj2elfguFMTM+G9xMNVKyeVpYdfk4ojs=;
        b=dLInfOyCmW6hQogLqQa7OGurr3kE4WzgWFk1J2iZyQR8mXbB/bSIc0p0dRpk+dpfpn
         DXgAweIAlDWjqJuktq0OHMZZURV6vRKRomQ2cAq+9iPLAJnhF252+tIAQzlUPBa2pm5g
         GhI3xopKkLe2IQiC3YOSqWAT5rixsTwNWPkdL/VqHbmtzk2k+FmbADZybsSC9ceIqzDq
         uTpNMtlolzTpcuWwr4d9ilQcVX5nye8OPH87N3Idll9k6VMZJT1fQ4YDsKCdLsZHpUnB
         AFVj1XlMVrqmCEBpqw6l5KC4aOt+p0C3gLKPk1CalrhljRSgJRTvhhvMDhR8N0QbpybU
         0KqQ==
X-Gm-Message-State: AOAM531R7HVY7ZY7SVo7bbnpMmNrjn33jpqxRxbwmyYXeofYIPik2DFq
        lGY38QbGFqjsu6VM4npWrwtYZx0b77+O9A==
X-Google-Smtp-Source: ABdhPJwH8aDh5f6BG4Rad2t8bTqFS3WHZya7/511uLZx3dugZdUnxrzxoJqmO8Yzc9FXfzlkBsbZ3A==
X-Received: by 2002:a92:8404:: with SMTP id l4mr62859671ild.49.1609588468488;
        Sat, 02 Jan 2021 03:54:28 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:f45d:df49:9a4c:4914])
        by smtp.gmail.com with ESMTPSA id l9sm37218245ilg.51.2021.01.02.03.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 03:54:27 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     aford@beaconembedded.com, biju.das.jz@bp.renesas.com,
        Adam Ford <aford173@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH V2 4/4] arm64: dts: renesas: rzg2: Add RPC-IF Support
Date:   Sat,  2 Jan 2021 05:54:12 -0600
Message-Id: <20210102115412.3402059-4-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210102115412.3402059-1-aford173@gmail.com>
References: <20210102115412.3402059-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The RZ/G2 series contain the SPI Multi I/O Bus Controller (RPC-IF).
Add the nodes, but make them disabled by default.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 17 +++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 17 +++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 17 +++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 17 +++++++++++++++++
 4 files changed, 68 insertions(+)

V2:  No Change

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index d37ec42a1caa..5246f4d91e84 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -2302,6 +2302,23 @@ sdhi3: mmc@ee160000 {
 			status = "disabled";
 		};
 
+		rpc: spi@ee200000 {
+			compatible = "renesas,r8a774a1-rpc-if",
+				     "renesas,rcar-gen3-rpc-if";
+			reg = <0 0xee200000 0 0x200>,
+			      <0 0x08000000 0 0x4000000>,
+			      <0 0xee208000 0 0x100>;
+			reg-names = "regs", "dirmap", "wbuf";
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 917>;
+			clock-names = "rpc";
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
+			resets = <&cpg 917>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@f1010000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index 83523916d360..5862aa2ad2bf 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -2160,6 +2160,23 @@ sdhi3: mmc@ee160000 {
 			status = "disabled";
 		};
 
+		rpc: spi@ee200000 {
+			compatible = "renesas,r8a774b1-rpc-if",
+				     "renesas,rcar-gen3-rpc-if";
+			reg = <0 0xee200000 0 0x200>,
+			      <0 0x08000000 0 0x4000000>,
+			      <0 0xee208000 0 0x100>;
+			reg-names = "regs", "dirmap", "wbuf";
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 917>;
+			clock-names = "rpc";
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 917>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		sata: sata@ee300000 {
 			compatible = "renesas,sata-r8a774b1",
 				     "renesas,rcar-gen3-sata";
diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index e0e54342cd4c..20fa3caa050e 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1654,6 +1654,23 @@ sdhi3: mmc@ee160000 {
 			status = "disabled";
 		};
 
+		rpc: spi@ee200000 {
+			compatible = "renesas,r8a774c0-rpc-if",
+				     "renesas,rcar-gen3-rpc-if";
+			reg = <0 0xee200000 0 0x200>,
+			      <0 0x08000000 0 0x4000000>,
+			      <0 0xee208000 0 0x100>;
+			reg-names = "regs", "dirmap", "wbuf";
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 917>;
+			clock-names = "rpc";
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 917>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@f1010000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 1333b02d623a..9be94945af8c 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -2393,6 +2393,23 @@ sdhi3: mmc@ee160000 {
 			status = "disabled";
 		};
 
+		rpc: spi@ee200000 {
+			compatible = "renesas,r8a774e1-rpc-if",
+				     "renesas,rcar-gen3-rpc-if";
+			reg = <0 0xee200000 0 0x200>,
+			      <0 0x08000000 0 0x4000000>,
+			      <0 0xee208000 0 0x100>;
+			reg-names = "regs", "dirmap", "wbuf";
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 917>;
+			clock-names = "rpc";
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 917>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		sata: sata@ee300000 {
 			compatible = "renesas,sata-r8a774e1",
 				     "renesas,rcar-gen3-sata";
-- 
2.25.1

