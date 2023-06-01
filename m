Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF89719810
	for <lists+linux-spi@lfdr.de>; Thu,  1 Jun 2023 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjFAKAX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Jun 2023 06:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjFAJ7e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Jun 2023 05:59:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7120A198
        for <linux-spi@vger.kernel.org>; Thu,  1 Jun 2023 02:59:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9700219be87so82205066b.1
        for <linux-spi@vger.kernel.org>; Thu, 01 Jun 2023 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613556; x=1688205556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqU5JKI8xSfMQrPkRhcyh7XPcg7Z1CafuGi9gOADxbY=;
        b=iSBGO9xVpkpBrdMwzD6BLjIAOWf60vKswFrqrbNgJzxxle+8VtVE5xX+viZc6exYvo
         5mM4/WTFIyZulW/kZEdl+iMMzNT6k6s+WXGUtMHfURs8Bm5XKJLhmQtG1VUV8JHNEmCw
         EsYfFO0F4dE4hQr3vjdmamDh4F3vw0ctJPVuaumvk0fe3yh/vBFxWrSbSLHiKeyQrfIS
         J0k92CCdYnpAK2rRBLtksydtIXEV/7XO1Yay/rmMmuIHGx9syLESYtA7XBerpHi/WSqG
         K2J9qNNXmmD8MHsWnD+1hzxY2JvWSIh4D4cmOJE6rVTp/Mg1gO0uQRovx+c2jfTsgnxa
         uYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613556; x=1688205556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqU5JKI8xSfMQrPkRhcyh7XPcg7Z1CafuGi9gOADxbY=;
        b=ex7o/OMphepw1/heVZFThGiJq9dP+q9rmhcpM0rpo3RyqPGPuYmERt9wfr2vqs5BGO
         K3hIsfLDCF7c89BXApMdzkhqJPub8EjNo7ZEFg0xS4cpVB6wUTAPbBShzqp5vi8bYOJt
         WJj3AtGUe2/VrYc9qGl6rk4WyVylGcE9GGuEGCQLJkCFyOiWqNzlWV3WkjUZO1lqjV8e
         CALW+wM/mPcUeGraeFdjiy4Hy5hSjvzVk/UMrTpzpMIYZboOrEcyW4SgDMu13lkavtMK
         MPfnlCIoe/+1AVWSTDStrn9xpD/9rNA8Y1phlPB7LMJ4UnNrX4A3f5mD2t1FrM3Gp9k0
         jlkg==
X-Gm-Message-State: AC+VfDx+7f4Ks+ryEww16AXAe4LC2mvZ3XR1Mz3iQIFmKKk4PckFi+X8
        Sab9P19FC7vL3ZjPWmiqmLWSpw==
X-Google-Smtp-Source: ACHHUZ5gzkqt8SW2dNBwPi6OCmq0SOHL+UihiUONfj0SGQPvjb21q3GASr/tqkSrkQAZlbaOuaU72w==
X-Received: by 2002:a17:907:a414:b0:957:2e48:5657 with SMTP id sg20-20020a170907a41400b009572e485657mr6962043ejc.68.1685613555753;
        Thu, 01 Jun 2023 02:59:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709060a8b00b00965bf86c00asm10475549ejf.143.2023.06.01.02.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:59:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] spi: dt-bindings: socionext,uniphier: drop address/size-cells
Date:   Thu,  1 Jun 2023 11:59:08 +0200
Message-Id: <20230601095908.563865-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601095908.563865-1-krzysztof.kozlowski@linaro.org>
References: <20230601095908.563865-1-krzysztof.kozlowski@linaro.org>
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

Remove address/size-cells because they are already mentioned by common
spi-controller.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/spi/socionext,uniphier-spi.yaml        | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/socionext,uniphier-spi.yaml b/Documentation/devicetree/bindings/spi/socionext,uniphier-spi.yaml
index 597fc4e6b01c..c96131ebbea1 100644
--- a/Documentation/devicetree/bindings/spi/socionext,uniphier-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/socionext,uniphier-spi.yaml
@@ -17,9 +17,6 @@ allOf:
   - $ref: spi-controller.yaml#
 
 properties:
-  "#address-cells": true
-  "#size-cells": true
-
   compatible:
     const: socionext,uniphier-scssi
 
-- 
2.34.1

