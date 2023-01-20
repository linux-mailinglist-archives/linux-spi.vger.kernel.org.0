Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070D1674ECC
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jan 2023 08:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjATH6p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Jan 2023 02:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjATH6o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Jan 2023 02:58:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00A05FE8
        for <linux-spi@vger.kernel.org>; Thu, 19 Jan 2023 23:58:41 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g10so3354742wmo.1
        for <linux-spi@vger.kernel.org>; Thu, 19 Jan 2023 23:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=87wewJcDMxO1/wApr9mM6wxg/gQpNDtlUo6zWwmTnUc=;
        b=dVh9GjP42y8hw3r8XKzX6I/3TTuG48UvMaXsEm05y/WklubZ7XmtvJFil4hvdWurWM
         H2GS/9A/BaFl47cQ5LXFqiSc4Nv20nB24KNnsFRuiDEaJ+ZpK3CNkn1nqd7mj2uDXct3
         2nf/GsPO/zt5PjGqa4nXalVPZ/6KAxI0QB438dagytOswxV6LTh2VzQ3J3yEa9y8YITh
         hVhYxX8iZSnZ8L3JASizW+e44jRkCHwkSioEDRSrls5qN4lNXI+W24reATXrMbo+yPxp
         p0g5N4xXDvGuNMQlsiubPR6NqvFQ9VAE9190b6mKrYLA56v3t0NubqMDjbU1Zt2h83pO
         HdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87wewJcDMxO1/wApr9mM6wxg/gQpNDtlUo6zWwmTnUc=;
        b=7XmIYit7g5Eh0xvDwt1vKEEKmcQl6H/OvYow9xExdrJPhsxUKxs4tbVyvVRBFwwZPU
         bAbV6XHtLqVeelkhvjrQKjvtrwY0Cvlto6e1G6wti2s2XYsxED65ysAfVNea6pWt+UO5
         za636Hb+PGQsbJdXueBGPG/cWtWWLp/6SofYYypeVeb3uoRd4edul5+VT4ca/bgTAO3s
         rih16mN7F4yNTdMNdSJAd1jQr4MYK9yGVccixkYqJ/4W9OOimv+X93kiIdRBIZuGKDuJ
         Dj28iCg5HnbHSncLwA7VVhpnwJr9J2FKAN0eXsjrT+kans9CP31A1/I0TLVrvyqt9SnP
         zydg==
X-Gm-Message-State: AFqh2kr5sNpkyM2P2d2ncC9unWD4jwMuYAUGVicVF3ftptM6ppwWvJ5s
        r7s9PZRjFVGM4c7VGDvKaJSTww==
X-Google-Smtp-Source: AMrXdXvUWTpH4UqzcY+oza3V4zravkwu5m+Qw2tWv22KZ/050+r9+QNwDcC/rLEiAis2iyBoKJCujQ==
X-Received: by 2002:a05:600c:4f4a:b0:3db:5f1:53a5 with SMTP id m10-20020a05600c4f4a00b003db05f153a5mr13547209wmq.20.1674201520190;
        Thu, 19 Jan 2023 23:58:40 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z2-20020a05600c220200b003db305bece4sm1083814wml.45.2023.01.19.23.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 23:58:39 -0800 (PST)
Message-ID: <ba05ccc3-6669-9a3e-361b-6b71f1f282de@linaro.org>
Date:   Fri, 20 Jan 2023 08:58:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] spi: spidev: add new mediatek support
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230118-mt8365-spi-support-v1-0-842a21e50494@baylibre.com>
 <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com>
 <60766c7b-abb2-3afb-aa16-0e1385b88a73@linaro.org>
 <CAFGrd9rtO0B2XWEEU6gtv39PndjdjLL6tbRWimWT3RvLu1GFrQ@mail.gmail.com>
 <b277b67c-bd00-a543-1945-f986134a78f7@linaro.org>
In-Reply-To: <b277b67c-bd00-a543-1945-f986134a78f7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20/01/2023 08:44, Krzysztof Kozlowski wrote:
> On 19/01/2023 20:18, Alexandre Mergnat wrote:
>> Le jeu. 19 janv. 2023 à 17:49, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> a écrit :
>>>
>>> On 19/01/2023 17:28, Alexandre Mergnat wrote:
>>>>       { .compatible = "micron,spi-authenta", .data = &spidev_of_check },
>>>> +     { .compatible = "mediatek,genio", .data = &spidev_of_check },
>>>
>>> Please run scripts/checkpatch.pl and fix reported warnings.
>>
>> Actually I did.
>> I saw: "WARNING: DT compatible string "mediatek,genio" appears
>> un-documented -- check ./Documentation/devicetree/bindings/"
>> But there are no bindings for spidev. 
> 
> There are. Just some other people were as well ignoring warnings. What
> is the purpose of having tools if people keep ignoring the warnings, sigh...

I documented the missing ones.

Best regards,
Krzysztof

