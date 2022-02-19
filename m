Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209634BC88B
	for <lists+linux-spi@lfdr.de>; Sat, 19 Feb 2022 14:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiBSNV4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 19 Feb 2022 08:21:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiBSNVz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 19 Feb 2022 08:21:55 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48A2BD6;
        Sat, 19 Feb 2022 05:21:36 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id lw4so21434992ejb.12;
        Sat, 19 Feb 2022 05:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=6/CbbKb963ZeCrGB3DpHf3S/LmT0OSOkIfiP6ix0yNw=;
        b=g8yJlYskzqTuBRAAEoQM+HWpp7cbLRi4aY04uw1k85i8g9VrN7PveuKbxE0xjXz4W4
         0m8evUE7XQDbQU2cJ/aNI445xwopOp7kGMWScIfUk9veu3ArqpGJ4skEVEV4M7czBpdJ
         HZVLz0XIreUBuFamppgdxrnMECREn1Nw2b8TeOcc6WmwgnmdWYPKlTb3nW3w778z+FrG
         1wMKa7bVwyw8ke4zopRSHWr4XCEV+19sHsOqDY7CBrIwTFReTdSdG/TvSVYJ4AshYgsA
         t9HyUZi+py5V9U9rKO8qcYoy/lHN8XeJsoLit22RP2uMU4w+jnswk+NZysuVCJ7NNVLn
         cj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=6/CbbKb963ZeCrGB3DpHf3S/LmT0OSOkIfiP6ix0yNw=;
        b=DV4KRANqozRvInbNa09HqcnbR/sRwKrq5ogsWpgKrvDv3bVZ9ebQaWzlF75aoKnOcu
         0fufG7gSpwpCNXglvQNf7FyuRREtazFnL2NTNUONmzXQwTgW0lsgo/cezy2oafwuWA3e
         7EKlCOEI9qU1ZnPG6RdbJ62KfUGqzuQkgWbDd10MoOaWlXzsOxzVvC2k/hqrxOh7qOH3
         E6xnuIYAzubYl7R1Xwo27uePhINW0JYw8/wdEGwSP5MappzaZ/lZ5WQrgmyE8olvqLsv
         +EaW90C+d70vI17UfC3BroDa+yu8QeBx0TNq6Y30TPsk9drri/liWacVg6tFkHOYiE3i
         Jyhg==
X-Gm-Message-State: AOAM530/RzBjk6ix6MQohq7TKZu3a8Dep2c81UakpyvmzDoiEQ8aRZgL
        JPwCmogGI89IYR88bsujPOU=
X-Google-Smtp-Source: ABdhPJzhAyytukio3fsv22UT9/mGIL0fYpo82E0oO6KLYaHugboccaHhai7rq9lexRYpVBewgQTSaA==
X-Received: by 2002:a17:906:6b8e:b0:6cd:7d22:e5b6 with SMTP id l14-20020a1709066b8e00b006cd7d22e5b6mr10437171ejr.259.1645276895195;
        Sat, 19 Feb 2022 05:21:35 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:5cf9:df09:c1b3:d44d? (p200300ea8f4d2b005cf9df09c1b3d44d.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:5cf9:df09:c1b3:d44d])
        by smtp.googlemail.com with ESMTPSA id p9sm3272675ejn.104.2022.02.19.05.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 05:21:34 -0800 (PST)
Message-ID: <ab21016c-503b-9ccf-6d64-07d25ac0a13f@gmail.com>
Date:   Sat, 19 Feb 2022 14:18:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH 4/6] docs: ABI: document tm1628 attribute display-text
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


