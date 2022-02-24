Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22824C3697
	for <lists+linux-spi@lfdr.de>; Thu, 24 Feb 2022 21:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiBXUMJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 15:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiBXUMI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 15:12:08 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85785193CB;
        Thu, 24 Feb 2022 12:11:36 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s24so4469412edr.5;
        Thu, 24 Feb 2022 12:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=e5NyuFcM6LQ6ck24zC5Lh3fqt3x4cs5RkTNn8b8l2Vk=;
        b=WW8m6ltpaXjzsUeL8mbZAG+qShtaE0rRC0oJsgH8l16Cgy1HBjPK4SjOi6cc9YXKLY
         FUJfNFr4zzbeWHGgcbrVYOkyb359yLsSYLIrICroCc8Dfz4N/OTVGEFeAQkxOPu1f4fW
         PdpD74HRc1Mh9mlT8MkTomiwLIow77sUEE7l5bCUAs1MTdH8+GjcMaAHlm/i3oW9N6lW
         Si0W3p3tf3bl4ssdMwkdDn6imwemZIgV1yNF8z8s2AjajQPK0btKxnLUyZkCK8p8XCxF
         Pw8OXgy/8d/mAVufBvqg3c7mwsawDB35XWDB57W2ZxP9rBvOon7fcgYsVtfbpk58Rlmf
         OfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=e5NyuFcM6LQ6ck24zC5Lh3fqt3x4cs5RkTNn8b8l2Vk=;
        b=RIk080JzsCivaXVCpL2QwnYI5RKM0+TMy7ytPE5dlYTa8VOHkq5idH6ezoauTauxYT
         cn7co+PA35KWz0Dp3A2g8ZpQM29OtZqdwwf1oRT5KGaIfPQ9Lf800+VIdrOKlth/352d
         04rz4xYgGHaBFnkvOVWi9Rcq3J0jurLhxEwWmmNnZzRhOuWpO3sErfQOndsjZi5iJn3E
         H6RHg96+LlUeDOivwaVSuAAJegLFSYzwnRFJplmY9s5HMHVqvyIfZNTMJLJ15ADcUGCk
         Xqxc+l/WGY8v4iYFUTjsB2d4bvkoWDSbVEVeVjAD7rJo5IrGVrFvZnSOhlRKr2wuWRW+
         2gEw==
X-Gm-Message-State: AOAM530YCb9WlgtVOcApkScbjQ1S8IQnrQPK93l6gE83cCAzvfUZXbYQ
        mrFRT6S+iiMQQP2hHoScs4w3joRdSXE=
X-Google-Smtp-Source: ABdhPJzgq2waSqW60Mpej34aIb3d1OVbopNz58VxC3hrhDTV4U4+trNRV9CIxszo/Xe4sDO01llm9A==
X-Received: by 2002:a05:6402:c90:b0:410:a0a7:ca5b with SMTP id cm16-20020a0564020c9000b00410a0a7ca5bmr3812607edb.417.1645733495020;
        Thu, 24 Feb 2022 12:11:35 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd? (p200300ea8f4d2b0070ade6bd1cea7edd.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd])
        by smtp.googlemail.com with ESMTPSA id b7-20020a50e787000000b00412d6970125sm229061edn.104.2022.02.24.12.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 12:11:34 -0800 (PST)
Message-ID: <0cd06b4a-026b-5705-b36b-1914e63bbf0b@gmail.com>
Date:   Thu, 24 Feb 2022 21:11:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v4 6/6] MAINTAINERS: Add entry for tm1628 auxdisplay driver
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

Add maintainer entry for tm1628 7-segment LED display driver.

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


