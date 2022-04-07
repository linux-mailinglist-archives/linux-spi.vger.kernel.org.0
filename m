Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F37A4F7EA3
	for <lists+linux-spi@lfdr.de>; Thu,  7 Apr 2022 14:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbiDGMGe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 08:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242562AbiDGMG2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 08:06:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB9CC31C8
        for <linux-spi@vger.kernel.org>; Thu,  7 Apr 2022 05:04:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id q26so6124828edc.7
        for <linux-spi@vger.kernel.org>; Thu, 07 Apr 2022 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TUagL1wODEikqUkLow3v0XH4BykbzucN8xEfLth78H4=;
        b=nnqmHk9r0F5jBw+maKTb6Sufj2aR12l7WrSCYLy+X52Zpl4xvhm3vApI8BfPZ/FSca
         HwzngoAMEytBgAXx1PNW+b2tl/TAti6xietSCob3HMt5mlOCiubX6i0Ggn4mfdljUpps
         vNPg1+Y/lvjLyBJkgf3IEKYOp8t7Hm7W1yCXMrJ+77edH7nDm23GGZz6eKW9LeWK/P0D
         zrTb8WSUD9w/KXU7BR0oL/kdGJksFN6WXoMWdRCT9V4DeGEWHZiGfSyTnraS9eQsxGm8
         eG83cMtly6GLGHunfjX/WRKVpeXQL0tuWbMK3qcGDVQZkfB3qmjO0N48MHzDLDytvW5w
         LYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TUagL1wODEikqUkLow3v0XH4BykbzucN8xEfLth78H4=;
        b=qgFcQu1MdpqAGFnC1LF834FBfzhsIe5WrhRgqQOUTuhZn/9zbZwBg8B9xIsUBO6wwU
         7lySJUtZAF62ma4ncjV6FVRcU3GyDbQGm8eSDXYvveb3yTl6wQPzzseC5fAMIrlZdWr3
         z5LFOI3QNc7++88boe3nEIZLABRJepwAaP1PtXxN6pgd2zak2A8Jrm7ac3aqcQ4jyX5U
         hM4VYW7AcdFMMzBVilyNRH6AT7EOqVzAEGNiX3IKaHUeFxKaECZXzhkhcD16UpfwRVfu
         kF4nH0fcIJewSqvJYsUSLBf3KxU6zWCbDUeS+3+FEJIEkKjCGPGhzUfQ5wps+S8K/1/d
         qnGw==
X-Gm-Message-State: AOAM531eDkazyGARFkfLpGae9mzaWKj2Qc9QsMV984gyUJ8dNMuTa1/0
        x23ebo4rTlxVZYixpiqUjyXV9w==
X-Google-Smtp-Source: ABdhPJxdmNVJ/HA/fsikeQAjG7ODJWyGCaxh4P4WauvZgQ4v3hxlwTN/dO22tLf5iCaB6uKilwN9NQ==
X-Received: by 2002:aa7:d1d0:0:b0:41c:c19e:a0d6 with SMTP id g16-20020aa7d1d0000000b0041cc19ea0d6mr13790784edp.179.1649333065649;
        Thu, 07 Apr 2022 05:04:25 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f2-20020a170906390200b006e7f5fedbe7sm4073522eje.3.2022.04.07.05.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 05:04:25 -0700 (PDT)
Message-ID: <65a57655-2311-0f9d-8667-851755aaec1f@linaro.org>
Date:   Thu, 7 Apr 2022 14:04:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] spi: atmel,quadspi: Define lan966x QSPI
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Mark Brown <broonie@kernel.org>
Cc:     Manohar.Puri@microchip.com, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        devicetree@vger.kernel.org, kavyasree.kotagiri@microchip.com,
        krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org,
        tudor.ambarus@microchip.com
References: <Yk7Ex5ltaxC7Z+N6@sirena.org.uk>
 <20220407112345.148316-1-michael@walle.cc> <Yk7LjrvqSLbzPYkw@sirena.org.uk>
 <561bbc1cf43c3795eee67e10537ba365@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <561bbc1cf43c3795eee67e10537ba365@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 07/04/2022 13:41, Michael Walle wrote:
> Am 2022-04-07 13:31, schrieb Mark Brown:
>> On Thu, Apr 07, 2022 at 01:23:45PM +0200, Michael Walle wrote:
>>> The subject should also be prefixed with "dt-bindings: ".
>>
>> I tend to complain about people doing that.
> 
> After all it is mentioned to use that prefix in
> Documentation/devicetree/bindings/submitting-patches.rst. I try to
> remember when submitting SPI related bindings.

From my point of view, the dt-bindings prefix is still expected, just
after "spi:" (and other Marks' subsystems), because that's I am
filtering the bindings.

Your submissions had the prefix in wrong place, this one patch does not
have it all. :(

Best regards,
Krzysztof
