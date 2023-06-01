Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93617719811
	for <lists+linux-spi@lfdr.de>; Thu,  1 Jun 2023 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjFAKAV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Jun 2023 06:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjFAJ70 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Jun 2023 05:59:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FA818B
        for <linux-spi@vger.kernel.org>; Thu,  1 Jun 2023 02:59:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso89949266b.0
        for <linux-spi@vger.kernel.org>; Thu, 01 Jun 2023 02:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613554; x=1688205554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gUTL11vnxpXlxWq5vLbzbP4rLUK3lP3DTT7y0ZjwjY=;
        b=Tz8PHzxd3P6JoImzVZfGM0u/T6P315gIEMdY7tO8FaC6ffAHK7T8lYXwPvgPESVvh6
         DNI9aXvm4jS9HaK4ECQZITBJw9T+hmUOO+qToskw3HmdUh2nxixIj34Khyr9/215EQJ7
         cZENCpFYWsPJeeJZFb8+c8/E55l2kuePHs4rrHFYptW27H1dPzwjlmnaR5Zgx/H6Q4Ji
         rNmvet1Nk4LP/5gIzUnULm3AlDQWHdj2YF+CKYypCl3CwhloMGpSa1MmlhaATTgfYPak
         Dtvs2pdMyz3YVlsAkPwXTFxQRyyq3FVhfkU8U4/r8BhF+QeHh2dDx57wHg1fp1lp1L5G
         84VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613554; x=1688205554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gUTL11vnxpXlxWq5vLbzbP4rLUK3lP3DTT7y0ZjwjY=;
        b=HGhY4cSWXJdugjv6wUd542SKxMov5S1S9MGVS7SfZ1r2ZHF90lK2pBIHKf0j4FVA/A
         ZGUcs4yKoe1KlrPkts/z5/ozCEFAbdPc2aMb+JEik6aA4+egGD8SpKF2hZfDDjyQIJkM
         H+bxCwSmoOf728FGJP3ivCak13VeF4lQ7EDI3o1CTcQR8zlaDTh3mY6geMPRHeF6wJa0
         ezXa0UiZcW+OvpcHkdJglX6Z1aadYrx4MYKVMzgAJxbZr0PAZpkJMw/xTwbBefsK5kaI
         aHwz51Ds1baxT5ZZMHaK3mSkeqXmSvYwlGRRI5nA8ESLMQCzuj+hlx52T79QVPvFcRbr
         Xx1g==
X-Gm-Message-State: AC+VfDxms3DSjHKXkRdZRx1P4wMeh5pADQd9gaYGgEd4Yevaxs93f/T0
        6IbLmfYompHY4amiwSdyRWfXtQ==
X-Google-Smtp-Source: ACHHUZ4I/69J6jg295rv4mi6qZgVezEeoosgJf5jB21FRODGPlUpK10s+4Umt6GwBaU0uBaGgYM0Ig==
X-Received: by 2002:a17:907:ea7:b0:974:1ef1:81fb with SMTP id ho39-20020a1709070ea700b009741ef181fbmr7716468ejc.22.1685613553897;
        Thu, 01 Jun 2023 02:59:13 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709060a8b00b00965bf86c00asm10475549ejf.143.2023.06.01.02.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:59:13 -0700 (PDT)
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
Subject: [PATCH 2/3] spi: dt-bindings: samsung: drop cs-gpios
Date:   Thu,  1 Jun 2023 11:59:07 +0200
Message-Id: <20230601095908.563865-2-krzysztof.kozlowski@linaro.org>
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

Remove cs-gpios because it is already mentioned by common
spi-controller.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index e0a465d70b0a..79da99ca0e53 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -35,8 +35,6 @@ properties:
     minItems: 2
     maxItems: 3
 
-  cs-gpios: true
-
   dmas:
     minItems: 2
     maxItems: 2
-- 
2.34.1

