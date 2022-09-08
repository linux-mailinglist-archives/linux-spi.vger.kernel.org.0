Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6335B1CD5
	for <lists+linux-spi@lfdr.de>; Thu,  8 Sep 2022 14:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiIHMYC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Sep 2022 08:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiIHMXv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Sep 2022 08:23:51 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34DF1228CF
        for <linux-spi@vger.kernel.org>; Thu,  8 Sep 2022 05:23:39 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b19so19657396ljf.8
        for <linux-spi@vger.kernel.org>; Thu, 08 Sep 2022 05:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lW3x8eMs+QDq4pmRmlvesMk544yrqFctPvdud3q1Yz4=;
        b=CkYzETGDsCABu3zsO3QW53/WMjWRnAk2n2cw87OBtjEJciu9giPSAXdMzemT/KvzhY
         7rNimHGKSlgaTSggRJzN0P1iDIjtFwChqFsUlh6XhZPVVJ2Lr3MOZFlq9nFKEgfLr2hg
         Ufgo25AJyOPpSksY8L+eaKgdHGkuTu6a80KBeoFOmfRSaWHQFM6hiHjJ45p0a4z1F40n
         7QXAYYqQ2cGilSz5IlBJJ8fUU/3SRSivJbsRvw14rrrtb8hT50bKN/1e/s3Dcz4g4QIR
         ZiayeWmK0jrOfzbUQ1b5877p2aCQb/GZbVcvyNk1Xd1EyFrHjm00FzB7vecpIUI2WGk5
         dYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lW3x8eMs+QDq4pmRmlvesMk544yrqFctPvdud3q1Yz4=;
        b=Zgrk4sV5N0UUJazuOsfrx5u3SGoMTq+XF7SPpEfuoH9Gnv12eEwCboMDghjNdBFaG3
         hJ1kjnxHES3nGNCR0v78QXtfUsX+onW14z3wlzQ2pecUdPPljyiFrI2Y1JFLZhLngzW6
         eWBx3euQae8VX+IIr6FeLo4WvGLasv7L/CIt8bLMVOPeezmMfxshv0gKDRyMD4QbQu7H
         4olxge6QjYiznqaru4ki8gYN1iOFY3oP3NT0YOxWnNd3gULheXt6zpW3sRxtNIyHXhc+
         9SwalQcedM90EO/KfNMuOMa0MvrySv/+wfgOa751z1RGIoB5InjdHEp8lhQwly/EShyb
         uqig==
X-Gm-Message-State: ACgBeo0hrOs83mllIlJBo59vbrI2rZkQ+Bf91ppGWG+XGOI0y9tgrlA5
        RC/0JaFF7Hsm6RcylXlJQMxKuA==
X-Google-Smtp-Source: AA6agR7p8K6nBFSlkCpNMVWclPQeCBtyk0lt7btEAXszHKHxjgDr2b7rT8hGCJ1Qq4HE7qhGJO3Bng==
X-Received: by 2002:a2e:bc06:0:b0:266:23b7:283d with SMTP id b6-20020a2ebc06000000b0026623b7283dmr2572196ljf.151.1662639818048;
        Thu, 08 Sep 2022 05:23:38 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m2-20020a056512358200b004947c4dfde8sm3018216lfr.129.2022.09.08.05.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:23:37 -0700 (PDT)
Message-ID: <71847bea-f84d-c2ba-fce4-612c179a9d2f@linaro.org>
Date:   Thu, 8 Sep 2022 14:23:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 03/13] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI
 child node ref binding
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, richard.genoud@gmail.com,
        radu_nicolae.pirea@upb.ro, gregkh@linuxfoundation.org,
        broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        jirislaby@kernel.org, admin@hifiphile.com,
        kavyasree.kotagiri@microchip.com, tudor.ambarus@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-4-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906135511.144725-4-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 06/09/2022 15:55, Sergiu Moga wrote:
> Another functionality of FLEXCOM is that of SPI. In order for
> the proper validation of the SPI children nodes through the binding
> to occur, the proper binding for SPI must be referenced.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
