Return-Path: <linux-spi+bounces-8317-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756DBAC53CD
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 18:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FD34A1ECF
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0FC27FB1E;
	Tue, 27 May 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7trjF/X"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18434276057;
	Tue, 27 May 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364718; cv=none; b=cOHHukf66qgSu3XhEiUmxdeUViMRRw0lIWhDBQ5YQgwOyx44QLx8sLTpDDL48XelmSql7dByBafrmtC/Hjdf/CjCMDGLJrHx0VRDd6zQnpj1YTuWs/+akH0hAU/RKenSvseOFYac+LIqqF2nPqyIqA48tZbybzqhmigiRXcMoVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364718; c=relaxed/simple;
	bh=1QHtJ70y+rvjR6EHIWwb1H2O+LY90CK8zar6Avm1ejE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CDrB2QOoP7f6l8wh9XlgHHOfMWhhMAvBFhmspd2yt5LZQ5rHTcTdMM08jfHqcUXYw5k1nOqWAbeFIUzzvUvouutNM+F0MicfC8ycjfVUXqLXvdNNiT5Nda1Hbrvc3XktbnprvbfLE/j+vw4U/QDYCVjRUDmiZqN5uBGtuliS8sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7trjF/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21BCC4CEEB;
	Tue, 27 May 2025 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748364718;
	bh=1QHtJ70y+rvjR6EHIWwb1H2O+LY90CK8zar6Avm1ejE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q7trjF/Xiu4/dOXeYm3XARMbuTenNw4xm/v/XKKhQ3Qpz2BR/MmP9HbtTAWT9WNY2
	 9Ue0cdZe2532DMrkxHXjLPtpiQBle4NzeiOBgrcgpWd6Ppx42XazvV31CdT8BbCy74
	 9KQX1OYFF0SFkEiAAhHpgAtJ9/PnPEyhv0/MJTjyKbm++CfIKWkGfC9cRP2KpMvq6T
	 ZGrFw2XqrcTHFs4x3c0tnOmGTbcE2umdCs2wXDsQ7CTP0SNXYrT97dRzF97KDK4DZa
	 qTvN/hAkBUo3bs+vwWqNantVMjKirXvuqg+P6KDHImv4jJ4X0Hi5fj24rhi/sf9biw
	 /tS8x5vXTdGbA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Chen Wang
 <unicorn_wang@outlook.com>,  Inochi Amaoto <inochiama@gmail.com>,  Mark
 Brown <broonie@kernel.org>,  Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Paul
 Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,
  Longbin Li <looong.bin@gmail.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  sophgo@lists.linux.dev,
  linux-spi@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] riscv: dts: sophgo: Add SPI NOR node for SG2042
In-Reply-To: <20250525-sfg-spifmc-v2-3-a3732b6f5ab4@gmail.com>
References: <20250525-sfg-spifmc-v2-0-a3732b6f5ab4@gmail.com>
	<20250525-sfg-spifmc-v2-3-a3732b6f5ab4@gmail.com>
Date: Tue, 27 May 2025 18:51:53 +0200
Message-ID: <mafs05xhmro7q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, May 25 2025, Zixian Zeng wrote:

> Add SPI-NOR controller and flash nodes to device tree for SG2042.
>
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>  .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 18 ++++++++++++++++
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 24 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> index 34645a5f6038389cd00d4940947c6bb71d39ec6f..c59a819e35d3201c484bf98392aec14392a7eb04 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> @@ -68,6 +68,24 @@ &sd {
>  	status = "okay";
>  };
>  
> +&spifmc0 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;

Shouldn't you also add other properties like spi-max-frequency or
spi-{rx,tx}-bus-width? Same for the other flash.

> +	};
> +};
> +
> +&spifmc1 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +	};
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
[...]

-- 
Regards,
Pratyush Yadav

