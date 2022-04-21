Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B1E509C02
	for <lists+linux-spi@lfdr.de>; Thu, 21 Apr 2022 11:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387498AbiDUJVC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Apr 2022 05:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387530AbiDUJVA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Apr 2022 05:21:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1222657C
        for <linux-spi@vger.kernel.org>; Thu, 21 Apr 2022 02:18:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a1so36166edt.3
        for <linux-spi@vger.kernel.org>; Thu, 21 Apr 2022 02:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=kmhiaQxqxxrEcAZhh+yNwzq2hOuXQMjlbA6lx4ca8i0=;
        b=IcQKPWd4riTif+Hkl53cvMC/y3Es1tpcy0ux7OPeHVIBPrPeMPSbTGLaXNP2+0wWlN
         h+UqaAyiEKobQ0zCFAf1CQhYLZ878c4adHG5sLZQjJ3d8a/zNuAsS9NXFhmSiaD+BIXF
         QHGT2yhopG4WFnAA5YXTEkSJKhUZwUiUzWST/PHAXDNsjLa7DIm5ZrXL9QUWwtZhsUum
         XwR6ctDB654XYDDM7GiX5Rg7NFHm0vEMR5HRWbsUjOQswodk+nQytrZn3Jg6aXDXVkox
         MynQ9Cq2NBddnOMXJTtfOwuN4JZUfIatPFJHA067Z0zcNvzsnN7yOb1lmzAHo2T/9ERd
         gAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kmhiaQxqxxrEcAZhh+yNwzq2hOuXQMjlbA6lx4ca8i0=;
        b=lI6mccZODPpU52NokQSVWuE3crkC5mPrK+Nkhkf653oZ/4+vGNNxOHm0Ej9bi4HZS0
         FpmYrxIFM/r3D2KX2DViY6LNKbsdkC2Y0vqaEQjeZfQPcdx+isDoTCO/FIMuMmLovGmW
         wTTrQg/AObtFJjURVwAwIv3iDqe83yOS9U+1gHMzxEcT/CSSd27577pzV+VFmZajGKxB
         hFfHP84pXxkLMGJQLvSShd/ON3a4yv9N//1vR3N33e1lGio+XfXwlQ2Rrc9Y7O5SZEl1
         sINPagqdqTmxwnu+jMDrLPJ/Hre0TrfRYfhmRrgK9185qllBw9lFZeYT0clCK4U3Aazs
         Op+g==
X-Gm-Message-State: AOAM530u1+RuEdZl4vq0RxON5r4PJ+puAr0BOFG73dqZYiXnMl/v7JRz
        5UTpiH5amJn1JVpaNi3oF5Doxw==
X-Google-Smtp-Source: ABdhPJw2V1NhrUtFTzpR84KL+ElSdaPSU1YX7RYN6P9D3rfgMA87iITUYQqOqv2WSfaGGeIpItks3Q==
X-Received: by 2002:a05:6402:4414:b0:408:4dc0:3ee9 with SMTP id y20-20020a056402441400b004084dc03ee9mr28169156eda.203.1650532682167;
        Thu, 21 Apr 2022 02:18:02 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906505600b006da7d71f25csm7612093ejk.41.2022.04.21.02.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 02:18:01 -0700 (PDT)
Message-ID: <f6086989-a4c1-4223-fad0-79bd5719432e@linaro.org>
Date:   Thu, 21 Apr 2022 11:18:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [EXT] Re: [PATCH 1/2 v4] dt-bindings: dspi: added for semtech
 sx1301
Content-Language: en-US
To:     Jerry Huang <jerry.huang@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220420073146.38086-1-jerry.huang@nxp.com>
 <d74f62d7-7aea-b31f-1c2f-540c54df289c@linaro.org>
 <VE1PR04MB6477553510B6EB35D7C22C13FEF49@VE1PR04MB6477.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VE1PR04MB6477553510B6EB35D7C22C13FEF49@VE1PR04MB6477.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 21/04/2022 11:11, Jerry Huang wrote:
> Please also answer Michael's comments.
> 
> [Jerry Huang] I double checked the MikroBus devices, we used two MikcroBus devices:
> BLE P click: https://www.mikroe.com/ble-p-click
> BEE click: https://www.mikroe.com/bee-click 
> Both of them are SPI interface connect to ls1028ardb through MiKcroBus interface.
> So the name "semtech sx1301" is not correct for this node.

I asked to remove the words "Devicetree bindings" and this was not finished.

Now you mention that entire name of device is wrong... It's confusing. I
don't know what device you are describing here. I expect you know. :)

What is this binding about exactly?

> How about "mikroe, spi-dev" or any suggestion about it?


Best regards,
Krzysztof
