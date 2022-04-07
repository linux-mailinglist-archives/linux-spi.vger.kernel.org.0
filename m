Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B24F82C5
	for <lists+linux-spi@lfdr.de>; Thu,  7 Apr 2022 17:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344583AbiDGPZq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 11:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344610AbiDGPZo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 11:25:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2440E217384
        for <linux-spi@vger.kernel.org>; Thu,  7 Apr 2022 08:23:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f18so6828529edc.5
        for <linux-spi@vger.kernel.org>; Thu, 07 Apr 2022 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SRJLkMyHvzi95y55Vn5Iq6WvE2FMbtq9vylE1+a7zq4=;
        b=FUhf0Yz9rc3d4pIj7ttd/N6bOFguOSqX0iP2Dj3sEZHZM8bY7Vn/J9Am/GtNHIdv0p
         HOormLf5sdc/+pw28UHba8FOquWhPSDcoiOENy6xWdRqk2D6gcr/x3DaRN3cKLcIUTEp
         qL5OA2o3TQHIlbMjx7Saqa4+WRlko39bz8RoIyrGVwtqKFrviQnw5pB8K7q1Ph+QeaDO
         zR1A8m/jTaYCG4NGdMyRmjnUFFGwyM+tBsjYeb7UfWRMKCZ0UhZ1Vzey86C48XeECYK2
         yNxMK03PJ9b9GguOpi4FtgXwrAsmMDpxpY+GkL4WiQBuYRuASHbQrsWzR2mes0EJ8fbY
         ywqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SRJLkMyHvzi95y55Vn5Iq6WvE2FMbtq9vylE1+a7zq4=;
        b=RjpZrq1YuqZsPoXkKe1liVUx620BYY+Lmx4PX/bQ6ItR/MO3yfG3pzyrUduOXo7y1Z
         9jvNRefICfVVWqUYOnS9q7/gK8MKCcTK8KaidjbMMKVb+wpNM0bUWEOpxzSFnBY6yHBS
         he/5jJmH2pi5rTFqWI56TP0VG1j4ALAUacCU8OPMUqy6rJgEBEwl/oxiIe1ZoacIOO9p
         iEQBLeTzCAW2UWghR3Wm3Xxicrum6qyfA37wddhJQNh+KCDAd5/rLHPqbeDLEBdECsYN
         iSx5VYaIDDVGt8UZIIQwaOpuFVaUvg95FOLfELapJYHOgazjN12HyyPnGNiHNPxgc6o7
         FI9Q==
X-Gm-Message-State: AOAM530Qhrwe4Jxo/Y5EhqKNjl1oaLb7jipuP4DuvBwiRJnuMrDcu28n
        t28dHLF3XDbYc09RgJ9QXUNhmw==
X-Google-Smtp-Source: ABdhPJxpe8sU19S4ZyP0NmK+CtJZABE3mnsomrt0BfI1Ai2vqC4WVJcaC76McVCKILcMcHQzBik/0g==
X-Received: by 2002:a05:6402:207a:b0:41d:80c:45 with SMTP id bd26-20020a056402207a00b0041d080c0045mr3671422edb.248.1649345021527;
        Thu, 07 Apr 2022 08:23:41 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k22-20020a170906971600b006e840b36f5asm375813ejx.91.2022.04.07.08.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 08:23:41 -0700 (PDT)
Message-ID: <67f75e49-e0c1-463f-da39-4a2efe7cce3c@linaro.org>
Date:   Thu, 7 Apr 2022 17:23:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: align SPI NOR node name with dtschema
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220407143405.295907-1-krzysztof.kozlowski@linaro.org>
 <Yk8AJcFRmYEryqra@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yk8AJcFRmYEryqra@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 07/04/2022 17:15, Mark Brown wrote:
> On Thu, Apr 07, 2022 at 04:34:05PM +0200, Krzysztof Kozlowski wrote:
>> The node names should be generic and SPI NOR dtschema expects "flash".
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/mtd/hisilicon,fmc-spi-nor.txt | 2 +-
>>  Documentation/devicetree/bindings/spi/spi-davinci.txt           | 2 +-
>>  Documentation/devicetree/bindings/spi/spi-pl022.yaml            | 2 +-
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> 
> but it would be easier to split this into per subsystem stuff.

With DTS changes I had 22 patches, so splitting is a trade-off. If
that's preferred (actually can reduce conflicts), I'll split it and send
a v2.

Best regards,
Krzysztof
