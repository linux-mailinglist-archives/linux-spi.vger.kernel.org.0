Return-Path: <linux-spi+bounces-10227-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C37B93ACC
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 02:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450FA4424E8
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 00:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722223A1B5;
	Tue, 23 Sep 2025 00:19:37 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC11D554;
	Tue, 23 Sep 2025 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758586777; cv=none; b=KXaWv3JA6UWnlFYoyTXi8DGoXnlaApo1pzPCKdumzJkwB7sgGzBqsx4TKRxv9p179opBQYcAZ86gxqEJbS82fLQRZD25y8XzCvnWqBtPmKmMAaWqduonh2hvP5hvy8obWEi+Ov3aayldhXMnDPY7cndQ8fdTyCej+WZBH+gupaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758586777; c=relaxed/simple;
	bh=m3PbYU+2V1fFSBAd5hXu+XYNk9LQPcAQq5Ha2JxlPGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+t1R9KnT0qgq1CASkFfOTbzpSkxHdAG8TJv7pFbHTWaB3V9CTQEsh9hyjS7fbum5BChJXCnvhr9kxvSNnTJdOQYSvx0nyvvtwyQimLG10Cl3k0pK9bqAUj+OdU2NYOSGlertiR+Xl05P4JKphSzfEo6AsHB+LSKvSXzJzPt55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id BE58B340F71;
	Tue, 23 Sep 2025 00:19:34 +0000 (UTC)
Date: Tue, 23 Sep 2025 08:19:30 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] riscv: dts: spacemit: define a SPI controller node
Message-ID: <20250923001930-GYB1303776@gentoo.org>
References: <20250922161717.1590690-1-elder@riscstar.com>
 <20250922161717.1590690-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922161717.1590690-4-elder@riscstar.com>

Hi Alex,

On 11:17 Mon 22 Sep     , Alex Elder wrote:
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
> v3: - Moved the SPI controller into the dma-bus memory region
> 
>  .../boot/dts/spacemit/k1-bananapi-f3.dts      |  7 +++++++
>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 20 +++++++++++++++++++
>  arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 +++++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> index 2aaaff77831e1..d9d865fbe320e 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -14,6 +14,7 @@ aliases {
>  		ethernet0 = &eth0;
>  		ethernet1 = &eth1;
>  		serial0 = &uart0;
> +		spi3 = &spi3;
>  	};
>  
>  	chosen {
> @@ -92,6 +93,12 @@ &pdma {
>  	status = "okay";
>  };
>  
> +&spi3 {
> +	pinctrl-0 = <&ssp3_0_cfg>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_2_cfg>;
> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> index aff19c86d5ff3..205c201a3005c 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> @@ -76,4 +76,24 @@ pwm14-1-pins {
>  			drive-strength = <32>;
>  		};
>  	};
> +
> +	ssp3_0_cfg: ssp3-0-cfg {
..
> +		ssp3-0-no-pull-pins {
I'd prefer not to enforce "pull" info inside the name, you can't embed
all property info, besides, what's if you want to change/override later?

how about just name it as ssp3-0-defaul-pins or simply ssp3-0-pins?

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
> index 6cdcd80a7c83b..eb8a14dd72ea4 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -797,6 +797,22 @@ uart9: serial@d4017800 {
>  				status = "disabled";
>  			};
>  
> +			spi3: spi@d401c000 {
> +				compatible = "spacemit,k1-spi";
> +				reg = <0x0 0xd401c000 0x0 0x30>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&syscon_apbc CLK_SSP3>,
> +					 <&syscon_apbc CLK_SSP3_BUS>;
> +				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_SSP3>;
> +				interrupts = <55>;
..
> +				dmas = <&pdma 20>,
> +				       <&pdma 19>;
can we also squash the dmas into one line? but, do split if there are too many..

yes, it's simply a style change that I'd like to keep them consistent at DT level,
besides you might also want to adjust dt-binding examples to align with them here..

thanks

> +				dma-names = "rx", "tx";
> +				status = "disabled";
> +			};
> +
>  			/* sec_uart1: 0xf0612000, not available from Linux */
>  		};
>  
> -- 
> 2.48.1
> 
> 

-- 
Yixun Lan (dlan)

