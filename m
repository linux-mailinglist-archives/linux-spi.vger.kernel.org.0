Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C1939BB77
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 17:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhFDPNR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 11:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFDPNR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 11:13:17 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8307C061767
        for <linux-spi@vger.kernel.org>; Fri,  4 Jun 2021 08:11:16 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t140so4806150oih.0
        for <linux-spi@vger.kernel.org>; Fri, 04 Jun 2021 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nzDBGocjHn2IrUk4Z69ayz+va87LVb0nNyKPqEYDMw4=;
        b=lMRNyS7BjOiMXbpSOBoHUehplevtPoTWp0wsFiTVfT0+f0mbwRfyyP6G4LGEdQ3rJd
         RWofimwRtaZTXosObROJAv+khHZdmpZGo8uL1or50ds0IvZluyeheKSg3jKj3BXH3Idj
         hSJM6TRC10JzbIaOroPuoxKA3sROneGAAfMu8Ivf5YHRC0hqpv1Z/OKFw0R4b/atFE7h
         Hp5IIp7eXD8Vkl6EeG7QtsvvdRJaxkX7+xEbU6pjU/yHkHW5mKtDD9qWc8X3rbb/4hhK
         WBpeH4Rz0yTy8iE7SDpTXc0uCYtAJa48fabSE7JrXOTgc+vuFBhRfDYsargOoW6mWmER
         rxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nzDBGocjHn2IrUk4Z69ayz+va87LVb0nNyKPqEYDMw4=;
        b=ifOy7ngyt+n7lXn/LnjxMy3bpoggmqwSVzA9CZIW26Pjxe8INbH4hGYRp7WBYwoCuh
         K6E+tZQGjuh4LmhmOXR3FBtvyy5HYF3msOkT4xPGgmQEVw+KRIeAEn8sWpD2hb8QfvdY
         6ZoObTvUfIzYy9ciijg/3bGUj8eWuEBVM1DWkzxktwZmc3oohQxbaaIeLmZUVmCSI1bn
         IiD/8Yp7ZhsNtUMPCDpui6H9seNrzG9xybv2GJx/YPf74cu/eWTpaPxaEh5x2ygYSBAE
         ty9rVWH+iF7YVZKAedukU3o2TowfzISVFF5Ju5b8qERG8DUTIC0RPNoRF67e1dbM9lri
         HQqA==
X-Gm-Message-State: AOAM531DlgBcZlmvvvpSRHkDLHNAM2ooJYFzyRnRlsZdUaJMczSigIME
        HdDpOGrvYRZC12ZGzLrpuy29+uwGX/U=
X-Google-Smtp-Source: ABdhPJz4xn0UG4QNk7VcbA9ajAimYmgAyMMWJnwoeqptc8AypkwYUSktrl0+T+EoWMAoydzxpGhQRw==
X-Received: by 2002:aca:ab50:: with SMTP id u77mr3267046oie.153.1622819475800;
        Fri, 04 Jun 2021 08:11:15 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id k16sm523440otp.19.2021.06.04.08.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:11:15 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC v4 6/8] arm: dts: rockchip: Add SFC to RV1108
Date:   Fri,  4 Jun 2021 10:10:53 -0500
Message-Id: <20210604151055.28636-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604151055.28636-1-macroalpha82@gmail.com>
References: <20210604151055.28636-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add a devicetree entry for the Rockchip SFC for the RV1108 SOC.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 884872ca5207..c0d95e13add4 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -536,6 +536,17 @@ usb_otg: usb@30180000 {
 		status = "disabled";
 	};
 
+	sfc: spi@301c0000 {
+		compatible = "rockchip,rv1108-sfc", "rockchip,rk3036-sfc";
+		reg = <0x301c0000 0x4000>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_SFC>, <&cru SCLK_SFC>;
+		clock-names = "ahb", "sfc";
+		pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus4>;
+		pinctrl-names = "default";
+		status = "disabled";
+	};
+
 	gmac: eth@30200000 {
 		compatible = "rockchip,rv1108-gmac";
 		reg = <0x30200000 0x10000>;
@@ -704,6 +715,32 @@ emmc_cmd: emmc-cmd {
 			};
 		};
 
+		serial_flash {
+			sfc_bus4: sfc-bus4 {
+				rockchip,pins =
+					<2 RK_PA0 3 &pcfg_pull_none>,
+					<2 RK_PA1 3 &pcfg_pull_none>,
+					<2 RK_PA2 3 &pcfg_pull_none>,
+					<2 RK_PA3 3 &pcfg_pull_none>;
+			};
+
+			sfc_bus2: sfc-bus2 {
+				rockchip,pins =
+					<2 RK_PA0 3 &pcfg_pull_none>,
+					<2 RK_PA1 3 &pcfg_pull_none>;
+			};
+
+			sfc_cs0: sfc-cs0 {
+				rockchip,pins =
+					<2 RK_PB4 3 &pcfg_pull_none>;
+			};
+
+			sfc_clk: sfc-clk {
+				rockchip,pins =
+					<2 RK_PB7 2 &pcfg_pull_none>;
+			};
+		};
+
 		gmac {
 			rmii_pins: rmii-pins {
 				rockchip,pins =	<1 RK_PC5 2 &pcfg_pull_none>,
-- 
2.25.1

