Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99C6566813
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jul 2022 12:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiGEKhF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jul 2022 06:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiGEKhD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jul 2022 06:37:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DBFAE56
        for <linux-spi@vger.kernel.org>; Tue,  5 Jul 2022 03:37:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z13so19754965lfj.13
        for <linux-spi@vger.kernel.org>; Tue, 05 Jul 2022 03:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KQNw+HNoVVOd6zABLLZO6EOnFM/ym/yFHXExMPN6G6Y=;
        b=Ue8SmLdOgCBJE7MacWwk7UayrMbTsgXvscTDx+rT9+Z5YqBhG6y3stxceoNeg0AKNW
         qMqBoDngkBRXgU5GCFjUvK5OfJwPLEfL8FeaATAtyPnvNPgnxewbpTwNk2VTvc4Qt11C
         lkxEITc/qcHopsPh680BlRThUvSz+Xljtouvn9blWoSG/8jUYgTV+tbHcGKyFok4PXTm
         nRcLw0kqEyD7kOTxwq0WGHZ4DyEdeAAQDVpekbRFvsWPYi98XUHm0edM8lTWj2owdOiu
         5EYduGeD/CaEOuu61PpQPBL5VlL04YbzNcS+OBgnB1EVV+LbE3B9y2daIgOauAU9CCXq
         B1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KQNw+HNoVVOd6zABLLZO6EOnFM/ym/yFHXExMPN6G6Y=;
        b=VwU4OmckmCB9c6lkY8WdIFbVy3oI1AKM8RLvQNtS7s924//5G5Uu+2ZmO365Im344Z
         AC5tY2eFomxKnT+KcqkeOk47bxKtDENCas5k7nLEiLyksjeXOuBWAtZ0OlyUTyfO1KoW
         7Gm/9syYuMdgepb7cYD493TMSqxU4cHXvL51anMHhrd0dD8RtWBSBIpkmJhria4qkVvT
         9kphGfDLUCeCrWkQewooR+fYyGbYWVet3eKm4fyel/1X8O98TBpshRw7LV8DgRZYOOw/
         W8eocbQl+68EaJg2C6U7zO+OtwkVLdhZjM9LtOkeRRMaoscV59IDiLjPPIK+VXBijjes
         3qxQ==
X-Gm-Message-State: AJIora8dH4Ik8v/py41Nj54KOgvNoCDPmyT5Jz6p+b51zZ1TTPyrAXiT
        9QKlDbdo7gLLKulKTlXTXItKnw==
X-Google-Smtp-Source: AGRyM1vfRzDYpBi1wpu63DmX2uwd1gFLDE0MhoUsAx26SeGlGJwEOS7cclobYWPcXvia+h6MPd2f/w==
X-Received: by 2002:a05:6512:281d:b0:47f:ac1c:fcf5 with SMTP id cf29-20020a056512281d00b0047fac1cfcf5mr23023535lfb.197.1657017420887;
        Tue, 05 Jul 2022 03:37:00 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id f9-20020a05651c03c900b0025a79b7fb7dsm5492251ljp.93.2022.07.05.03.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:37:00 -0700 (PDT)
Message-ID: <59d360ef-5374-c7a7-2995-854ab3715b25@linaro.org>
Date:   Tue, 5 Jul 2022 12:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Content-Language: en-US
To:     Bough Chen <haibo.chen@nxp.com>,
        "ashish.kumar@nxp.com" <ashish.kumar@nxp.com>,
        "yogeshgaur.83@gmail.com" <yogeshgaur.83@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Han Xu <han.xu@nxp.com>,
        "singh.kuldeep87k@gmail.com" <singh.kuldeep87k@gmail.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "zhengxunli@mxic.com.tw" <zhengxunli@mxic.com.tw>
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
 <1657012303-6464-7-git-send-email-haibo.chen@nxp.com>
 <ef676df1-77e0-b8ee-3950-97eade8ddd5b@linaro.org>
 <VI1PR04MB40167A70FBE772DF91047A4190819@VI1PR04MB4016.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VI1PR04MB40167A70FBE772DF91047A4190819@VI1PR04MB4016.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 05/07/2022 12:28, Bough Chen wrote:
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 2022年7月5日 17:48
>> To: Bough Chen <haibo.chen@nxp.com>; ashish.kumar@nxp.com;
>> yogeshgaur.83@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; Han Xu <han.xu@nxp.com>;
>> singh.kuldeep87k@gmail.com; tudor.ambarus@microchip.com;
>> p.yadav@ti.com; michael@walle.cc; miquel.raynal@bootlin.com;
>> richard@nod.at; vigneshr@ti.com; shawnguo@kernel.org;
>> s.hauer@pengutronix.de; kernel@pengutronix.de
>> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-mtd@lists.infradead.org;
>> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
>> linux-arm-kernel@lists.infradead.org; zhengxunli@mxic.com.tw
>> Subject: Re: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
>> nxp,fspi-dll-slvdly
>>
>> On 05/07/2022 11:11, haibo.chen@nxp.com wrote:
>>> From: Haibo Chen <haibo.chen@nxp.com>
>>>
>>> Add one optional property nxp,fspi-dll-slvdly
>>>
>>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>>> ---
>>>  Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
>> b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
>>> index 1b552c298277..6bd61565686a 100644
>>> --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
>>> @@ -45,6 +45,12 @@ properties:
>>>        - const: fspi_en
>>>        - const: fspi
>>>
>>> +  nxp,fspi-dll-slvdly:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: |
>>> +      Specify the DLL slave line delay value.
>>
>> What are the units?
> 
> Do you mean here need to give more detail explain about this properity?
> 
> How about change like this?
>    Specify the DLL slave line delay value. The delay target for slave delay line is: ((nxp,fspi-dll-slvdly+1) * 1/32 * clock cycle of reference clock (serial root clock). 

This would be good.

> The range of this value is 0~16.

This needs to go to schema instead as "maximum: 16".

But still the question is - what are the units used in this "delay"? ms? us?

Best regards,
Krzysztof
