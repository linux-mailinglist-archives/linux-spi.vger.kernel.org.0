Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E956A6078CB
	for <lists+linux-spi@lfdr.de>; Fri, 21 Oct 2022 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiJUNoY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Oct 2022 09:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiJUNoW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Oct 2022 09:44:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AFDB84
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 06:44:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a10so4415407wrm.12
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZpaxMvmEuJPF3OgoDpXULb0R5XqV+uhtln4+RAmmd8=;
        b=HOny0ruFI9g5TTzJ5ZH5qvGL6+UqA9BmO6SUTjvo8lyGP84OduwmM3imoX5TfLfQpX
         ErIPWwPwtiBgh5+cGpZS4bF5gzGh7q4mp3WyPs05jgxYtWDaNdoTT/2RJl3Ma7kZkKeS
         NURZRhHE7c0nbQqwVRSImTCopAdiYUQdWHovO/cJNQtOmeviI63EKOhJFOiZz4XPq8hT
         L5tlfCsV4MNt4gIcoW+NcpqdQMjlmMK/cDQ2SgL+L4FmTvmOtkw9MoR5doYjmgnTSB7W
         l+mBUrZgtjW38JdnhIB4wA/uCMpvxiW68VCkV/I/cmccE3nItp3GMRryTteLFGrfPvP1
         yt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZpaxMvmEuJPF3OgoDpXULb0R5XqV+uhtln4+RAmmd8=;
        b=pQBtKOg/5TNW9N8DinEwlV7vgWqzcDDYNPtRMFRDMyxXlb7iZGlXkWVdglcpy4MXZL
         /x6JKfQjAVqXRd/FGvjYqpJDHk74RwSwYYa3cM3wrC1tN+Z8YPlXQN/RE3HcL1a6AeXi
         zLaansaDT9WxbxKDUyFMahghA+cGy6ZF50tdBE8Qu/7xaVS01mGQoskebd2V96eYhcjD
         TQyLbUWIHTyHWPT7zjke2TPXvkPusjWp1OGl/fA5uu1yd0s04LOD4OKF5imKVWPhfuGx
         o3XzLAKE75W2ByxDZQVRaG+m+YW6vEQh/dwcrtH5IEgQijkrrq8r/CeQlBxPHcIbxDaw
         r8IA==
X-Gm-Message-State: ACrzQf2//9j03iSsCk7mYJdPG/X1tXma2akfnCXNOM8uvdqUjplX/kkx
        vTK781Wek9EeMK1gIWK/veAzNA==
X-Google-Smtp-Source: AMsMyM4nd+8JiG4Qbt3OaJ5WL7VTFhfdy3U2bhmHB12MxhIYrGqcodjTvuokWPVyjHYedie2uggWdQ==
X-Received: by 2002:a5d:584a:0:b0:231:636c:de28 with SMTP id i10-20020a5d584a000000b00231636cde28mr12412891wrf.175.1666359857728;
        Fri, 21 Oct 2022 06:44:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8104:adb4:5d77:2050? ([2a01:e0a:982:cbb0:8104:adb4:5d77:2050])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a9246c853sm19016553wrt.41.2022.10.21.06.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 06:44:17 -0700 (PDT)
Message-ID: <3bc7dfc1-3e26-926f-f55e-bc9e6531e04b@linaro.org>
Date:   Fri, 21 Oct 2022 15:44:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 4/4] arm64: dts: meson-gxbb: add SPI pinctrl nodes for
 CLK
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, Da Xue <da@libre.computer>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com>
 <20221004-up-aml-fix-spi-v4-4-0342d8e10c49@baylibre.com>
Organization: Linaro Developer Services
In-Reply-To: <20221004-up-aml-fix-spi-v4-4-0342d8e10c49@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 21/10/2022 15:31, Amjad Ouled-Ameur wrote:
> Add SPICC Controller pin nodes for CLK line when idle for Amlogic GXBB
> SoCs.
> 
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 7c029f552a23..923d2d8bbb9c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -427,6 +427,20 @@ mux {
>   			};
>   		};
>   
> +		spi_idle_high_pins: spi-idle-high-pins {
> +			mux {
> +				groups = "spi_sclk";
> +				bias-pull-up;
> +			};
> +		};
> +
> +		spi_idle_low_pins: spi-idle-low-pins {
> +			mux {
> +				groups = "spi_sclk";
> +				bias-pull-down;
> +			};
> +		};
> +
>   		spi_ss0_pins: spi-ss0 {
>   			mux {
>   				groups = "spi_ss0";
> 


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
