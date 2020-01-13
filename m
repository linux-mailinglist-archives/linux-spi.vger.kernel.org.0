Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71136138D57
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2020 09:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgAMI7e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jan 2020 03:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:32894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgAMI7e (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 13 Jan 2020 03:59:34 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A09820678;
        Mon, 13 Jan 2020 08:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578905972;
        bh=JfZwSTOrI3J7CIa5OdM8C3bfShk23rBqMg7ZmqPnXd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oi9IO6MWKgGI+YoNaP20pa1l4rq2n7FBdgy/pBOn4XJCDISx2Jdz3ni2uErW4Ldz2
         cWG4w1zm8qisUTJI8kAGS2iXzgfSOqAuQwq9GzZNo8NOW7hBs4Wl2kDoXd9byaG6+U
         TBfAuEQKR39d2TFLq3Hr+4Z3HC0pneZIvN7Sr7ak=
Date:   Mon, 13 Jan 2020 09:59:29 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     =?utf-8?B?QW5kcsOp?= Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.xyz>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] arm64: dts: sun50i: H6: Add SPI controllers nodes
 and pinmuxes
Message-ID: <20200113085929.24iseck4fljw5njh@gilmour.lan>
References: <20200108101006.150706-1-andre.przywara@arm.com>
 <20200108101006.150706-2-andre.przywara@arm.com>
 <20200111172639.to3lhzros6ca5hj2@gilmour.lan>
 <cea0a8ed-fcf7-53c8-daf9-cf27408d83f9@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ir7fewqs7mlcjtw5"
Content-Disposition: inline
In-Reply-To: <cea0a8ed-fcf7-53c8-daf9-cf27408d83f9@arm.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ir7fewqs7mlcjtw5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2020 at 03:12:19PM +0000, Andr=E9 Przywara wrote:
> On 11/01/2020 17:26, Maxime Ripard wrote:
>
> Hi Maxime,
>
> > On Wed, Jan 08, 2020 at 10:10:05AM +0000, Andre Przywara wrote:
> >> The Allwinner H6 SoC contains two SPI controllers similar to the H3/A6=
4,
> >> but with the added capability of 3-wire and 4-wire operation modes.
> >> For now the driver does not support those, but the SPI registers are
> >> fully backwards-compatible, just adding bits and registers which were
> >> formerly reserved. So we can use the existing driver for the "normal" =
SPI
> >> modes, for instance to access the SPI NOR flash soldered on the PineH64
> >> board.
> >> We use an H6 specific compatible string in addition to the existing H3
> >> string, so when the driver later gains Quad SPI support, it should work
> >> automatically without any DT changes.
> >>
> >> Tested by accessing the SPI flash on a Pine H64 board (SPI0), also
> >> connecting another SPI flash to the SPI1 header pins.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >> ---
> >>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 54 ++++++++++++++++++++
> >>  1 file changed, 54 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64=
/boot/dts/allwinner/sun50i-h6.dtsi
> >> index 3329283e38ab..40835850893e 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> >> @@ -338,6 +338,30 @@
> >>  				bias-pull-up;
> >>  			};
> >>
> >> +			/omit-if-no-ref/
> >> +			spi0_pins: spi0-pins {
> >> +				pins =3D "PC0", "PC2", "PC3";
> >> +				function =3D "spi0";
> >> +			};
> >> +
> >> +			/omit-if-no-ref/
> >> +			spi0_cs_pin: spi0-cs-pin {
> >> +				pins =3D "PC5";
> >> +				function =3D "spi0";
> >> +			};
> >
> > It seems suspicious to use it in the Pine H64, since PC5 is also used
> > by the eMMC (and this prevents either the SPI or the emmc controller
> > to probe, depending on which probed first).
>
> Argh, good catch! I saw that AW changed the pin sharing between SPI and
> MMC2 slightly, but didn't actually check that they made it worse :-(
> Because this time it's the MMC CMD pin affected, and not the somewhat
> optional DS pin as in the A64.
> So I see we can't really have both at the same time. So what about this:
>
> We keep the SPI flash chip described as in patch 2/2 (as it's soldered
> on every board), but mark it as disabled and explain this in a comment.
> This way we can't access it under Linux, but keep a potential eMMC chip
> accessible.
>
> In U-Boot's DT copy we could deviate and mark it as "okay", as U-Boot
> doesn't use both eMMC and SPI at the same time. I need to check whether
> this works or we would need to move the pinmux setup out of the probe
> routine into something later.
>
> And we could go one step further: If U-Boot detects an eMMC connected
> (it's on a socket and so optional), it changes the SPI flash status to
> "disabled", to allow EFI apps and kernels using this DT to access the
> eMMC - which is far more useful than the SPI flash.
> Otherwise (no eMMC connected) it can stay at "okay", as there would be
> no conflict.
>
> Does this make sense?

It does, it seems like a good plan

Maxime

--ir7fewqs7mlcjtw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhwxcQAKCRDj7w1vZxhR
xeN3AP472p91nx9oqXRJe6+0u8r0T386EdVwUUHUSJGHeqdtzwEA8UiwW9E3F42A
/XZ5acoOflKaj0ShNtTko85S2oaFWQM=
=8bva
-----END PGP SIGNATURE-----

--ir7fewqs7mlcjtw5--
