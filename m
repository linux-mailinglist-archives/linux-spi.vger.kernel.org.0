Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E424AC4E1
	for <lists+linux-spi@lfdr.de>; Mon,  7 Feb 2022 17:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiBGQD4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Feb 2022 11:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384942AbiBGPzO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Feb 2022 10:55:14 -0500
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 07:55:13 PST
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ACFC0401CF
        for <linux-spi@vger.kernel.org>; Mon,  7 Feb 2022 07:55:13 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 245B13F203
        for <linux-spi@vger.kernel.org>; Mon,  7 Feb 2022 15:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644248728;
        bh=6Y+2dKF+oax8zT1A/qm081V7yzQIygshkjwkuuK0Jjs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ObLcz3uko4ptfvBF35/pdsXgcaPGSEf/pUqNeqMVjwb/d85L1Zv29MRSjQOz0PDTT
         ZMt83cfofhbsc8cqX81jD3tTC6SjOni7amzMdiuZeTrFmQMNBbejzsvX68DHF61N77
         c7LNkMBzODC/CadlDkcmO0rV5Kcw4N62ZkdcVegKWXQ/ITE6PoxzghMIsJW+2sIaMA
         vaAGXdxF+S+YxLeriSD04HlqJgbdUxt8+LoqqIlpSzpNTBRV5gqAmR8j5FzeJe06Dj
         rVmAn0pIPY8vXn0jmYhJPS/2/wwGI/heZB8AeQB/lshl5heT5O/Qb0qOuyIbUt3rGl
         j1rv/WZEmUC7g==
Received: by mail-ej1-f70.google.com with SMTP id ky6-20020a170907778600b0068e4bd99fd1so4473748ejc.15
        for <linux-spi@vger.kernel.org>; Mon, 07 Feb 2022 07:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Y+2dKF+oax8zT1A/qm081V7yzQIygshkjwkuuK0Jjs=;
        b=hnLJEIH4IvXXWKs10GYEbp4Y4pDg2XEl3FT5SkNpg19oJIBosFpcj1MjhbqromfLAQ
         YBB37rhukh1iACYSegs2FjoO6TlLWC0E6D/N9ABl6vjTmAGlCSKvsjahapJGgxc8uulb
         +LnJrVoK2qb/iHc18wH3/+PrquONGkjtHJi/8y0s7oz8MVzDVUZm5taX9XnMcR30SJKW
         humc75lX+TpAPLsgEtP1J9sorxJQIQQJ1NbZ9yo7MlmHAAqCCgiLDmGmDIlYbwNnANXO
         aZBjWLnAgJY65S/o9ur672ZdIG7PtzWXKEWAedN2JfWdAFRVJCCgLPUAxnwiDn7uTPmx
         QS1g==
X-Gm-Message-State: AOAM532iy/eHjTbjwOJEKFTYSEl9BB4J6WRwn4Ienw6wsb5MJMWUpHHe
        JQNzXn0yNfdgGSuUkxgRxlseZNEs7iGs3F7r0SXes89wzMmByMl8aglGnV9yy0BmXNyzzq9u7Xw
        +LVuID8op0tgtnePTWVKEXBjRS5dAgqZ9R5yCZg==
X-Received: by 2002:a17:907:7241:: with SMTP id ds1mr253311ejc.491.1644248727450;
        Mon, 07 Feb 2022 07:45:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWwLB3X8srR0F9tgq40qKr7ABY3oB3F7i+C8YvII4SCUp1VGjoXcEv3mNNgvu3qM4y28Q/Ww==
X-Received: by 2002:a17:907:7241:: with SMTP id ds1mr253275ejc.491.1644248727021;
        Mon, 07 Feb 2022 07:45:27 -0800 (PST)
Received: from [192.168.0.90] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h7sm1280103ejb.40.2022.02.07.07.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 07:45:26 -0800 (PST)
Message-ID: <a49f77c8-3d92-8c84-28fe-0e6735f09610@canonical.com>
Date:   Mon, 7 Feb 2022 16:45:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH next] dt-bindings:spi: Fix test error for sp7021.
Content-Language: en-US
To:     Li-hao Kuo <lhjeff911@gmail.com>, broonie@kernel.org,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com
References: <b8a94fbfcab68b1279b09b6297099310c209927b.1644198244.git.lhjeff911@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <b8a94fbfcab68b1279b09b6297099310c209927b.1644198244.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 07/02/2022 02:46, Li-hao Kuo wrote:
> Remove the include path and modify parameters for fix error for bt binding test

1. No trailing dots in commit title. Space after each ":".
2. s/bt/dt/
3. Wrap the commit msg:
https://elixir.bootlin.com/linux/v5.13/source/Documentation/process/submitting-patches.rst#L124

4. What is exactly the error you are fixing?

> 
> Fixes: a708078eeb99  ("spi: Add Sunplus SP7021 schema")

5. Only one space after SHA.

6. Wasn't it reported to you? Looks like it was, so you need to add
"Reported-by" tag:
https://lore.kernel.org/all/CAL_JsqKwg_bzJmehTG8tR2cpr+HwwvpF_cpoESidZouc_SpKcQ@mail.gmail.com/

> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> index 38589fd..298eac2 100644
> --- a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
> @@ -59,8 +59,6 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> -    #include <dt-bindings/clock/sp-sp7021.h>
> -    #include <dt-bindings/reset/sp-sp7021.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>      spi@9C002D80 {
>          compatible = "sunplus,sp7021-spi";
> @@ -73,8 +71,8 @@ examples:
>          interrupts = <144 IRQ_TYPE_LEVEL_HIGH>,
>                       <146 IRQ_TYPE_LEVEL_HIGH>,
>                       <145 IRQ_TYPE_LEVEL_HIGH>;
> -        clocks = <&clkc SPI_COMBO_0>;
> -        resets = <&rstc RST_SPI_COMBO_0>;
> +        clocks = <&clkc 0x32>;
> +        resets = <&rstc 0x22>;
>          pinctrl-names = "default";
>          pinctrl-0 = <&pins_spi0>;
>      };


Best regards,
Krzysztof
