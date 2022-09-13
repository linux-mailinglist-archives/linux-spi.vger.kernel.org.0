Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5A45B748D
	for <lists+linux-spi@lfdr.de>; Tue, 13 Sep 2022 17:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiIMPY1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Sep 2022 11:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbiIMPWx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Sep 2022 11:22:53 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410247C1E7
        for <linux-spi@vger.kernel.org>; Tue, 13 Sep 2022 07:37:02 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id z12so2787705wrp.9
        for <linux-spi@vger.kernel.org>; Tue, 13 Sep 2022 07:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=98b3ViV0sOxY601CxqpC7jH63smaiD0oF4bKw9dMEOU=;
        b=x63sDMCcfZTy1D748IyJ5aIRfCyPzNArlDP0lV9hvY4+cWUdRbyGcVG6xrdDRre/wu
         OK58fX8B9uI58ozCYyzfgATB4Rdq2rJik1QNvT01pZlRndkJ7W/smi2v5UEkVJCJJpMa
         /UjP5jhzzQUt/3TQ1vnKejcSVqf6wAm8KqerKf1MwIz7CIhvIo0h/3JcJeGM09YkqRrM
         JCz4zmvgYmgkI0MxrpHEOWKJjtiZjZNZQMe0OdoWeKlk3V7WARO0cSXoS+jwgdnjnS/y
         Hmu7TrqgUjhUSWEwHLc8llAeqrkWMx8Xsa6pAvK076PPomcN0/DoT6ceK/jSnulzUi5Z
         aqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=98b3ViV0sOxY601CxqpC7jH63smaiD0oF4bKw9dMEOU=;
        b=I0TUCYHU6nskzxgqHeAZ8mkwUk5iMcEV45nqI5aviz1kkCP9Sv/6Eb1HvIu0ItrHsQ
         8dw2PcHDsyyeGMW5Zvxak+F/eUwh/JUTb/RJf2TiBMJWeKCs3Oc3EOxFzXz3g9meLFbx
         xESwJLdFpNYBXl7GvCvwhMu6hFd4RbbuTLo6BtXtw1IE9tOSxPIyipxiAQFHkPxMEiPO
         s7P9n6ermbSEybN9YsDPjHQSsXsbXsBK0Xw/tzBsXibz3ylaDZpV5uHPajfrtDG14GMn
         Ul+FpyQZhFOztVKZkaOz6JHlKqvVzoVyVF+Ou2AJMAHVCRvl3OBImnbNi/eTyR+/EgVd
         +8zA==
X-Gm-Message-State: ACgBeo3gZ5zsNLUFR6EVN1kdMkk4eHiBb84h63Xl1gPpFjJOQHuRYzGd
        FYrMBJB+WPHoBEtsz7nPAfwFdA==
X-Google-Smtp-Source: AA6agR50vZb8xTosW20EeX8oWSBviovENhMmwWYTaHu44Hk9vz9gqIKhodf+GxHuJX6NHOObWD9U4w==
X-Received: by 2002:a5d:550e:0:b0:228:da13:952c with SMTP id b14-20020a5d550e000000b00228da13952cmr18908046wrv.694.1663079400099;
        Tue, 13 Sep 2022 07:30:00 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.67])
        by smtp.gmail.com with ESMTPSA id t3-20020a1c4603000000b003a5c244fc13sm13971234wma.2.2022.09.13.07.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 07:29:59 -0700 (PDT)
Message-ID: <fd42b847-0dcb-e116-a1bd-48e68161333f@linaro.org>
Date:   Tue, 13 Sep 2022 16:29:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 09/14] dt-bindings: serial: atmel,at91-usart: Add gclk
 as a possible USART clock
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
 <20220913142205.162399-10-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220913142205.162399-10-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 13/09/2022 16:22, Sergiu Moga wrote:
> The Devicetree nodes for FLEXCOM's USART can also have an alternative
> clock source for the baudrate generator (other than the peripheral
> clock), namely the Generick Clock. Thus make the binding aware of
> this clock that someone may place in the clock related
> properties of the USART node.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
