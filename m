Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8C82F1DEF
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 19:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390237AbhAKSYN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 13:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390024AbhAKSYM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Jan 2021 13:24:12 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B08BC061795
        for <linux-spi@vger.kernel.org>; Mon, 11 Jan 2021 10:23:32 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id a109so632214otc.1
        for <linux-spi@vger.kernel.org>; Mon, 11 Jan 2021 10:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oHRRLRP3syrNXRgtXLe4zDZLAZUIXTDNntM1178Onx4=;
        b=Lp1keZgFL5eKc+p+U8+latPO0VrJ+THVD5+vETX/XbAZVYvwgTosayKSqfBl4lltLE
         prnwYmDyDqZjjpkZG8T/fbfotQ6/9AZe9de6vzX2LvnCC9Nv+KSQ2x/qNvGSxDLKSTdF
         amxHMiw4LqCC5QtpruCbAu3fVVPKQy91ziavo1befz2e23eqvTdKjqxycWNvOjrlUhcs
         Xt52rjVidw91lPqNouCwIpaozGhne9OrdiRIYZQYe2bbEi6E5nR2aU4mFIYzr32uRMcj
         RX10ysfFcmaxIWpq5Y+ZQjIklMACRFAa/bfh11s3Zf9e3cAaemVfkB5dWFn1RaHlh5O7
         8sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oHRRLRP3syrNXRgtXLe4zDZLAZUIXTDNntM1178Onx4=;
        b=V/t9E/fyc+YiX+iQN1M6u7EcxGns8AEYtzTBaAjVHFkWxjjnb6waui+W8mgI9ae7ux
         2JJE5Jcn3HV1OTZXCDIkNtreBam53cA6HQrvt0qcs6ArQKoNFt70DF6FHs4vqQufnw9T
         BlNV6SBn//wmlt/rSOn/prUtCYO1vvAyJKcQj8Myk1caNJJPWZIpOWLj1cbiFfTUpzZw
         dIwD39S9oC+bEbcPJvDjfepRXnsE4WiY9ZCpUtc3bwp/kIxJblJ7lhUVP9DYOGBaaI26
         WaksZeDn7VWIZyhd/WvMYLEChh04XLrqc7P4C4FiJoMKwDOIABQ77l0aeXMIFbI7SOsF
         x9tQ==
X-Gm-Message-State: AOAM5317UK+I8G5UszWsB8JgRrDNRlnIViTRKskOU0ByEdov/ZsfOpoe
        WkFgx9W6IMdQ/mUXVWp3rI/+FA==
X-Google-Smtp-Source: ABdhPJwSQkESyJB6Kz1cjy5okZasf3ZxNpivGY61xq/DZzbGSNQ/13Qf+v159Mg5XngNF2QuTl/ANg==
X-Received: by 2002:a9d:65d7:: with SMTP id z23mr309029oth.131.1610389411993;
        Mon, 11 Jan 2021 10:23:31 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f145sm58970oob.18.2021.01.11.10.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 10:23:31 -0800 (PST)
Date:   Mon, 11 Jan 2021 12:23:29 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sdm845: Add gpi dma node
Message-ID: <X/yXoY/3pqvvDpd6@builder.lan>
References: <20210111151651.1616813-1-vkoul@kernel.org>
 <20210111151651.1616813-7-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111151651.1616813-7-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon 11 Jan 09:16 CST 2021, Vinod Koul wrote:

> This add the device node for gpi dma0 instances found in sdm845.

I think the 0 in "dma0" should go?

Apart from that, this looks good.

> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 46 ++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index bcf888381f14..c9a127bbd606 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1114,6 +1114,29 @@ opp-128000000 {
>  			};
>  		};
>  
> +		gpi_dma0: dma-controller@800000 {
> +			#dma-cells = <3>;

Nit. I know #dma-cells are important to you ;) but I would prefer to
have the standard properties (e.g. compatible) first.

Regards,
Bjorn

> +			compatible = "qcom,sdm845-gpi-dma";
> +			reg = <0 0x00800000 0 0x60000>;
> +			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-channels = <13>;
> +			dma-channel-mask = <0xfa>;
> +			iommus = <&apps_smmu 0x0016 0x0>;
> +			status = "disabled";
> +		};
> +
>  		qupv3_id_0: geniqup@8c0000 {
>  			compatible = "qcom,geni-se-qup";
>  			reg = <0 0x008c0000 0 0x6000>;
> @@ -1533,6 +1556,29 @@ uart7: serial@89c000 {
>  			};
>  		};
>  
> +		gpi_dma1: dma-controller@0xa00000 {
> +			#dma-cells = <3>;
> +			compatible = "qcom,sdm845-gpi-dma";
> +			reg = <0 0x00a00000 0 0x60000>;
> +			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-channels = <13>;
> +			dma-channel-mask = <0xfa>;
> +			iommus = <&apps_smmu 0x06d6 0x0>;
> +			status = "disabled";
> +		};
> +
>  		qupv3_id_1: geniqup@ac0000 {
>  			compatible = "qcom,geni-se-qup";
>  			reg = <0 0x00ac0000 0 0x6000>;
> -- 
> 2.26.2
> 
