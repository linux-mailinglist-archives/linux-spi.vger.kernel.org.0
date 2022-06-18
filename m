Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72E5504A8
	for <lists+linux-spi@lfdr.de>; Sat, 18 Jun 2022 14:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiFRMcu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 18 Jun 2022 08:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiFRMc0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 18 Jun 2022 08:32:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485791EADE
        for <linux-spi@vger.kernel.org>; Sat, 18 Jun 2022 05:32:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o16so8802736wra.4
        for <linux-spi@vger.kernel.org>; Sat, 18 Jun 2022 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1RrlYN7xRo44UoZQ9vXu2CHD6ouZYfkPgpPQl3XW2/Q=;
        b=BPAP4EOMpcTLtigvaPPAmrkhyUhM2es3mn99xXabOD36beL2UV5x4oZfV2njhaHRDu
         6CJGk2QVhn6oPqlOR2djhrL2247MI0pKKag+FDbmQ4H1hZD3+mmDz6hqN32wihfedwv8
         0JY3Dc3Cdrb0deOAs1Y2GOWa/xJwK81U2UBuCQMBHxKmg45ip5zSneSbL7BpIz3+F9U/
         HD9dL2+AWfZ418nW0lUl3ciiJOF84+lcioBfjjBShBTDpTsuwqj7tIBkBiNbmNeX1w9i
         bBklT1NVM2cTV5b3a0VEOCSBXAlFbb9ESoUAC/KWlmIDjjTCsZX275Q9n2aNWJYhq+7O
         e64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1RrlYN7xRo44UoZQ9vXu2CHD6ouZYfkPgpPQl3XW2/Q=;
        b=WaSu+4w2m6b8959SpckjL1b3So3XCg49rZKkhTwxttngvpmJhujD4IHs1NbS7xnr/M
         wQwRxtj3rpsLwsJQ7YHJWmHqAAZJNWoTrW40Vpu6l/jG+4gByAUtvUv5zyuZ0ZHkWhn0
         oiJJxHvmTqbM0596CvyHIFonyRpxp/N/40HKOSJUX5P1LqFypL335C4UZKjvyctpLxgg
         +QiwYw9ccteikX3oATJ6XWVrcMgRHx6TDMvVZjQ6CqJkm1HFCzYRB5dR943IQJeXUQLl
         dl0RXbBShRwcVufvA6yso4LudRQWCHJKdE4Vx+TnPNPg+oUJ/VRtEsjxE3I1fhglO7c8
         zYVA==
X-Gm-Message-State: AJIora+gVsrdHhCy1Vqg1SlsnhRb3G8nzbwCWSwmlYKcCgHFD8E4iSIZ
        C+IhFAKVTO0icoSeU50oYNcWBQ==
X-Google-Smtp-Source: AGRyM1uZgNeRAWVSfV/hT8p8ffzeOsYwkUHkdfjgJGx3PbBuSC2KESMglEYy9aDYjH9MqXxklw0uUQ==
X-Received: by 2002:a05:6000:695:b0:21a:3a1a:7b60 with SMTP id bo21-20020a056000069500b0021a3a1a7b60mr10579808wrb.441.1655555539583;
        Sat, 18 Jun 2022 05:32:19 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm9292305wrb.45.2022.06.18.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 05:32:18 -0700 (PDT)
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
Subject: [PATCH 11/14] riscv: dts: canaan: fix kd233 display spi frequency
Date:   Sat, 18 Jun 2022 13:30:33 +0100
Message-Id: <20220618123035.563070-12-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618123035.563070-1-mail@conchuod.ie>
References: <20220618123035.563070-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

