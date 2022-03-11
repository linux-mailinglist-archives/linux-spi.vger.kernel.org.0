Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419994D581F
	for <lists+linux-spi@lfdr.de>; Fri, 11 Mar 2022 03:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbiCKC0u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Mar 2022 21:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241175AbiCKC0t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Mar 2022 21:26:49 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E956E1986E1
        for <linux-spi@vger.kernel.org>; Thu, 10 Mar 2022 18:25:47 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7BEF35C01DC;
        Thu, 10 Mar 2022 21:19:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 10 Mar 2022 21:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=PGmWpq5SKEqgCq
        3RYGxHSRrzwwQ4Gsnl5MGvptadrxY=; b=AoBHra5Jtab68vFoOq6JwU9EQ1eBEu
        +WKhJAwsOrXPMkCOsWrr7tdZchzX1Jf5cWbludzBtvTAMqBTYw1gaYwAOoIpH5Wz
        2qbrzdywzVYxdhMW4j5cpmvssaE50RPQFHDW+dFLr3r0FQAtA4/CFu55NroxPQV/
        3p6QSpBeerZIwO4Ri3ruuJ2Lxwa6SkduO7CbupH/BgsheMP7fKvF/+2cziNuKKD6
        GmjDs2T8zEpbqELzJ/7BX7Xjy2v34Otm1dVB1DEM2qsLd07Anb+ZdnFblPaOdVHr
        Z7ANDmgjv2+TmNpksY4NsLdsVGVk0Jepv3uP3M//CB1TZI1c76NEFb/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=PGmWpq5SKEqgCq3RYGxHSRrzwwQ4Gsnl5MGvptadr
        xY=; b=U4PsUm4KdpcWExVMjHDK17b69Tv4j+d9w5Zh4pvzcbeOLmiVB8OubyujG
        Y5tFHyWzHCcBpU8fFss90TUbb8+qxcjvml3/ka1+FOOqscyNUj5Zn1UmvEf3ot1H
        Fp/iu/f8SKm2nleFu20jMz775l0oeGUA5f2Tf4RcsBBq391YdehhwCnpQ7j+AJWC
        TtwbLwfG/8wiitcEYygxVpoh8piEkbYCPEyj81htohyx1NK3jmhZr7H5BV8Rvtmx
        epkwpSh1I0jBPmOCaYV6cgtIdF/mC+iG29cGWpNkM69Cm9POLKuJ+9SADgkzCM5L
        O1soi8ubYCs2zpIVFfjOZpRh0noJA==
X-ME-Sender: <xms:z7EqYlgoc2iZTT2NId0fsLv41dCidKY1wAU7Te0Jq6bdW_6VsbJwxQ>
    <xme:z7EqYqBZXbiBwaBO3AyIDp97JLu6g4OJDcWfJu86f1Sa0vQ015wOLZkeyID0BucRs
    2ytKicPvvtWCoXJXw>
X-ME-Received: <xmr:z7EqYlFBJbVkrxIJZLNC5uZMxhLdQnKo6_YKOKpbqg4v-QoHD5Iga4B87O9G_ofE-b0TD-obEE2Pwu-trVze2MLj1VLMsKu5WUDMUA0JowNgGDi7FUarF_5CZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvuddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:z7EqYqQBG1Ps9Z0Hfc8QAVIQ3XsMd77bXp7CSbmd9GZKIUIQ3aC9CQ>
    <xmx:z7EqYizPbJ29r_AzGe-fonk-y_ZB2sRhZ-j5ehhfvbqUmYQHMkR-SA>
    <xmx:z7EqYg5a7G6-FmY6Ecj6WL71CcwZXJ0lBNkaAQOYhLAF6F4_Vj9Phg>
    <xmx:z7EqYmj4faBw7ym3G6OaktQsccqm5an6C0hbjH7OpxuCHaBXfHEo7Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Mar 2022 21:19:58 -0500 (EST)
Subject: Re: [PATCH 11/14] ARM: dts: suniv: F1C100: add SPI support
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        George Hilliard <thirtythreeforty@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
References: <20220307143421.1106209-1-andre.przywara@arm.com>
 <20220307143421.1106209-12-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <15ed4319-9645-089c-9977-94dfd2fd79c5@sholland.org>
Date:   Thu, 10 Mar 2022 20:19:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220307143421.1106209-12-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 3/7/22 8:34 AM, Andre Przywara wrote:
> The F1C100 series contains two SPI controllers, and many boards use SPI0
> for a SPI flash, as the BROM is able to boot from that.
> 
> Describe the two controllers in the SoC .dtsi, and also add the PortC
> pins for SPI0, since this is where BROM looks at when trying to boot
> from the commonly used SPI flash.
> 
> The SPI controller seems to be the same as in the H3 chips, but it lacks
> a separate mod clock. The manual says it's connected to AHB directly.
> We don't export that AHB clock directly, but can use the AHB *gate* clock
> as a clock source, since the MMC driver is not supposed to change the AHB

Do you mean the SPI driver here?

> frequency anyway.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/boot/dts/suniv-f1c100s.dtsi | 33 ++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> index 6f2f97458fe0..f8ec1c7a2ca9 100644
> --- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
> +++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> @@ -105,6 +105,34 @@ mmc1: mmc@1c10000 {
>  			#size-cells = <0>;
>  		};
>  
> +		spi0: spi@1c05000 {
> +			compatible = "allwinner,suniv-f1c100s-spi",
> +				     "allwinner,sun8i-h3-spi";
> +			reg = <0x01c05000 0x1000>;
> +			interrupts = <10>;
> +			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_BUS_SPI0>;
> +			clock-names = "ahb", "mod";
> +			resets = <&ccu RST_BUS_SPI0>;
> +			status = "disabled";
> +			num-cs = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		spi1: spi@1c06000 {
> +			compatible = "allwinner,suniv-f1c100s-spi",
> +				     "allwinner,sun8i-h3-spi";
> +			reg = <0x01c06000 0x1000>;
> +			interrupts = <11>;
> +			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_BUS_SPI1>;
> +			clock-names = "ahb", "mod";
> +			resets = <&ccu RST_BUS_SPI1>;
> +			status = "disabled";
> +			num-cs = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +

Please keep the nodes sorted by address. These should come before the MMC
controllers.

>  		ccu: clock@1c20000 {
>  			compatible = "allwinner,suniv-f1c100s-ccu";
>  			reg = <0x01c20000 0x400>;
> @@ -138,6 +166,11 @@ mmc0_pins: mmc0-pins {
>  				drive-strength = <30>;
>  			};
>  
> +			spi0_pc_pins: spi0-pc-pins {
> +				pins = "PC0", "PC1", "PC2", "PC3";
> +				function = "spi0";
> +			};
> +
>  			uart0_pe_pins: uart0-pe-pins {
>  				pins = "PE0", "PE1";
>  				function = "uart0";
> 

