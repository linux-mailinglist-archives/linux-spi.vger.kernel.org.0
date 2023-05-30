Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E6C7164F2
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 16:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjE3Otb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 10:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjE3OtT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 10:49:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B1410E
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 07:49:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51496f57e59so4008265a12.2
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685458153; x=1688050153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8G0c0mpPhFQo7i+RrdSfLHYDtYE35R5vJ/b+M/gxuM=;
        b=TwckJzmIHLNkTEHE3PeH0rFIRq6IgHs6ns9hHaVT+YPvGvMq0zVOCf9i3GguI1d4gZ
         ++87FyS17cHjFpyYYP11L6B1mQU4Qo74fZSooFervsiBR+0ar8BkWpaVXwtpZJ22dllW
         F4As95G3fMbOJoMJg6N8HhzdnsqtbXz5JGTeY2R8J4hUP1ovNUrwdSrIKFEDFkBMxgWS
         VOOZWJYhhEWYhR9zQGpR4NKq5NMj69QmgmJqj/PlGAuQQv3USs+CB94ozMps71kYZ+cw
         UxnmmPyVuSIi0a0b5aN2HgHzEreZKBY9iaovEdyc1IzjG70Ypp+EX32+456crShhdma/
         B9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685458153; x=1688050153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8G0c0mpPhFQo7i+RrdSfLHYDtYE35R5vJ/b+M/gxuM=;
        b=e66iSAWoR+g0OlcWkak7zgI6GxHbUHVdI581pAGy9W5b2IcY36jI82j7EFkddEIJRO
         ZncDRM5aUMYZP+EaKNUTcFoKlGkqqVe4Sty95tSZi5QHKGSc6Ts1VqW5ZJOs28FQvRtq
         yfz4kB+NYX/1VxiV0M20nA6oEAa2jYBL7VTiYG1ZCy+EnZgbLPSW6v+9kKNtnTbLzmKg
         7VXjmJBdlbdMW4IYW8FrLHqyACa6EgiCKE+9PvQxZCQ3NPyS6+qk64bE8P3/axvwqliV
         5lQEuHpiR/ht3vcfgqRiHUQ0pWCBCRUR7WoqoW8aiN7aw1LWBwW/W1hW9kkpnyX43qBY
         nXHQ==
X-Gm-Message-State: AC+VfDwtoT2iD1j5eJsVJLoNRXc+abLA3YI4CaQD8cxikQCGndo0PAKP
        19jSwyjJ66/iHHAX8FUKOg1vFg==
X-Google-Smtp-Source: ACHHUZ4bhaXhOGjXcCnROMILTcaXL9g90bzH/pnqZRsukzbQfT55KK4gcDyEoP7X+Mzn6P4JbZvAeA==
X-Received: by 2002:aa7:c59a:0:b0:514:9319:ebff with SMTP id g26-20020aa7c59a000000b005149319ebffmr1869786edq.24.1685458153812;
        Tue, 30 May 2023 07:49:13 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b00514b2717ec6sm631283edt.28.2023.05.30.07.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:49:13 -0700 (PDT)
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
Subject: [PATCH 6/7] dt-bindings: timestamp: restrict node name suffixes
Date:   Tue, 30 May 2023 16:48:50 +0200
Message-Id: <20230530144851.92059-7-krzysztof.kozlowski@linaro.org>
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
 .../bindings/timestamp/hardware-timestamps-common.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
index fd6a7b51f571..95f42acd0c54 100644
--- a/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
+++ b/Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml
@@ -17,7 +17,7 @@ description:
 
 properties:
   $nodename:
-    pattern: "^timestamp(@.*|-[0-9a-f])?$"
+    pattern: "^timestamp(@.*|-([0-9]|[1-9][0-9]+))?$"
 
   "#timestamp-cells":
     description:
-- 
2.34.1

