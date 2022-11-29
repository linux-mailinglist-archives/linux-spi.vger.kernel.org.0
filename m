Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B987563BB2F
	for <lists+linux-spi@lfdr.de>; Tue, 29 Nov 2022 09:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiK2IEe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Nov 2022 03:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK2IEd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Nov 2022 03:04:33 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917553056C
        for <linux-spi@vger.kernel.org>; Tue, 29 Nov 2022 00:04:32 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u27so10240629lfc.9
        for <linux-spi@vger.kernel.org>; Tue, 29 Nov 2022 00:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXyXfpITKQ1f0v4IiIRxCCdu6umQUGRQnWD4tT6S+YU=;
        b=Zop+AILn4XfFJ1Pe4OIG9kBWpPMnn+ZuEVZL2peZcr6WqqPJFWZfCriecVhYtqPpfd
         V+ir4ClwKrKpoY9HgQrjEix5cGk+7iR6+WT5ObiJOMMieVWjxU5x54FBFPg3PiOQ1QXC
         umIhteMpPKVk5ac8BW39bNLtho67DsVwAhiUghyzplPPe16ToFWeS5ZSXJBOafkGw1ED
         PtIBVHcoeUOv9vYcyBHUt8XNViDmvh5sh4azqjmAjfLYrelPR3bra6dP+aHowNb3sft5
         2E1+NBf6gCgdDlFaFaJYRyExCgMZLBJKTWp5H4dXL8F2pyuyG7bI+m7bbPKrixST27ML
         83ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXyXfpITKQ1f0v4IiIRxCCdu6umQUGRQnWD4tT6S+YU=;
        b=zU16nK3m8a5o1hve8Lk8PeGNhIhkEbjBSQqrJfghxpiGtXFmN6xDUbc4qcdX9qf57G
         0QVrXUi5eLa7IdkCdNaOwYKQqJmME6cIhVYP4K8w2jCX0UPNeupK/DxnICHau4erPyRD
         IOaW0PjWbrwBxK5dc4OGySdMNNXOpzi1+Jb0kyApamfB1fDqV1rmZBmlNOXl7AuZZd7q
         57J3Bl1yHI1YZJy/UV3+5qPZv6MDCQWgqCTye+4MgpW3alW1EhdX9U4bjo28LeGi2/Dx
         tjWvJdvDP5G9rx4wc2//1zy5FipazVgy+Sgn4j+iAllhRTeT7n4YOd4SC1DhfMLaSzwe
         ceDg==
X-Gm-Message-State: ANoB5pkBaycPYXkj54lRskO/xWONiSfF2si1El+Wte4kyZkD/4DhoNGL
        KMRN05Px+rq6r1Ym51vU9V8djeHygEGVQ+Q5
X-Google-Smtp-Source: AA0mqf7LAvBn/5qmjBUYmO2ML5b/eIC/kz/K85GCEqKLsVxDyPSdydIV8sSvdvwlmxksju2gYtIoHw==
X-Received: by 2002:ac2:4bc5:0:b0:4b4:c099:a994 with SMTP id o5-20020ac24bc5000000b004b4c099a994mr18163385lfq.193.1669709070963;
        Tue, 29 Nov 2022 00:04:30 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z2-20020a056512370200b004b4a0482a53sm2093801lfr.231.2022.11.29.00.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:04:30 -0800 (PST)
Message-ID: <54a7fe29-2cde-0e33-6eb6-aa5fcddec93a@linaro.org>
Date:   Tue, 29 Nov 2022 09:04:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] spi: dt-bindings: nuvoton,wpcm450-fiu: Fix error in
 example (bogus include)
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221128214928.3531463-1-j.neuschaefer@gmx.net>
 <20221128214928.3531463-2-j.neuschaefer@gmx.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128214928.3531463-2-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 28/11/2022 22:49, Jonathan Neuschäfer wrote:
> The nuvoton,wpcm450-fiu binding's example includes
> nuvoton,wpcm450-clk.h, which has not been merged yet,
> thus causing a dt_binding_check error on -next.
> 
> Fix this error by simply hardcoding the clock index in the example,
> before the breakage spreads any further.
> 
> Fixes: dd71cd4dd6c9b ("spi: Add Nuvoton WPCM450 Flash Interface Unit (FIU) bindings")
> Reported-by: Conor Dooley <conor.dooley@microchip.com>

Report came from Rob:

Reported-by: Rob Herring <robh@kernel.org>

> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

