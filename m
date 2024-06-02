Return-Path: <linux-spi+bounces-3194-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CC38D76D2
	for <lists+linux-spi@lfdr.de>; Sun,  2 Jun 2024 17:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE03B22492
	for <lists+linux-spi@lfdr.de>; Sun,  2 Jun 2024 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C31482CD;
	Sun,  2 Jun 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="vTjdqiLR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp-out.freemail.hu (fmfe35.freemail.hu [46.107.16.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD9517736;
	Sun,  2 Jun 2024 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342755; cv=none; b=VfUFt+EOWDUPERSOfX4wK4qWKZMn23YWHyyWrvFJP0ZLo79c9XjaghMqufDkPITzWG7Elrd123SKfEfFcpTh6AiSACmxSGKTSuIm9oMyGSF1ynxi/IUt/unBaEVU6GgQ1Zmcz0bXCau/b1rf1ee+53IM0dFXc0Hac4Mo4a875Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342755; c=relaxed/simple;
	bh=cu1Ss0V90yPLtbBTiY5VNm7dU1DFjdCGGYetsr2pX8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhT3+GoZ66EXL2U4auYIfJGg5HyLXScpoVssYTkpaIZc9U2XZcFAKIMcTSgzJ7NfAwzvEhmuHAP5hoU2VNKDupTeY41AbFgKRk/zUJZSo43r+9iiIDlRUnX5vZVjs6WeaIlhVYBz/KnBslf4ssxL87inNEHMBlw9o2Y1St6YYkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=vTjdqiLR reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from [192.168.0.16] (catv-80-98-74-198.catv.fixed.vodafone.hu [80.98.74.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4Vsgmz6970z4F6;
	Sun,  2 Jun 2024 17:31:15 +0200 (CEST)
Message-ID: <30944fda-6d18-4fc1-8c73-bcda4814a417@freemail.hu>
Date: Sun, 2 Jun 2024 17:31:10 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spidev: Introduce "linux,spidev-name" property for
 device tree of spidev.
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240519211346.30323-1-egyszeregy@freemail.hu>
 <1ec9e8e5-0818-42b0-8776-d9cfb0585f42@sirena.org.uk>
 <9ae65e3c-f1fa-4ca9-8d74-12d92c51c5c6@freemail.hu>
 <e8837fe0-e93c-4133-aac1-f8f0a010f6de@sirena.org.uk>
Content-Language: hu, en-US
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <e8837fe0-e93c-4133-aac1-f8f0a010f6de@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1717342276;
	s=20181004; d=freemail.hu;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=3367; bh=Fd1Lsy5QNOanvMIRy/o0jKg+8qGYkFTM1ga4jW9aSxo=;
	b=vTjdqiLR8mjuIVqAkyaMnTEB02XIsX9+HBbE21M3InL4/8FoE/GrIJM08VoYWTbL
	OjGKneyr0KehwQ6onnMnK54diGTV3HJ84/KdyVXub9Ufx+qC9Wm5Qe+Qz6BIX81HsQ5
	tip24fmmsj80XbUY9qcVWArgrz0H6slaQeQytsqyPuygYe+wm53aVIynEvZOL9AX6Cs
	vk8jbemGU/DJK6kB6U4wlcZJiNdJCyKSryrToPwloFOyBbY3hXurdCfU6LHpZNMaLTf
	/6yV4sfbvlH2Hs+IbxJTqfRxd/gLKrCjrkPUnk2YfzRQ8yrL6IOLCjEWQlb9cT3tsT9
	dNuUv8Nujw==

2024. 05. 20. 22:14 keltezéssel, Mark Brown írta:
> On Mon, May 20, 2024 at 07:20:12PM +0200, Szőke Benjamin wrote:
> 
>> So, in Yocto project build system point of view the best, if any Machine
>> specific settings is stored in the device tree files of the target machine
>> in driver levels/config, because it will be deterministic in 100% sure and
>> it will be nicely separated from the SW meta layers which may not contains
>> any machine specific hacking with udev and so on.
> 
> Given that with Yocto you're building a full system image it's not
> super obvious to me that it is particularly harder to ship udev rules in
> the image as opposed to modifying the DT.  It's a little more annoying
> but not drastically so and it's not creating a burden on the ABI for
> something that's mainly used within a vertically integrated software
> stack.
> 

In Yocto and Buildroot it is harder and more ugly to provide MACHINE specific 
settings in a rootfs config files than define it in the machine specific .dts 
and .dtsi files because they are separated in meta-layers for SW recipes and HW 
related machine recipes.

As i know udev is much older than device-tree in Linux kernel history. For 
embedded Linux image maintaining/developing for ARM, RISC-V etc. to solve this 
kind of features/issues is more elegant to do in device-tree than with udev, 
moreover for an embedded Linux developer it is more familiar to do in 
device-tree then udev.

I spent 3-4 days to understand udev rules files and i tried to do it via udev, 
but i gave up it due to it complexity and incomplete documentation about it.

axi_quad_spi_0: axi_quad_spi@a00a0000 {
     bits-per-word = <8>;
     clock-names = "ext_spi_clk", "s_axi_aclk";
     clocks = <&zynqmp_clk 71>, <&zynqmp_clk 71>;
     compatible = "xlnx,axi-quad-spi-3.2", "xlnx,xps-spi-2.00.a";
     fifo-size = <16>;
     interrupt-names = "ip2intc_irpt";
     interrupt-parent = <&gic>;
     interrupts = <0 106 1>;
     num-cs = <0x1>;
     reg = <0x0 0xa00a0000 0x0 0x10000>;
     xlnx,num-ss-bits = <0x1>;
     xlnx,spi-mode = <0>;

     #address-cells = <1>;
     #size-cells = <0>;

     spidev@0 {
         reg = <0>;
         compatible = "rohm,dh2228fv";
         spi-max-frequency = <1000000>;

         // via my kernel patch -> /dev/spidev-mysensor
         // linux,spidev-name = "mysensor";
     };
};

As i understand "axi_quad_spi@a00a0000" can be mapped via udev to a custom 
symlink name but in a new adaptive SoC HWs like AMD ZynqMP, Intel Stratix, 
Microchip PolarFire Soc etc. it is not possible and not good solution because 
this axi reg address can be different and become to non-deterministic in day to 
next when there is a new PL FW update for their FPGA part in the silicon.

What udev rules have to use for it if you say it can be perfectly done via udev 
and "axi_quad_spi@a00a0000" cannot be used for making this rule?

>> DT binding would need to be documented later in a separated patch as a
>> guideline mentioned it in Linux repo.
> 
> No, that needs to happen along with the code change.

The official documentation says totally different:
"The Documentation/ and include/dt-bindings/ portion of the patch should be a 
separate patch. ..."

https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/submitting-patches.rst

By the way where can i find .yml or .txt dt-bindings documentation of spidev driver?


