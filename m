Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB0B6F4B2C
	for <lists+linux-spi@lfdr.de>; Tue,  2 May 2023 22:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEBUR7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 May 2023 16:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEBUR7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 May 2023 16:17:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DF42698
        for <linux-spi@vger.kernel.org>; Tue,  2 May 2023 13:17:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so9066057a12.0
        for <linux-spi@vger.kernel.org>; Tue, 02 May 2023 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683058659; x=1685650659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AkGULLyqF8CC2Bp6dAKyvnTxkPczQ+NJ3Bki8TOIHmw=;
        b=EcF2SP95UU/BhrdQNCz/A2zrvTL2Tda6Lq1WpiPhMiUhlVa2laHS7RftgJifUWyWAt
         KOL+0CrXzcsAkxschr/TxSFNmgTspOUdrwoYogekNJt/8owN6UI4dvmkLBuACC57+fCe
         H3/xnvAqcjD/ftNvZpOpCKwn91SVve7sSNPORfrjJUjT6h3tLyCq7+VD1LxK6EOhbdzP
         EvapYtN49f7iSQDxH7jlfD/tLM8Pezx9Msu7QXB7PcdioxpIIiKFvHq0C0w6u3IRYllp
         ZTUsTIyAbGPqz9ArmklWlHP8hXHL5hwHAxDPmPHRQAG5uGCWEZ/JSGZGa0uuW7j5NNCJ
         Vl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058659; x=1685650659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkGULLyqF8CC2Bp6dAKyvnTxkPczQ+NJ3Bki8TOIHmw=;
        b=VYlAiw3ao53Te2IJt+2IJKMK3DlzrqQXogYqURfzTOaHDbxQm+dqFv4syki+GQaNib
         wAY/6cOj6CjA59giJ3KsgTifGKUkz8oam54TERsGfIMXQ4s9Q42Tma17VYEzyaAF1tqp
         VSnCSvB+dlQ7SWY2nzMUbkirL6bupgR7jm+suZCR+eVX+I8Ye+89mI2AybRiLBF0z0RT
         oNd+xie+t//MSFNGyt7JXETG7JLz75hK/eqEEcqFrDD7TmsUZmFzNCrI9wMWbfaoSvzR
         K+TtnXd9HZLTbobg0+2/Q0p3aVQyN993CiWwyY9L+YM+dKiu1YNGlS396ZT2Rpbbtl5U
         DXHw==
X-Gm-Message-State: AC+VfDyZ2ZgrEZlMNJmkit3M0xrxj5peVG65yG/E5cC3aGvZly0LJ1Ez
        4CU1HhETHxeKVwVgdO368lk67g==
X-Google-Smtp-Source: ACHHUZ7zGxsr0DvWKldqTBk/QCFwJTKsjmi/LPUolHgqBsjr3CFTWtkh536KoXTyH1F/P/6HHjoqoA==
X-Received: by 2002:a17:907:c28:b0:957:802:497d with SMTP id ga40-20020a1709070c2800b009570802497dmr1261507ejc.9.1683058659249;
        Tue, 02 May 2023 13:17:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:37be:eda5:e303:19e0? ([2a02:810d:15c0:828:37be:eda5:e303:19e0])
        by smtp.gmail.com with ESMTPSA id kw15-20020a170907770f00b0094f8ff0d899sm16154857ejc.45.2023.05.02.13.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 13:17:38 -0700 (PDT)
Message-ID: <f5431f96-0b3b-e2f8-2136-862ed529987c@linaro.org>
Date:   Tue, 2 May 2023 22:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] dt-bindings: spi: zynqmp-qspi: Add power-domains and
 iommus properties
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
References: <87563d1a920458dff134bb92b27645471f4d9fca.1683035258.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87563d1a920458dff134bb92b27645471f4d9fca.1683035258.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 02/05/2023 15:47, Michal Simek wrote:
> Describe optional power-domain property to fix dts_check warnings. The
> similar change was done by commit 0aec3958c88f ("dt-bindings: gpio: zynq:
> Add power-domains").
> And also by commit 84fa8f159022 ("dt-bindings: arm: coresight-tmc: Add
> 'iommu' property") for iommus property.

I am a bit pedantic, but you cannot use such arguments for this change.
Just because some other unrelated device (Coresight or GPIO controller)
has IOMMU does not mean your device has it as well. You know, some
device has reset-gpios, so shall you add it here?

The argument could be something around: The foo bar uses IOMMU and
belongs to a power domain.

Please re-phrase the commit msg.


Best regards,
Krzysztof

