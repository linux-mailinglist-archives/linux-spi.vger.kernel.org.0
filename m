Return-Path: <linux-spi+bounces-8863-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C9CAECBC3
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 10:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22D53B5F27
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 08:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253081FDE14;
	Sun, 29 Jun 2025 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY+uqySs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ADC1E47C5;
	Sun, 29 Jun 2025 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751186244; cv=none; b=YWFXCdwcMuC3a0JbjMDc/3cRFwiodI230No+EJVD/FONQeMROg759SgW/kxjAEFzUCdrU0X/Edf/ci4eRdJ1GFNEbD576LUp9NTB5rD3X7CixHGdKj1WkYH38RF9OCcl9KjiKCzbBxUY77rMALnz1WqNOQh9KvoQp01Y9OBwsok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751186244; c=relaxed/simple;
	bh=QjtaeULOocQ639xsWhZDYI4GEBGiiOhnaPbbA/yGWrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hATZoYRAJumvVbDFiPqdi3AolnnOgU94+cP/CojKnyrV+opPuS1fxcYhMXmFKtmLh+cHSQE2S+hp6MtLgXN1vnIuzrs/IZ+Gd7Ur8xArcJCgyOTcV9PYSLWiyDzx5ERWYe17y96zxSzHgMnHwKBRWLnT8e2zLGLPfT2CJAqgMqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IY+uqySs; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7490702fc7cso2693452b3a.1;
        Sun, 29 Jun 2025 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751186242; x=1751791042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+BcgPGnRt3iJg519EPQI5YMO+fb+KS53JEcTm8aE2s=;
        b=IY+uqySsvl9tY0olrzooy7l1xZI6ZukxzDz0aW0BD6KIAAGNXYZe8o4rN7Js8BaLMD
         pZifZA4hUa1WpLVZRkQY534aNXZgPvKMvnSbevOYim6rzPe2bmuJGkcmLfb3Jrb5uCK1
         3d9GGfOENUyLr5fQ/Aapcp7Iy4QFd0wAU3bikzrs+qpTvKVavxSTjSiyK/LC/CDxA9nN
         +OMAYcBTHPT6X0BCkiZuRU6EVnlIZnk5OGMZL8zeaBHJVMpFPmw0tlNfU88sAjua+GBm
         v5DWPYNj7IF9Mg4Qtsg/W/Ow14CWPcQzxmrOcm6YIv4d6zu/8no5lhHJiJx6YKQWpN+V
         2XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751186242; x=1751791042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+BcgPGnRt3iJg519EPQI5YMO+fb+KS53JEcTm8aE2s=;
        b=GNnxomIRvRplt+LaesTPaCD7iJDa1UZM+S5Uc2tAP41mY/LlXZTk8Jj32R+u0ZC66o
         aZRhGZ9vuufcNIVMrnCEfO70/YpYsplSe9kxyfcP3AiQIonmyFos3BXeWVNgD4EU8wk5
         fJujydfVkhslzKtysCh3lOco9vXLMK5Is3xNL7BfgQi+5h9Y6ll173AfW5f9XcmWSvNd
         tVelVP34UpHiM9YIzdmnUD2yFY5mqHFRNcZAXzi8kEzpxuSO3Fdy8zRUheN/UGhrRBL3
         1qsw5C5XUaN4Cs5gcWmHa2551NWM61vLzmQ71Q7xy1oG9g5LVntMMK6Eixoucij50XDL
         BUyA==
X-Forwarded-Encrypted: i=1; AJvYcCU/idFdwebbTGXnPzwUMQDcL6RPcKojq3Cmtrxt3jslz/9RTjdfzQ9hKEzaZnpT43DQH6dtRqMwxtAJ@vger.kernel.org, AJvYcCUFVmFkLEZBfaaFWTmDp+y7SBDMOC2RDOQWWcbVnLB4Fz2aNI9BM4+v5Na4frdVihFOVxHAlqRFohwbE53n@vger.kernel.org, AJvYcCWgWVfheZqCb5DBN0zXqwNoUjnNs7GRnNHe3iHML04h6t9T3ZvZEfWe6CpaQ5N4dc7T0M+l0tC1kG1b@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10Szt3jRCHUElcewpKO0++tavvc1L2YMJ4fNo20fMCv51vnVW
	TU96qwHRiCI9hlPyaLlPdvawCFJV6KX+tgmy1T7ifEBcIri9YDYEs3Sg
X-Gm-Gg: ASbGncvx6J0xyTvBUvXz2e9HCxbrS9X1OZc8k+tnSE1Ov4so3NBhB0PtJ0VKIpyhcp6
	/XT3pQFvwFDD627z4ZOB0EpEp6NWIeUGo93TytOFPxHcC+k3bWN5u62oXs0FPn+2WDwjc1ieCLO
	cTcEag76T+qkoYXnJxWKpai7gJIF1FqeAtkalBocgKSIAXS3wZxtxSqG8OeOpmTupR3FUqvp69h
	V1+GI8tMK2+MRdwV94/mpCItyF+iE7+fijX6YBbfYE7jtX4FqWoHYx8qgIufKxIyOwrBzAJIf+N
	qAdiSbACtOq5+WwaXfPVOpX7GXyb+m0GMDJOCPO4HTVhGNBc5Qk4gi1pI4KkfMJm0EU=
X-Google-Smtp-Source: AGHT+IF5QdK7zE4cTr0041AFjTqMIeuBxsDXV4WV5f+rw5vGOtEvUzEIvjAK9unWEGYVymasc3U0vA==
X-Received: by 2002:a05:6a00:4b11:b0:748:f1ba:9af8 with SMTP id d2e1a72fcca58-74af6fcd15cmr10632012b3a.21.1751186241526;
        Sun, 29 Jun 2025 01:37:21 -0700 (PDT)
Received: from localhost ([101.76.241.248])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af557b3a2sm6117064b3a.104.2025.06.29.01.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 01:37:21 -0700 (PDT)
Date: Sun, 29 Jun 2025 16:37:18 +0800
From: Zixian Zeng <sycamoremoon376@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Longbin Li <looong.bin@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 4/4] riscv: dts: sophgo: Add SPI NOR node for SG2042
Message-ID: <aGD7Pvua1OCdqfb3@calculate>
References: <20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com>
 <20250629-sfg-spifmc-v3-4-28db1f27e999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250629-sfg-spifmc-v3-4-28db1f27e999@gmail.com>

On Sun, Jun 29, 2025 at 04:23:13PM +0800, Zixian Zeng wrote:
> Add SPI-NOR controller and flash nodes to device tree for SG2042.
> 
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>  .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 24 ++++++++++++++++++++++
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 24 ++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> index ef3a602172b1e5bf3dcf54a8cacdad5172b7f50e..554ec14d58453a44a02a82da40a7aedb80d61dc9 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> @@ -138,6 +138,30 @@ &sd {
>  	status = "okay";
>  };
>  
> +&spifmc0 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <100000000>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +	};
> +};
> +
> +&spifmc1 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <100000000>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +	};
> +};
> +
>  &uart0 {
>  	pinctrl-0 = <&uart0_cfg>;
>  	pinctrl-names = "default";
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index 85636d1798f11804546ed8606595ace1b4cb2a2f..0e1fcb54480af71147d0e71178a8eb08a31b75c3 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -48,6 +48,30 @@ soc: soc {
>  		interrupt-parent = <&intc>;
>  		ranges;
>  
> +		spifmc0: spi@7000180000 {
> +			compatible = "sophgo,sg2042-spifmc-nor", "sophgo,sg2044-spifmc-nor";

Sorry, This should be compatible = "sophgo,sg2042-spifmc-nor", binding
is changed in this patch series. My git branches are a bit messy, sorry
for taking your time for this issue.
> +			reg = <0x70 0x00180000 0x0 0x1000000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&clkgen GATE_CLK_AHB_SF>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <108 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&rstgen RST_SF0>;
> +			status = "disabled";
> +		};
> +
> +		spifmc1: spi@7002180000 {
> +			compatible = "sophgo,sg2042-spifmc-nor", "sophgo,sg2044-spifmc-nor";

Same as above, sincerely

Best regards,
Zixian
> +			reg = <0x70 0x02180000 0x0 0x1000000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&clkgen GATE_CLK_AHB_SF>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <109 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&rstgen RST_SF1>;
> +			status = "disabled";
> +		};
> +
>  		i2c0: i2c@7030005000 {
>  			compatible = "snps,designware-i2c";
>  			reg = <0x70 0x30005000 0x0 0x1000>;
> 
> -- 
> 2.49.0
> 

