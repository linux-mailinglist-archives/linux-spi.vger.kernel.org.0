Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC34588726
	for <lists+linux-spi@lfdr.de>; Wed,  3 Aug 2022 08:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiHCGLJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Aug 2022 02:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiHCGLI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Aug 2022 02:11:08 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE9E201BF
        for <linux-spi@vger.kernel.org>; Tue,  2 Aug 2022 23:11:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e11so17861775ljl.4
        for <linux-spi@vger.kernel.org>; Tue, 02 Aug 2022 23:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QoMJEDXqR4eIF4IASWXdOokQ+55n5mDMby1kRaG/HSM=;
        b=OhJcdZq9zDydApto3QxFuxa9FqLO7pJWxzKfN2DV0yGhlBLC9EFrB9hSwYRUHyWfz7
         OSsjTc8Hn9m5eZQzG8cI0MnIcVg9eyNhajmfcXpgfxDbwEB1T3rMFElhaIjQoHSo/WTJ
         NFYOzHs0Z67TWBlUGJxOgpSHxplYLxJtOb0N8iU8iNsHMmtFgL2IWq+mZusa3hzU49K6
         nlf/maCe1y6OHkSX/p9UFzB1TVrAbINL2Wr1sFL0ulmHLMDdBQvfYBft2p/frxLNw9zA
         UHGyuZmaHaF39CAT4K+ZAyG9QsQCfeyHZH9CIGcvnG5N6fBAkhsv6KJt22GPRzoKXoBy
         GS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QoMJEDXqR4eIF4IASWXdOokQ+55n5mDMby1kRaG/HSM=;
        b=xprtjLs2v7lDZ1nZv7BL76s+B248uacLP42ftPrbAy4IN1WSR689aBK+SdO9OubljF
         iB0jbIqQ7Nvr8sY72haPwmB8Cel2xBFNP+2DlpXUrK7pMZb6a6yOH+wys/Ua+emwB2xw
         nMHP1ikQHifiamWCmG0kyWRF58z+79cd9swEa9ebEOTSZyhsFRadFEU0hA5UTukMl3si
         M2hwmHh0flEB2VGfaVPV4Gg5Q1KObEpYY2S+PorRyvhaLk/UkL/rf/hRGL/cwlDHQWF5
         fmDgC8N+2U9Xzn5AHfiEbTVmLaQtxlGBXv/x0ouMuwToUnN1KAmJ/hPrQ2HGIkxFzzzt
         /GUA==
X-Gm-Message-State: AJIora8ZaY/d84XqqmeK8HEYhc9zI9zeP1DhCRhCtl+YNydjbN1e3ErB
        XfXazVMc00a2trYzzdilzt2NcQ==
X-Google-Smtp-Source: AGRyM1vW8N/9hORhsm1kN8Q9PDUfMzZ2mGXeJpVq9yj72rbi1OLc/w3tUsYZ84ZlhLAxUACT1oT/2g==
X-Received: by 2002:a05:651c:1992:b0:25e:68d:e757 with SMTP id bx18-20020a05651c199200b0025e068de757mr7245754ljb.309.1659507065652;
        Tue, 02 Aug 2022 23:11:05 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id o18-20020ac25e32000000b00489f0c8bddesm455144lfg.207.2022.08.02.23.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 23:11:04 -0700 (PDT)
Message-ID: <dc7bca02-5eb3-3b33-8911-a950b630f197@linaro.org>
Date:   Wed, 3 Aug 2022 08:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] spi: dt-binding: add Microchip CoreQSPI compatible
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor.dooley@microchip.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-2-nagasuresh.relli@microchip.com>
 <6d36b192-9e63-ec13-5583-22b81c99c18b@linaro.org>
 <Yuki3jpCSJDdXcWA@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yuki3jpCSJDdXcWA@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 02/08/2022 15:13, Mark Brown wrote:
> On Tue, Aug 02, 2022 at 10:52:25AM +0200, Krzysztof Kozlowski wrote:
>> On 01/08/2022 11:42, Naga Sureshkumar Relli wrote:
> 
>>> -    enum:
>>> -      - microchip,mpfs-spi
>>> -      - microchip,mpfs-qspi
>>> +    oneOf:
>>> +      - description: Microchip's Polarfire SoC SPI controller.
>>> +        const: microchip,mpfs-spi
>>> +      - description: Microchip's Polarfire SoC QSPI controller.
> 
>> Useless descriptions - they repeat compatible. Just keep it as enum and
>> skip descriptions. What value do they bring?
> 
> Someone not familiar with the full Microchip product line might not be
> aware of the expansion of mpfs, it's not blindingly obvious.

Then it should be explained in title/description of the binding, not in
compatible. This is the usual way of providing some text description,
not for each compatible by repeating the compatible text.

Best regards,
Krzysztof
