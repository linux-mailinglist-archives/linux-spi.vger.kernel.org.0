Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA814C50AA
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 22:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiBYVYn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Feb 2022 16:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbiBYVY3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Feb 2022 16:24:29 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1EA194152;
        Fri, 25 Feb 2022 13:23:55 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s24so9147481edr.5;
        Fri, 25 Feb 2022 13:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=nfqVpMsDeMm4Dl6KEyxiRu7U3Ug1Y0nrCDl3R9Adamk=;
        b=mn/5WQpvX8UpDXsx+/RJi1a8Tq3ZBpyGuoVhfX1+uduashZxSvh0nFqa/wMhTAVV3F
         1ZNVsQmqkwlppgH4A3GWHsWS/ZXCuP23r0F/B3CDsO+eevrdIkwp/gXhFCwrZj9QI96t
         8PnD/Vk1/Y9fui67586scyCpkFBBmkU/puggcxVpcDLLHCDLtnq0yx3xCUvhE0eb1fNJ
         3MX92ovkDtLjTtEyHMaMoeYmynZ6wClfOoydJ01+jLRa2u1IINXAlYDaheefX27dG/2X
         FcAQaM+1d+B5iuxuIXGHZkESgKKkVD//CTDR/7fxNqwYiAVNV2jEbIWvmHb1igWgwtUh
         oWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=nfqVpMsDeMm4Dl6KEyxiRu7U3Ug1Y0nrCDl3R9Adamk=;
        b=39J82WTszKvD8/0H66HA3g4zDxbcSrYHG/3xV6QzPcTTBmKCxBBX7Ie6JcmCOlFUBR
         H057T6HKLx3o5mNvCkulFk2Cc2UbqEkhv+H26veePVCe2/QZJtyfJV35J7YRHD5W63B6
         cQXgYuuSSHw9db8dGcaCqgW8u81KPiAdnsYXEd81qvhvxgcrVO+LMacIoeZMP++weddj
         /nBANBVrQ9ZRb7c9HDGmrd4HFMGF2DikOqk8eQQQi+iCNrjC/crkyidB0bKbKZeqGu5Y
         IpJdllDmETtHp6pFmEW2EvyEo04IyLCM6ouCD0akX2Mhnwa9E2dggpSBTgEW7MXHecV4
         RkJQ==
X-Gm-Message-State: AOAM532FmDU6WBGu1B37O8ztklzSJ3buq5sMXfZtlA38UEbFhDzX9Mz1
        TFMC2etr2YBwqXNOKw2NK+g=
X-Google-Smtp-Source: ABdhPJxeuoGcGF6Eo+InxvhSFmSvajf4aKhd1YO+sL7RSrUZuHGA4+z5ze+zFBMxCjC0GO00VQk0RQ==
X-Received: by 2002:aa7:df86:0:b0:413:2d4a:5358 with SMTP id b6-20020aa7df86000000b004132d4a5358mr8888580edy.21.1645824233893;
        Fri, 25 Feb 2022 13:23:53 -0800 (PST)
Received: from ?IPV6:2a01:c22:7326:e100:c9d3:3c62:2c99:d44b? (dynamic-2a01-0c22-7326-e100-c9d3-3c62-2c99-d44b.c22.pool.telefonica.de. [2a01:c22:7326:e100:c9d3:3c62:2c99:d44b])
        by smtp.googlemail.com with ESMTPSA id u10-20020a50d94a000000b004131aa2525esm1948050edj.49.2022.02.25.13.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 13:23:53 -0800 (PST)
Message-ID: <1c1fe4e6-3c73-1445-e766-0dba264d4581@gmail.com>
Date:   Fri, 25 Feb 2022 22:22:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v5 6/6] MAINTAINERS: Add entry for tm1628 auxdisplay driver
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
References: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
In-Reply-To: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb321d82f..d66da447d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19672,6 +19672,13 @@ W:	http://sourceforge.net/projects/tlan/
 F:	Documentation/networking/device_drivers/ethernet/ti/tlan.rst
 F:	drivers/net/ethernet/ti/tlan.*
 
+TM1628 LED CONTROLLER DRIVER
+M:	Heiner Kallweit <hkallweit1@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
+F:	Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628
+F:	drivers/auxdisplay/tm1628.c
+
 TM6000 VIDEO4LINUX DRIVER
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-media@vger.kernel.org
-- 
2.35.1


