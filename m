Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE13397B05
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jun 2021 22:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhFAUMS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Jun 2021 16:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbhFAUMQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Jun 2021 16:12:16 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DF1C06175F
        for <linux-spi@vger.kernel.org>; Tue,  1 Jun 2021 13:10:34 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id b25so625646oic.0
        for <linux-spi@vger.kernel.org>; Tue, 01 Jun 2021 13:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SJn5FRuw/EiIvtLinsK2GbKy9tMV7GDq0Fhvm6NhLVg=;
        b=JX1cphjxSijfmB4ZAnLWJ7O6M0wZJXlUNzB8TuxqJSrXdYuuUGIBUujhQ9jGLh1oUj
         NYX6sr63ZZ6Kv3rtBHlfjFw9J9DD6SnGws2WcyuFc6nqCeSh12fdfV//wXT+kPMf5EWu
         5zQ+cCqVzgeUnOL35f/WPhy2iy3Q3sjE3aNF7KVigcSYRjhyD0dy0AcAkz+BIfDsCKX5
         4VuDfFRChojJSMiueCNIuZSs6EjhBPg0DoVRHhaHusx2aHlA0GzZJEL7U+wrhkSUFXRO
         0/44o+Fhd6d5sHIPUY/eLiwvDCUI7QJM8+i/TRxDm2k2R2nFMjG+knAwYHDtZNUr1I0y
         CNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SJn5FRuw/EiIvtLinsK2GbKy9tMV7GDq0Fhvm6NhLVg=;
        b=mo4zKVUg1syXqaJylNFaUjlOI8uVDhzUBpjSFotApN5+P0GP1dtrkUzJuxDpsahXSH
         A+py700/jlFxD6pxexUsh4qjwzK3pzzTzQ+trNAsO7npACBga0M0KuH80mCKTa9aHMqP
         PZ6995ZyJcjNd9+o8KfiY5gsO5HxsQ6NNurR1UGhuFJJ3PqQahKKpYoMBxsv0vivNJBY
         zeOxf0vnmXnm62lpv7L5MucUbvjkXIfC1n3bKz5d85LxgMhS5qQN/R9SiiF0c0yjGt8G
         aw5XeJPA45FkZb53s7vHV0H8z2n0zysm6+F+dBHo35D1BkQhcdDi3ukLLTZoP+HfVaRd
         SYrg==
X-Gm-Message-State: AOAM533xQJbIamQ4X8kQi9xLzXpcv6vrttoL18YLTAI8MZc+a5Kjq6Hs
        jy5v6YEOhYAw1BugKdlnPomzJcxtTvQ=
X-Google-Smtp-Source: ABdhPJxOcxQ4KlMkRDkgNCMadsKgeZ8Bb4XeVjMZjVMIqSt4wFGX9j3RuwSR/zSMLzQPwYm4Qzrezw==
X-Received: by 2002:aca:d18:: with SMTP id 24mr1189511oin.56.1622578232856;
        Tue, 01 Jun 2021 13:10:32 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id p25sm468118ood.4.2021.06.01.13.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 13:10:32 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        jbx6244@gmail.com, hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v3 3/4] arm64: dts: rockchip: Add SFC to PX30
Date:   Tue,  1 Jun 2021 15:10:20 -0500
Message-Id: <20210601201021.4406-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601201021.4406-1-macroalpha82@gmail.com>
References: <20210601201021.4406-1-macroalpha82@gmail.com>
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
index 09baa8a167ce..1f4feb53e270 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -966,6 +966,18 @@ emmc: mmc@ff390000 {
 		status = "disabled";
 	};
 
+	sfc: spi@ff3a0000 {
+		compatible = "rockchip,px30-sfc","rockchip,rk3036-sfc";
+		reg = <0x0 0xff3a0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+		clock-names = "sfc", "ahb";
+		pinctrl-0 = <&sfc_clk &sfc_cs &sfc_bus4>;
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
+			sfc_cs: sfc-cs {
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

