Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467656CD3FA
	for <lists+linux-spi@lfdr.de>; Wed, 29 Mar 2023 10:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjC2IGA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Mar 2023 04:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjC2IF7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Mar 2023 04:05:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FD82114
        for <linux-spi@vger.kernel.org>; Wed, 29 Mar 2023 01:05:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g19so5931937lfr.9
        for <linux-spi@vger.kernel.org>; Wed, 29 Mar 2023 01:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680077154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjsCaclLV54PUQBCXvfqXG6NcxhUWOzoT0j7GVU3LHk=;
        b=JkmUi/idGnZvhQNNVFQ7LPjDya7OX27oIez1Vy/KArqlD2gs4p2XgvA00bVLlcf99Z
         l4wL8KOOW+E93PtjJb0N04FOA2nNBjDKmyf+B2tZjNp3OAEmTyTwp/nywhSfX447hpeo
         d7VervBxS2h7/XvEORlYL/N/4BB7+Syt3OnzrNOIAHgi9pp2Bh6V0yx2/kNmeqYMd8I/
         IvEnvR6a2E2O4kETdWhIisP2FpqqeBc6IC+Xcxq9Gom6QnN3UTfFcYDORtJ1EYe02ZuH
         Z84+BfgZGmTlnNOsK787ZAU0GNVkQeWTtZiDavAxGJwjJNYv6uQqd/+sFOPhB3R5zkEd
         XNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjsCaclLV54PUQBCXvfqXG6NcxhUWOzoT0j7GVU3LHk=;
        b=o4p4GVcG4UQMKsOfaKUogYSzIeHj4i+ZaJ+JwyhM6M4paHuaYS2pfrrw2YyAGjKGLT
         g5XHsTv/XmF2atk+3zl443BmDmuN+opgmB2gNuBqb7hzGMegVC6lWYa3fIEtzSxGpb5k
         zSUDfnMWpXvGBUA7ks1ModT3BMLfVf/sV6k+IBOo4PEN6sHufiFiv5AxI+qGvHYTsQAu
         yKMy/0H1WeIZ7cQ6NlpF3f25WhQB5/FT5fs4xgOlDIbtWxD6ccoOwZJSOyxANzrwHhYX
         QtxZeFcxQJdUfstwx2iLL0BQMLmdkzqjKOnaYnVbgB16qEOZ7JeVH+7LIgcv2hIrZJyo
         uS/Q==
X-Gm-Message-State: AAQBX9dxgJDM4l6aJu9N9/su9CfWgXSWqWiUjEfAYzP8nS2kNx+lE9Ov
        rUNyGPckE+X2ppW6STLAUGGD4A==
X-Google-Smtp-Source: AKy350ZHmWuIA0HL6qbVF9DdPRUk6J/Ib7EpPBBdbwXuprkVuitGJ+/S4yTzEeLzd8KdLZvgYbrtKw==
X-Received: by 2002:ac2:530d:0:b0:4e9:a9e6:2752 with SMTP id c13-20020ac2530d000000b004e9a9e62752mr5597821lfh.22.1680077154459;
        Wed, 29 Mar 2023 01:05:54 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s8-20020a19ad48000000b004dc83d04840sm5325670lfd.79.2023.03.29.01.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:05:54 -0700 (PDT)
Message-ID: <3850df80-d3e9-00a8-df4a-fddd86706373@linaro.org>
Date:   Wed, 29 Mar 2023 10:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/2] dt-bindings: spi: add loongson spi
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        Mark Brown <broonie@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20230328112210.23089-1-zhuyinbo@loongson.cn>
 <20230328112210.23089-2-zhuyinbo@loongson.cn>
 <168000761529.3001360.2224316097077012976.robh@kernel.org>
 <4ed4e0b6-63a8-a5b1-fed9-64a6d036459b@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4ed4e0b6-63a8-a5b1-fed9-64a6d036459b@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 29/03/2023 03:12, zhuyinbo wrote:
> This patch need depend on
> https://lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/
> then the spi yaml file will build successful. That changelog had record it.

Thus it cannot be merged now. Do not resend it till dependency hits
mainline (since you decided not to go with Rob's advice).

Best regards,
Krzysztof

