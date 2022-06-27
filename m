Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE77F55C758
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 14:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbiF0TlY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 15:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbiF0TlW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 15:41:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DE517042
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 12:41:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so6246781wmb.5
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wA+ekkpjde0Zx9cXanks0YsUmdtDvWig/ia7r5xRwsg=;
        b=QizeLMoa4P+K5NRfW783uv00QZQ9FUl1yrJSFvTDQ91NxzrJIEoQC1vyn7V6UN1aBI
         KC47cW6AyaaQsZOVeSRRRcDH6KVsIokTGyvzOhvNcwVXXmO9A5cBaI7DAxVPi39AhkBc
         suh5GymLQ6pb0Omy1yzYvTL9j0If9mnJhIDj0ku/aQjAl5BJ1s4s5lX4boSmhT/3axFd
         9BaZlYgOo9FI3fxMT4EBBRC7Mae04h+WHW7wbDtw8HercIYexvTAN752j8mUDTucVOX3
         dyTU0rPZKbAWUOVQJDUXIMdakema1v4gXRBDbYJnKue0E1FRC9jfhN3HZzfcP4SKHOku
         6lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wA+ekkpjde0Zx9cXanks0YsUmdtDvWig/ia7r5xRwsg=;
        b=EqGeko/hS4nHn4/+oKC8q8X0arx+mkbyht44kybNZhexumYdig2SwIvmGLPsICyf91
         IsfmvKKb9VUyZmc34eqjF7Pxesd20NkcRQze1JoD0nURcj9uyzGVksrpK+JEYnO+qQ92
         u57ESxfZW8mMQOAl5hgWBphvyeC1sxBk3Bsx6OBHYhxQnKZo9NQgmwXAV44vKMMPac8z
         pZumVgwbZVWgm1NLBVmIF6tDqgdydk6++MxodJhdRHiY2GyFYOOrodUllzNk9h7pHdrL
         yoWI5vKVs738F2NXBrFQBvEHmnhTd4hxtL6sJE2j/1zueDawme7UD+xSujB9mEbS1QlG
         05qQ==
X-Gm-Message-State: AJIora+BwFwEhbHHKphoC0gtVne2XqLUOFRuipd0J1b+ovym1RsJzZ4u
        1TNq1gaoPW51EJVNGIDodFb23Q==
X-Google-Smtp-Source: AGRyM1sGEP9IS4aUetkgrW5cPwURwUYGFTM9jMyAFxw9F86IEWrWl9NXn+BD46xMXN0gtp4uxfYclw==
X-Received: by 2002:a05:600c:4e04:b0:39c:66bc:46d2 with SMTP id b4-20020a05600c4e0400b0039c66bc46d2mr22594341wmq.71.1656358878796;
        Mon, 27 Jun 2022 12:41:18 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm11428047wru.47.2022.06.27.12.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:41:18 -0700 (PDT)
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
Subject: [PATCH v2 02/16] dt-bindings: display: panel: allow ilitek,ili9341 in isolation
Date:   Mon, 27 Jun 2022 20:39:50 +0100
Message-Id: <20220627194003.2395484-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627194003.2395484-1-mail@conchuod.ie>
References: <20220627194003.2395484-1-mail@conchuod.ie>
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

The dt-binding for the ilitek,ili9341 does not allow it to be used as a
compatible in isolation. This generates a warning for the Canaan kd233
devicetree:
arch/riscv/boot/dts/canaan/canaan_kd233.dtb: panel@0: compatible:0: 'ilitek,ili9341' is not one of ['st,sf-tc240t-9370-t']
        From schema: Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
arch/riscv/boot/dts/canaan/canaan_kd233.dtb: panel@0: compatible: ['ilitek,ili9341'] is too short
        From schema: Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
Allow ilitek,ili9341 to be selected in isolation.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/display/panel/ilitek,ili9341.yaml     | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
index 94ca92878434..c402bedaa37a 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -19,12 +19,14 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          # ili9341 240*320 Color on stm32f429-disco board
-          - st,sf-tc240t-9370-t
-          - adafruit,yx240qv29
-      - const: ilitek,ili9341
+    oneOf:
+      - items:
+          - const: ilitek,ili9341
+      - items:
+          - enum:
+              - st,sf-tc240t-9370-t
+              - adafruit,yx240qv29
+          - const: ilitek,ili9341
 
   reg: true
 
-- 
2.36.1

