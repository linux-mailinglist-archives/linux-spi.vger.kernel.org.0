Return-Path: <linux-spi+bounces-12059-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4E0CD2C57
	for <lists+linux-spi@lfdr.de>; Sat, 20 Dec 2025 10:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73D523009F15
	for <lists+linux-spi@lfdr.de>; Sat, 20 Dec 2025 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22B7302773;
	Sat, 20 Dec 2025 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgxVDZjl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D14A35;
	Sat, 20 Dec 2025 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766223411; cv=none; b=UdM+7qASXZaYr0tR/JbuqfrpT4kmmvyXIC48BeShYFi8P3y2zK3RgboSDv2wlwt8Rb6Sx4Hk8Y5tXABWxU+k05T1MJFfD5I08wgnPMxTnVNhe0JYK1XV/DxrDmKuERanIdZYeXF7nMG/1130v5sVhQIAL0T/JwdSzblaHWp1GkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766223411; c=relaxed/simple;
	bh=QOvv/T1GkTwBLvIOmgnWChvdwKFUOXir6r1DlwNXLPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g41jNuEAOeComvLkbyjp2TdiZkx2Gbaj5indtyVoPSEFSPYvNejiIEh8tzqQiSrTYHlVxLCVFoG0v9vS4XVirpiGHQtgsyEOu1SF0+JHqNCfo3jmOwvNg+o32uvEV8I0NLrcMZKFczrqGtLY25RLN3TT8EvvlFVJdNOLgM0wIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgxVDZjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AC0C4CEF5;
	Sat, 20 Dec 2025 09:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766223411;
	bh=QOvv/T1GkTwBLvIOmgnWChvdwKFUOXir6r1DlwNXLPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgxVDZjls3ACYi1NpRxei6Hp1UEsL6kyv095NGkULlZ0qMYXP0yY7g1//DlErYAw3
	 CjeumAuY2BTgqgMcHqfk6CZf5kUUJAl8jaRMIHODtn1CPd7wbXenlQ2fB0wdrREzBn
	 o2ZVD398rlzktvXU3lm1CxpbwHPhtkErt5kksIPcoRyHjaYGY8TVVONsQ9eBqLzonm
	 GvroYMCNz1TKYApMP97GynIWPOpgk3kESY6x2wCValbaJTBIuxPzJZqnAXBrhnssiu
	 e02xHwSRh2L+gXkThEHmAig+EKBHw6dqJEHSFh4gMZwuUXR+udFVDK1UF2R87XJamD
	 6ntnPjYWLP8cQ==
Date: Sat, 20 Dec 2025 10:36:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Vaishnav Achath <vaishnav.a@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 13/13] ARM: dts: r9a06g032: Describe the QSPI controller
Message-ID: <20251220-shapeless-mussel-of-temperance-2c4874@quoll>
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
 <20251219-schneider-6-19-rc1-qspi-v1-13-8ad505173e44@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251219-schneider-6-19-rc1-qspi-v1-13-8ad505173e44@bootlin.com>

On Fri, Dec 19, 2025 at 08:22:15PM +0100, Miquel Raynal (Schneider Electric) wrote:
> Add a node describing the QSPI controller.
> There are 2 clocks feeding this controller:
> - one for the reference clock
> - one that feeds both the ahb and the apb interfaces
> As the binding expect either the ref clock, or all three (ref, ahb and
> apb) clocks, it makes sense to provide the same clock twice.
> 
> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
> ---
>  arch/arm/boot/dts/renesas/r9a06g032.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/renesas/r9a06g032.dtsi b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
> index 8debb77803bb..a6f4670f5c45 100644
> --- a/arch/arm/boot/dts/renesas/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
> @@ -66,6 +66,20 @@ soc {
>  		#size-cells = <1>;
>  		ranges;
>  
> +		qspi0: spi@40005000 {
> +			compatible = "renesas,r9a06g032-qspi", "renesas,rzn1-qspi", "cdns,qspi-nor";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x40005000 0x1000>, <0x10000000 0x10000000>;

reg is always the second property.

> +			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sysctrl R9A06G032_CLK_QSPI0>, <&sysctrl R9A06G032_HCLK_QSPI0>,
> +				 <&sysctrl R9A06G032_HCLK_QSPI0>;
> +			clock-names = "ref", "ahb", "apb";
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0>;
> +			status = "disabled";
> +		};
> +
>  		rtc0: rtc@40006000 {
>  			compatible = "renesas,r9a06g032-rtc", "renesas,rzn1-rtc";
>  			reg = <0x40006000 0x1000>;

Even nodes around tend to agree...

Best regards,
Krzysztof


