Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876CD7DD47B
	for <lists+linux-spi@lfdr.de>; Tue, 31 Oct 2023 18:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343574AbjJaRRL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 31 Oct 2023 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjJaRRK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 31 Oct 2023 13:17:10 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469D291
        for <linux-spi@vger.kernel.org>; Tue, 31 Oct 2023 10:17:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40839807e82so280205e9.0
        for <linux-spi@vger.kernel.org>; Tue, 31 Oct 2023 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698772626; x=1699377426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1FS6T6JcOn8zGVyFOJ/mVRDweHgiixRXGwY1HImzFA=;
        b=amC79fPX8D7Gff3dErjKYo6FaFxx81M0Xd0l/HJ2vW7HlKmJ6tZSm0vtiPrzQg2pv7
         QomJVKDIoQfzPCKfI5wCGkk7QJVIfzZ/TIx3R6znAyh70stzk6Kfh4Q61LqMt2xtUf8P
         EHkRGETS8kV6AKIv5lg2Hlp4eSTTXWiKOapA5KLMUB3vNEQSXz8f+049aNp26w/w1Oat
         Le7BlFxtABFazk4k/GZLYh53+E5uVzInaZE8wd/q+Z04cGJxmoawgnkmeTXMvF83XQT/
         /Uw8kj3j9Rt/tNxKpf02eKy6Ryg4RSL6IteJGcVQ54PdAboF7wNqANq+bYWPwfAaZYVI
         H0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772626; x=1699377426;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1FS6T6JcOn8zGVyFOJ/mVRDweHgiixRXGwY1HImzFA=;
        b=w7OpSyo0fF3NGFU5IfFAgE7WVcrxZDPmUPhO8lXHpSCuWspmDHAJhoAGKgU0OIHuPs
         QHeYx2VhV0cGu00LTBjRkYtWE1LvaeBYHc6IuuTMWwknALJ94p4sITLhXuQCI+3lZbQ8
         zlgUzHMwTN5XE4JhsDrZiv9xWRGaDApE6xx8yokT+V4YHg899NrINx717dBrp0yUoqEh
         v0jx24HRR+FPN37/DKRBc1Yaay1JAmZ7SXyyvyKg/K2I0dMWNp8mIqoksxO8gXX1E14x
         BzRM9Cdr3REc+231q2UJx4whsqk6uhr1b/L+Y6AmTbni54MkgCNIlL8HUKYkyncIiPmb
         1fzw==
X-Gm-Message-State: AOJu0YyD0EAsYnb4j24YQ+QMMcqPuzoPOPN/sICJtd4pgLM5398bwJEy
        voJ/KNZ7Y/1U8O7P9BtwAf3FZg==
X-Google-Smtp-Source: AGHT+IF/bWL98PTDWUCakM20W/GD3Sh4u8HG0zteoaBtvt3R3loTGpifO7TwcA4W2Tiz6MzOo8v42g==
X-Received: by 2002:a05:600c:3b96:b0:405:409e:1fcb with SMTP id n22-20020a05600c3b9600b00405409e1fcbmr3933421wms.5.1698772625688;
        Tue, 31 Oct 2023 10:17:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d49c3000000b0032dc2110d01sm1940289wrs.61.2023.10.31.10.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 10:17:04 -0700 (PDT)
Message-ID: <43fec656-8fda-49ad-a117-1ada0c2b7a79@linaro.org>
Date:   Tue, 31 Oct 2023 18:17:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] arm64: dts: qcom: ipq9574: Add support for SPI
 nand
Content-Language: en-US
To:     Md Sadre Alam <quic_mdalam@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        quic_srichara@quicinc.com, qpic_varada@quicinc.com
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
 <20231031120307.1600689-6-quic_mdalam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231031120307.1600689-6-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 31/10/2023 13:03, Md Sadre Alam wrote:
> Add support for QPIC SPI NAND for IPQ9574
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 56 ++++++++++-----------
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 30 ++++++++++-
>  2 files changed, 57 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> index 1bb8d96c9a82..5e4200edb873 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> @@ -15,48 +15,48 @@ / {
>  	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
>  };
>  
> -&sdhc_1 {
> -	pinctrl-0 = <&sdc_default_state>;
> -	pinctrl-names = "default";
> -	mmc-ddr-1_8v;
> -	mmc-hs200-1_8v;
> -	mmc-hs400-1_8v;
> -	mmc-hs400-enhanced-strobe;
> -	max-frequency = <384000000>;
> -	bus-width = <8>;
> -	status = "okay";

Why? This is not explained in commit msg.

> -};
> -
>  &tlmm {
> -	sdc_default_state: sdc-default-state {
> -		clk-pins {
> +	qspi_nand_pins: qspi_nand_pins {
> +		spi_clock {
>  			pins = "gpio5";
> -			function = "sdc_clk";
> +			function = "qspi_clk";

Why?

>  			drive-strength = <8>;
>  			bias-disable;
>  		};
>  
> -		cmd-pins {
> +		qspi_cs {

No, come one. Code was good and you replace it to incorrect one. Please
stop bringing more issues to fix.

>  			pins = "gpio4";
> -			function = "sdc_cmd";
> +			function = "qspi_cs";
>  			drive-strength = <8>;
>  			bias-pull-up;
>  		};
>  

...

> +
>  		bch: qpic_ecc {
>  			compatible = "qcom,ipq9574-ecc";
>  			status = "ok";
> -		}
> +		};

This is the saddest part of the entire patchset...

>  
>  		blsp_dma: dma-controller@7884000 {
>  			compatible = "qcom,bam-v1.7.0";

Best regards,
Krzysztof

