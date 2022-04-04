Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0D44F0DE8
	for <lists+linux-spi@lfdr.de>; Mon,  4 Apr 2022 06:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377075AbiDDEFB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Apr 2022 00:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377100AbiDDEEy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Apr 2022 00:04:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EAA3A733;
        Sun,  3 Apr 2022 21:02:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y6so7139913plg.2;
        Sun, 03 Apr 2022 21:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HV5c5QEBjHHJKwEleOTxRh6M5uLQnGXYD11zp0jEEY=;
        b=Th2x/KrGd+A33w7vq9tYo45HQNILH5GVOU7O0QWQVZDkWGA0s374oCg9OcbwhU77Er
         fddlJT40IlUhdqc/R39Cf6GeryMWeh94712B5h1YDUHXBxS3SkmvS0i4Q3pHqQXa/tHA
         LGT2TIiJhcV44kcYOjJT5ciueOlISkpEgsCzMNh1/JjnPS7mQbYCYtou2YM7CAp8ATf+
         7XSVKUz7E+djK9L44ZSla18JiVLJep39FvZUdP3ROqdbNcVvIhqeiCQsi7Qp5R+1uvNa
         KU4wy3AjcBqoph/UzVRj1rH/5MyScLePaPEVHXtRqa6QO4li6FwmdWs3rZ/EkEash1il
         5L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HV5c5QEBjHHJKwEleOTxRh6M5uLQnGXYD11zp0jEEY=;
        b=MN0UOANBAy2kT5627TOGzEjAk3CfbOTlFwUbAqsRTr6NltljNaJtuTdQBXuNM8I6Vw
         9uHf7ENAaASpWYkpAnqtqpiys3ST7Aos8dq4k0PUPFknJiYPqaebVMxGKBrpKWkHfxKG
         oDCUfJpcjKorJ8nCWJFe6hvucFi9ImRvsR1bG6Hh5nMunzDRMXiDSpcsB3X2pcD9/ZYn
         brJJBQnnFnvxqicMip8Gc0TD6rABdTfkSgQK2T/gHYmg2caiutrpfVaDHIQqvxoMBHXu
         Vc/ely60rVwMw1v4hMX9Wszd1LG9uVjYbVntTolUjA9k5ujIR1Vw6jFb2GL04ePpGdXo
         GWaQ==
X-Gm-Message-State: AOAM532sn2WiHFbYxqVXUmYGAefVfhI4D+TvkbvSrv5VRJqabJ9XtCCD
        lS6CQgktypWK2YkfM+hfoKSS3qccuBLNZ4xBMnnkGA==
X-Google-Smtp-Source: ABdhPJw2VMe0j+rzz5r581Dqg1+SGhDEuCaA4GPBKVV20F35xs8PFv9ElxWDZgNpQ0SDkkWPRFewLw==
X-Received: by 2002:a17:90b:3502:b0:1c7:2920:7c5f with SMTP id ls2-20020a17090b350200b001c729207c5fmr24262038pjb.89.1649044965102;
        Sun, 03 Apr 2022 21:02:45 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id j70-20020a638b49000000b003985b5ddaa1sm8756191pge.49.2022.04.03.21.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 21:02:44 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: [PATCH v2 5/5] arm64: dts: mediatek: add mtk-snfi for mt7622
Date:   Mon,  4 Apr 2022 12:01:53 +0800
Message-Id: <20220404040153.1509966-6-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404040153.1509966-1-gch981213@gmail.com>
References: <20220404040153.1509966-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds a device-tree node for the MTK SPI-NAND Flash Interface
for MT7622 device tree.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Changes since v1:
  1. use the newly introduced nand-ecc-engine instead
  2. reword commit message

 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 6f8cb3ad1e84..4b8f7dc1ec23 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -545,6 +545,18 @@ nandc: nfi@1100d000 {
 		status = "disabled";
 	};
 
+	snfi: spi@1100d000 {
+		compatible = "mediatek,mt7622-snand";
+		reg = <0 0x1100d000 0 0x1000>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_NFI_PD>, <&pericfg CLK_PERI_SNFI_PD>;
+		clock-names = "nfi_clk", "pad_clk";
+		nand-ecc-engine = <&bch>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	bch: ecc@1100e000 {
 		compatible = "mediatek,mt7622-ecc";
 		reg = <0 0x1100e000 0 0x1000>;
-- 
2.35.1

