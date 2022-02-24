Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522EF4C369E
	for <lists+linux-spi@lfdr.de>; Thu, 24 Feb 2022 21:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiBXUME (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 15:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiBXUMD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 15:12:03 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E0A21F;
        Thu, 24 Feb 2022 12:11:32 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qx21so6615454ejb.13;
        Thu, 24 Feb 2022 12:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=UVQe4QpHFzuLZpN6vaQunZm/CaPTqOiqz/VUjJgbjIY=;
        b=m4GtAAGYO3BkIqRQzP7hsZcEyNeuyay3Jjo2z6wAqy8pzAlVvAWp/C010rUQJkb2bi
         je2GEOSuEPP9mc5TmrhyLEvNDelV/sql9bY2VPq5UPxFGP0PVTm9tlfWzZt8K70PajHT
         MnhbShrEp6d0xPUmQRBKBh1IK1Bqj4jqYTogPPzwl38IUzImWXvJlzs2vOOTd74RizAr
         NA6xSilGzlsaehEHCaPYpvSNs6fjGZa92kvg5nrGua0cSErkd5vC48RvHfteVRZMGQfy
         x2U0suYB2cpM+diRvAB3KGqJpJXFODFG46Op6NnicHkFHoHXwu22LKAzo433HMYFkhqS
         FspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=UVQe4QpHFzuLZpN6vaQunZm/CaPTqOiqz/VUjJgbjIY=;
        b=Hv4aARh/fm0ocsYp3Gxzuvc95IJ+eJL1cF1Ab5UqAcnZoHhyooKeAJnpWwvLp73jLF
         5NKrbpt2upSRi1UVELoEKrOYkc1TNTIGJyo1WuSnwUSsgTbU4P0GYVVfmpGJMEIzW8qn
         TK0bk9FO+M33VhXCjKU+bMns+PdjYk2WOuHFwug6wy+VyjkafLtZS+3gmcCbsEihBUWB
         Rq+iItu6WwicRqPCQ0F4VqYih6euO4oXlHlY64Hx7ONaBhRDt7fVxZ5xGrrxfuslJjzr
         zyvNeLLdFFizGGoEyL+gzfXBwd2fAXbg1O2KlrXUYIQa1RhbrIfvJCA3EwelQnpIXYKH
         lgcQ==
X-Gm-Message-State: AOAM531/v7xJs5t2+2cLXhxiejAmcL0L4PLi0KYPMIhlkPcrYd3iIxAA
        KBpnx81bE5iM6iXbff2tyAY=
X-Google-Smtp-Source: ABdhPJzObB3m8DZuDRS0hvPr1rvD8F041xotEfnMfzcSRpVuPmAYDkbJiI09GZqa/CJQgIuCX6towA==
X-Received: by 2002:a17:906:7e52:b0:6ce:b94d:a97d with SMTP id z18-20020a1709067e5200b006ceb94da97dmr3672271ejr.4.1645733490776;
        Thu, 24 Feb 2022 12:11:30 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd? (p200300ea8f4d2b0070ade6bd1cea7edd.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:70ad:e6bd:1cea:7edd])
        by smtp.googlemail.com with ESMTPSA id j18-20020a50d012000000b0040e3ea64d4asm264262edf.31.2022.02.24.12.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 12:11:30 -0800 (PST)
Message-ID: <21a84254-ae31-3f4f-e1cf-5bd53043e64a@gmail.com>
Date:   Thu, 24 Feb 2022 21:05:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v4 3/6] docs: ABI: document tm1628 attribute display_text
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
+What:		/sys/devices/.../display_text
+Date:		February 2022
+Contact:	Heiner Kallweit <hkallweit1@gmail.com>
+Description:
+		The text to be displayed on the 7 segment display.
+		Any printable character is allowed as input, but some
+		can not be displayed in a readable way with 7 segments.
-- 
2.35.1


