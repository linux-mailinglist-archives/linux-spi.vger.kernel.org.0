Return-Path: <linux-spi+bounces-5804-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1089D68AF
	for <lists+linux-spi@lfdr.de>; Sat, 23 Nov 2024 12:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47154281D18
	for <lists+linux-spi@lfdr.de>; Sat, 23 Nov 2024 11:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE904188907;
	Sat, 23 Nov 2024 11:04:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803DC37171;
	Sat, 23 Nov 2024 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732359888; cv=none; b=REsVd0tN8ipnSgdr4G/SxsMtbPQFyPYI2wsthZaSWzDVahrMdEDA8ZPeI7ephRjwCOnLSlRfinMA9p1QjzjGH72TD6uQz5UtAy69FuJbhQ31qf+Ptewe5m0AqmvaMwFtsMZApZGvrBlbxN0l/2Od1wV49tDO5BzsH6QA7TdA76g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732359888; c=relaxed/simple;
	bh=6g2lUM70jNivzuxuoC2WEihURosHXc9laXkjI5Lfb1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcQ6FPwGlxNlVKU12qWTP6eibwt/dWfesQhznOGC30Kxq3SAYzdwm8X4Vl4PcbaHNGkhx82DI+MX4wB/yNKNqutUVFfX4exPdEUOjiZWc+dJRWY/u5FwrMJyNPoh0ol8+bGbWPZthI2yflW/LEWnkAvR+hBaAE7xFuOqr/Ji4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1tEnw5-0005uq-00; Sat, 23 Nov 2024 12:04:21 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 98377C014F; Sat, 23 Nov 2024 12:03:49 +0100 (CET)
Date: Sat, 23 Nov 2024 12:03:49 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, markus.stockhausen@gmx.de,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v5 2/3] mips: dts: realtek: Add SPI NAND controller
Message-ID: <Z0G2lYGXHKwXpuWB@alpha.franken.de>
References: <20241015225434.3970360-1-chris.packham@alliedtelesis.co.nz>
 <20241015225434.3970360-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015225434.3970360-3-chris.packham@alliedtelesis.co.nz>

On Wed, Oct 16, 2024 at 11:54:33AM +1300, Chris Packham wrote:
> Add the SPI-NAND controller on the RTL9300 family of devices. This
> supports serial/dual/quad data width and DMA for read/program
> operations.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v4 & v5:
>     - none
>     Changes in v3:
>     - drop wildcard rtl9300-snand compatible
>     - drop clock-names
>     Changes in v2:
>     - Add clocks
> 
>  arch/mips/boot/dts/realtek/rtl930x.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/realtek/rtl930x.dtsi b/arch/mips/boot/dts/realtek/rtl930x.dtsi
> index f271940f82be..b01a40ec3064 100644
> --- a/arch/mips/boot/dts/realtek/rtl930x.dtsi
> +++ b/arch/mips/boot/dts/realtek/rtl930x.dtsi
> @@ -32,6 +32,8 @@ lx_clk: clock-175mhz {
>  };
>  
>  &soc {
> +	ranges = <0x0 0x18000000 0x20000>;
> +
>  	intc: interrupt-controller@3000 {
>  		compatible = "realtek,rtl9300-intc", "realtek,rtl-intc";
>  		reg = <0x3000 0x18>, <0x3018 0x18>;
> @@ -59,6 +61,17 @@ timer0: timer@3200 {
>  		interrupts = <7>, <8>, <9>, <10>, <11>;
>  		clocks = <&lx_clk>;
>  	};
> +
> +	snand: spi@1a400 {
> +		compatible = "realtek,rtl9301-snand";
> +		reg = <0x1a400 0x44>;
> +		interrupt-parent = <&intc>;
> +		interrupts = <19>;
> +		clocks = <&lx_clk>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
>  };
>  
>  &uart0 {
> -- 
> 2.47.0

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

