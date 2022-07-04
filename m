Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505435657C1
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jul 2022 15:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiGDNsb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jul 2022 09:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiGDNsa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jul 2022 09:48:30 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9911BB7F
        for <linux-spi@vger.kernel.org>; Mon,  4 Jul 2022 06:48:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i18so15882534lfu.8
        for <linux-spi@vger.kernel.org>; Mon, 04 Jul 2022 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yVbQnN1PdV/5v48GLy/QEdWqmX9NmiWLFU5UyW0TQnM=;
        b=rFLfUSOXjD2JjVJL/awHbonTL7lX7Z5hIC6zHt9o3NC2R0K2e9G8ESUvc2VZVgjQ6m
         9ChHtc6aHEnkPCQWZ9wLaj7L9+4tIb20KLDKVwJkjlugMNzupybs1UKcf+B9yppnj+ij
         74HO2cFs1+IUowwdAygmHZwiDYZ3/OUAX8A+vuvwE4d3HRmFxR6KoT6pHim7pdT/YmWk
         Ing7j+/NsubjRivQm4ux38AkWAsU1LeX1YDl9Sn/9mGq+4Up4vg3j7gCExHBPY02QVSS
         WnCdDB685HRdOLXIgO6BcsCs60s4CpYR7KM/SWHq4TfDFzhnx1SX8KzIei1rRjIfayRP
         TvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yVbQnN1PdV/5v48GLy/QEdWqmX9NmiWLFU5UyW0TQnM=;
        b=7cMMjHj7RGbohkTH7Rg+/fjv4b9maHZ4qNS6K4adYOzUdTetsvodgOKRgYYu7vJ4R3
         2z/embs17HrdwOQLhK5DI4MqvHOTEmZRdrGU6G89+tDvbU8toybHuQn5sW+Lpocb+kGq
         A3oRZ23Hr7nqo183eXgouE3bSNN3yMtuKuuil3o0oA7AEME91eLLPh0GYPPigEzpcQLu
         GvAZ/yoe2ER/MRlI7f7xto0DRaFIx3T6b7nf+l/tvAsP8nlKDaGwyL57eaPFay+zblj1
         eGA87qVa76KikoksswEm1U+J3K7RaZfVac1sLkpdDbj7fewcamgNx/SOdyhrTQxl/nlF
         EcdA==
X-Gm-Message-State: AJIora/qeG9JzispHXb1LqLAxGhQhSOITwsT9Y1TaMP3Br2oxWU6PQtw
        KBmn1hyxy1E+gK6sTnnzxW8+fg==
X-Google-Smtp-Source: AGRyM1u3gbCEHTgedWzowPEp/7kLB+zf3Lu/svXSdqOhTM/fT2mxiHgbYWx1SOcHzOS1U6n+bXGDlg==
X-Received: by 2002:a05:6512:1103:b0:482:dbb9:c64 with SMTP id l3-20020a056512110300b00482dbb90c64mr377191lfg.346.1656942507983;
        Mon, 04 Jul 2022 06:48:27 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id w16-20020a05651234d000b004815305854bsm2245919lfr.61.2022.07.04.06.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:48:27 -0700 (PDT)
Message-ID: <a14e1b78-0f25-7f66-7969-66c3ee113025@linaro.org>
Date:   Mon, 4 Jul 2022 15:48:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] spi: atmel: convert spi_atmel to json-schema
Content-Language: en-US
To:     Sergiu.Moga@microchip.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kavyasree.Kotagiri@microchip.com, UNGLinuxDriver@microchip.com,
        Tudor.Ambarus@microchip.com
References: <20220704083143.56150-1-sergiu.moga@microchip.com>
 <315d4fd3-4f50-5d3e-ef83-e4c8604814af@linaro.org>
 <8afa9243-b216-ac6c-66d1-2509845de17c@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8afa9243-b216-ac6c-66d1-2509845de17c@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 04/07/2022 15:32, Sergiu.Moga@microchip.com wrote:
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clock-names
>>> +  - clocks
>> In properties it's clock-names followed by clocks, so better to keep
>> same order here.
> I am sorry, but I don't quite understand. Isn't it the same already (the 
> order in properties and the order in required)?
>>> +

Apologies, ignore my comment. I saw something else... It is fine.

Best regards,
Krzysztof
