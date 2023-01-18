Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257D66717B2
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jan 2023 10:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjARJ2Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Jan 2023 04:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjARJZX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Jan 2023 04:25:23 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4A4708F
        for <linux-spi@vger.kernel.org>; Wed, 18 Jan 2023 00:51:28 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id DC568B8B;
        Wed, 18 Jan 2023 09:51:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1674031881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzjI/eD/g/cYAAa/GfEEAFqCMUNeI0aSZEvb7n5U/zM=;
        b=ddutgwBY+yRU9ND79tbhwdT/boOYkZCa6skiFzkA3y1sH8tmZXugYpvV8fQSMjSH8t1PMd
        lnFHyZldv3Y8fZw/viGANFZDs/5T7z6xAke1p7GL6aMzWSQTT+Q8h4g+39nz93PvzfccRQ
        LiBe4yJFME+pLGuqBns6nV2roI5EpDbthRaklwowtURgBNIJS2g6MX8ixWz8bUVH/M5YkY
        +KSqtJd7WhnMGJhdDFM1PYbo0M9QiIzaWJoDg1LjPipCEYJSNrW5TOHXABt5hSYuudGNqR
        9HBNWMwieLfCUKe7kClclCyV6g0n99CuKtyBmMavWI33c0/QjL4lJBMRxbUemw==
MIME-Version: 1.0
Date:   Wed, 18 Jan 2023 09:51:21 +0100
From:   Michael Walle <michael@walle.cc>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     han.xu@nxp.com, broonie@kernel.org, dev@kicherer.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-fsl-qspi: add optional
 sampling-delay
In-Reply-To: <2a684f19-6749-ddb0-6e32-4ffe35269cb3@linaro.org>
References: <20230117210500.oimf4yjkkqh3o4hi@umbrella>
 <20230118080159.112295-1-michael@walle.cc>
 <2a684f19-6749-ddb0-6e32-4ffe35269cb3@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <30a7f1174b5c16f4f6c86eb8b25fba7a@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

>>>>> unfortunately, the rx-sample-delay-ns property does not fit here, 
>>>>> as we
>>>>> can only delay
>>>>> the sampling point between zero and three "half cycles" (or edges), 
>>>>> not
>>>>> by an arbitrary
>>>>> number of nanoseconds.
>>>> 
>>>> Why this is a problem for FSL but not for other platforms having 
>>>> exactly
>>>> the same constraints/property?
>>> 
>>> Please use the common delay in DT and calculate to half cycle in 
>>> driver, we have
>>> the similar discussion before for fspi controller delay settings.
>> 
>> Do you mean [1]? There my suggestion was to use a -degrees property 
>> (because
>> it doesn't depend on the frequency). There wasn't any follow-up, or 
>> did I miss
>> something?
>> 
>> -michael
>> 
>> [1] 
>> https://lore.kernel.org/linux-spi/62f113a0cdb0d58bf04ab0b274912eb7@walle.cc/
> 
> I think the patch using existing ns property (and calculating cycles or
> phase shift or whatever was needed) was merged. In such case please go
> the same way.

I couldn't find anything that the fspi driver now supports this delay.

I still think this is the wrong way to go. Like I said, it depends on
the frequency, which means that you need to change the delay-ns property
everytime you change the frequency. Think of a bootloader which patches
the frequency (or something like that). But what's worse is that you
cannot have an enum in the binding for this property then.

Now OTOH, you could actually have a hardware which take the
delay as a time period, in that case this -delay-ns makes sense
and recalculating that into -degrees would be impossible.

Are there standard properties which expresses the same, but just in a
different way? Like for example drive strength as an impedance or in
current at a specific voltage. But having two different properties for
the same thing might be just as bad..

-michael
