Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AAA67809D
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jan 2023 16:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjAWPzy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Jan 2023 10:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjAWPzx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Jan 2023 10:55:53 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912C55250
        for <linux-spi@vger.kernel.org>; Mon, 23 Jan 2023 07:55:50 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so4566013wmq.1
        for <linux-spi@vger.kernel.org>; Mon, 23 Jan 2023 07:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQ+/a8w/qFj3luZoDJ3OxPjYbwogmzi2kqkpt3vBPmQ=;
        b=VWS7PSmLmcJaTf6s/uhF+6wnvE+BRrCrll9s928FrSFccqhWO2UJvnlL2172c3R4BG
         baRGfNGYybTJ1LR97ouds3lNSYT8qGmBhAdsjsUV546yl55AzJOKPYUWxLnfbvYeSrx9
         QCWrCKMzl1u9q/CRqKphUzwokHw+oju5ZLZq1JnFj+d40qH6lzC00YG8Pb7PWDDux65R
         aZmNwO97F8yUgYsLPeyQMTsoJTJzwr9v9V8yqrcwR4eDRbH1Er+hFD3lgoowNAy2hzjE
         NF2x6ukHrhImJI21NHC0LyBw30x1IOvup7SRC4sbmDvQOjrajtr07Jn770O8tTq4viIJ
         2qLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ+/a8w/qFj3luZoDJ3OxPjYbwogmzi2kqkpt3vBPmQ=;
        b=O58Yi/+OWUDJSfIRUEH2pPdIne4kYswe+xcBHVYCyLp1BVusD83lOyprFO1cTd8xQX
         ndWlHB1qyNtV4QVWq9qNiYG+KpGsUaLDvimrkKxpcG0g6luE9QSv4ibOEDnlSqO104dh
         LE4efBmqKGmk8TtS8XyytGNPEbOiP0qtYID9ipC7xlazWyv7D221oSkajfKIgwQvTj8o
         guSXnWmNMfUZj3p4HJ/k1Ufj4mgZ3BP205/e6SxFtP+XoAGBaMFuUuqJyfoZSeCH2yMT
         XdVmNiF9VAtQuX/ZsXTOoSELQQE8GXv4SOfF+YAWTATVcrygOCObWqx+i7MD1ZaTNFpF
         pzig==
X-Gm-Message-State: AFqh2ko5FSsaTdQ+9pd4wS1EEBqeZREgPybSKXx3INHvq7H5nYWCbqu+
        UH76Bwjo2URL+pd/+1JII73qUA==
X-Google-Smtp-Source: AMrXdXt8WYT9onKbkfM8CaJV81Gp9fudEaR2Scx8A4s5srCWVOUCIqmfOHP0RzuwYfOTN5WR9mt20w==
X-Received: by 2002:a05:600c:2d05:b0:3d0:85b5:33d3 with SMTP id x5-20020a05600c2d0500b003d085b533d3mr23415558wmf.16.1674489349204;
        Mon, 23 Jan 2023 07:55:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o24-20020a05600c511800b003d9de0c39fasm14623257wms.36.2023.01.23.07.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 07:55:48 -0800 (PST)
Message-ID: <b2fee032-cd19-eea9-730f-0502274884ba@linaro.org>
Date:   Mon, 23 Jan 2023 16:55:47 +0100
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
 <259d738b-5717-8fda-22f0-c61db4660e95@linaro.org>
 <CAFGrd9qENTZV2fs52HPv291=AJdcBHpd2L_uoc9PhbO1vcKw=w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFGrd9qENTZV2fs52HPv291=AJdcBHpd2L_uoc9PhbO1vcKw=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 23/01/2023 11:06, Alexandre Mergnat wrote:
>  Because there are no logical order:
>     { .compatible = "rohm,dh2228fv", .data = &spidev_of_check },
>     { .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
>     { .compatible = "semtech,sx1301", .data = &spidev_of_check },
>     { .compatible = "lwn,bk4", .data = &spidev_of_check },
>     { .compatible = "dh,dhcom-board", .data = &spidev_of_check },
>     { .compatible = "menlo,m53cpld", .data = &spidev_of_check },
>     { .compatible = "cisco,spi-petra", .data = &spidev_of_check },
>     { .compatible = "micron,spi-authenta", .data = &spidev_of_check },
>     { .compatible = "mediatek,genio", .data = &spidev_of_check },
> 
> I can put it first then before "rohm", or before
> "micron,spi-authenta" you prefer.

Yeah, I noticed it afterwards.

> 
> I can also introduce another patch in my serie to re-order everything.

I already sent a patch for it.

Best regards,
Krzysztof

