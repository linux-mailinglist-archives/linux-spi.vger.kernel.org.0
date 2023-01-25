Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E3867AAF9
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jan 2023 08:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjAYHg3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Jan 2023 02:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjAYHg1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Jan 2023 02:36:27 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52ED4903A
        for <linux-spi@vger.kernel.org>; Tue, 24 Jan 2023 23:36:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so1995921wmq.1
        for <linux-spi@vger.kernel.org>; Tue, 24 Jan 2023 23:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEwkXXMdiVTNxB9QHTTk/uZ3SKJjCOZaopngUP+uBrI=;
        b=v1u2VccfeUn9zChfgH/umi4BFdIoP97KAMdrX+yQy3iVsNYuEVGUFhegICKBBhLy7o
         l6LmhNbljgJCx9m6sgzlTaQ2N2YlVRQ+wzEC/nc7JC5qAMVho3G6gXYEQTJjyt15qU2R
         maUGnFWlmnPBO1rrTDPZviagGhAtt5uoixXCyoiW9PXkxd7SSR+wWjbHtPe5EC1oLvF1
         qGLfWTDQlhrd7uQixN2FCiI9gEyMFXPKkxrl7XpCFer3TveOj6u/v8vo4Z/FPLRmFkQa
         DaFw5GIsAxPbWqWkJKenBBNS2A3tdFf08j/rKrXSnzBJ0JfCwJYkuZAfC2mWWiODoo5J
         eNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEwkXXMdiVTNxB9QHTTk/uZ3SKJjCOZaopngUP+uBrI=;
        b=4++2PlAJAUTxAGOcOOUg8naXfSS6JArCeSI4ZKvbKn2Ggm0vZKrduPqlHGGV1X1FdA
         Wkp7C304GBo2G4uW/EjYfig6miqWKrL+u93s70pu/5ziympThD1iBokGV3wxDdd8+rET
         8I75j7CQSOkiEZnGraMeULvM0GlbJVYEhBOLvBta6DS7tRc5/yJZQdLXcnbszdRLeU3c
         BBnhcUtgvasTlOvTbl/ibkLZtNtiLptp1/nfPU9YT+ktmgvoU62oGNXBu+yGChOGx9Jm
         r1mWuE6kyCYPvHGAodlF3dG6U2dfZFFGOu4t6nvIaYJ8ez8uNycB8++CAq8v29ybmGJZ
         LrgA==
X-Gm-Message-State: AFqh2kr6ZqeyUZ+Y0/z+vcot/mHZM5Pq/OCzjvJoAtB4+3rys67vUBMN
        eBqL3qUuVExwXujWMU9bwWQ3tQ==
X-Google-Smtp-Source: AMrXdXv3+hxzaNFShXPJlwyC5LtwBTaM734bhEHkRBJdoLdyVNtwHEC6u2LFkuqVytq19dz0LN1rog==
X-Received: by 2002:a05:600c:5386:b0:3da:f670:a199 with SMTP id hg6-20020a05600c538600b003daf670a199mr30370353wmb.36.1674632184313;
        Tue, 24 Jan 2023 23:36:24 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c430a00b003dc0d5b4f75sm920940wme.43.2023.01.24.23.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 23:36:23 -0800 (PST)
Message-ID: <5b4bf72e-37e5-0840-cacb-df3873c3a5c9@linaro.org>
Date:   Wed, 25 Jan 2023 08:36:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 03/14] ARM: dts: broadcom: bcmbca: Add spi controller
 node
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230124221218.341511-1-william.zhang@broadcom.com>
 <20230124221218.341511-4-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124221218.341511-4-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 24/01/2023 23:12, William Zhang wrote:
> Add support for HSSPI controller in ARMv7 chip dts files.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---
> 
> Changes in v2:
> - Update compatible string with SoC model number, controller version
>   info and bcmbca fall back name
> - Add interrupt property
> 
>  arch/arm/boot/dts/bcm47622.dtsi    | 19 +++++++++++++++++++
>  arch/arm/boot/dts/bcm63138.dtsi    | 19 +++++++++++++++++++
>  arch/arm/boot/dts/bcm63148.dtsi    | 19 +++++++++++++++++++
>  arch/arm/boot/dts/bcm63178.dtsi    | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/bcm6756.dtsi     | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/bcm6846.dtsi     | 19 +++++++++++++++++++
>  arch/arm/boot/dts/bcm6855.dtsi     | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/bcm6878.dtsi     | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/bcm947622.dts    |  4 ++++
>  arch/arm/boot/dts/bcm963138.dts    |  4 ++++
>  arch/arm/boot/dts/bcm963138dvt.dts |  4 ++++
>  arch/arm/boot/dts/bcm963148.dts    |  4 ++++
>  arch/arm/boot/dts/bcm963178.dts    |  4 ++++
>  arch/arm/boot/dts/bcm96756.dts     |  4 ++++
>  arch/arm/boot/dts/bcm96846.dts     |  4 ++++
>  arch/arm/boot/dts/bcm96855.dts     |  4 ++++
>  arch/arm/boot/dts/bcm96878.dts     |  4 ++++
>  17 files changed, 192 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm47622.dtsi b/arch/arm/boot/dts/bcm47622.dtsi
> index f4b2db9bc4ab..6de4a2287c90 100644
> --- a/arch/arm/boot/dts/bcm47622.dtsi
> +++ b/arch/arm/boot/dts/bcm47622.dtsi
> @@ -88,6 +88,12 @@ uart_clk: uart-clk {
>  			clock-div = <4>;
>  			clock-mult = <1>;
>  		};
> +
> +		hsspi_pll: hsspi-pll {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <200000000>;
> +		};
>  	};
>  
>  	psci {
> @@ -119,6 +125,19 @@ bus@ff800000 {
>  		#size-cells = <1>;
>  		ranges = <0 0xff800000 0x800000>;
>  
> +		hsspi: spi@1000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "brcm,bcm47622-hsspi", "brcm,bcmbca-hsspi-v1.0",
> +						 "brcm,bcmbca-hsspi";

Several of your lines are not properly indented/aligned.

Best regards,
Krzysztof

