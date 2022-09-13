Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BFD5B755F
	for <lists+linux-spi@lfdr.de>; Tue, 13 Sep 2022 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiIMPlP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Sep 2022 11:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbiIMPkb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Sep 2022 11:40:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6FE82859
        for <linux-spi@vger.kernel.org>; Tue, 13 Sep 2022 07:45:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z14-20020a05600c0a0e00b003b486df42a3so4550624wmp.2
        for <linux-spi@vger.kernel.org>; Tue, 13 Sep 2022 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=OhF6oMN0Vft4kYUQAEz3NIZteHA5CSketL8WhjAlGZo=;
        b=mgZkp0qtG887ldB/nYlLfTsC8bvE7Lbjsbc1ppx1ap75vdzVux7ueu+wcbyyHG1MWm
         esr0PcvJI+8SxAWq5LALLfR8mnLMmt5muQCa9uz6dJ/gkacyARAVg8zeGYkFgM8Nbk7m
         F/Snv/9W43ggFYy4/czyzlhpJeI9jZIYgv60dBJUWhaiPckbXVpuGNZw3gjCQjXZ5aFB
         8vPL7FPc8ALnGM6GDgnh/zCCmaZdngZg6AiZysat/D+kLu287RCkJMTCtYf2JrPIRSUm
         Bq/eIIYxqhWrwuOeT5jQA9xUFNDqoWkJ42O3EIxNK9a1/S1PiaNYJrM7JrxRNw3S1gaA
         heRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OhF6oMN0Vft4kYUQAEz3NIZteHA5CSketL8WhjAlGZo=;
        b=Np6H8DK/3ItVleTD0l2KEViHRcoc509vcHbGjVT1IkssjyVeJLV7ZyVeduIOlUUeHt
         oEDKpTKs+UVUVI7LST4xhj+Iu+Pwf+54hR/GBUsydOr7Fp7a6aM3nFDBMAclc/95yfUt
         1YCXA9Z2v3wx4F9v52CGqjsoVue28Ra1p2ZBmNZ8tiTQa41m+kTWF8OFiOK5Mw+vo9eL
         orixjHfOoAbhlkAqBAUw6h9hPMGUC1Joe3UWYKx0ISMRXb8zVaztUQY3s0fYv+2rBisi
         O26ul/y0gBxNfNkksNUYYenalI9+D7kbYIPuxLCox+pUM6Z/6kyCMCQvCruUSC2JfFdS
         8Qag==
X-Gm-Message-State: ACgBeo0VZSTSplJmbAuMfgAciff3Xx6gWPmWAERmyT7ziuFT4hGN1JFo
        uiPLFt/dmiMQmWokB6YXdqUUUcBIWBtZ/3jO
X-Google-Smtp-Source: AA6agR5y3YuJuE0WW8Gg+GnmXi2r7cCvaATmA0bTNzNx9FS7VSHFHfbQ1KFa0M0vZrsfnXgdc4PHnA==
X-Received: by 2002:a05:600c:3ac9:b0:3a5:f114:1f8 with SMTP id d9-20020a05600c3ac900b003a5f11401f8mr2595338wms.204.1663079384919;
        Tue, 13 Sep 2022 07:29:44 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.67])
        by smtp.gmail.com with ESMTPSA id c1-20020a7bc001000000b003a5ffec0b91sm13200404wmb.30.2022.09.13.07.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 07:29:44 -0700 (PDT)
Message-ID: <dad37ca0-a44b-59ec-0be9-fb121de12244@linaro.org>
Date:   Tue, 13 Sep 2022 16:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 08/14] dt-bindings: mfd: atmel,sama5d2-flexcom: Add
 USART child node ref binding
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        jirislaby@kernel.org, admin@hifiphile.com,
        kavyasree.kotagiri@microchip.com, tudor.ambarus@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220913142205.162399-1-sergiu.moga@microchip.com>
 <20220913142205.162399-9-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220913142205.162399-9-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 13/09/2022 16:22, Sergiu Moga wrote:
> FLEXCOM, among other functionalities, has the ability to offer the USART
> serial communication protocol. To have the FLEXCOM binding properly
> validate its USART children nodes, we must reference the correct binding.
> To differentiate between the SPI of FLEXCOM and the SPI of USART in SPI
> mode, use the compatible string.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
