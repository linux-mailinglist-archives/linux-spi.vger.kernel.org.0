Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8338716506
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 16:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjE3Otq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjE3Ota (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 10:49:30 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4605193
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 07:49:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2af177f12d1so49994331fa.0
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685458156; x=1688050156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07SVfkqZ0qgipCgWqf2WUuDolS+hCGhbSje3XLty2Ao=;
        b=aPeYmCNt05cObjx95ndQCrOdKmC01qE9rKbj1E0y9u+++2RIcqlsWtlkGyGI2n1xbU
         AghcT3BWhigFLgjE4GPxSIys40q1Sl8bw+sC08K6jVCsHQe1FDuz+txGGgs4K7+tN9lv
         D+4p4yaduPEphpO5OXOqcpkPAhLrj3akuiJimPh+rPajTiJxAjHzij7o/Rb5N41Szij0
         Vfjo2jfGnHworYtyq2Bgw0ZYnG2uSy5rKuQvaYzL13g1eDccob4no3SUelsX3xA+WyXc
         Qeq3VqRPuVvPCLgdqEFa3pTldVfXGj5yH9H+3Chlgzhm00nwJTyVe701en4WhppjApJz
         aTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685458156; x=1688050156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07SVfkqZ0qgipCgWqf2WUuDolS+hCGhbSje3XLty2Ao=;
        b=G0d6RwsKmjWFIdN58Agcdcw97BF7QbBC6huqrJSozp/BvZNtwSBTQtUP7jU1v58m5M
         4iBM34++o/IdYoYqVQUIKmwX+/yhDRTsqIaMKgWfYGKK78X+IUcWpJhrmPqXKn+hN7Ox
         /+niGBG/ktr2Ip4KR/65xfagsvvMknV2UyfnQfEOm7T0khkWXwSJxuYlROvQuxkzBmk7
         ujJrC4NbI0jNPJx7Nrzn5Xufi1Szle+STxou0E8jlk+jtMV34Wh7Z+tbOigO7FgMYGD7
         V8Q12OODfnudGwxmqgKnViaHVhZMSdv79Zlmi0U4WZ16687n53KbDV99ptMm0HA040JO
         gTnA==
X-Gm-Message-State: AC+VfDy+cfjGRT3RAwyz9nzWSYQgFSSf6qwkRNjK+GTY933J2o7WiUJl
        wBryI6y1yhAgtrburFY1e2LyaA==
X-Google-Smtp-Source: ACHHUZ4eIHTpavdLEXQppq1HffGyODpAFKw+HJwL/rxKmW3KOl/YjNnJCyJOlMEXir4uXif/y/NFgw==
X-Received: by 2002:a2e:c42:0:b0:2ac:67f7:25a2 with SMTP id o2-20020a2e0c42000000b002ac67f725a2mr897767ljd.50.1685458156521;
        Tue, 30 May 2023 07:49:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b00514b2717ec6sm631283edt.28.2023.05.30.07.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:49:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 7/7] dt-bindings: watchdog: restrict node name suffixes
Date:   Tue, 30 May 2023 16:48:51 +0200
Message-Id: <20230530144851.92059-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Make the pattern matching node names a bit stricter to improve DTS
consistency.  The pattern is restricted to -N suffixes to decimal
numbers.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Tony Lindgren <tony@atomide.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/devicetree/bindings/watchdog/watchdog.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.yaml b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
index 519b48889eb1..f0a584af1223 100644
--- a/Documentation/devicetree/bindings/watchdog/watchdog.yaml
+++ b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
@@ -17,11 +17,11 @@ description: |
 select:
   properties:
     $nodename:
-      pattern: "^watchdog(@.*|-[0-9a-f])?$"
+      pattern: "^watchdog(@.*|-([0-9]|[1-9][0-9]+))?$"
 
 properties:
   $nodename:
-    pattern: "^(timer|watchdog)(@.*|-[0-9a-f])?$"
+    pattern: "^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$"
 
   timeout-sec:
     description:
-- 
2.34.1

