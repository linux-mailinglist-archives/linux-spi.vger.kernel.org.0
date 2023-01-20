Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C247674E8C
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jan 2023 08:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjATHpv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Jan 2023 02:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjATHpk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Jan 2023 02:45:40 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF968B74D
        for <linux-spi@vger.kernel.org>; Thu, 19 Jan 2023 23:44:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g10so3334394wmo.1
        for <linux-spi@vger.kernel.org>; Thu, 19 Jan 2023 23:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drfFdgpb4YkUjSwdoc9Z5a3O+ognmoqBbo2eF6alSdU=;
        b=e+mfRRxTfGW5YTv/Rk9ZBMpWJa9fMCCQ17hOT/s5m2unxnuD9/dQh529Rr8DacQ8/9
         Pyn4ZGgPU0hBpE4SZEuuurb0zU1EOSM3CGagMFIn+q7stgDJm3j+dM3p5zO7GSu+Kp/1
         Vl6gjh8CuC7mH346RLr42h9JUD5657RToSf8famYSTfsPFxiucbg+DLVP1EYB0SX5PeB
         Nia+5KEjroz2gFWuMsvL+Nf++pfSdjOXfB+ohS03PZRyUTWwM6F/cTpEBWLt7Q3oHZ34
         OunY3n/J6VouQ5NEnAJP60JSmc8OdVhgFHg1vhcqS1+5+2qCjwPZcurLVSIwbbWMl0YP
         k+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drfFdgpb4YkUjSwdoc9Z5a3O+ognmoqBbo2eF6alSdU=;
        b=M4UMTKI0ckj75J/njfn9KUgcVNTcqUEcBJmldSo1QNv/R6N/F7dldMiZSf5XN9cWSH
         itRTjCPFJ6hhmqJxRNe7MhjBNmrPnhS6uvPkQ1jWJH5oxWSabdg1fctU2PXMuaeu7fmw
         ePSov3qihpd1ksHke9HtHsH+nWVYsPmoTihXHOnz6RCqk6uYZ7rgyvyH1kmUsnJcIaE1
         fVuuijna5bn+n9DhqB4tWVXdBFmWNaEtF8KxuOzGFn6B5/R56XPiS3rmTzIT+sScJTHq
         Lav5ggubrZy1lFBuG5D3LbRD+zEYaj+bBLO5WlmStwSAobR4oWCCXb5pI6tnqZt5RK/M
         FNaA==
X-Gm-Message-State: AFqh2krOXaNO5z4Px088REsXpbDSGpCqj/QWyILUbTs2+yBv6oQ8m7ND
        hkLun6JwKTwasiiwxnylbfqocA==
X-Google-Smtp-Source: AMrXdXul6atu6mzYQTY69VMfekx6QHfoNRoaaWTtrahYGNQRtASVGIqsSfmGvRdAjKSkA656+k/cyA==
X-Received: by 2002:a05:600c:4c21:b0:3cf:900c:de6b with SMTP id d33-20020a05600c4c2100b003cf900cde6bmr12667812wmp.15.1674200673849;
        Thu, 19 Jan 2023 23:44:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b003c71358a42dsm1893276wms.18.2023.01.19.23.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 23:44:33 -0800 (PST)
Message-ID: <b277b67c-bd00-a543-1945-f986134a78f7@linaro.org>
Date:   Fri, 20 Jan 2023 08:44:31 +0100
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> But there are no bindings for spidev. 

There are. Just some other people were as well ignoring warnings. What
is the purpose of having tools if people keep ignoring the warnings, sigh...


Best regards,
Krzysztof

