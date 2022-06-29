Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588B5560995
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 20:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiF2SpR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 14:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiF2SpE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 14:45:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F562E9DC
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 11:44:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d17so18142683wrc.10
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=At25po1Wc0Z0LVVscrUsguBv2A3DKxx2gWOZDMIuiaM=;
        b=WijjS3QGog80xtGqzblrYaaoGoUeqfb6SjDeiBhfRNzBdio44L6EGW9/Z8tdELkAW6
         L9clreZk2UZKoJ9JIA0XqRhuszwyomm61dIFCzrch88g2jAODCY8XeiVZ+uZMBMMZF1X
         28C8fpv0EZnh/al+rSxiF0l0uZHN5U//tuhTMK28cuEWxNRsQ54aVcWsQV3O7n03gcGG
         t4zqFpt8r4DzKJg4IgbJ+vvKARa431qC4A2nW221KIGHoQVqbA3M3NgW9bZPPPd+b06/
         9B4lhXNF7nJEA+yeIQbLhq59zdV268Ah0KGtuDIt7O1tHoewRNFl9Nzs7ADpYfcvKEXK
         YCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=At25po1Wc0Z0LVVscrUsguBv2A3DKxx2gWOZDMIuiaM=;
        b=PmpcKPtc9WgFrDckmxRP7uWAxv2JRFpE0h3HUlpZM8kRZCVhKuTkmTWURm+1vWSGjj
         4ldWn6EBNGAu2+yIxUeeF1Es5J/QxXdq2nTHqkEk6Y/ulKQoLjtNcHHHGsx7DDYEvJtg
         HxfHj58ywJoy4Vy4PLz9uvYyDsdVAx4B1UnKk7N6zZOKWorDXyX/aMj7CtSZvXLI5W5k
         GdnG2e4J4ER1axHzQTfV9Op1rjK1TxIcEJdRk4lMq4tpaqqDy1tR/GO8vHAbtXmNW4vx
         HBNzuYbhOuoZgghLnXEamjFgoHeMHK1iIXTzchTRNcjXEILWVFhgrhJhZfDJiyyHyI3L
         kT6A==
X-Gm-Message-State: AJIora8WLP/kq9GGnZ47kgVvHk8CPIAmx7kNXTtHuyY7/OJTjEjUUHPg
        KYXhO1fATSl7dC/HtMefhcxLmw==
X-Google-Smtp-Source: AGRyM1tFdtxNpzN6iXVKryB/C/h+KEXfAJwTszphJPZwHiXExUEtPjYGqRR55VLOxlslhU0/OHZqag==
X-Received: by 2002:a5d:4b04:0:b0:21b:8640:273f with SMTP id v4-20020a5d4b04000000b0021b8640273fmr4644814wrq.195.1656528297564;
        Wed, 29 Jun 2022 11:44:57 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm3834371wmj.35.2022.06.29.11.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:44:57 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 13/15] riscv: dts: canaan: fix bus {ranges,reg} warnings
Date:   Wed, 29 Jun 2022 19:43:42 +0100
Message-Id: <20220629184343.3438856-14-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629184343.3438856-1-mail@conchuod.ie>
References: <20220629184343.3438856-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The k210 devicetrees warn about missing/empty reg and/or ranges
properties:
arch/riscv/boot/dts/canaan/k210.dtsi:408.22-460.5: Warning (unit_address_vs_reg): /soc/bus@52000000: node has a unit name, but no reg or ranges property
arch/riscv/boot/dts/canaan/k210.dtsi:352.22-406.5: Warning (simple_bus_reg): /soc/bus@50400000: missing or empty reg/ranges property

Add reg and ranges properties that naively cap the buses after the
allocation of their last devices.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 948dc235e39d..6a34dc4f3e51 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -163,7 +163,8 @@ apb0: bus@50200000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-pm-bus";
-			ranges;
+			regs = <0x50200000 0x200000>;
+			ranges = <0x50200000 0x50200000 0x200000>;
 			clocks = <&sysclk K210_CLK_APB0>;
 
 			gpio1: gpio@50200000 {
@@ -382,7 +383,8 @@ apb1: bus@50400000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-pm-bus";
-			ranges;
+			regs = <0x50400000 0x40100>;
+			ranges = <0x50400000 0x50400000 0x40100>;
 			clocks = <&sysclk K210_CLK_APB1>;
 
 			wdt0: watchdog@50400000 {
@@ -437,7 +439,8 @@ apb2: bus@52000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-pm-bus";
-			ranges;
+			regs = <0x52000000 0x2000200>;
+			ranges = <0x52000000 0x52000000 0x2000200>;
 			clocks = <&sysclk K210_CLK_APB2>;
 
 			spi0: spi@52000000 {
-- 
2.36.1

