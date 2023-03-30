Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CF66D089B
	for <lists+linux-spi@lfdr.de>; Thu, 30 Mar 2023 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjC3OqY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Mar 2023 10:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjC3OqW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Mar 2023 10:46:22 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255157EC3
        for <linux-spi@vger.kernel.org>; Thu, 30 Mar 2023 07:46:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id br6so24804364lfb.11
        for <linux-spi@vger.kernel.org>; Thu, 30 Mar 2023 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680187572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z1Fjh5ZtqQhB8d4/UD1BbNRwfMP9z+fQO4XHd2yct5U=;
        b=kmvvP0cwtzzFxAvMqLvXH+s/VC+SKGkFg2H9qYkC3jx469rq/SPWGs5V5BeETD3HxG
         9I0y29h599gCXvjsSzSDDpnuhyrmc5vvDXAHMSfJyS3wcJlFzfCz+r/TRK45n4Po+5ed
         e3uX2U7KVAUDZe7syaKG285CUJuUkew2bbItTPl5lBCCM9LwnJ7mARm7h/FnYclzf1p7
         FXUhoFfuZ4IszPxhGmrGT2FjZkVb6gFO1spR6jp+0e82/QtTzF4y/pJldPmqqwthduM4
         iYjBhtPmSh+uA2j9fQ2N3MLA5KarV14tJCORHNulgOfUBurdj9i2/Zn8x4gkJ4UXUha8
         SmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680187572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1Fjh5ZtqQhB8d4/UD1BbNRwfMP9z+fQO4XHd2yct5U=;
        b=164O0WvG8XTv17xB42BojhOD38SqPZE4BjfRNnlqaSxwiWUp/1A+y2N/vBDT5Zyzt5
         d9rSSB7CDCkHD+wUT5OfWDpLcA2yk3Pdf+EYQ7gpd/5zfjDdLefit1RTv5IgOjyIJ8eD
         lF+3FhKP/NFnc9ij+vOs2WIcYlaAMmaFQapKVpqX3fXCtGIfEOa4Cigb2144nYuigc/P
         dAfiABkPiNeq9XIKLGPEx8Fbwss+54jKsNcaMjCwHCU9QE3bvYXsd9xECwNKMGMIhudA
         6xxmyNU4epfspfW1x1fhsHznwLqirCqyNvwO2vHXIohxvGZ754gdFGnqp2j7W5xwOY/J
         HmwQ==
X-Gm-Message-State: AAQBX9c7WBxxTBzQ5AHwkZjDOdlPXg9drvi5tASUyCIrhgUYDXSDoasA
        SHCoLRJl8C/qCmGRqHCdHWGRTg==
X-Google-Smtp-Source: AKy350YiLWbNsV5anB2e8tcq75HozfrseDABH+uyqe4bp+uO++luAoeVQZ+C37X7sNCsVJg5DEggBQ==
X-Received: by 2002:ac2:515e:0:b0:4e2:cb9:e266 with SMTP id q30-20020ac2515e000000b004e20cb9e266mr6799001lfd.50.1680187572387;
        Thu, 30 Mar 2023 07:46:12 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n1-20020ac24901000000b004eb0c18efc2sm2230035lfi.221.2023.03.30.07.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 07:46:11 -0700 (PDT)
Message-ID: <420495f8-b894-1665-bbc3-f5cab0f95301@linaro.org>
Date:   Thu, 30 Mar 2023 16:46:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] spi: s3c64xx: add no_cs description
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
References: <CGME20230306015413epcas2p371356e4008af6978cdadb5b859d8be2a@epcas2p3.samsung.com>
 <20230306014239.80570-1-jaewon02.kim@samsung.com>
 <1b4f0367-a919-cd8a-17e1-a38998575e58@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1b4f0367-a919-cd8a-17e1-a38998575e58@samsung.com>
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

On 30/03/2023 15:40, Jaewon Kim wrote:
> Hello Mark
> 
> 
> Could you apply this patch?
> 
> I missed you in the mail recipient.
> 
> 
> https://lkml.org/lkml/2023/3/6/34
> 
> https://lkml.org/lkml/2023/3/6/232

I think you should resend. This time with entire output of
scripts/get_maintainers.pl

Best regards,
Krzysztof

