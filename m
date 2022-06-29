Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5056C560961
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 20:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiF2Som (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 14:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiF2Som (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 14:44:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17BC2558E
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 11:44:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so202845wmq.0
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 11:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lpjeVnS37MRZXTHhlWJRP5jSKS1LyxijGlzK/Tshm9g=;
        b=ATJhBJ9ugmok84wwSO+HYBz2wAsXjKYfnwZNqr4scgd0TZLvc8JVRwUZW3O0Q832jf
         DG/SQUKzkqUSVolgMZhDEbFn6nMeaCdRXFOqlOiulTMmYNxmafx9zS2dlWLSSsSCXjLR
         Z5PCawGeoInle7l9qzdYXzbyx1jz3mSIk6TXI+dYhK+E7sARTZgwJu93aZB7hRCTOiB2
         1fRFyZwJI5UvoofzuhSir/T3y2kr8bT0cCJR3FW1hNdGS2FGBoyDd+1aCjP/VCi377TA
         7+7xCBvGGA0Nt06Ps/ZZvI3hb3cmkq4S2dluOS75v2+k03kTrhNaWRtcM9hZgjyLU8cC
         gtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lpjeVnS37MRZXTHhlWJRP5jSKS1LyxijGlzK/Tshm9g=;
        b=lcWYt/ofOaMc2nE9qk8tYDuswr9lV8yD6n1xR0R1jA8pCgndIcS3xJWtVs8ebSq2uJ
         CKP7FjU4cV0RbJ+pS+tU8Z1e9gGJHajvSY6ujFjBax5uoon7RzgnosF8xCAqdeVLFaas
         XiEgIJPDnJk7vH+nyIJg8CW6b5c+l0WiT/earti7AXPQuNqO5DAn6X0wxDtmzBaoBkMD
         GvImHKqbVbQv/FikRQfZynaRguEE1PVBje/GSkixM2S++BREiGeSz1shQloPZNmF2uDP
         Ikr1fJyDzbtcddm7JLtvsAkUbMdRVSDbbyYkd+usiaubPMlMa1XaaOKvwPV/HeykeR55
         d73A==
X-Gm-Message-State: AJIora8GpettFaR5TBiXRQJuMmLVPgIN2C3oIs8GByA+pG7exY6L7eZ9
        bomT/X1ONk58M1xG0KUBvO4syw==
X-Google-Smtp-Source: AGRyM1vAd8B1ZGTJtHDdB37c3Ztn/6oKjQ+dM2AgrpPNGcXEijohVmjDFbvu8f/fC534km4KRK26HA==
X-Received: by 2002:a05:600c:4e90:b0:3a0:57d6:4458 with SMTP id f16-20020a05600c4e9000b003a057d64458mr5478121wmq.198.1656528279491;
        Wed, 29 Jun 2022 11:44:39 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm3834371wmj.35.2022.06.29.11.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:44:39 -0700 (PDT)
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
Subject: [PATCH v3 02/15] dt-bindings: display: ili9341: document canaan kd233's lcd
Date:   Wed, 29 Jun 2022 19:43:31 +0100
Message-Id: <20220629184343.3438856-3-mail@conchuod.ie>
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

The Canaan KD233 development board has a built in LCD.
Add a specific compatible for it.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9341.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
index c5571391ca28..99e0cb9440cf 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -24,6 +24,7 @@ properties:
           - adafruit,yx240qv29
           # ili9341 240*320 Color on stm32f429-disco board
           - st,sf-tc240t-9370-t
+          - canaan,kd233-tft
       - const: ilitek,ili9341
 
   reg: true
-- 
2.36.1

