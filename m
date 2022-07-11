Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949455609AC
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 20:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiF2SpG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 14:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiF2Soz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 14:44:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7438275D0
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 11:44:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f190so9609443wma.5
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 11:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1RrlYN7xRo44UoZQ9vXu2CHD6ouZYfkPgpPQl3XW2/Q=;
        b=UAll3MyHfXcJWjHvJItFiKt+q0UDpdoZitVUmDKi17Z3tEqFaYeAa5I62dF9Ntp9ll
         izJeCsDmziR+qqGG6d1KJvui6VvkxYr1DY3A0DkU5WcyCeCJ4cFVVbKi7eEA/X3QMXIB
         UVs2gxxjHW0kQZtZLt5O6Wii36mOWwxTj9V35BJEEDO+hl7N3eUDwy36Of2SyBsE6UIj
         H6j75OklTOzvxdWOtJNtMBOCzCMI2H5xrFLsH2RNlvYtcVfpNE2mYlA6uIbBS1CmLl2f
         vmt9cLRnDkXhmABiQE/7jTone6UNsxp186B1ayF3xci6EtiTdGhbee1QsMAcImYigN9g
         Ti+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1RrlYN7xRo44UoZQ9vXu2CHD6ouZYfkPgpPQl3XW2/Q=;
        b=awbSYKsVGYgRolqpCZ5+htcOsbyVCHyBoywrUZlRd47+vZGBpl1K+h0LO+tqTWzaiB
         YvLnyELbysv8rFEjg2725GxDR0GmdT8XO+N+1/fgyTkqGIiO8Q6ZoRZG6Czh/TjTCavP
         URhjj8i/C1bmCh05PJ8INcfmoA9eayEIG5VPaCsP39Bo61bsohwxWflgrXuFliTfqgkn
         J8GvImOSO45379dcVuppvljIiNpFWvoeykgk1aYUgwx+7Of6k+zSppOqpUpDPg6KsNME
         tKG/ftPuliaC4NXFLs7obKNCfwLs8mFQFwZEeXTE0nZUrPSnOHAo5Hnej73uJafWBsJN
         wSOw==
X-Gm-Message-State: AJIora9ZaAsdUak3VydHtG43+CCbiPWGeDNipuz9k7gu30BogLtqr+kE
        adiXsALDW3158Duy6EfgMVBvmA==
X-Google-Smtp-Source: AGRyM1siRoebXeOTAi1aRlb3B7Y2ytiMC6ZasSqJOtJlLU+5gBlJlHVkI1lfg9OpYTZWjusZH35PlA==
X-Received: by 2002:a05:600c:19c8:b0:3a1:7399:861d with SMTP id u8-20020a05600c19c800b003a17399861dmr3088575wmq.170.1656528292500;
        Wed, 29 Jun 2022 11:44:52 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm3834371wmj.35.2022.06.29.11.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:44:52 -0700 (PDT)
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
Subject: [PATCH v3 10/15] riscv: dts: canaan: fix kd233 display spi frequency
Date:   Wed, 29 Jun 2022 19:43:39 +0100
Message-Id: <20220629184343.3438856-11-mail@conchuod.ie>
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

The binding for the ili9341 specifies a const spi-max-frequency of 10
MHz but the kd233 devicetree entry has it listed at 15 Mhz.
Align the devicetree with the value in the binding.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/canaan/canaan_kd233.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/canaan/canaan_kd233.dts b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
index 40992d495aa8..4a540158f287 100644
--- a/arch/riscv/boot/dts/canaan/canaan_kd233.dts
+++ b/arch/riscv/boot/dts/canaan/canaan_kd233.dts
@@ -130,7 +130,7 @@ panel@0 {
 		compatible = "ilitek,ili9341";
 		reg = <0>;
 		dc-gpios = <&gpio0 21 GPIO_ACTIVE_HIGH>;
-		spi-max-frequency = <15000000>;
+		spi-max-frequency = <10000000>;
 		status = "disabled";
 	};
 };
-- 
2.36.1

