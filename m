Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40C7631F54
	for <lists+linux-spi@lfdr.de>; Mon, 21 Nov 2022 12:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKULHS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Nov 2022 06:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiKULGw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Nov 2022 06:06:52 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D991B10DC
        for <linux-spi@vger.kernel.org>; Mon, 21 Nov 2022 03:06:26 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t10so14159531ljj.0
        for <linux-spi@vger.kernel.org>; Mon, 21 Nov 2022 03:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyWwGeNhRFmvWfv+vCOYlIM/UFkEFOWpWKA/JfKWszY=;
        b=k1zR2LZGJzgjCfmMp4p4sU+lt9Y/jVgcaRyvmTurxH242gX8IQXQ/MjQg7EUV7qPIt
         Uocx5kN58tws2Qih7DmeyVqq2zI1PiY7WtbxX0Vqnp47COj5UTsxlGsTBd5Wl+uEIrIM
         znlDN9X06BKuJ8t3bWEeuK4hDuMdNeiwc7hmSsyJuwHor8VOB+IozAqcJtzsXFTFSqnp
         BAvpVY23qpQTdFU+5YR6MFtjqOF7YDE9y2+1WIPKLJz8k1FKV7oBPXJ1iT5SNYu8EFn4
         aIlRvpPlykkiIQhw6Gzo5jqzl0qGOlMgAgnCb/uRZuFaGL67r5tTmVBcXdviOBviPPgy
         Le7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyWwGeNhRFmvWfv+vCOYlIM/UFkEFOWpWKA/JfKWszY=;
        b=lRdCPggRF8+VUHZHZZQTJDUQJVM8Q5DZ3uylT5nPHuMwUmADThm0vxPPGDRpQddOqL
         2QvFGywI2ezmEitVAFpQj1XhYeoWj9hwhejJBQqsXrVOdvDUHVodWHcNxj4WKxYeLuFT
         kMECW6yRxkm3+B8+w+XRMrbI3qRX6RSEqLiGsTBJeInfxdWoEbO+2mv76W11Y68mHMBU
         GK87vpdNT4UuuSK8d5iIu4eLcKzdyOF8I8NHeXuEppDYV3NAqVMxPYHh+gjw97PgSfly
         FWTjSYL3hJKjt180U8bM8nv9J9MCLz36W+DR3NCaQZC8bTWZL9uy1upgZNDbtm0gqRTx
         aMuQ==
X-Gm-Message-State: ANoB5plcs6WrQfO8R5DMBVEx0dLH4cL4qZZFdGpOLYZgzR7CTzsss7/H
        tXAZ47VZbfYHvpx0YJ6FQE8+nA==
X-Google-Smtp-Source: AA0mqf6U7Ox5Cg3AOmfzFZsyMueM2uMreFj1RmdNjod5QJ6XQGeJ0gdoX1HOEA4iywF9yX/nrfBnTw==
X-Received: by 2002:a2e:9786:0:b0:277:2e8a:bc59 with SMTP id y6-20020a2e9786000000b002772e8abc59mr5136640lji.344.1669028784202;
        Mon, 21 Nov 2022 03:06:24 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n1-20020a05651203e100b0049313f77755sm1991521lfq.213.2022.11.21.03.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:06:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-can@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-watchdog@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 2/9] dt-bindings: memory-controllers: ti,gpmc-child: drop redundant part of title
Date:   Mon, 21 Nov 2022 12:06:08 +0100
Message-Id: <20221121110615.97962-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
References: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Devicetree bindings document does not have to say in the title that
it is a "Devicetree binding", but instead just describe the hardware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/memory-controllers/ti,gpmc-child.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml
index 4a257fac577e..383d19e0ba26 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/memory-controllers/ti,gpmc-child.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: device tree bindings for children of the Texas Instruments GPMC
+title: Texas Instruments GPMC Bus Child Nodes
 
 maintainers:
   - Tony Lindgren <tony@atomide.com>
-- 
2.34.1

