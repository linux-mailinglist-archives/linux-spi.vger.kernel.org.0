Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A077813829C
	for <lists+linux-spi@lfdr.de>; Sat, 11 Jan 2020 18:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgAKR0n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 11 Jan 2020 12:26:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730533AbgAKR0n (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 11 Jan 2020 12:26:43 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA2B6206ED;
        Sat, 11 Jan 2020 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578763602;
        bh=ktFS9YWjiT6ht7tc+v11qTbRy7B1vTvUdZZhKJ0Egnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVi3m3sZJlBPvA51bmf/sgXDrDsOxKOQ3pU47IiGlF7fi3vkjBCtPAK/evnvnIW0b
         N/SukqfHK00DO9Ix+FNtpuGle7O6iweMUvBkPN1rhwNke2cKxyRlMapRr32lo+/7M0
         RZy/zc7DJGUoa0MATrwjwkCRusi9Lwsxx0M2bLKM=
Date:   Sat, 11 Jan 2020 18:26:39 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.xyz>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] arm64: dts: sun50i: H6: Add SPI controllers nodes
 and pinmuxes
Message-ID: <20200111172639.to3lhzros6ca5hj2@gilmour.lan>
References: <20200108101006.150706-1-andre.przywara@arm.com>
 <20200108101006.150706-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108101006.150706-2-andre.przywara@arm.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jan 08, 2020 at 10:10:05AM +0000, Andre Przywara wrote:
> The Allwinner H6 SoC contains two SPI controllers similar to the H3/A64,
> but with the added capability of 3-wire and 4-wire operation modes.
> For now the driver does not support those, but the SPI registers are
> fully backwards-compatible, just adding bits and registers which were
> formerly reserved. So we can use the existing driver for the "normal" SPI
> modes, for instance to access the SPI NOR flash soldered on the PineH64
> board.
> We use an H6 specific compatible string in addition to the existing H3
> string, so when the driver later gains Quad SPI support, it should work
> automatically without any DT changes.
>
> Tested by accessing the SPI flash on a Pine H64 board (SPI0), also
> connecting another SPI flash to the SPI1 header pins.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 54 ++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 3329283e38ab..40835850893e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -338,6 +338,30 @@
>  				bias-pull-up;
>  			};
>
> +			/omit-if-no-ref/
> +			spi0_pins: spi0-pins {
> +				pins = "PC0", "PC2", "PC3";
> +				function = "spi0";
> +			};
> +
> +			/omit-if-no-ref/
> +			spi0_cs_pin: spi0-cs-pin {
> +				pins = "PC5";
> +				function = "spi0";
> +			};

It seems suspicious to use it in the Pine H64, since PC5 is also used
by the eMMC (and this prevents either the SPI or the emmc controller
to probe, depending on which probed first).

Maxime
