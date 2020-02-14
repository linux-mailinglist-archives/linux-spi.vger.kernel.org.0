Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C5015D097
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2020 04:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgBNDgP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Feb 2020 22:36:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:49486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgBNDgP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 13 Feb 2020 22:36:15 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B013320661;
        Fri, 14 Feb 2020 03:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581651374;
        bh=FQq2eSsY4LMduKHB5Lrk+/8WyGuLFYrA6vIr5eefBcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qhOJijaNMbRRFaXbZQ4jSwTstmesoXm74LV3twO/zVG2G33fqiGGEjdey6ttv5Ot7
         WMAh1HQNKUOtgLpfcojpSHcgcJ0CaRuGXnc9W0wEpDpUicLBXhlTeLS98V2klIZFXv
         Qce17kAsJdh/ZVQvswKLS84bkApa+StnM6nq4VhU=
Date:   Fri, 14 Feb 2020 11:36:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 5/5] arm64: dts: enable fspi in imx8mm dts
Message-ID: <20200214033605.GP22842@dragon>
References: <20200202125950.1825013-1-aford173@gmail.com>
 <20200202125950.1825013-5-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200202125950.1825013-5-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Feb 02, 2020 at 06:59:50AM -0600, Adam Ford wrote:
> Pull in upstream patch from NXP repo to:
> enable fspi in imx8mm DT file
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2: Reorder s-o-b lines to give credit in proper order.
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 1e5e11592f7b..679769fe6cab 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -558,7 +558,21 @@ aips3: bus@30800000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			ranges = <0x30800000 0x30800000 0x400000>;
> +			ranges = <0x30800000 0x30800000 0x400000>,
> +				 <0x8000000 0x8000000 0x10000000>;
> +
> +			flexspi: spi@30bb0000 {

Keep the node sort in unit-address.

Shawn

> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "nxp,imx8mm-fspi";
> +				reg = <0x30bb0000 0x10000>, <0x8000000 0x10000000>;
> +				reg-names = "fspi_base", "fspi_mmap";
> +				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MM_CLK_QSPI_ROOT>,
> +					 <&clk IMX8MM_CLK_QSPI_ROOT>;
> +				clock-names = "fspi", "fspi_en";
> +				status = "disabled";
> +			};
>  
>  			ecspi1: spi@30820000 {
>  				compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
> -- 
> 2.24.0
> 
