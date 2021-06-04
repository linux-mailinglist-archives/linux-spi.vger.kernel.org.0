Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5289F39BB7A
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 17:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhFDPN7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 11:13:59 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:37611 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFDPN7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 11:13:59 -0400
Received: by mail-ot1-f51.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so9370650otp.4
        for <linux-spi@vger.kernel.org>; Fri, 04 Jun 2021 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmERDzA/ERlMENTHiwmD7XH/Ew0+jugDLfjVr8CV6Vc=;
        b=CRxqr94ZqH9d671tSQn0MTM+grqoReU2f9urbwT/W+ArDZyttNEfzit+tqZjXQqT6O
         jb+HYb7pTJA3x07ewTDMBvaCFQC62kVFscprjJjmy/JY0MJGh8fbPnU1y5BS7ITFIgJp
         N+EQGDuFLCBGvwyoMYbOQ8zC2djV3hwAT+/C8HDZE3WEX4ACdUm59TvwroAQ4IPscJiE
         KsbBoj0Eh+LSlFxhOcFOsBseVAVPhXi8HGCv87eTrVFnks/D/alvg8EhgsGBwHr51LU7
         1D3jzJ5dMETcEZnWPIZUpyJUgCo6Op3+0iM9bsJoO6emCV2DYxGVlBWaFdSaSK6h5Jd0
         Lddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmERDzA/ERlMENTHiwmD7XH/Ew0+jugDLfjVr8CV6Vc=;
        b=dlOYKu+q43ZEJRJ1YL5LS6Ch0AoVS/bb0UjH7br8PkrxLzfZbinlHnjAfhoP7MGin1
         qvi4kss5iwOCSXd57wDCaYS/wMylE9ULMQ6wSPDfcCDHtm41WqoQh73TfEUACRn7a1Yw
         XcFqFcftqQeJSlJ+FD4rVyGBCa++eVbIm+KaRmwbLGMwHJ8kfgV3r7EL+5ejhMyAD6z6
         uhwrPfUl7NdBqLxrrLlWY+39qsApvZSUXgis49BcQaqLg9y9RIT4iZQDqU5BK9jXKzI+
         u4UTblw/lZXvdhYy4m+FO2U8zzPhSfFMIqb9KpdIDQGyGnXHba52nb6qLZTeXRB8N2/a
         Ue6Q==
X-Gm-Message-State: AOAM533cesCeyxQcXo4sglGQUzOSFBjh5v5/j9WYjf42kSZakvhe/wPF
        JZs8dTozJqEwePd0mVwMwgUaD8e4bRM=
X-Google-Smtp-Source: ABdhPJxPipvsTaYVm4HD/RnZJ1adBvAEiC+ZGAajw9Jb6T1P7/BYagDEAJ1ajdqby7URhDqtlTbOBg==
X-Received: by 2002:a9d:608b:: with SMTP id m11mr609120otj.146.1622819472219;
        Fri, 04 Jun 2021 08:11:12 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id k16sm523440otp.19.2021.06.04.08.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:11:11 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC v4 3/8] arm64: dts: rockchip: Add SFC to PX30
Date:   Fri,  4 Jun 2021 10:10:50 -0500
Message-Id: <20210604151055.28636-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604151055.28636-1-macroalpha82@gmail.com>
References: <20210604151055.28636-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add a devicetree entry for the Rockchip SFC for the PX30 SOC.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 09baa8a167ce..cc7aced2dde9 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -966,6 +966,18 @@ emmc: mmc@ff390000 {
 		status = "disabled";
 	};
 
+	sfc: spi@ff3a0000 {
+		compatible = "rockchip,px30-sfc","rockchip,rk3036-sfc";
+		reg = <0x0 0xff3a0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_SFC>, <&cru SCLK_SFC>;
+		clock-names = "ahb", "sfc";
+		pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus4>;
+		pinctrl-names = "default";
+		power-domains = <&power PX30_PD_MMC_NAND>;
+		status = "disabled";
+	};
+
 	nfc: nand-controller@ff3b0000 {
 		compatible = "rockchip,px30-nfc";
 		reg = <0x0 0xff3b0000 0x0 0x4000>;
@@ -1967,6 +1979,32 @@ flash_bus8: flash-bus8 {
 			};
 		};
 
+		serial_flash {
+			sfc_bus4: sfc-bus4 {
+				rockchip,pins =
+					<1 RK_PA0 3 &pcfg_pull_none>,
+					<1 RK_PA1 3 &pcfg_pull_none>,
+					<1 RK_PA2 3 &pcfg_pull_none>,
+					<1 RK_PA3 3 &pcfg_pull_none>;
+			};
+
+			sfc_bus2: sfc-bus2 {
+				rockchip,pins =
+					<1 RK_PA0 3 &pcfg_pull_none>,
+					<1 RK_PA1 3 &pcfg_pull_none>;
+			};
+
+			sfc_cs0: sfc-cs0 {
+				rockchip,pins =
+					<1 RK_PA4 3 &pcfg_pull_none>;
+			};
+
+			sfc_clk: sfc-clk {
+				rockchip,pins =
+					<1 RK_PB1 3 &pcfg_pull_none>;
+			};
+		};
+
 		lcdc {
 			lcdc_rgb_dclk_pin: lcdc-rgb-dclk-pin {
 				rockchip,pins =
-- 
2.25.1

