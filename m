Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B64C3673
	for <lists+linux-spi@lfdr.de>; Thu, 24 Feb 2022 21:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiBXUCu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 15:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiBXUCr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 15:02:47 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD431E64DD;
        Thu, 24 Feb 2022 12:02:17 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d10so6588482eje.10;
        Thu, 24 Feb 2022 12:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=XMOMyaP+5tw/NTE2jwKE8j7Rm2F5qsTyT92ajHBSVzE=;
        b=CO0fSRAek4bdCwTabHBOyTV//bomfxsKiwtf24TvCt3E/ghibT7nI1SwynRANTKZOH
         sJ5EwBa/MKMV0M7Ao2dpvFihZJ4Sp5cnH3tBViWUwjUPSBikbQVXGsZCO4+n3t3ikBb+
         SCob2GZQT5W0WUeCOtSEQRImMwq59WQ4F4UowavJeojoDvMGtoyOgypJAYGw02O6rvVK
         iOD9aWd6bMTaN/0Kd3bVHT+8lw84NMZVfp+FuUwOKx4nJ/wtZ4Dv4xR5sRmH40p3T8Ja
         0xeOHNlu6Zi7pxQQM0Z7ohNbwZ/P0XaRr00mOFcjfUH5Q4CMKWG5jxRiMI7uDHAQfUGt
         txng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=XMOMyaP+5tw/NTE2jwKE8j7Rm2F5qsTyT92ajHBSVzE=;
        b=qitu196gu0IMNy0xOAee3vG4x99q5MOvvKpoRyqkTeMKZgxdYpZW4qxrMiffP+j4tl
         fY/1KbXZ+KHZdNDCrsw7zeQQtxU9kUQVchPLlH/p6No8vx4nPpJRSxikBZ9NVXD4iyB3
         hAAII3Nc8VS/mvzzqFcGYWu7eMAh6VKIxh6cgtA38A1QyP702RlObKv/VP8hpJvkdrZF
         M73GDJ4Y1izn6MFqpw2TICRFtJD5hN79Uh0d+MV1WOTBi/aSI6gUkvdYDjygY2ACgy+m
         M6en9OWMToq09FKY0j1S17/kPCWEiZdK9nibbaXfDu4YKfmiNdDwMv/LQ2Nc8r99p7ZF
         q4+A==
X-Gm-Message-State: AOAM533U/DKafNZaBSsNP9aoCkd5e1lQhz9q2UfhiDlXxkl/VraWvnrD
        Zuov5+MdStgjAxJKWH3lgzw=
X-Google-Smtp-Source: ABdhPJwoQF7agrZ0iFxeuqZW1ispp3xWQbui3gq2JpfwyFy+q8EbyiXnrW3yIfB7IUj7ep7750dKaQ==
X-Received: by 2002:a17:906:3b4b:b0:6d3:4b9f:1764 with SMTP id h11-20020a1709063b4b00b006d34b9f1764mr3423702ejf.345.1645732935531;
        Thu, 24 Feb 2022 12:02:15 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd? (p200300ea8f4d2b0070ade6bd1cea7edd.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd])
        by smtp.googlemail.com with ESMTPSA id b22-20020aa7df96000000b0040fb8c4806fsm224276edy.93.2022.02.24.12.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 12:02:14 -0800 (PST)
Message-ID: <0d3c7622-24c9-f348-010e-a98aca251986@gmail.com>
Date:   Thu, 24 Feb 2022 21:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v4 1/6] dt-bindings: vendor-prefixes: Add Titan Micro
 Electronics
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <f911c7d3-a9c4-32ee-68a1-e30b478732c9@gmail.com>
In-Reply-To: <f911c7d3-a9c4-32ee-68a1-e30b478732c9@gmail.com>
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
index e062a8187..6ffdec91f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1238,6 +1238,8 @@ patternProperties:
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


