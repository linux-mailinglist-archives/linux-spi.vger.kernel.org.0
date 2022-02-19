Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDCD4BC889
	for <lists+linux-spi@lfdr.de>; Sat, 19 Feb 2022 14:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiBSNVy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 19 Feb 2022 08:21:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiBSNVx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 19 Feb 2022 08:21:53 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA57BD6;
        Sat, 19 Feb 2022 05:21:33 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a8so21496662ejc.8;
        Sat, 19 Feb 2022 05:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=fvuoOelNYUnuMw3RclEAhuWky9HY1ItIURN9LiLCtBE=;
        b=A9baqpgIaLoiyIClgnlI8nQkXVzJwoe0eugY7NROFOJ6j8QraPv2HwSPS/Z323hdck
         KavmMKJuF6uLw59HQ9kMEyaEGryARBpJXKIW3mu6/G75KoOVw6U2NG1dH5toDfhnxFLA
         pF4h1GyD+88QxRW2+8oyG3rShvVYC3jdoSB73HcZ6iHRjFm54hRrQtAxveTXRkqWKmFc
         NUgFVy2HEZV8iRguDefeh0sj97PKbvK2KnxCjyAM2qE9qW1zUayw9Vyl31M/01U/iWPh
         TrkVZvfxCoygGUKgzysP3PA+x97+LTYB492XeYz5DTFWjw5F2w66DpFVa93gOtHxeDAw
         kK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=fvuoOelNYUnuMw3RclEAhuWky9HY1ItIURN9LiLCtBE=;
        b=4Kk/q2UMpdlsD3/ZUewWU20bXCmtu2KQfjitb2JYK7/6duI5AJJES0R3iAPp13AWTs
         G3jwryQEdfw9zZLIX/GOIliUcZMuW9pIEZtj4Csc/QMxl6N7GwxFHaQa/FUM8wjKLXHM
         DzlDKy8ngQZEPbu83hqV/zSlkkO26E8k91RB7ek6+mplQuGmVHC/k2iHQ98JPY75GlxN
         j/0syTWzOj4AdFTduR7FDzOBZEVv4lSnOYQB/YjwyZSSUzTDssDPgC4Nk/shCfR5Oh/z
         kGPsA7FitXka4KRzCTrjA1ryrPA4APup9tRu64monE+DwN4MNvB9e5XZCcB7Bd7EGyiy
         dHOw==
X-Gm-Message-State: AOAM5308XI95BX95/I/2gl5lOp+OAMDangR3oiUlov+hhtfNFMSSlkDs
        q2jU5hQIAqPVvIs6zJKCuL4=
X-Google-Smtp-Source: ABdhPJzqpPkqjcbqzzs0Iy+XWNBKleezaBJfKQY7AcpRwS61+T49RYqYpFuYKzO7oARcEK8qWX0Sjg==
X-Received: by 2002:a17:906:ad90:b0:6cf:74f1:a34 with SMTP id la16-20020a170906ad9000b006cf74f10a34mr9780970ejb.175.1645276892319;
        Sat, 19 Feb 2022 05:21:32 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:5cf9:df09:c1b3:d44d? (p200300ea8f4d2b005cf9df09c1b3d44d.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:5cf9:df09:c1b3:d44d])
        by smtp.googlemail.com with ESMTPSA id o21sm1302818ejh.114.2022.02.19.05.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 05:21:31 -0800 (PST)
Message-ID: <e527eabe-3fe2-ceb6-7981-a4c3b6661fb5@gmail.com>
Date:   Sat, 19 Feb 2022 14:16:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH 2/6] dt-bindings: vendor-prefixes: Add Titan Micro Electronics
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
In-Reply-To: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Assign vendor prefix "titanmec", matching their domain name.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ebe294516..38bfb462c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1229,6 +1229,8 @@ patternProperties:
     description: Texas Instruments
   "^tianma,.*":
     description: Tianma Micro-electronics Co., Ltd.
+  "^titanmec,.*":
+    description: Shenzhen Titan Micro Electronics Co., Ltd.
   "^tlm,.*":
     description: Trusted Logic Mobility
   "^tmt,.*":
-- 
2.35.1


