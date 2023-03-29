Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AECB6CD2D0
	for <lists+linux-spi@lfdr.de>; Wed, 29 Mar 2023 09:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjC2HSr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Mar 2023 03:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjC2HSq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Mar 2023 03:18:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2B13A86
        for <linux-spi@vger.kernel.org>; Wed, 29 Mar 2023 00:18:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r11so14573329wrr.12
        for <linux-spi@vger.kernel.org>; Wed, 29 Mar 2023 00:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680074310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eajfSt8w9ufgtddPRPPD3ycsjjI6dYwIY70vn8OhuP8=;
        b=JSFX3SUpSO5Pnvj3Bqsee5QeVRvC2/QwIyuCX8YXzGW5i6X0bCAvZLf1SupVEtz9UN
         gWwlHf96GuuINcA1o7sN3ygP5HYuSo3uU0xg3t2cl3SYta1zrA83TbWB0hvtj5rRA9Sc
         HV0juj5v3ecuAP/ce0rn4BjDpEVsBrLy1rMJqs8Cfy9vz8lAouIOy71e1tvEvb5a4ffr
         tTrJzYV969vDjgvXcW8u0u8g863K1CSaP8NmoqUbU3UZi21B+uTtoOR8MMVjlMEkaLGV
         tjpGeEu8vDUCA8qPVH1YKFk3tYIcTKnUbvoCO34usOfWxaFUV8fnmnDk3hvC+7EoS6xe
         6Obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680074310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eajfSt8w9ufgtddPRPPD3ycsjjI6dYwIY70vn8OhuP8=;
        b=6mkFoh3I1lt6QI9hmnOH6aZBya7coPbVlspa2EsS3fZ5EvQmuya8+1oRWhtVuv24pV
         OQQoxV2TGCQrayoJi5FGlMorfta//uBD2Dp2nWlNYVcDmP+V+TLX9IT6uRYIpAPZqKWZ
         uHdlu+KDGJTBRuMOSrttOH+mRTAeHBWx05XsEApQjhquG5xPjq046NcB3WT4RIT7Ju2m
         xtAYKBk5nWBVjxpNwl2xZF5LYe7hsVOVsOFkSqMfzPP0Aoa8sOrty3Jzq5uuuUjh/Goa
         B7H85DY0u8n7BVE6e32x5z7DzXlU7s82LRKeVNTlpRhnlwnQolkTmj78tLYMa36RX/jf
         h9rw==
X-Gm-Message-State: AAQBX9ffk2AJbE2F3wFq0/HYnZ3oKD77uhyQXlnvIdOXg3QA25vzjNc9
        6wZ1Y673JL/V8heaplImv+LhDQ==
X-Google-Smtp-Source: AKy350bo70toYQ1jB282XzP5A8Q0DmRgF0RkhKapiG7TXsz1y7SEzDi3UbCgIf7qeNPJVgxKvgJFNg==
X-Received: by 2002:adf:ce01:0:b0:2e2:730a:c7de with SMTP id p1-20020adfce01000000b002e2730ac7demr3550893wrn.24.1680074310088;
        Wed, 29 Mar 2023 00:18:30 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d484c000000b002c59f18674asm29503250wrs.22.2023.03.29.00.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 00:18:29 -0700 (PDT)
Message-ID: <e01a753e-aea2-5489-e436-2ec0f3fedb64@linaro.org>
Date:   Wed, 29 Mar 2023 08:18:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next] spi: rockchip-sfc: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     "Yang.Lee" <yang.lee@linux.alibaba.com>,
        broonie <broonie@kernel.org>
Cc:     heiko <heiko@sntech.de>, linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20230328062118.86336-1-yang.lee@linux.alibaba.com>
 <48f1ee32-a030-8188-3a9d-612888b9678f@linaro.org>
 <e6d8f4ce-8b3b-4cce-be94-cd5902c676ae.yang.lee@linux.alibaba.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <e6d8f4ce-8b3b-4cce-be94-cd5902c676ae.yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 3/29/23 07:06, Yang.Lee wrote:
> 
> From:Tudor Ambarus <tudor.ambarus@linaro.org>
> Send Time:2023年3月28日(星期二) 23:16
>> If I were you I would make a single patch addressing all the drivers
>> from SPI as this is a single logical change. You get extra points as you
>> avoid polluting the log.
> 
> First of all, thank you for pointing out this.
> Because the maintainer list of each SPI driver file is not identical, I am worried about causing trouble for too many people, so I split it into multiple patches based on this.

The change is trivial enough to don't bother at all. Here's an example:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=4b23603a251d24022f2fa48ee67610eb245a4115
> 
>> No, you better use devm_platform_ioremap_resource() as res is not used
>> afterwards. You'll get rid of the local variable too.
> 
> It's my bad, I will send a new version.
> 
> Regards,
> Yang Li
> 
