Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF8458ED42
	for <lists+linux-spi@lfdr.de>; Wed, 10 Aug 2022 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbiHJNaN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Aug 2022 09:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiHJN3u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Aug 2022 09:29:50 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1548531DE5
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 06:29:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l21so4630510ljj.2
        for <linux-spi@vger.kernel.org>; Wed, 10 Aug 2022 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=M2+lgkUGbiFpPnZJdDr1e6oVq21WQvDGuoGeryWgspw=;
        b=v76915Wzkkb1kBO16clztnFIfDJ0uvr0SKRaKC9YqQTf4IG6gm5Esg0V2n7qpgVjKc
         53nyQ/6SBOQYXM3S0uiFmZeMkhhjD6qU654x8jiVbC7Nt8ucqIjFzFVtA7w/z4nbWDSd
         JE45An8wat3l9WvALCFihINHrujCNJ2Gupi30v++JCi+M0GNMhSuSUzliUhhyTEUFtjw
         CXxs2tmiy6RbEfe/gpI/6HUrNlz157WV0BTEOTQcnt7A92mZJh2au/0Mgi1w61PS5QAu
         T6Q51PpTF4bAyyS/dXsa0CkH3HhfdugGRaM1OelRmPstyyYWe/Gc9WoJ+KTJRXSuvIgK
         S12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=M2+lgkUGbiFpPnZJdDr1e6oVq21WQvDGuoGeryWgspw=;
        b=KVF+X2vrjNOOPQPz6+AyuFXNPBM3ixcdeTnv8J5TwC+HkWfMViIKjERIbt4Y/LcVg9
         2EbBySLlGdXvxjl7ymQMDZnQl4mi21iHqd4kTyWEZLjUzXccI8VklzaL4w+3h4QKherU
         Ntu6xdfnHXfqWkJedhfHZZhL7OtZEdDDPzZb5TK1zhBGuJr6DDbElnigz4aQf44J5jIl
         1kFeWtt9Tmh9EfKz5mhwjn+NJ8FlkXfC/TOuYGhaEv07qSSAOJVTtNL0uVr1alRpbMYs
         9k/7RQy+jxTXqFignDP3thAOn0vTPFXzy5qwnt2kkORbC40FMlmVJ/ufZl5wBMuWrmq0
         YtIQ==
X-Gm-Message-State: ACgBeo2UMAPbbVjM++RtvDG5YUwfbgxWdrA3aWZSTq+e7Gmsrtnx7Wf1
        88683ofqVxnZVOHOnZQBMf9piw==
X-Google-Smtp-Source: AA6agR56rpbkPS2VaMru/xs//Y04YuIV0S7fJ48JvFSxZ8tdGKn2VGteZCIB89deq4DtpaBko9t+5g==
X-Received: by 2002:a2e:a28e:0:b0:25e:734f:38fa with SMTP id k14-20020a2ea28e000000b0025e734f38famr8723830lja.446.1660138177491;
        Wed, 10 Aug 2022 06:29:37 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id d8-20020a19f248000000b0048a934168c0sm349958lfk.35.2022.08.10.06.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 06:29:37 -0700 (PDT)
Message-ID: <dd173944-80d3-e13f-c405-f076401bf6c7@linaro.org>
Date:   Wed, 10 Aug 2022 16:29:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] riscv: dts: microchip: add qspi compatible fallback
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc:     nagasuresh.relli@microchip.com,
        valentina.fernandezalanis@microchip.com, broonie@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220810085914.801170-1-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220810085914.801170-1-conor.dooley@microchip.com>
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

On 10/08/2022 11:59, Conor Dooley wrote:
> The "hard" QSPI peripheral on PolarFire SoC is derived from version 2
> of the FPGA IP core. The original binding had no fallback etc, so this
> device tree is valid as is. There was also no functional driver for the
> QSPI IP, so no device with a devicetree from a previous mainline
> release will regress.
> 
> Link: https://lore.kernel.org/linux-spi/7c9f0d96-2882-964a-cd1f-916ddb3f0410@linaro.org/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> See the link for binding discussion. I'll apply this at some point once


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
