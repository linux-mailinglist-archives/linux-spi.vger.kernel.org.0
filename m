Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B279D4BC8B5
	for <lists+linux-spi@lfdr.de>; Sat, 19 Feb 2022 14:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbiBSNhd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 19 Feb 2022 08:37:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiBSNhd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 19 Feb 2022 08:37:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174A2CE90B;
        Sat, 19 Feb 2022 05:37:14 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i11so18605489eda.9;
        Sat, 19 Feb 2022 05:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=hHHScw58pgrJJfCMocTEt/w7m0EUDTl2Y3p2I5hmxFU=;
        b=geXHgpGEe/z7ZCgVptzMQTHiMvRCzFRYIm1uvPmUAdWqXNLPlnnY+/xOllwgkXx9Au
         hR6KfUsDdsTAr9uAclO4CZkXgiTX4VFL0pvGyNBH8cm2BoTHmx6Hfprqigu7tfG7npQc
         j+MWPPYclHLr6OFoeTQJIMxKAH8LcpFpp32XXUiGW3mmXBVK51ExIar0//d8JKpgWvSd
         EpgzBrihpsKgS1vGvnk5GBzr3RzAJWC1rKHNIOWN0muw/q9AaRpwDmEIIFpyDDnSEa7K
         LYHLnTXVyn1l9HVUnUaySfLCTTg2ny05MSMTvNYescIM1lRLzc0PdQENePU3C7DjTLmS
         2Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=hHHScw58pgrJJfCMocTEt/w7m0EUDTl2Y3p2I5hmxFU=;
        b=jqYeZnlJQLpkghcoo4QsTMlHZgy2RQSAk3sVnt6y3bjtCEiaqpNwpq3CHIVN6RITIH
         5O0o216lRgoSQk+quTCFYXHQdjuQhFPr85XbOyFBLxk26xruY9TRiLOcjq8hbrBgNMMc
         Z9WShT8NF6lTarHRdcWlz/h4mwCm973cZch9wB3qcgwU/D+e6f8CKT27f1RWTOrBeAoB
         hz6quYxpmkgbt+ZRmEoqTsnfGVf37X/kumVzbRvx8gIiDA7ex7nJlOt8cFaa+AoG/2j6
         zRjnngf8usNzKKGXozHWsllrE7FEih7Ii4sJh3OdI6Kl/zoeFABMwECjDkraMBh5cUay
         Uplg==
X-Gm-Message-State: AOAM5300Mujtu3pAHQ0sf3gY1ztVMYhtxenKZOLLH/tPexf2ZKQmp986
        jbG3bYlTN23wJWZQSROOVIg=
X-Google-Smtp-Source: ABdhPJyGz2QRe4cH/p7/PdgSmapN0KXIN8wsQGnjP8tAiLQoAuu5SPDnUdbm2SqEWQwxiRFgxY4BCQ==
X-Received: by 2002:a05:6402:358c:b0:412:e44e:f62c with SMTP id y12-20020a056402358c00b00412e44ef62cmr1911773edc.206.1645277832636;
        Sat, 19 Feb 2022 05:37:12 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:5cf9:df09:c1b3:d44d? (p200300ea8f4d2b005cf9df09c1b3d44d.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:5cf9:df09:c1b3:d44d])
        by smtp.googlemail.com with ESMTPSA id s11sm2347445edt.10.2022.02.19.05.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 05:37:12 -0800 (PST)
Message-ID: <ecdbfb3a-e214-a059-95b9-1ebf2f625295@gmail.com>
Date:   Sat, 19 Feb 2022 14:37:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
 <CANiq72mi5fj07cfo6T4jPmp=EiRtE_uDeHHCqjG9h+duPrUMKg@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
In-Reply-To: <CANiq72mi5fj07cfo6T4jPmp=EiRtE_uDeHHCqjG9h+duPrUMKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 19.02.2022 14:27, Miguel Ojeda wrote:
> On Sat, Feb 19, 2022 at 2:13 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> This series adds support for the Titanmec TM1628 7 segment display
>> controller. It's based on previous RFC work from Andreas Färber.
>> The RFC version placed the driver in the LED subsystem, but this was
>> NAK'ed by the LED maintainer. Therefore I moved the driver to
>> /drivers/auxdisplay what seems most reasonable to me.
> 
> Could you please link to the discussion and/or summarize the rationale
> behind the NAK?
> 

+Pavel

I didn't find an explicit reason, but I suppose Pavel sees this driver as
one that makes use of the LED subsystem, but doesn't belong to it.
In the following mail he's expressing his opinion that the driver should
be best placed under auxdisplay.

https://lore.kernel.org/linux-arm-kernel/20200226130300.GB2800@duo.ucw.cz/

> Cheers,
> Miguel

Heiner


