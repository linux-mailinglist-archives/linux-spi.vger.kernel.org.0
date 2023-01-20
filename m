Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2A1674EA2
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jan 2023 08:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjATHse (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Jan 2023 02:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjATHsd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Jan 2023 02:48:33 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F216881E1
        for <linux-spi@vger.kernel.org>; Thu, 19 Jan 2023 23:48:12 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d14so368904wrr.9
        for <linux-spi@vger.kernel.org>; Thu, 19 Jan 2023 23:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUbYG6CNFZkAaSfmbsiOn5ZLfVicT6OQUe0wKNSaOFg=;
        b=E/gsgiKDlovjPEr1wVqqhP64WUTBcW7LnrIaA4cGorpachmtdKSTBYWEnqah2dt/ro
         1xumU7oIe5rQIZ6aGhYE5xSJwLTldpojPXW1rqA1+1h/HnlvGwt1yQMMJaWTfnLw+fGJ
         /jhjZNOe4+iFJYnBW5/8uANdzqMhKWVjryvU9eCf4ZpwED4iiCqNoKE/i7ftjwXzlMUN
         uQYg8rgLbc27HtpviXGt4mc51RFmQYU6aTIPJ1+GtcDafEg0fhIv9mkBvEfHRoRskB7d
         0+jHp1P1kPTFwujMCz268zCKy1yN454PEPflBYCbr14i5q4hrSusYofS/dqyeGNzriFe
         jOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUbYG6CNFZkAaSfmbsiOn5ZLfVicT6OQUe0wKNSaOFg=;
        b=gcB+m2qvyOAKl8+wG5EngQ/AEMY0gqXpA+m9F5GxS+x1jkdSK+ZnU7ZUrR9TKV83Vd
         yDUhDIqZ3O9lQrFj6T3RsG1qsMaOojhauTmxenyicmgCO/sHLDmuCoFtYi6rODQbKXow
         m/4LdWEsYSYPW4zcnPjLktLkSVVfT7T03eeIYtB7kRrX7WeJ70EzBdRcFRuGH6Ng0HJm
         4MOxdsI9BjrNg6RGE9N6VmvQhevM5WbIOurrgazyh1keB23INsCBwl+Xk2MBibGSPuqC
         dgFzOKAoKDbB0jRP7NysizYL2sv2JdFzKDUpNWSreb6zna6AvLk464jUSTKfdeBuMflF
         Lcpw==
X-Gm-Message-State: AFqh2kptdDm2L47iBmi1WXMufkb9bbm3aaA8LPbXqTEm3vsEXnX/O7GZ
        ZOTw3B6xkQo4AO3qiFsDbcBWNtTjDe8Nc0e/
X-Google-Smtp-Source: AMrXdXuXFnAh8TD3IFzfCwiyzZGic0IxxbCUXc7p1siPzKJJVl9d52SoYbHlIXsU456hEn0aOzJiQw==
X-Received: by 2002:a5d:58e8:0:b0:2be:b07:d411 with SMTP id f8-20020a5d58e8000000b002be0b07d411mr11456316wrd.3.1674200825135;
        Thu, 19 Jan 2023 23:47:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f3-20020adfdb43000000b00236883f2f5csm35975719wrj.94.2023.01.19.23.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 23:47:04 -0800 (PST)
Message-ID: <259d738b-5717-8fda-22f0-c61db4660e95@linaro.org>
Date:   Fri, 20 Jan 2023 08:47:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] spi: spidev: add new mediatek support
Content-Language: en-US
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFGrd9rtO0B2XWEEU6gtv39PndjdjLL6tbRWimWT3RvLu1GFrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 19/01/2023 20:18, Alexandre Mergnat wrote:
> Le jeu. 19 janv. 2023 à 17:49, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> a écrit :
>>
>> On 19/01/2023 17:28, Alexandre Mergnat wrote:
>>>       { .compatible = "micron,spi-authenta", .data = &spidev_of_check },
>>> +     { .compatible = "mediatek,genio", .data = &spidev_of_check },
>>
>> Please run scripts/checkpatch.pl and fix reported warnings.
> 
> Actually I did.
> I saw: "WARNING: DT compatible string "mediatek,genio" appears
> un-documented -- check ./Documentation/devicetree/bindings/"
> But there are no bindings for spidev. I've made some grep on already
> supported compatible devices like "micron,spi-authenta", but I didn't
> find documentation to add "mediatek,genio".

Another point - why is this after "micron"? Don't add entries to the end
but in order.

Best regards,
Krzysztof

