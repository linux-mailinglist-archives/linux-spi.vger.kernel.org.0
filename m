Return-Path: <linux-spi+bounces-10117-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4E0B84D99
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 15:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CD13B5D1A
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8547308F33;
	Thu, 18 Sep 2025 13:32:25 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B742306D58;
	Thu, 18 Sep 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202345; cv=none; b=Uh1AO0pjVg4Nrc0zUFU7PaQ61CLN4npLjs6GV7X1FWCf/ivXtCw1cjtnWPOeZiOENGuWeBvty7wsbPd5mCHpUfzrrb+y+AwtPRSj0LbNEMPn8nm4g7EwvhikSYetaUY518KRJwi1lnhMU9jnBXCSQkexzbxMQDU1YqXS93Cpqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202345; c=relaxed/simple;
	bh=/Efvng1++KUoJ3QNb+mWNdxT0oifsZx/t2oDLWmjtYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzwFfORw9AMXl6iPXeXepaz6A2koKI47K63IljV4PikQlh0b6pMeM4FLgUoAWzdYpqrL7Ey36fhK26NPi4T0mjaYRFxVSfO6CBZmDktV7Y+7+bOBAG1ZNkuDsjtkn6e8b09tNSd1mvZF74dIXUE28FbjexcG48VAS03JGhzPuIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 30205341F29;
	Thu, 18 Sep 2025 13:32:22 +0000 (UTC)
Date: Thu, 18 Sep 2025 21:32:09 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv: dts: spacemit: define a SPI controller node
Message-ID: <20250918133209-GYB1273705@gentoo.org>
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917220724.288127-4-elder@riscstar.com>

Hi Alex,

On 17:07 Wed 17 Sep     , Alex Elder wrote:
> Define a node for the fourth SoC SPI controller (number 3) on
> the SpacemiT K1 SoC.
> 
> Enable it on the Banana Pi BPI-F3 board, which exposes this feature
> via its GPIO block:
>   GPIO PIN 19:  MOSI
>   GPIO PIN 21:  MISO
>   GPIO PIN 23:  SCLK
>   GPIO PIN 24:  SS (inverted)
> 
> Define pincontrol configurations for the pins as used on that board.
> 
> (This was tested using a GigaDevice GD25Q64E SPI NOR chip.)
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++++++
>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 20 +++++++++++++++++++
>  arch/riscv/boot/dts/spacemit/k1.dtsi          | 19 ++++++++++++++++++
>  3 files changed, 45 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> index 6013be2585428..380d475d2f3f3 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -44,6 +44,12 @@ &pdma {
>  	status = "okay";
>  };
>  
> +&spi3 {
..
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ssp3_0_cfg>;
Can you swap the order of these two pinctrl properties?
Yes, we currently have some inconsistency in tree, I plan to fix during next cycle

> +	status = "okay";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_2_cfg>;
> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> index 3810557374228..16c953eca2aaa 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> @@ -28,4 +28,24 @@ pwm14-1-pins {
>  			drive-strength = <32>;
>  		};
>  	};
> +
> +	ssp3_0_cfg: ssp3-0-cfg {
> +		ssp3-0-no-pull-pins {
> +			pinmux = <K1_PADCONF(75, 2)>,	/* SCLK */
> +				 <K1_PADCONF(77, 2)>,	/* MOSI  */
> +				 <K1_PADCONF(78, 2)>;	/* MISO */
> +
> +			bias-disable;
> +			drive-strength = <19>;
> +			power-source = <3300>;
> +		};
> +
> +		ssp3-0-frm-pins {
> +			pinmux = <K1_PADCONF(76, 2)>;	/* FRM (frame) */
> +
> +			bias-pull-up = <0>;
> +			drive-strength = <19>;
> +			power-source = <3300>;
> +		};
> +	};
>  };
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index 66b33a9110ccd..a826cc1ac83d5 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -834,6 +834,25 @@ storage-bus {
>  			#size-cells = <2>;
>  			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
>  
> +			spi3: spi@d401c000 {
> +				compatible = "spacemit,k1-spi";
> +				reg = <0x0 0xd401c000 0x0 0x30>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&syscon_apbc CLK_SSP3>,
> +					 <&syscon_apbc CLK_SSP3_BUS>;
..
> +				clock-names = "core",
> +					      "bus";
can you simply put them together in one line? it's kind of tedious to split..
> +				resets = <&syscon_apbc RESET_SSP3>;
> +				interrupts-extended = <&plic 55>;
why use interrupts-extended?
> +				spacemit,k1-ssp-id = <3>;
> +				dmas = <&pdma 20>,
> +				       <&pdma 19>;
.. em, so the SPI will use pdma, then probably you should also adjust Kconfig to
select PDMA driver?

> +				dma-names = "rx",
> +					    "tx";
> +				status = "disabled";
> +			};
> +
>  			emmc: mmc@d4281000 {
>  				compatible = "spacemit,k1-sdhci";
>  				reg = <0x0 0xd4281000 0x0 0x200>;
> -- 
> 2.48.1
> 
> 

-- 
Yixun Lan (dlan)

