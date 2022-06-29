Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB17560902
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 20:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiF2S0G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 14:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiF2S0C (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 14:26:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387D72C137
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 11:26:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id k20so1977575edj.13
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PGvQA2q5EDiJWHvDGLlQjqNXSoePOx5RlZoa/jDsGIM=;
        b=mUk3MLjXZe8xmtFA+A7Ur0A03lsDuLYDkYFueLi/WrSTxjNMaaZY8ivwseG40TOw3n
         x+t7Nhwennih/jhdTdBH3jY7hcCQeLUN3JP7ApfsPjEwH92padppPKdLCPSfowz4U4cT
         0HMNo0ScyiYVeUnxHnmd7xu4Xm2lbnvsrI50o6PlBVuulg979nME96h5oiNIGjW0ATeZ
         GnuN/2yT4TndbD1AWak8mPNNDOrFr3AxSfYWNCU2PVkG/xaWdkYeUFwYk2iLthV/WWvm
         0MZcBnJRiBDOUmBENasr9ACWeVCcHF3moAQiGRkL2geau/rDsa9UV7TMBhw9rwbS1d4V
         KUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PGvQA2q5EDiJWHvDGLlQjqNXSoePOx5RlZoa/jDsGIM=;
        b=XRq7/m/ZqdVUuIaq5OVEY7OYGHW9E8l+EM9CTc5wwq1eudGEquLJPxpJj+HEmtESyG
         33UsvHVKUX9gEtd5FksKYA/0fg6suDJuiIcMzjIX2rNA8YO1iYoF/DJIA0kkWj2fJaB4
         Hfni6IfdQvdb5xZ3bc7lmj22WlvCNI/AXtAGS8fzJMRUqV9GFzWo/RQiG5XC37rOvlNt
         tOMfkhcqI7mlFr5F9O7rQwpR8d51P+8f6lT1HG9PFdba70OGcAWoUm2BnPhKH22FX4JR
         mHG+xnUGrjeFoyoCG6evNTMNdjiJ5vP1kLZzeDO5hHz4J5SngHDZkaGU4vPsVUYObwaz
         fVHg==
X-Gm-Message-State: AJIora+V45OI+S98K2G+TnGavTcWxE768rwQ/4CRjxP876wdEojVJm2Y
        gp8k88Piu6FK4/eu4nIX/95loQ==
X-Google-Smtp-Source: AGRyM1tf2ghr3a7w3ALY1YaMDY+R25x1r3NtjQHZAjz3pI7PXJjhK4dHNadSye6O1W9nW3KMbNK/OQ==
X-Received: by 2002:aa7:d484:0:b0:435:65b0:e2d8 with SMTP id b4-20020aa7d484000000b0043565b0e2d8mr6071090edr.373.1656527159829;
        Wed, 29 Jun 2022 11:25:59 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906078200b006fe89cafc42sm8127516ejc.172.2022.06.29.11.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 11:25:58 -0700 (PDT)
Message-ID: <bab4d845-330e-c7f0-5dac-a96caa93a39e@linaro.org>
Date:   Wed, 29 Jun 2022 20:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/7] memory: renesas-rpc-if: Move resource acquisition to
 .probe()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1656341824.git.geert+renesas@glider.be>
 <2fd9b9e3f60fe555d9dcad499c90e3ec869aa96e.1656341824.git.geert+renesas@glider.be>
 <c65d6a94-b5c2-e2e4-6fdb-b7982d291e01@linaro.org>
 <CAMuHMdW=s42sfFwimizTsNjyKue+W9NasTOG0jgjkgkoKv3wfw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdW=s42sfFwimizTsNjyKue+W9NasTOG0jgjkgkoKv3wfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 29/06/2022 19:55, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Wed, Jun 29, 2022 at 7:44 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 27/06/2022 17:31, Geert Uytterhoeven wrote:
>>> While the acquired resources are tied to the lifetime of the RPC-IF core
>>> device (through the use of managed resource functions), the actual
>>> resource acquisition is triggered from the HyperBus and SPI child
>>> drivers.  Due to this mismatch, unbinding and rebinding the child
>>> drivers manually fails with -EBUSY:
>>>
>>>     # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/unbind
>>>     # echo rpc-if-hyperflash > /sys/bus/platform/drivers/rpc-if-hyperflash/bind
>>>     rpc-if ee200000.spi: can't request region for resource [mem 0xee200000-0xee2001ff]
>>>     rpc-if-hyperflash: probe of rpc-if-hyperflash failed with error -16
>>>
>>> Fix this by moving all resource acquisition to the core driver's probe
>>> routine.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> This looks like a fix, so how about putting it as first in the series,
>> so backporting is easy/automatic?
> 
> Unfortunately that is not as simple as it sounds, as this really
> depends on patch 4.

You sure? Except rebasing I don't see that. rpcif_sw_init() received the
rpcif so it had access to all fields.


> I agree patches 1-3 could be moved later, if you think it is worthwhile.

This would not be enough, it has to be first patch to be backportable.

Best regards,
Krzysztof
