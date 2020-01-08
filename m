Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03963134508
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jan 2020 15:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgAHOcg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jan 2020 09:32:36 -0500
Received: from mail.blih.net ([212.83.177.182]:26771 "EHLO mail.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgAHOcg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jan 2020 09:32:36 -0500
Received: from mail.blih.net (mail.blih.net [212.83.177.182])
        by mail.blih.net (OpenSMTPD) with ESMTP id 44fc4725;
        Wed, 8 Jan 2020 15:32:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mail;
         bh=2yUHFzCKidxrTbLTYWuAZ0T5Tlo=; b=jgLCFiOQaLOxXHprjINfgd7x7d8W
        UNDP9F659T9fBhRFiVeP/PV/20Bhc7XkY2PW1cPHb8G0s+tsmCcUKE0n4U88npEc
        8oR+SA1cQCvVmEflHGLWN4EgirZC55s1kYDMzHDBrLAK/EEXGQkv6FbxRHZjhvhd
        2/f547rCFfM5alY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; q=dns; s=
        mail; b=bvBMmkZ221zKQvLyKxA+SPMgg+O573MGZjvnAWQfZdAUqvKpJYa6gBUL
        3eCkdxCRQi0aXy2uhUrTlGYmCOokssIwj6KLahT/X7Q+ne71OEQmm3lUqMXJpfFZ
        9ZNCND5YDXSAQGZZrG8vc95Z1DjJtIlHG8IZAU490cE1Vy75P0U=
Received: from skull.home.blih.net (lfbn-idf2-1-1164-130.w90-92.abo.wanadoo.fr [90.92.223.130])
        by mail.blih.net (OpenSMTPD) with ESMTPSA id 4fe403c8
        TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
        Wed, 8 Jan 2020 15:32:32 +0100 (CET)
Date:   Wed, 8 Jan 2020 15:32:30 +0100
From:   Emmanuel Vadot <manu@bidouilliste.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-spi@vger.kernel.org, linux-sunxi@googlegroups.com,
        Mark Brown <broonie@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: sun50i: H6: Add SPI controllers nodes
 and pinmuxes
Message-Id: <20200108153230.509ce90f4cbdf1122dbd6d59@bidouilliste.com>
In-Reply-To: <20200108114706.5f27a9b2@donnerap.cambridge.arm.com>
References: <20200108101006.150706-1-andre.przywara@arm.com>
        <20200108101006.150706-2-andre.przywara@arm.com>
        <20200108123448.26286186e74f899caaf5ad35@bidouilliste.com>
        <20200108114706.5f27a9b2@donnerap.cambridge.arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd13.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 8 Jan 2020 11:47:06 +0000
Andre Przywara <andre.przywara@arm.com> wrote:

> On Wed, 8 Jan 2020 12:34:48 +0100
> Emmanuel Vadot <manu@bidouilliste.com> wrote:
> 
> Hi Emmanuel,
> 
> > On Wed,  8 Jan 2020 10:10:05 +0000
> > Andre Przywara <andre.przywara@arm.com> wrote:
> > 
> > > The Allwinner H6 SoC contains two SPI controllers similar to the H3/A64,
> > > but with the added capability of 3-wire and 4-wire operation modes.
> > > For now the driver does not support those, but the SPI registers are
> > > fully backwards-compatible, just adding bits and registers which were
> > > formerly reserved. So we can use the existing driver for the "normal" SPI
> > > modes, for instance to access the SPI NOR flash soldered on the PineH64
> > > board.
> > > We use an H6 specific compatible string in addition to the existing H3
> > > string, so when the driver later gains Quad SPI support, it should work
> > > automatically without any DT changes.
> > > 
> > > Tested by accessing the SPI flash on a Pine H64 board (SPI0), also
> > > connecting another SPI flash to the SPI1 header pins.
> > > 
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 54 ++++++++++++++++++++
> > >  1 file changed, 54 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > index 3329283e38ab..40835850893e 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > @@ -338,6 +338,30 @@
> > >  				bias-pull-up;
> > >  			};
> > >  
> > > +			/omit-if-no-ref/  
> > 
> >  That would prevent users to use an overlay and use those pins, is that
> > something that we want ? I'm not sure that the space saved by those are
> > useful.
> 
> Me neither ;-), but Maxime asked for it before, and it doesn't really hurt.
> 
> For overlays: if a .dtb is compiled with support for overlays (-@ to generate symbols), this tag is ignored, and the nodes stay in the .dtb, regardless of being referenced or not. Just confirmed by trying this.

 Oh I didn't knew that (and didn't tried before sending my mail
sorry :P), then it's good for me leaving them :)

 Thanks,

> Cheers,
> Andre.
> 
> > 
> >  Cheers,
> > 
> > > +			spi0_pins: spi0-pins {
> > > +				pins = "PC0", "PC2", "PC3";
> > > +				function = "spi0";
> > > +			};
> > > +
> > > +			/omit-if-no-ref/
> > > +			spi0_cs_pin: spi0-cs-pin {
> > > +				pins = "PC5";
> > > +				function = "spi0";
> > > +			};
> > > +
> > > +			/omit-if-no-ref/
> > > +			spi1_pins: spi1-pins {
> > > +				pins = "PH4", "PH5", "PH6";
> > > +				function = "spi1";
> > > +			};
> > > +
> > > +			/omit-if-no-ref/
> > > +			spi1_cs_pin: spi1-cs-pin {
> > > +				pins = "PH3";
> > > +				function = "spi1";
> > > +			};
> > > +
> > >  			spdif_tx_pin: spdif-tx-pin {
> > >  				pins = "PH7";
> > >  				function = "spdif";
> > > @@ -504,6 +528,36 @@
> > >  			#size-cells = <0>;
> > >  		};
> > >  
> > > +		spi0: spi@5010000 {
> > > +			compatible = "allwinner,sun50i-h6-spi",
> > > +				     "allwinner,sun8i-h3-spi";
> > > +			reg = <0x05010000 0x1000>;
> > > +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> > > +			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
> > > +			clock-names = "ahb", "mod";
> > > +			dmas = <&dma 22>, <&dma 22>;
> > > +			dma-names = "rx", "tx";
> > > +			resets = <&ccu RST_BUS_SPI0>;
> > > +			status = "disabled";
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > > +		};
> > > +
> > > +		spi1: spi@5011000 {
> > > +			compatible = "allwinner,sun50i-h6-spi",
> > > +				     "allwinner,sun8i-h3-spi";
> > > +			reg = <0x05011000 0x1000>;
> > > +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > > +			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
> > > +			clock-names = "ahb", "mod";
> > > +			dmas = <&dma 23>, <&dma 23>;
> > > +			dma-names = "rx", "tx";
> > > +			resets = <&ccu RST_BUS_SPI1>;
> > > +			status = "disabled";
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > > +		};
> > > +
> > >  		emac: ethernet@5020000 {
> > >  			compatible = "allwinner,sun50i-h6-emac",
> > >  				     "allwinner,sun50i-a64-emac";
> > > -- 
> > > 2.17.1


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
