Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415794BEBCB
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 21:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiBUU1V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 15:27:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiBUU1U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 15:27:20 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F66237CC;
        Mon, 21 Feb 2022 12:26:56 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cm8so22132692edb.3;
        Mon, 21 Feb 2022 12:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=6/CbbKb963ZeCrGB3DpHf3S/LmT0OSOkIfiP6ix0yNw=;
        b=CZ2cpSnJj/iYQkv+MnAaAe+Hi3/lKYxwLMWRl30vUsJBwPfghMR2i6Rw33lo63nd4L
         si7vTuHXPscr8e+B8mMHu+VGezXiWiq+inpaAqHLE368pE49xTWzhXVCcc/YAIYLEULK
         XDP6rnd1QriUbfHvlzSRzfXrOMY68uBsGfy20b3OEJkHS50VEJ00JWWGhS8Fm1120Wli
         UQjcl7l6ao+nrl/IWI88Eihp6WWAIEJvy8sPm9hZ3ZvJLYdMaQl6ALRjtT+HXSZWsMQt
         VZ0mTqFsM/wLO1aX4JjKvzC+j8jpE9mtrDpndGHuYRbGE0MnaQP3J9mcy4th4ql/0JiM
         PhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=6/CbbKb963ZeCrGB3DpHf3S/LmT0OSOkIfiP6ix0yNw=;
        b=C6/BhQJAGYYsD40IW179RHzIlpZD8Wqus1E0ZS5Wu3XRzl+NsHZ8HS2ahkw+NzZaxk
         Du/RKJFdmkkVvuq5Kir813k/S+3F9qrAiXyCcyNEnaxzrVlDPUzJ+MwkZj0yZLnNuSqW
         uVm6mDO7HHNqr8GsI5K3qcMfmyz/UzNu+YkOJqZYuIUpC/DqmCDtgNrwLjp/m0J8keIh
         TZleKbP7Cy0s/KHhrrYpSylB2P4eR6VujG+4a2GqQOLrosCSVVvnZ0wGZqWjxoqcgJuT
         f8/AYg4thlpcxTuRPV6McqgzNL+XXWWq1HxFDEF2CYKlJyaP8M9DWyzM0YQ/qh3ZaWkq
         6nHQ==
X-Gm-Message-State: AOAM531UlC30By+Q5nZ/Yn8/3tZjzHj6zHcmEcrKECZEFoW6pSxzsQ8D
        rsCKdE1Ju7FddDLaScJp74D4T0Gwy8c=
X-Google-Smtp-Source: ABdhPJw5C8aS2uojppIF/KiB3IM1XbxzEZagKJMBWFLTCnt1ltvm5AtbsTjekE5NprGJ/F9a1Vpm7A==
X-Received: by 2002:a05:6402:2159:b0:410:8098:b6cd with SMTP id bq25-20020a056402215900b004108098b6cdmr22582027edb.429.1645475215609;
        Mon, 21 Feb 2022 12:26:55 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:b141:a0d:4aad:2a06? (p200300ea8f4d2b00b1410a0d4aad2a06.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:b141:a0d:4aad:2a06])
        by smtp.googlemail.com with ESMTPSA id e1sm5475062ejy.103.2022.02.21.12.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:26:55 -0800 (PST)
Message-ID: <94ceeca1-3123-fc4b-8cc9-a86e9ad08863@gmail.com>
Date:   Mon, 21 Feb 2022 21:24:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v2 4/6] docs: ABI: document tm1628 attribute display-text
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

Document the attribute for reading / writing the text to be displayed on
the 7 segment display.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628 | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628

diff --git a/Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628 b/Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628
new file mode 100644
index 000000000..382757e72
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628
@@ -0,0 +1,7 @@
+What:		/sys/devices/.../display-text
+Date:		February 2022
+Contact:	Heiner Kallweit <hkallweit1@gmail.com>
+Description:
+		The text to be displayed on the 7 segment display.
+		Any printable character is allowed as input, but some
+		can not be displayed in a readable way with 7 segments.
-- 
2.35.1


