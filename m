Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD1D5F696A
	for <lists+linux-spi@lfdr.de>; Thu,  6 Oct 2022 16:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiJFOPk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Oct 2022 10:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiJFOPM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Oct 2022 10:15:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AE7EE25
        for <linux-spi@vger.kernel.org>; Thu,  6 Oct 2022 07:12:47 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d6so2871430lfs.10
        for <linux-spi@vger.kernel.org>; Thu, 06 Oct 2022 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=n77JB3v5NQQWYXMjQE9mQos/CzAUaBxNKKkh7H62z+s=;
        b=LErqkYQ3SKuNYCFFC05liT3/69AynMf1KtPpKCZaBCGgTDRYRpQMD+PACtiHdUHNVI
         CvL7H/8TXvtFKsOimAKz9j64XVLhx++47eDDb4XoEJHNRQ4A1yei0XH+pHhZ/nuCbToP
         QnT6vhg+DQWa0u+MCmqLMJX7KlspTevR+QOJ/exQD7s+yqOU9jDMeonj0iIrBJ7dF6GK
         +XDbYeLQ9pUwvE+s97XqKmB3SsHEs5se1x5e6mSZGwuKp5/UvT+ejwzFzCpZXHUi4IEM
         rciTiYPNX+VBCe04KFWxwdPqiRhlwgi0aD3xSse+ZGkoUdleRcyiWu60qAEtHCBiWSAN
         9ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=n77JB3v5NQQWYXMjQE9mQos/CzAUaBxNKKkh7H62z+s=;
        b=nI+Ppi8QhAJESSjrZhFh8a4xR6QrJQ1BvdY6OUJ+PvyqLE4kSm1ZLHKE2wjGTmrInc
         2wue0s2wAah6wriOBheslid4tVLvgyY5xw3807eDDKk6rh5oGTF+5P0qDKzCIyirAen1
         0x5JuThiuk4Bm6TgxyRGbIpX397HRWFKAx7KrDc89eZrP7p0Je0YXX+itp9Av72syX4c
         Ix0jRkjOBbTajrUuZZu2I3OeOrLXYje0O3jJ0VVe5auDRbFQ8BJlLQBu6ZGny5HsCJ+f
         ASB3RQjEoKV9dvlQTFoAshZBqQMnbkOUSFdYCQtvKMKeYyNJe0s+JFCHRRVG9K+tUg8s
         w4WA==
X-Gm-Message-State: ACrzQf23v1IL0pygpLLIxVywCwcHSNDnYLbodJhxtIfjsQxuxzViWDZ0
        LnMSvB2BuZdW0YWfrKzswNzobw==
X-Google-Smtp-Source: AMsMyM4ylZPoyJycfqTxZLE/wBpDPIPW+NjZKnv18zVYR3Uj+em69HKE9roVPotUhNN1V5zutAzBpw==
X-Received: by 2002:a05:6512:261c:b0:49f:af36:d47 with SMTP id bt28-20020a056512261c00b0049faf360d47mr65017lfb.284.1665065502063;
        Thu, 06 Oct 2022 07:11:42 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be25-20020a05651c171900b0026c1cbbf461sm1922973ljb.80.2022.10.06.07.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 07:11:40 -0700 (PDT)
Message-ID: <7bcb9ef1-6b56-2f5f-3ac9-acc9ed9370df@linaro.org>
Date:   Thu, 6 Oct 2022 16:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Da Xue <da@libre.computer>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221004-up-aml-fix-spi-v2-0-3e8ae91a1925@baylibre.com>
 <20221004-up-aml-fix-spi-v2-1-3e8ae91a1925@baylibre.com>
 <d2ce98d7-1025-9c6e-e207-00e91942077a@linaro.org>
 <fb2706e3-f758-a0b0-d595-75ef362a853e@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fb2706e3-f758-a0b0-d595-75ef362a853e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 06/10/2022 12:57, Amjad Ouled-Ameur wrote:
> Hi Krzysztof,
> 
> Thank you for the review.
> 
> On 10/5/22 10:14, Krzysztof Kozlowski wrote:
>> On 04/10/2022 13:10, Amjad Ouled-Ameur wrote:
>>> SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
>>> pin biais when idle. Therefore define three pinctrl names:
>>> - default: SPI pins are controlled by spi function.
>>> - idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
>>> by spi function.
>>> - idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
>>> by spi function.
>>>
>>> Reported-by: Da Xue <da@libre.computer>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>>> ---
>>>   .../devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml   | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>> index 0c10f7678178..53013e27f507 100644
>>> --- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>> @@ -43,6 +43,14 @@ properties:
>>>       minItems: 1
>>>       maxItems: 2
>>>   
>>> +  pinctrl-0:
>>> +    minItems: 1
>> maxItems?
>>
> Will fill it in next version.
>>> +
>>> +  pinctrl-1:
>>> +    maxItems: 1
>>> +
>>> +  pinctrl-names: true
>> Why do you need all these in the bindings?
> 
> SPI clock bias needs to change at runtime depending on SPI mode, here is an example of
> 
> how this is supposed to be used ("spi_idle_low_pins" and "spi_idle_low_pins" are defined
> 
> in the second patch of this series):

I know what it the point in general of pinctrl configuration... But the
question is why do you need to specify them in the bindings? Core
handles that. IOW, do you require them and missing/incomplete pinctrl
should be reported?

Best regards,
Krzysztof

