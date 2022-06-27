Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BF455D1B2
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbiF0TmD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 15:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbiF0Tlq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 15:41:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E759918370
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 12:41:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v14so14490362wra.5
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 12:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ef3I7471zi7adAYmEZiBXZpXh9J/sRivupa07zlI37s=;
        b=HJumt5kWS06mWGiL+4OpEcLUtAC7SNNT45MpSDG001Qi8EIc3dVNUQkn+knFTjW69J
         R8mWOCqcz4e7Q/CPs83n2+HBdGAR/MzDo8iFe+iUMlIwG0BO4ENAltYbtbL4+2H5oDG3
         3WbwwkXTpMHcDzA4RGeRsnyQOybwev/kCCZNAV5bbmfuagFZNHAQw8fw3UnbgMKZLGK5
         KkQqCMzp90DxTnxWzxGdvNfo4Chy7TQO1QO4MitEFQ3DF547kU9BQECLyLo3Uaceo6W+
         sWjJxo+kCADRBxT1Zui4rHIfIWdahlWRan847eRFOyScrZ5BHz3b9KUA57p656/reecj
         FWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ef3I7471zi7adAYmEZiBXZpXh9J/sRivupa07zlI37s=;
        b=TPiC0V7H4UgQ0oT62AioXnBxuSocH1VavyGKc1gQvJ2AzK/Igb/qkufzRvy++6LrCd
         XIbBUdltX777dFaZpsxhN2CCh3b8jBIk55AGqcaOyN6NIPLe8cZwChuBLSQvXC2ue1BG
         NRiwu7zBlqsNV8y1qoTECm9j9KaGvrT9oCUnJKxXdcmLx5hRAb0XoA3QPvBWX6m5IH7+
         rFpWj4+O3Py/T9nB3UzM4oB2r/FeESKccG8w//uRBc868lRmW377egw9DPriN4E/kWlV
         IDhSRIPbtGuvUErg1WyK5dKuH47CtLp0ihvRhDiB00VjjGDlHL/WQPxAcoMimrb/7MKv
         lWQQ==
X-Gm-Message-State: AJIora/4Zj7Mzkl5RMShZwUztTrUfwtRvXcK180PunDmQWZt3TnQjmw7
        6/k+2h2a+9mPI2FkWFD5T2f8OA==
X-Google-Smtp-Source: AGRyM1ttZZCmnyf7M6EsntZ4/SALGTw3iqAI7J+sn1WlB30nJAP/WNiYM9WiVd2M71fg6imXwScP2w==
X-Received: by 2002:a5d:64c1:0:b0:21b:981a:594e with SMTP id f1-20020a5d64c1000000b0021b981a594emr13681508wri.171.1656358899484;
        Mon, 27 Jun 2022 12:41:39 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm11428047wru.47.2022.06.27.12.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:41:38 -0700 (PDT)
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
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 13/16] riscv: dts: canaan: use custom compatible for k210 i2s
Date:   Mon, 27 Jun 2022 20:40:01 +0100
Message-Id: <20220627194003.2395484-14-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627194003.2395484-1-mail@conchuod.ie>
References: <20220627194003.2395484-1-mail@conchuod.ie>
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

The devicetrees using the Canaan k210 all have a sound-dai-cells value
of 1, whereas the standard binding example for the DesignWare i2s and
other use cases suggest 0. Use a k210 specific compatible which
supports this difference.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/k210.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index be42c56e770c..10c2a1417deb 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -251,7 +251,7 @@ spi2: spi@50240000 {
 			};
 
 			i2s0: i2s@50250000 {
-				compatible = "snps,designware-i2s";
+				compatible = "canaan,k210-i2s", "snps,designware-i2s";
 				reg = <0x50250000 0x200>;
 				interrupts = <5>;
 				clocks = <&sysclk K210_CLK_I2S0>;
@@ -260,7 +260,7 @@ i2s0: i2s@50250000 {
 			};
 
 			i2s1: i2s@50260000 {
-				compatible = "snps,designware-i2s";
+				compatible = "canaan,k210-i2s", "snps,designware-i2s";
 				reg = <0x50260000 0x200>;
 				interrupts = <6>;
 				clocks = <&sysclk K210_CLK_I2S1>;
@@ -269,7 +269,7 @@ i2s1: i2s@50260000 {
 			};
 
 			i2s2: i2s@50270000 {
-				compatible = "snps,designware-i2s";
+				compatible = "canaan,k210-i2s", "snps,designware-i2s";
 				reg = <0x50270000 0x200>;
 				interrupts = <7>;
 				clocks = <&sysclk K210_CLK_I2S2>;
-- 
2.36.1

