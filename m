Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C09C70190C
	for <lists+linux-spi@lfdr.de>; Sat, 13 May 2023 20:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjEMSL4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 13 May 2023 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjEMSLo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 13 May 2023 14:11:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8663B2D73
        for <linux-spi@vger.kernel.org>; Sat, 13 May 2023 11:11:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so19782809a12.1
        for <linux-spi@vger.kernel.org>; Sat, 13 May 2023 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684001471; x=1686593471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdRy69fIEsxIBR9NIDENofSkdxQv1jnZ0R7WuYlxvmg=;
        b=MU8qhVrza6BMzX7g6FE02hJZGhbAQ84Ltq//ddggsJUAULkZ7u3v+Uw9aYtM8o/C19
         QSok5XIAJV6w+OVaVCLAnXSnuZr3zf3ZLgb2LSEJFzZd+Ke0URReJYefM2FCAxCFfnPj
         us6WgPECSDxGjozAJkG1Wub6JIa6qahR40zQe7PkF1J/q1ST/evgJa/lZC4UiMsyn0mp
         IavHthGLZff8V2xuqS9Zeibnr7+xzTNDA95jICB3mzrDevNpTAhriBnkA1vXMdkpuVZI
         XOIyNU4YesashA3hWqAb4EgE2Sc+bsHFF3On6CPVWH79WH2U3sN23cRFUz+ep0a5lvRU
         VwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684001471; x=1686593471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdRy69fIEsxIBR9NIDENofSkdxQv1jnZ0R7WuYlxvmg=;
        b=DWab/NstG9kDtqIDTyAqRawejLwMJVG7678/WvF4ZzSshJxyvwR+tp6FaUqrDKr3Wn
         KnXISjbJT3F6HpoFLv4VDTpERqd2dY602lqBA3ANue46B86Wm/LqiDfqRagiI9oUaRG2
         znDvrLaLfe73a8GxMdZ7JTyUSsXUcpwWCteInL425EraXCSHlzMXfFKCO8KxP7XFlY28
         bPDtjQxeV8+S8MU/shaA4asR+Woy/vgY8SYe6/JP6s/nepziirip/oUY2CJ/DqDY1wQW
         HCxtknVlJPEIv9qJgY7+ROGEIxruqHrkvuKs5i5kALNDn9Ka36Mnyyo1nYzpFQdiA0Eq
         knUg==
X-Gm-Message-State: AC+VfDwzi6ucVhuB00b9kKShPYDvjBJ3LK8I3PUhrLJ/VQRen1cfW+TW
        uPXRo/XheUfhH0mFpoAVRKF4udH7Zq2K0MHTKA28LA==
X-Google-Smtp-Source: ACHHUZ4m7lCl8p2Q7EHaoUU/9iQg5m8GgeAPaGDj82d7+DhAw/jzqEtERboZRuZ59/7bEz4RKl+kkg==
X-Received: by 2002:a17:907:7f94:b0:969:e9ec:9a0 with SMTP id qk20-20020a1709077f9400b00969e9ec09a0mr20377665ejc.77.1684000807359;
        Sat, 13 May 2023 11:00:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba68:e5c9:694e:c6e4? ([2a02:810d:15c0:828:ba68:e5c9:694e:c6e4])
        by smtp.gmail.com with ESMTPSA id u24-20020a056402111800b0050bc4eb9846sm5105168edv.1.2023.05.13.11.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 11:00:06 -0700 (PDT)
Message-ID: <633b305e-a311-3334-3d4e-30d5d09ebb6a@linaro.org>
Date:   Sat, 13 May 2023 20:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/10] pinctrl: cs42l43: Add support for the cs42l43
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-9-ckeepax@opensource.cirrus.com>
 <9591999e-9d7f-2a4a-29df-d9c42dfa736b@linaro.org>
 <20230512155426.GJ68926@ediswmail.ad.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512155426.GJ68926@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/05/2023 17:54, Charles Keepax wrote:
> On Fri, May 12, 2023 at 05:30:37PM +0200, Krzysztof Kozlowski wrote:
>> On 12/05/2023 14:28, Charles Keepax wrote:
>>> +	priv->gpio_chip.fwnode = dev_fwnode(cs42l43->dev);

What's also a bit confusing is that gpio_chip is the parent's node, but
pinctrl is not...

>>> +
>>> +	if (is_of_node(dev_fwnode(cs42l43->dev))) {
>>> +		device_set_node(priv->dev,
>>> +				fwnode_get_named_child_node(dev_fwnode(cs42l43->dev),
>>> +							    "pinctrl"));
>>
>> That's something unusual. It seems you want to bind to a DT node because
>> you miss compatible in DT node?
>>
> 
> Kinda, I don't really want to add multiple compatibles for the
> device. This is just a CODEC device, even in device tree it
> seems a little weird to have multiple compatibles for a single
> I2C device. On ACPI I am pretty sure it would be considered flat
> out right wrong. The fact Linux supports the device using multiple
> drivers is seemed to be a Linux implementation detail, rather than
> describing the hardware.
> 

I think if you do not have compatible, then the device node should be
rather the parent (so the main node with compatible), not the child.
Child is just a wrapper for pinctrls, but not something representing a
device.

Best regards,
Krzysztof

