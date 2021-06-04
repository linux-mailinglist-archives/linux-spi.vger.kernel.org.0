Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8314339BB7D
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 17:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFDPOR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 11:14:17 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:33424 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhFDPOR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 11:14:17 -0400
Received: by mail-ot1-f53.google.com with SMTP id q9-20020a9d66490000b02903c741e5b703so8270058otm.0
        for <linux-spi@vger.kernel.org>; Fri, 04 Jun 2021 08:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tcOkC5VLrGMggQW0/cK3a0vHPS7zEtQley9DVLkd3MU=;
        b=tvkLMHgqP6xKcgtHLGO4Mu75FFkXNjILRvACWIjzgLONqGdeuo7cA/TsiB4UPuwbqm
         8JGu2ufe7LWehmOl97tg3+CF2ZvuivHT11JDJI8iUkzEDU+9bIvh3/qlnnQ8RLX/Epqo
         JBDJVl2FF/e3qbfiBbvZ9nWdVXa33ndPM/zZGSLm2UoGjESIATz/DvfA3fyrWUrHAM1N
         l3LK9pfmcxmmbpCfqSXi9jmACNeB0/TKbcgQ6LbUSVMvNKbq/d2INlfpF7Q4fwgA7lGX
         qwMbzdYp+aI70DyduM4yjP6is4vJ6M+TkQL5SqX8CChH65aDOMGpeRxQ8rch0py/Kedx
         mykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tcOkC5VLrGMggQW0/cK3a0vHPS7zEtQley9DVLkd3MU=;
        b=Q2mCnIG7XWop4g5C4EqtVNmLY+BhlS1ZP9C2B7lt0Uu7taja9JOlE4YRyW8ZSahacK
         rosoxXPxEvI4eL+/niX/u/vFyK0M7P2tRzXS4nD/xrzEXI4kQEhp4cq/mYTqUCbUcwh0
         3DFGkRMC22zFrcyUXkpYWikmSl51xZgdx6yYqDVT7hIEfc8m/cRdthXoE09XLCmH0kPt
         EBKBhBPIr7zbGjFd1EWxqKxADJxT6kM1SQESmpsabjaOHp1fDKeiYBV5NRHrw4Me3TF1
         S2n35G9AV2w/TabsBfekmb2aK28fGLiwiTjNXTvI3jmLIeN5ea9nqpHSavuzmqllWdcD
         BmAA==
X-Gm-Message-State: AOAM531sOqo0lbb3jNygEL7RYA1/LCaYotpPJcS9o67mXhwVU9nZLc6p
        zW9ikSIHiZIk1hTakRtZhDUfzutrxxg=
X-Google-Smtp-Source: ABdhPJw+iIVWLirlLWj1ASIfVhTk3Cc37un01nAD0o0oR5HSWHeYrriYIKRgczNXkt8ODOJppQxqXg==
X-Received: by 2002:a05:6830:11d7:: with SMTP id v23mr3971951otq.44.1622819476922;
        Fri, 04 Jun 2021 08:11:16 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id k16sm523440otp.19.2021.06.04.08.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:11:16 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC v4 7/8] arm64: dts: rockchip: Add SFC to RK3308
Date:   Fri,  4 Jun 2021 10:10:54 -0500
Message-Id: <20210604151055.28636-8-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604151055.28636-1-macroalpha82@gmail.com>
References: <20210604151055.28636-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add a devicetree entry for the Rockchip SFC for the RK3308 SOC.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 0c5fa9801e6f..2d922b1d51d5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -637,6 +637,17 @@ nfc: nand-controller@ff4b0000 {
 		status = "disabled";
 	};
 
+	sfc: spi@ff4c0000 {
+		compatible = "rockchip,rk3308-sfc", "rockchip,rk3036-sfc";
+		reg = <0x0 0xff4c0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_SFC>, <&cru SCLK_SFC>;
+		clock-names = "ahb", "sfc";
+		pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus4>;
+		pinctrl-names = "default";
+		status = "disabled";
+	};
+
 	cru: clock-controller@ff500000 {
 		compatible = "rockchip,rk3308-cru";
 		reg = <0x0 0xff500000 0x0 0x1000>;
@@ -910,6 +921,32 @@ flash_bus8: flash-bus8 {
 			};
 		};
 
+		serial_flash {
+			sfc_bus4: sfc-bus4 {
+				rockchip,pins =
+					<3 RK_PA0 3 &pcfg_pull_none>,
+					<3 RK_PA1 3 &pcfg_pull_none>,
+					<3 RK_PA2 3 &pcfg_pull_none>,
+					<3 RK_PA3 3 &pcfg_pull_none>;
+			};
+
+			sfc_bus2: sfc-bus2 {
+				rockchip,pins =
+					<3 RK_PA0 3 &pcfg_pull_none>,
+					<3 RK_PA1 3 &pcfg_pull_none>;
+			};
+
+			sfc_cs0: sfc-cs0 {
+				rockchip,pins =
+					<3 RK_PA4 3 &pcfg_pull_none>;
+			};
+
+			sfc_clk: sfc-clk {
+				rockchip,pins =
+					<3 RK_PA5 3 &pcfg_pull_none>;
+			};
+		};
+
 		gmac {
 			rmii_pins: rmii-pins {
 				rockchip,pins =
-- 
2.25.1

