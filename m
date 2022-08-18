Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4A959802E
	for <lists+linux-spi@lfdr.de>; Thu, 18 Aug 2022 10:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbiHRIjX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Aug 2022 04:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241839AbiHRIjW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Aug 2022 04:39:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE06B07CC
        for <linux-spi@vger.kernel.org>; Thu, 18 Aug 2022 01:39:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id l1so717640lfk.8
        for <linux-spi@vger.kernel.org>; Thu, 18 Aug 2022 01:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=CNM79prDnvIGSdG9tlifJZsSJQ0rshfUT/oq6uCdJvU=;
        b=mGVNv5Mc1HMPLSu4GlDp/YLob++Lu2/T7DNm0ANal8QINKzOTEVbxAtDZmDRgtbKH3
         jme2kEQl99d4grbAfk/GpXsnIaRT+j9YKRSDjpoDw/MotBME5rNx5TApO2j7ejSA/1y1
         Wv4yctGawIC3IFvw27iy9dlqfObrmUQ23NhnZEXtIl1gBIs28HltLZniUMrhVa586Mz6
         WSo3gcaZLoYC2N/BUlXt6oJlLU0n3b5iWXsW1wrIYR8A9FkSFyAnFLmH9k4KABCYN0qX
         fV6bbQ1hkktKK3eWdSPVo2sMg86eJxo2CSxKDe1pLPoD9TctHA2mVHR8wQ5zYQjqoPRJ
         GRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CNM79prDnvIGSdG9tlifJZsSJQ0rshfUT/oq6uCdJvU=;
        b=Wq4+wE67c+rJMpshO+HFy7LqiTAoPnvgGbNQSBb9MMd9kSb9PB3jUdithYVve0xyjy
         jskYqp87ze6e5R3rWU/AV4vwzDBxMmU+ccNrRnqlgqT6//DdhbXXBLy6F25qryB1+Qr0
         Ycjk0X9JVCAJ2wcf1wAk/gRnAo0YlBp2gFXNMBeqg/7kZiCn3Zu48ZP75EHEUHksz55S
         PdgSlJz6xMdBOCI+yI6gtpTeXBBTfka8Ujo4p34rM5/4nMdQFk/FdV4jall35kd9AO1Q
         zCqTMGcxGd2QH+jsrW0tX/nzVRj2kfsJbilG6ZjPtSyjhRuJVw6ZPBGiw/GKBgFe5NK2
         rDtg==
X-Gm-Message-State: ACgBeo3sVRed1iWyvUFaSKEde+K/yWg6xfxWn6NYNtkdmxyLCALMRKLL
        3t9CJ9XGbQoXxlFYgR5xKSaGPA==
X-Google-Smtp-Source: AA6agR4367n1q2WXa3SG7R2Rcvmplkgds9jPoODuhhRniPzdWqLdJxJHMOCgLGESuA8/WtW6lLEYPw==
X-Received: by 2002:a19:c506:0:b0:48a:ee19:a820 with SMTP id w6-20020a19c506000000b0048aee19a820mr710181lfe.38.1660811959222;
        Thu, 18 Aug 2022 01:39:19 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id k18-20020a2eb752000000b0025e4c49969fsm134851ljo.98.2022.08.18.01.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 01:39:18 -0700 (PDT)
Message-ID: <942accc5-70aa-3bb2-63dd-306a39ee5ea4@linaro.org>
Date:   Thu, 18 Aug 2022 11:39:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        admin@hifiphile.com, kavyasree.kotagiri@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-3-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220817075517.49575-3-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17/08/2022 10:55, Sergiu Moga wrote:
> Convert at91 USART DT Binding for Atmel/Microchip SoCs to
> json-schema format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../bindings/mfd/atmel,at91-usart.yaml        | 190 ++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ---------
>  2 files changed, 190 insertions(+), 98 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
> new file mode 100644
> index 000000000000..cf15d73fa1e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml

One more thing - I think this should be in serial directory, not mfd,
even though it includes SPI. MFD is just a Linux naming/wrapper device.

Best regards,
Krzysztof
