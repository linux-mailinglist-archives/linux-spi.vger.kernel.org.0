Return-Path: <linux-spi+bounces-3903-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB77D9374A7
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 10:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05D21F21B70
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 08:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF52946444;
	Fri, 19 Jul 2024 08:03:03 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF33D0C5;
	Fri, 19 Jul 2024 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376183; cv=none; b=d/8Xp7VH3pm54QDe+eK+isIk2755jFuxN0PEFuhQ/PCK9kl/U26OYOQJnG1IPXgT1NH0q8Hz7fFwdoMuqyY6xTTZFCunp/IEF7gCfmHRw6rmDLMHwAfd52/Yl+w53DTrV181y5IWDULZEDxyLsVZtidkTtcH39+M8lf24tVi6is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376183; c=relaxed/simple;
	bh=QXTuCc897EYVGldfKI0BBXVQfq0vccfFsgsmQrGa2Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRKHTSVvs1IfZjCeZEs2OvqCOV+ERrqySvj1D6mtPK+aInrJcg1DoPIuOM1KFuytlc7nE5LC9JnLAm+oxcu3dNv9OJmlV+/7+PVQCY3RoqmXah7n/93kdBlSAdtrP01cJNgELOZKqxeTGnLvj5uyyZNfu8J+08sgLOipWzweC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sUiZt-0005F8-V9; Fri, 19 Jul 2024 10:02:57 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: broonie@kernel.org, Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, otavio.salvador@ossystems.com.br,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject:
 Re: [PATCH 3/3] ARM: dts: rockchip: rv1108-elgin-r1: Do not describe
 unexisting DAC device
Date: Fri, 19 Jul 2024 10:02:56 +0200
Message-ID: <13142574.ZYm5mLc6kN@diego>
In-Reply-To: <20240718200540.955370-3-festevam@gmail.com>
References:
 <20240718200540.955370-1-festevam@gmail.com>
 <20240718200540.955370-3-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Fabio,

Am Donnerstag, 18. Juli 2024, 22:05:40 CEST schrieb Fabio Estevam:
> There is no DAC connected to the SPI bus of the Elgin RV1108 R1 board.
> 
> There is an LCD controlled via SPI though.
> 
> Properly describe it by adding the "elgin,spi-lcd" compatible
> string.
> 
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Closes: https://lore.kernel.org/linux-arm-kernel/20240717-parrot-malt-83cc04bf6b36@spud/
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Hi Heiko,
> 
> Conor sent a patch removing the rohm,dh2228fv entry from rv1108-elgin-r1.dts:
> 
> https://lore.kernel.org/linux-arm-kernel/20240717-parrot-malt-83cc04bf6b36@spud/
> 
> If you prefer, I can send a patch on top of his.

The decision is interesting, one less patch vs. keeping Conor's separate
patch history. Maybe Conor voices his opinion while we're still in the merge
window :-) .


Heiko
> Or you can apply this one instead.
> 
>  arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
> index 2d9994379eb2..971bb617e845 100644
> --- a/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
> +++ b/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dts
> @@ -168,8 +168,8 @@ &spi {
>  	pinctrl-0 = <&spim1_clk &spim1_cs0 &spim1_tx &spim1_rx>;
>  	status = "okay";
>  
> -	dh2228fv: dac@0 {
> -		compatible = "rohm,dh2228fv";
> +	display: display@0 {
> +		compatible = "elgin,spi-lcd";
>  		reg = <0>;
>  		spi-max-frequency = <24000000>;
>  		spi-cpha;
> 





