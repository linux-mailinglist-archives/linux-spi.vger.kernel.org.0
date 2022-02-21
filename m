Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5744BEBC6
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 21:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiBUU1S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 15:27:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiBUU1S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 15:27:18 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1634F22BFF;
        Mon, 21 Feb 2022 12:26:54 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p14so36016392ejf.11;
        Mon, 21 Feb 2022 12:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=fvuoOelNYUnuMw3RclEAhuWky9HY1ItIURN9LiLCtBE=;
        b=Ekao84nEYzAyOpyQKupv6ZcKea+mL7DmE2rbOlazS4zXeoeZendkPVkipjpYNRVRjm
         5KDH5Fj1HBOoYLZqjRfoKxAvcbHWoxHKXoTAp389AkhrdjxXNRxgZuVOH1qoONBlO4xa
         p4MwPxryFN6gG1a9lyFLwCIg6xvBYHuCZs4+HAW9UGvkJ0vrDcsg2DV/UZriyfyHOMGX
         xXRBNQ+0itlmeUzExBxT+oZ2KRLG9VfUsMMCDhsLdQLVRasjfZn+3snZDrLDx9YIoqmL
         HWcGrwbdpLZMFJ+nxJqheV1SrNU/FyI15eJWgvf2Zmz3XyruSu/qQt07dusVeYQZKzj8
         UZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=fvuoOelNYUnuMw3RclEAhuWky9HY1ItIURN9LiLCtBE=;
        b=yzvLkSkDl7RfMjM2afILDkOrVtuX1o0WWPKrmCAD2Io/LKEzSb+bgGRxPRUelO2n7S
         K6ujL8gsmBpvs8RlKkNDP3qHH5n9XYElPUB9FnxZBsMjAucqR0ft14kFSkqQBq9YAuey
         zMyrGfrUMO5UMr0jzsVO2E+g+MA7sEGsZyEazJpa109hgu7hRTOZc67Eo1j3SDLV+3jJ
         DVdNpNMuy36eKiklJkSaEDZ0rx9WuBF+6Fw0XGlVDsNchD3bCj6EF3kuHVE8CBOutXKa
         tx7EbpmBqXWAiysaBNRXSE98I0kEe7B4P1pvXKsuqyqfy/mb4ECAcMAf42dqwBH/9Jqj
         P1sw==
X-Gm-Message-State: AOAM533udRzfnVCJRl/o4ctaRQ4JUi08qKU0yYcmLINnd5uhVBL1ABva
        xheXb+JLMMZjQGIzNQoqz9lfLGigWSc=
X-Google-Smtp-Source: ABdhPJxbYvk+lqvBbfPU8LgrZy56/J92yjPQy18vAN4mgZsbd+WMc6R85IT5h5yTz2e6tBqJCcb7Ew==
X-Received: by 2002:a17:906:3bc7:b0:6cc:493e:31e4 with SMTP id v7-20020a1709063bc700b006cc493e31e4mr16745224ejf.549.1645475212691;
        Mon, 21 Feb 2022 12:26:52 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:b141:a0d:4aad:2a06? (p200300ea8f4d2b00b1410a0d4aad2a06.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:b141:a0d:4aad:2a06])
        by smtp.googlemail.com with ESMTPSA id o17sm2820552edc.16.2022.02.21.12.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:26:52 -0800 (PST)
Message-ID: <358ccbef-4151-a0e6-fc4d-9859e4fdf2df@gmail.com>
Date:   Mon, 21 Feb 2022 21:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v2 2/6] dt-bindings: vendor-prefixes: Add Titan Micro
 Electronics
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
References: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
In-Reply-To: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
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



