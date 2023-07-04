Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414DA747150
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jul 2023 14:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGDM2R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jul 2023 08:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjGDM2Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jul 2023 08:28:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A11610CE
        for <linux-spi@vger.kernel.org>; Tue,  4 Jul 2023 05:28:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-992ca792065so580807066b.2
        for <linux-spi@vger.kernel.org>; Tue, 04 Jul 2023 05:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688473679; x=1691065679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SevSQ95ow3GtjYpqXgCPnMrECe2jzasM0xVgVLW819c=;
        b=fgwp2G4rHlpBpyYwQHFN+c8PamgAxQJjZb4Ph8qKhZ4M9mCE+NXFd3tZR1OJpdYl6y
         j879K72BdCsDrvRi0s9o6ClSTHUarfwo5MGBAA/UrKyS4/GxzvJCPMg8rcNHy2eeBSC0
         /wLonHBc8XRHaXnVfPbU2B6GUcv+kT+If8UJd952WhXDhZB38pnXvjUiPj2Dhumqx5+f
         zBcPDWbHSCNfuv47yjqbmmKcDsGE2SX8zqHdlKYwhSXtHrClDiTUqJ0XvPsJQ6x8f/r7
         l1v6HYZPX2jgk7UoO+Gdde6BRMSN3o4AtQtufyp7fxcJAXZh041ggRIYBIPC/wgKFroc
         Okag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688473679; x=1691065679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SevSQ95ow3GtjYpqXgCPnMrECe2jzasM0xVgVLW819c=;
        b=KnGvl4+a0SKK01xMaL9TdwK92yoZJjfsLj+aab/inoLYmLteJEJWxT+3nIy2XlVkiT
         jzpYu43X801NCGAL+zTq2VXlGc6ylA4O49rgKi9Jp78OhFA0+ckrJuckdqi0tgcHdFxc
         XtBYhYy/yHah+nxzF/ByTFQyYAMtrxqKHE/W9MGy5Rp/L1mPdJDfGCBywBBogV3N+w1O
         rbUESENKmeYpQyOLjeoQsavtEhbOWqfkAuZPmhm82be7bsst3+hcmSol6lh/4UUObeQw
         fI0AS1DVywS2SaDCjxADSRdxlGbF5ICoV9WjxeiocLoWaOHRHiHWaWaM24WkokYyi5EE
         OCDg==
X-Gm-Message-State: ABy/qLbGUd+9KBPO85tt6DmCBS4qxa9OihPwVm6czLaWH4GeObZLqYlT
        vcs2qedDfNxAaTrk9teWK3Qg8Q==
X-Google-Smtp-Source: APBJJlH19su5vA9EyL6D7MtXA5VlLwKOm8UcW/oRKW1bw+rDa/li+5szobRKvBCIOYgZGAJ6K98IAA==
X-Received: by 2002:a17:906:5296:b0:977:e310:1ce7 with SMTP id c22-20020a170906529600b00977e3101ce7mr10322466ejm.38.1688473679643;
        Tue, 04 Jul 2023 05:27:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n5-20020a1709061d0500b00992b2c55c67sm6979176ejh.156.2023.07.04.05.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 05:27:59 -0700 (PDT)
Message-ID: <4afd90d9-f1bd-f40d-1c79-50fef1406ab7@linaro.org>
Date:   Tue, 4 Jul 2023 14:27:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND v1 2/2] riscv: dts: starfive: Add spi node for JH7110 SoC
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230704092200.85401-1-william.qiu@starfivetech.com>
 <20230704092200.85401-3-william.qiu@starfivetech.com>
 <7f3b600d-d315-22d6-b987-eabfe1b04fdf@linaro.org>
 <eba1e868-6371-42fe-91be-bcbee54d1aff@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <eba1e868-6371-42fe-91be-bcbee54d1aff@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 04/07/2023 14:26, Mark Brown wrote:
> On Tue, Jul 04, 2023 at 11:39:29AM +0200, Krzysztof Kozlowski wrote:
>> On 04/07/2023 11:22, William Qiu wrote:
>>> Add spi node for JH7110 SoC.
>>>
>>> Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>
>> Missing SoB.
> 
> It's fine not to have a signoff for the codeveloper of codeveloped
> patches, see case (a) for the DCO.

Also see:
"every Co-developed-by: must be immediately
followed by a Signed-off-by: of the associated co-author."

https://elixir.bootlin.com/linux/v6.4/source/Documentation/process/submitting-patches.rst#L467

Best regards,
Krzysztof

