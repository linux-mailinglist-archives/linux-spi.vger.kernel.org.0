Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4587166E482
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jan 2023 18:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjAQRKu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Jan 2023 12:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjAQRKt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Jan 2023 12:10:49 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C4B2FCC9
        for <linux-spi@vger.kernel.org>; Tue, 17 Jan 2023 09:10:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so5236265wmb.0
        for <linux-spi@vger.kernel.org>; Tue, 17 Jan 2023 09:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJZrjs9gIAePj2JWZucgl4KqkX8gBUba8+l84UFe0sk=;
        b=lxAQjJd0DQR3iHiWtUCfBch7u0vWQTPf5HM/vCjp0OQahVUf3gJe4QMUe5LmDCt+4e
         OCX3dsHgG9SEAnlp8XJJWoN9XaAc9Mdv+IDrPje2wo7p1PMSFlo4jrZf8D9fYE5wFPH/
         3q0OA8f+fxHVlRD+4aHURCViLOGSelep5PuRiGIHpR7aWCLqb8/w0WT/idMH7gdok6j9
         Q/mN3cwXiF5FWWEho968LADfveV+FSTugTmNVX6+Sk7cL8bVsCQ1BqCb8td8I4+65aKU
         bvUjhm80sb9vbRvNYnWfzoi7G05kVf6Xakiu3R9GHuciQyqs8DKXuIynFelr7RR75rGz
         6vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJZrjs9gIAePj2JWZucgl4KqkX8gBUba8+l84UFe0sk=;
        b=GzigXqbc7KyLwfbqrSoj//GBVqs4SvHOIxZnY2avjt944xWODqi+x6fIeFZsZJqBZL
         K9/J/7KnNifQrgNRCYtO869xtx/rmIXAbhgZYJG/kIF4FliVbTjQoWZtixoDEkwPp3c2
         bJoXmcfPqGiizcXhPDT2bmuBbOyzI9p8CeVECfyUWi+zk6rrgBgA8O/X6rCtBhQw1wf8
         oteCbQjSCDvAdDBVI4q7Ww8MmVyLmaI9JKKZXO4GG6b2nc5XD7L4DmZjxLxs/mOqdVlD
         9QJ6EnK8kR/TfqmN7YS3oES8hFw6nlgMmqtzdQxf7/74jjfKJjX/qMJUXeuyQIHAJ4rj
         FbTA==
X-Gm-Message-State: AFqh2koCZq3xtLQa/9GxvG3zVswlJan+lBcdfeVlXbeopI8uHcVtgiyv
        kl5BZmN/ekU0+MLxYzZC9fgdNw==
X-Google-Smtp-Source: AMrXdXvTPTuCnoyaO9K4WPo2MoPlGBzfRoZz27kKrLtZdpI/CyGyIFOYIq6OYekJUMbMEZkOXTKspw==
X-Received: by 2002:a05:600c:4256:b0:3da:1d51:ef9e with SMTP id r22-20020a05600c425600b003da1d51ef9emr3741760wmm.17.1673975447372;
        Tue, 17 Jan 2023 09:10:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003db0b0cc2afsm2163802wmq.30.2023.01.17.09.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 09:10:45 -0800 (PST)
Message-ID: <78fcf85f-b56b-79d1-f2fe-c038f424c72d@linaro.org>
Date:   Tue, 17 Jan 2023 18:10:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-fsl-qspi: add optional
 sampling-delay
Content-Language: en-US
To:     Mario Kicherer <dev@kicherer.org>, Rob Herring <robh@kernel.org>
Cc:     linux-spi@vger.kernel.org, han.xu@nxp.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
References: <20230116115050.2983406-1-dev@kicherer.org>
 <20230116115050.2983406-2-dev@kicherer.org>
 <20230117141057.GA2991740-robh@kernel.org>
 <85967a3fbce7051449f8d2b29ce5a47c@kicherer.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <85967a3fbce7051449f8d2b29ce5a47c@kicherer.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17/01/2023 17:33, Mario Kicherer wrote:
> Hello,
> 
> unfortunately, the rx-sample-delay-ns property does not fit here, as we 
> can only delay
> the sampling point between zero and three "half cycles" (or edges), not 
> by an arbitrary
> number of nanoseconds.

Why this is a problem for FSL but not for other platforms having exactly
the same constraints/property?
https://lore.kernel.org/all/20221208062955.2546-6-xiangsheng.hou@mediatek.com/

Best regards,
Krzysztof

