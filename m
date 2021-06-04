Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E6F39BB7B
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFDPOB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 11:14:01 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:35737 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFDPOB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 11:14:01 -0400
Received: by mail-ot1-f54.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so9414610otg.2
        for <linux-spi@vger.kernel.org>; Fri, 04 Jun 2021 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPwsgHZfI7X2x/NCoAxg4rZpLg9do9zJr4tiKRuNV2U=;
        b=XKT5uArA2Y93UoUY499zE5bbJv1N0dJeuV5pbfWnn0yPwPAmAZr1KBymRC+Jybm6lg
         fxAi1XcPbKpoouTM8uygZrqcMAV7yOAGF3pyREh3ofMeCOY1XgEycXjkU5QGDjmYeR6u
         olo8n2jNj7vhfJN+VqjS7UZ5oP8nWTSZTKEb5cikoXCMrjhI0ipnevEuaa05wwf8noNJ
         nq9YDy0wPBUuB4RYpMG1NKMV70YE+LB5fvsO1K+R+BGK5pnkIqCXeHm7nH3PPbfN0z7I
         o0sTWVe4gbI5xdyD69JpcI+Wc/ZlxZBOtx+UxtYPo1DnlAh5EwExyCB1EkC+plqdN/Bj
         8i0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPwsgHZfI7X2x/NCoAxg4rZpLg9do9zJr4tiKRuNV2U=;
        b=odne3GGKfzOUNdrU/14eqNHmrKpiZzKIa4eyf5pk9z+08vQs+PV8oMhVcEiQBGCN/p
         DN5M6Nq27mMV1ylyYOQXuuH93M/VfZx2eVcFE4YWlmEKm5fPnM6QZ/0bmnpy8kLYOxJt
         oYfi3oC/anNSfu8O0oDO02138IYdarYQN3u7qvk7afAQWHJ+ODEJ8rJgChZ03nz7ICT/
         ArGWFd/TtdYIDt5eNhDf9Bzq5DZzaS2LH3J2Gjf6HxE1Gs3uFpJ5l04S9mYcH96seW1E
         sTmUyO8R6sKXz6a11JF3KWP4UYVEpkVJ9EkqavYuBEncDEhu+UwLlv5VO9U3ainBXBZY
         Fetw==
X-Gm-Message-State: AOAM532ocX0yhm0Rc/gzxuf048FA+MOo14JnlJLIRsdx3DmHKIFC0B44
        ie5lydBiXO9f9qXxRDFpEpkoxmI8ehE=
X-Google-Smtp-Source: ABdhPJy5ES3R6EtHURbrmb60FZhk3ISvUZCZ5kwgT2RbBoGW/fHp9+86zwvj7K65PwavwGPHwy3chg==
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr4193051otb.281.1622819474472;
        Fri, 04 Jun 2021 08:11:14 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id k16sm523440otp.19.2021.06.04.08.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:11:14 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC v4 5/8] arm: dts: rockchip: Add SFC to RK3036
Date:   Fri,  4 Jun 2021 10:10:52 -0500
Message-Id: <20210604151055.28636-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604151055.28636-1-macroalpha82@gmail.com>
References: <20210604151055.28636-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add a devicetree entry for the Rockchip SFC for the RK3036 SOC.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index e24230d50a78..0dba2956dfb8 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -206,6 +206,17 @@ emac: ethernet@10200000 {
 		status = "disabled";
 	};
 
+	sfc: spi@10208000 {
+		compatible = "rockchip,rk3036-sfc";
+		reg = <0x10208000 0x4000>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_SFC>, <&cru SCLK_SFC>;
+		clock-names = "ahb", "sfc";
+		pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus4>;
+		pinctrl-names = "default";
+		status = "disabled";
+	};
+
 	sdmmc: mmc@10214000 {
 		compatible = "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x10214000 0x4000>;
@@ -684,6 +695,37 @@ flash_wrn: flash-wrn {
 			};
 		};
 
+		serial_flash {
+			sfc_bus4: sfc-bus4 {
+				rockchip,pins =
+					<1 RK_PD0 3 &pcfg_pull_none>,
+					<1 RK_PD1 3 &pcfg_pull_none>,
+					<1 RK_PD2 3 &pcfg_pull_none>,
+					<1 RK_PD3 3 &pcfg_pull_none>;
+			};
+
+			sfc_bus2: sfc-bus2 {
+				rockchip,pins =
+					<1 RK_PD0 3 &pcfg_pull_none>,
+					<1 RK_PD1 3 &pcfg_pull_none>;
+			};
+
+			sfc_cs0: sfc-cs0 {
+				rockchip,pins =
+					<2 RK_PA2 3 &pcfg_pull_none>;
+			};
+
+			sfc_cs1: sfc-cs1 {
+				rockchip,pins =
+					<2 RK_PA3 3 &pcfg_pull_none>;
+			};
+
+			sfc_clk: sfc-clk {
+				rockchip,pins =
+					<2 RK_PA4 3 &pcfg_pull_none>;
+			};
+		};
+
 		emac {
 			emac_xfer: emac-xfer {
 				rockchip,pins = <2 RK_PB2 1 &pcfg_pull_default>, /* crs_dvalid */
-- 
2.25.1

