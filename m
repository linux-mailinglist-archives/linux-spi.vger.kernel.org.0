Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCF34C50A4
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 22:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbiBYVYd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Feb 2022 16:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238822AbiBYVY1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Feb 2022 16:24:27 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1C9190B7F;
        Fri, 25 Feb 2022 13:23:51 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i11so9122418eda.9;
        Fri, 25 Feb 2022 13:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=UVQe4QpHFzuLZpN6vaQunZm/CaPTqOiqz/VUjJgbjIY=;
        b=kaIHl/LJkdJS1GsMcUT8EPAy28bkiKpgVIuR7Ckd8pBLs7N9Ps7oK7Zg1IABnceVjk
         wBVwWlmP0ZVa5tEQxlnKMN2IheP35af6KLq3O6YncNLr4b4/IHOSoe4gjuPwPjuro4+x
         ty1cGK+HJD5urjdLI0xAj8st0OE7QYNHU6cZlnKhM6lGkSib5SB+H5YoTKPPpZMpUmJR
         QJKTxYYU9d0F0jV4rNTkD7ctoPZMpvNWn/NrXqcsA80NcwFy8yFfL9rz5seMq7Z3HayK
         nPLsP86VzXFoYFrFHYY2bIrYByBu+upgFFSezqO3RptCToX2Qa+oV635kPJbr/F0wyc3
         8JnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=UVQe4QpHFzuLZpN6vaQunZm/CaPTqOiqz/VUjJgbjIY=;
        b=aCzWRZN82Cdrn6W6t1iUDNepx1lq3ZRAADkGPxSph3CDGZiy5UWaAGqKdCVTTwPDF7
         LIz2RgdrRsDuhNVqNcrrRlKBh8hX7t6Ob6aWS2yAumY53Rs6C9rEgrtOh6sS3E7bU/FY
         8yIf39OqFS2rzKWP7mv4vzaspN9Bs2AbgIZEEfTkOjaAcgvBGI7OYARkk3Ys1zt/Bu70
         YnD8P6pfjwXYkU4jr51XLgCznPhS5sYYAiSxocnpIrJaQOfiMtBGxBprwlH/X0RBXQ7a
         RREht5S9JLsMhi8gxU2ns1Zd/GwDCKxadvGlSmEdT8dkQrGFgVgOI1cQ/lqLg34IQAPp
         Po4w==
X-Gm-Message-State: AOAM531+pgMayoqO/PDXMoqj6ZmVu2zmIqEFvEaWuPlWjLc6n8fxSlV5
        VmTr2uB4lQNiznd35FnwlTo=
X-Google-Smtp-Source: ABdhPJzVIlBCczq4S+kTfnqXgmTqkiY8UrCJ1lwdNVQJ0089sdMxaAY8UWYBfi5xnmZiKwi563Lnhg==
X-Received: by 2002:a05:6402:1148:b0:413:11e0:1f58 with SMTP id g8-20020a056402114800b0041311e01f58mr9009941edw.113.1645824229928;
        Fri, 25 Feb 2022 13:23:49 -0800 (PST)
Received: from ?IPV6:2a01:c22:7326:e100:c9d3:3c62:2c99:d44b? (dynamic-2a01-0c22-7326-e100-c9d3-3c62-2c99-d44b.c22.pool.telefonica.de. [2a01:c22:7326:e100:c9d3:3c62:2c99:d44b])
        by smtp.googlemail.com with ESMTPSA id ka6-20020a170907990600b006ce54c95e3csm1435030ejc.161.2022.02.25.13.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 13:23:49 -0800 (PST)
Message-ID: <95c57066-82b4-1c32-4324-77f9a79451c0@gmail.com>
Date:   Fri, 25 Feb 2022 22:16:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v5 3/6] docs: ABI: document tm1628 attribute display_text
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


