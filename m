Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4634A871B
	for <lists+linux-spi@lfdr.de>; Thu,  3 Feb 2022 15:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351588AbiBCO4G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Feb 2022 09:56:06 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39454
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351574AbiBCO4B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Feb 2022 09:56:01 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4115E4003C
        for <linux-spi@vger.kernel.org>; Thu,  3 Feb 2022 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643900160;
        bh=JKwlxtatWZQCVG4GF4BszucWwjVQTt2PxoebrxL5ciY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=i6yA7t9Cv2ukmUXvHhtNRdUE9hNLWOnYQ2g7APjSZAMHCMKpeANi/B1ZtgoguxDA5
         Nm8VGjt1PXrQCyAjvavzejgvqNwBlvEgSHGjKPyLksrXFul6IDWxivqgsLUUGcCUjS
         fYm9h6Pyw0RXim93IOsKpnABcf1QYGK+V8qRcDxd11bioFzHas2El667YHdN3q+EGT
         2qj40Z0/CY+7lpUpF8OMylyrNyz35bRpUel+rnHAY/Czwj0Tnr1Wlb+rKxCPcM4sIj
         7RfT/OhKWfuiBotVjERE1wg8fEM53q7Hpi+txS+3Vpb2pmHIpb1VidkUD8X5eEaxz4
         C9+xoRt97/5cg==
Received: by mail-ed1-f72.google.com with SMTP id k10-20020a50cb8a000000b00403c8326f2aso1585435edi.6
        for <linux-spi@vger.kernel.org>; Thu, 03 Feb 2022 06:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JKwlxtatWZQCVG4GF4BszucWwjVQTt2PxoebrxL5ciY=;
        b=VxV5jAt0HKfkjMYqWloOoqAIpqaRyfzvyBDZiDxvLcQ8cgo0brG4z6g7yO1hskXMCP
         4P+todHXi2v4MopTlRIlXBJYbniNnyEnEFYS+921phG/Q3PQ1v8U0Jmt31Dxqj+VA5I6
         LqMvwxQD+AOXVb/nDjod7zMuZcOxFvCK/XnmWlAjgGWOPewq+tGyACYPf5T2ICHA5N7z
         2ZLIy1RY+O7sKAN+4+g25+JHABFmUhYUwmgBNMMhKmmH596WV3N6QqA5aQPyfU/6dCUc
         OeE/Wm+DLwrz5YIBCQp48wAIKFxsBmkJKmM7e+3VmflWoAdfi6p1WTOWrB52YEsvI7fZ
         13Pw==
X-Gm-Message-State: AOAM530VC0SKBcMRU4NZJrXSHGhT+uWjEXGUjqrygLPkHd/XbtBxBATU
        WXLl13+9ibB26w/RTwi0yV3Y4CMdKFpn52PlGcqB7TsMiW32PcKvol30beiZH4QavG4vHzVJeWy
        rQGtC6iZgPypKK1H7zF/FfSuMGYHNlFiGfVMeOw==
X-Received: by 2002:a17:907:c14:: with SMTP id ga20mr1992494ejc.243.1643900159513;
        Thu, 03 Feb 2022 06:55:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxET41+skPJ0t2ws3cpvdAuE3SIGtoLLzPApxhNtKVWxdECIqy/nqXcAWE2tMCANk5h/+crhA==
X-Received: by 2002:a17:907:c14:: with SMTP id ga20mr1992450ejc.243.1643900159293;
        Thu, 03 Feb 2022 06:55:59 -0800 (PST)
Received: from [192.168.0.81] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id z19sm7573934eja.18.2022.02.03.06.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 06:55:58 -0800 (PST)
Message-ID: <e79133f2-f872-3ed6-4038-526e94e84909@canonical.com>
Date:   Thu, 3 Feb 2022 15:55:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] HPE BMC GXP SUPPORT
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>, nick.hawkins@hpe.com
Cc:     verdun@hpe.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Corey Minyard <minyard@acm.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hao Fang <fanghao11@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Wang Kefeng <wangkefeng.wang@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <nick.hawkins@hpe.com>
 <20220202165315.18282-1-nick.hawkins@hpe.com>
 <CAL_Jsq+K2t5WYE056so1iZgZr7CBKvDEjAwnJVTyUFQcK-VFSA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAL_Jsq+K2t5WYE056so1iZgZr7CBKvDEjAwnJVTyUFQcK-VFSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 03/02/2022 15:29, Rob Herring wrote:
> On Wed, Feb 2, 2022 at 10:55 AM <nick.hawkins@hpe.com> wrote:
>>
>> From: Nick Hawkins <nick.hawkins@hpe.com>
>>

(...)

>> +
>> +       vuart_a: vuart_a@80fd0200 {
> 
> serial@...

Maybe it does not look like, but this is actually a v2. Nick was asked
to change the naming for the nodes already in v1. Unfortunately it did
not happen, so we have vuart, spifi, vic and more.

It is a waste of reviewers' time to ask them to perform the same review
twice or to ignore their comments.

> 
>> +               compatible = "hpe,gxp-vuart";
>> +               reg = <0x80fd0200 0x100>;
>> +               interrupts = <2>;
>> +               interrupt-parent = <&vic1>;
>> +               clock-frequency = <1846153>;
>> +               reg-shift = <0>;
>> +               status = "okay";
>> +               serial-line = <3>;
>> +               vuart_cfg = <&vuart_a_cfg>;
>> +       };

(...)

>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index 294093d45a23..913f722a6b8d 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -514,7 +514,9 @@ patternProperties:
>>    "^hoperun,.*":
>>      description: Jiangsu HopeRun Software Co., Ltd.
>>    "^hp,.*":
>> -    description: Hewlett Packard
>> +    description: Hewlett Packard Inc.
> 
> Why are you changing this one?

I guess this is squashing of my patch:
https://lore.kernel.org/all/20220127075229.10299-1-krzysztof.kozlowski@canonical.com/

which is fine to me, but vendor changve should be a separate commit with
its own explanation. Now it looks indeed weird.

> 
>> +  "^hpe,.*":
> 
> You used HPE elsewhere... Lowercase is preferred.




Best regards,
Krzysztof
