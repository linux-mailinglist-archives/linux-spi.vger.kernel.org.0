Return-Path: <linux-spi+bounces-2801-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 644578C0BC4
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 08:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EA5B20CB9
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 06:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D9522615;
	Thu,  9 May 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSFJ5F5B"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E69DF78
	for <linux-spi@vger.kernel.org>; Thu,  9 May 2024 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237703; cv=none; b=QGmOfHdye98P1CsMFQvwnPqccYx5GR/yyIDeqxaXSrE69gmRHRBCheqMgEeYjuutnoNk6rctmDMysK6ttKEerAH5+r3PyI5y92cFTVJxf4Iid8tTUWvMi/Q/hgs2UHUJEd7oao1JPJa9bwvfwQ4Z20RsLuWUV0MIj/kzz+ybprw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237703; c=relaxed/simple;
	bh=DgTGVkJSemn+StTJ2snTjbDta0Scl0MfHZjWeSQnM5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUIMGS8HFkeQ//U4AkuFC/wpLUhBIyUXhAFqiTMc1iRruvSMfkrFdSBSgWZF+3K2FBLEqBL24z/abBcqLpLvldlOn1jaD+CnpAf1LN/Et131qZzLVfGVx1AmjVUy6oEvLGucXbuWLzBDcn+N4BgnSRuE/OrK4I1JRLdHZeO/D/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSFJ5F5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEB9C116B1;
	Thu,  9 May 2024 06:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715237702;
	bh=DgTGVkJSemn+StTJ2snTjbDta0Scl0MfHZjWeSQnM5k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GSFJ5F5BRrFnILgQCp0Ms+Aj+IjVj0AIJa2muL0oJVBzhA+Hs54KTTX1kVT0DQlDp
	 T4/4eXzzncwUB6CC+oTTdZpgyocGNgdnXAB0ozZ9f/l6MMvlnOfJNcfijI/2PWZCn3
	 3HdvUTYTfsOF7ab/cRzuPS/hlGsGbdAuq40mByBL89xG/n9u995j6pvm3n6KHo+kAy
	 I4pznwGtafnbGP0RRGmUEPv8soAb9h6N5LL53Cqe7vVDlmCpKQfVdlBhHMnMXFdGcZ
	 2M8SGo1LS8/5yfOqlJ+KMxbgY0FsS0sRR9dhG+91JHwKtLlw52wfbVc7Pv2wJIuBbF
	 p/8eeAAWAOTBw==
Message-ID: <3800ccd6-0f55-4a87-a85b-9e3053439d94@kernel.org>
Date: Thu, 9 May 2024 15:55:00 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: dw: Bail out early on unsupported target mode
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Serge Semin <fancer.lancer@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-riscv@vger.kernel.org
References: <7ae28d83bff7351f34782658ae1bb69cc731693e.1715163113.git.geert+renesas@glider.be>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <7ae28d83bff7351f34782658ae1bb69cc731693e.1715163113.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/24 7:20 PM, Geert Uytterhoeven wrote:
> Currently, the DesignWare SPI controller driver supports only host mode.
> However, spi2 on the Kendryte K210 SoC supports only target mode,
> triggering an error message on e.g. SiPEED MAiXBiT since commit
> 98d75b9ef282f6b9 ("spi: dw: Drop default number of CS setting"):
> 
>     dw_spi_mmio 50240000.spi: error -22: problem registering spi host
>     dw_spi_mmio 50240000.spi: probe with driver dw_spi_mmio failed with error -22
> 
> As spi2 rightfully has no "num-cs" property, num_chipselect is now zero,
> causing spi_alloc_host() to fail to register the controller.  Before,
> the driver silently registered an SPI host controller with 4 chip
> selects.
> 
> Reject target mode early on and warn the user, getting rid of the
> error message.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
> Commit 98d75b9ef282f6b9 is in spi/for-next (next-20240508 and later).
> 
> Overview of all SPI controllers on K210:
> 
>     spi0 (52000000.spi):
> 	num_cs = <4> in k210.dtsi
> 	num_cs = <1> override in sipeed_maix*.dts and canaan_kd233.dts
> 	DW_SPI_SER says 0xf (but value is unused)
> 
>     spi1 (53000000.spi):
> 	num_cs = <4> in k210.dtsi
> 	num_cs = <1> override in sipeed_maix*.dts and canaan_kd233.dts
> 	DW_SPI_SER says 0xf (but value is unused)
> 
>     spi2 (53000000.spi):
> 	spi-slave
> 	no num_cs property
> 	DW_SPI_SER says 0
> 	dw_spi_mmio 50240000.spi: error -22: problem registering spi host
> 	dw_spi_mmio 50240000.spi: probe with driver dw_spi_mmio failed with error -22
> 
>     spi3 (54000000.spi):
> 	num_cs = <4> in k210.dtsi
> 	DW_SPI_SER says 0x1 (but value is unused)
> 	Used in sipeed_maix*.dts, unused in canaan_kd233.dts
> 
> See also "[PATCH 2/2] riscv: dts: canaan: Disable I/O devices unless
> used"
> https://lore.kernel.org/r/f85d460efd7ad85ec59c9253c989b10a07f2ff24.1715163174.git.geert+renesas@glider.be
> ---
>  drivers/spi/spi-dw-mmio.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index c56de35eca988ee4..819907e332c4b004 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -321,6 +321,11 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>  	struct dw_spi *dws;
>  	int ret;
>  
> +	if (device_property_read_bool(&pdev->dev, "spi-slave")) {
> +		dev_warn(&pdev->dev, "spi-slave is not yet supported\n");
> +		return -ENODEV;
> +	}
> +
>  	dwsmmio = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mmio),
>  			GFP_KERNEL);
>  	if (!dwsmmio)

-- 
Damien Le Moal
Western Digital Research


