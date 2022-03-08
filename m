Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88294D1233
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 09:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243749AbiCHI2t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 03:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiCHI2s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 03:28:48 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665176404
        for <linux-spi@vger.kernel.org>; Tue,  8 Mar 2022 00:27:52 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CF91E3F798
        for <linux-spi@vger.kernel.org>; Tue,  8 Mar 2022 08:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646728070;
        bh=pUg50sDh5ymtm+MSkxgXE+QGITtwAzozR40OUJkKG5c=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ofV3+7Ig3o/rtnHSn1WI/7WttcksPcfA/QoKk2p9IidMrDtHTkHeVM/A7kBCUni1y
         cDpMRLvAwSFGnBw5/k04zefrCqpzBMpWghtNC4DvdS78v04FIq57ZI7pohacBb6Rjt
         rkmLpptXF7a3gLJMFOKwl7F4vROQF/uInAjm+X231DSfb4dRjioyU6WdTuidz8IFyI
         z7RrO1JZQ5So0kNUhqOclT9OJt44370oHE8d1facb/F6YmrkOtsE847CTzW2LsNXfu
         Bw8Ly43qA42cT8zrD1FW+aZNE419OCIxy0oz+nV2FvxvSCLYUAakNQ7aB95lrhW3sx
         z7kQtrPgpxLBw==
Received: by mail-ej1-f69.google.com with SMTP id hr26-20020a1709073f9a00b006d6d1ee8cf8so8200946ejc.19
        for <linux-spi@vger.kernel.org>; Tue, 08 Mar 2022 00:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pUg50sDh5ymtm+MSkxgXE+QGITtwAzozR40OUJkKG5c=;
        b=HJIvX+UZcxlMVXpoBFe9x2GrXhbs4np4adSXs4dqhwMHGE8tKnKKxVVPdPAuXZjTp3
         s8PzsfMnX8///KPWoaFTbID913r2BMn0sZWN4cBzeaHEs/D8qHksypFJFK0H+uoA7cFM
         nqAC9Wwed6uNZ46ikdkUi2O5pDtEsZE1Zi4LPepXUBIzJzJD2sT7b/uLFDqwfivVjDhI
         QBZTRWji4fvqzgtYhfL2MI691rHT+ucSkoXr2eZrzPlJ7rJkU+WtE5OCQ2pjTfvfqVTe
         zF2+s7BpEsziAddWyVV3EtqDXvVfUwjm1RZ5xu0+cNna+JMbwQxqyc6JOk/lB3jnNHm4
         8I1g==
X-Gm-Message-State: AOAM531OTq+BDF+jZ7D8Dt1uUO1EesCz/cOWwwHmeclg8Y9Fukrl+iRu
        8L3YNoFTJbbSujF4ybNf5qO5YetZwxIWD9TkNH44+Y8gxBG0BrbOJtImVVNZrVgZ+Y9j0XfCDiu
        clWTWgcRfEixeN5LQOFEVkvQYmCGBuATqvJMSdw==
X-Received: by 2002:a05:6402:442:b0:416:14b7:4d55 with SMTP id p2-20020a056402044200b0041614b74d55mr14782477edw.183.1646728070137;
        Tue, 08 Mar 2022 00:27:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3BGB0pMI+5hioCDtbikJ78d+wt3/4IPLNlM66bRumaAAzOEXIcoZ09B602Plxia66ZsA77Q==
X-Received: by 2002:a05:6402:442:b0:416:14b7:4d55 with SMTP id p2-20020a056402044200b0041614b74d55mr14782463edw.183.1646728069971;
        Tue, 08 Mar 2022 00:27:49 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id g26-20020a50ee1a000000b0041631c5b1f3sm3572278eds.30.2022.03.08.00.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 00:27:49 -0800 (PST)
Message-ID: <f9fa1045-c0a4-97fa-16ee-20530b404381@canonical.com>
Date:   Tue, 8 Mar 2022 09:27:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Update clocks property for ARM
 pl022
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20220308072125.38381-1-singh.kuldeep87k@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220308072125.38381-1-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 08/03/2022 08:21, Kuldeep Singh wrote:
> Add missing minItems property to clocks in ARM pl022 bindings.
> 
> This helps in resolving below warnings:
> clocks: [[4]] is too short
> clock-names: ['apb_pclk'] is too short
> 
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
> v2:
> - Keep actual warning and remove path to file
> - Reword commit message a bit

It still misses information whether it is actually correct from PL022
point of view to have just one clock.

If the DTS are wrong, do not change the bindings to match such wrong
DTS. If the DTS is correct, please explain why bindings are wrong.

> 
>  Documentation/devicetree/bindings/spi/spi-pl022.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> index 6d633728fc2b..7d36e15db5b3 100644
> --- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> @@ -34,6 +34,7 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 1
>      maxItems: 2

This does not match clock-names which requires two clocks. It's not
correct now.

>  
>    clock-names:


Best regards,
Krzysztof
