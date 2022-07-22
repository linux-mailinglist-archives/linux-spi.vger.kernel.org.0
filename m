Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E5A57E6AA
	for <lists+linux-spi@lfdr.de>; Fri, 22 Jul 2022 20:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiGVSh7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Jul 2022 14:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiGVSh5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Jul 2022 14:37:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48A8A0B81
        for <linux-spi@vger.kernel.org>; Fri, 22 Jul 2022 11:37:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u19so9075778lfs.0
        for <linux-spi@vger.kernel.org>; Fri, 22 Jul 2022 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pZNADembFWMrMyIeeoU2sLzijZgUqqEN6vVBxD7cEAs=;
        b=GsqhyOyvPqQLTvBum+zuJxJdCWumdKt28rH2mPmYbBK74XD17jt60KtD0pMHpo/hya
         vb9wzTzbNdeHuA/5g/kHobFtb0+H7CYDfb4AvZumRqW3JnejJKFeINvR34dlTLchYXjz
         j0UREVOivqXUfB4/IgLh/3GwMH3nmWpkN29OsnadwZiyJhvuC8Ke+A7q5rONII1LLIRN
         ur9/WC2nNosjE3LvdRSxF0kGBq3CGOT6wxtYRhP1t3tA3RPVu4/9VS+clhFLMjMPW09o
         1TD97bVIN/s+O48yV/5C3XwcnVszKfIepyHe6JQqce4HYChtqdx1Ean31k2MwSuBhPl2
         mZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pZNADembFWMrMyIeeoU2sLzijZgUqqEN6vVBxD7cEAs=;
        b=hxwb5hC4h227oDgPsF/ctAcIiZAuWXOqi63YP3tiFJfM3K76+QlZVIX27QTnlYBBve
         1e4LNjch2/84rXB6i9RyxHK7vjJss4yxVMTfFm9CAMVKbwBfjokIQt9410QFIGtx1NHp
         3RP9PYZG2hhaXVZvSsCpRCn4GOWBsoRKErfyzEvdMT7EV14ZmfMaXHsQMF2jGos3Xycc
         drzPZoW5CVsIDD2X25HZnCN0CkKCr1RnpHlQHwgfI3h4+WvqhQe7UbAK1eK0/NDCPhOb
         aNjJLeK7lw5b3iUk+sblREeMYuqxbueq/7Dld5bMnvHJf6ZPm0D7hxtfIEoal0fEPtz5
         hKQA==
X-Gm-Message-State: AJIora96mUtp+rWqJgjiPJISHxhTeSdukLmCvsuWS4sfGMsYDlDDAOBI
        PQe18Ixm0lqePQ0c223EKBd2ww==
X-Google-Smtp-Source: AGRyM1t4tkeV7OyDpZcsS6qCtak/AfOICQG9L4dyANvy9yS4TYY7Ac7Z+0mbnuyWn6CiHaHsFou02A==
X-Received: by 2002:a05:6512:2622:b0:481:5b17:58e7 with SMTP id bt34-20020a056512262200b004815b1758e7mr478609lfb.600.1658515073264;
        Fri, 22 Jul 2022 11:37:53 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id d15-20020a0565123d0f00b0048a7222eb8bsm1008194lfv.135.2022.07.22.11.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:37:52 -0700 (PDT)
Message-ID: <1a03d894-3f4c-fb57-5f05-ad7bf11f5488@linaro.org>
Date:   Fri, 22 Jul 2022 20:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/6] dt-bindings: panel: explicitly list SPI CPHA and CPOL
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Belisko <marek@goldelico.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Christian Eggers <ceggers@arri.de>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>,
        Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>,
        Cristian Pop <cristian.pop@analog.com>,
        Lukas Wunner <lukas@wunner.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Sankar Velliangiri <navin@linumiz.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Stefan Wahren <stefan.wahren@in-tech.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, netdev@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20220721153155.245336-1-krzysztof.kozlowski@linaro.org>
 <20220721153155.245336-2-krzysztof.kozlowski@linaro.org>
 <20220721193004.GA1783390-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220721193004.GA1783390-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 21/07/2022 21:30, Rob Herring wrote:
> On Thu, Jul 21, 2022 at 05:31:50PM +0200, Krzysztof Kozlowski wrote:
>> The spi-cpha and spi-cpol properties are device specific and should be
>> accepted only if device really needs them.  Explicitly list them in
>> device bindings in preparation of their removal from generic
>> spi-peripheral-props.yaml schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/display/panel/lgphilips,lb035q02.yaml   | 10 ++++++++++
>>  .../bindings/display/panel/samsung,ld9040.yaml       | 10 ++++++++++
>>  .../bindings/display/panel/samsung,lms380kf01.yaml   | 12 +++++++++---
>>  .../bindings/display/panel/samsung,lms397kf04.yaml   | 12 +++++++++---
>>  .../bindings/display/panel/samsung,s6d27a1.yaml      | 12 +++++++++---
>>  .../bindings/display/panel/sitronix,st7789v.yaml     | 10 ++++++++++
>>  .../devicetree/bindings/display/panel/tpo,td.yaml    | 10 ++++++++++
>>  7 files changed, 67 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml b/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
>> index 5e4e0e552c2f..0bd7bbad5b94 100644
>> --- a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
>> +++ b/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
>> @@ -21,6 +21,16 @@ properties:
>>    enable-gpios: true
>>    port: true
>>  
>> +  spi-cpha:
>> +    type: boolean
>> +    description:
>> +      The device requires shifted clock phase (CPHA) mode.
>> +
>> +  spi-cpol:
>> +    type: boolean
>> +    description:
>> +      The device requires inverse clock polarity (CPOL) mode.
> 
> Not great duplicating the type and description everywhere.
> 
> We can move the definition back to spi-controller.yaml, so then that 
> does type checking of the property, but not presence/absence checks.

If I understand correctly, all client devices (which do no reference
spi-controller) will need to explicitly mention CPHA/CPOL. Good idea.

Best regards,
Krzysztof
