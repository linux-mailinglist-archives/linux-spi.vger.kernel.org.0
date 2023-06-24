Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8673C8E9
	for <lists+linux-spi@lfdr.de>; Sat, 24 Jun 2023 10:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjFXIVH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 24 Jun 2023 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFXIVG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 24 Jun 2023 04:21:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C6ADC
        for <linux-spi@vger.kernel.org>; Sat, 24 Jun 2023 01:21:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51a2de3385fso1755611a12.0
        for <linux-spi@vger.kernel.org>; Sat, 24 Jun 2023 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687594863; x=1690186863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KXFy1y+GxEpWoS2XA5y1VOww+5x8Ww/esZIImWKElzw=;
        b=KZWyreTmC1qMsLkMg9b2+Z1ASl0sWM0ljIY3qKhqRnYi15DikQw0zG5fCfGcZTwc/o
         vTzzxN3uKQl57M38sqb0Imep8NumWIGU5bCDlvQ7U3++vbVDzH5i7skKyMxcO4nsyqE8
         CZq+qxCEmHxaWuFo+ld4MhAac2VFr0IuReGEWIMrFEWGwkdFGLKnO4KdYixVxCeIgd0L
         qHBZxYYlOcj2ncXonY6MEUOOXFHxXDxXsxQ9D9jyeGJn+2snhLATis6Lz/wvXtEVYPyF
         NkQCjak6+ErMoQVHuhBCoHxeFj1cXvqOLzUViXv44ZG2ekGONNF7Gj/PmvABD94TlCjT
         Yzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687594863; x=1690186863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXFy1y+GxEpWoS2XA5y1VOww+5x8Ww/esZIImWKElzw=;
        b=iMGLjiivf6aGywLedx3CUM2C1W7mNR2rLTdhr89Cf0GHJHUu2BxYaTYqud6VDVIQ1H
         5wy5G07Z5vkY7sdJdzPBRb3fK1fXQxOEE3veDXP9FKo9GWbHilFtWvvh+/ebUgoloOmq
         lNX6vy2tyrtGHlxlUYP5vTXxBTebfDV7EN6U6ZkTA6nnLmqmuKDjORx0LiQt0WmZfDRj
         7wcScxF5cUxypg3s/X8Itb3JHsDkaYTSW/gCZAHdfSFS0mRGUs36yDV5ibQfsh/7R/hD
         u3K5N6FGXzGQslRweqzLs9yI6oG+axhGz9zv8PWVkhCQobeVqt5KgZGyQcOnIFeyBdLW
         ErCA==
X-Gm-Message-State: AC+VfDwIrpUiJ/WPRout6zp6M4Z17eggIPuua+81aGNy9ag/HhhjbhHz
        WicuUAJjHAY3ZuEQaoxpkpEl6ZSirrjaByRHbBs=
X-Google-Smtp-Source: ACHHUZ58lskxm/QQaR0UvV9FoXR0tfu1PcHHqBKtZle8xF3qYJAw++nyC1vbs4jQZGJvh2+J9L+dxQ==
X-Received: by 2002:a17:907:70d:b0:979:65f0:cced with SMTP id xb13-20020a170907070d00b0097965f0ccedmr18872642ejb.17.1687594863305;
        Sat, 24 Jun 2023 01:21:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bm4-20020a170906c04400b00973ca837a68sm602287ejb.217.2023.06.24.01.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 01:21:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Varshini Rajendran <varshini.rajendran@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] spi: dt-bindings: atmel,at91rm9200-spi: fix broken sam9x7 compatible
Date:   Sat, 24 Jun 2023 10:20:54 +0200
Message-Id: <20230624082054.37697-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit a3eb95484f27 ("spi: dt-bindings: atmel,at91rm9200-spi: add sam9x7
compatible") adding sam9x7 compatible did not make any sense as it added
new compatible into middle of existing compatible list.  The intention
was probably to add new set of compatibles with sam9x7 as first one.

Fixes: a3eb95484f27 ("spi: dt-bindings: atmel,at91rm9200-spi: add sam9x7 compatible")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
index bdc42eeacba4..58367587bfbc 100644
--- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -19,7 +19,10 @@ properties:
       - const: atmel,at91rm9200-spi
       - items:
           - const: microchip,sam9x60-spi
+          - const: atmel,at91rm9200-spi
+      - items:
           - const: microchip,sam9x7-spi
+          - const: microchip,sam9x60-spi
           - const: atmel,at91rm9200-spi
 
   reg:
-- 
2.34.1

