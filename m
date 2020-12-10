Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1FA2D5FD2
	for <lists+linux-spi@lfdr.de>; Thu, 10 Dec 2020 16:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391093AbgLJPfJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Dec 2020 10:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391772AbgLJPek (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 10 Dec 2020 10:34:40 -0500
Date:   Thu, 10 Dec 2020 15:33:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607614439;
        bh=iMwv7c77IjrqicDbjsGvEy84gWS+/5SD4Vci9BgKJn4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=WtncBznI2e4tcslywLdMN7BlXtSq67/ZC7sO/xVh0jA7Mder3gDlzZ27l2M1hzrXI
         ErKREhbBerczgjbEPJjrVF2kW0zV2XwLwtGT6b5DJ4WcP1/3TVxyCusgHTqUn+7F9+
         4b3mIUV+hrxGW5hiR32+Ce0Ht0UUoXscZtkq+IQNLzOUI5jwk4sqqyn2nTR9LX3a3Y
         oYKNj8fRm6mPNZlCPIWADxUlAihoHkotQHHuEswzG+6mn7/cujNdVx3ywoSq7AD2vw
         94a2Ch1822VuoDdkHJzhEO7TweI6fh6NicboNnL6Fz1VLEJGial5fo5NqOvFHPQw+b
         f7DLUHPGGtgcA==
From:   Mark Brown <broonie@kernel.org>
To:     Tudor.Ambarus@microchip.com
Cc:     fancer.lancer@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Limit the spi device max speed to controller's max
 speed
Message-ID: <20201210153351.GB4747@sirena.org.uk>
References: <20201209173514.93328-1-tudor.ambarus@microchip.com>
 <20201209194636.32f4ioxxdggezklr@mobilestation>
 <20201209195420.GD4790@sirena.org.uk>
 <20201209201535.32g4kwpzo45jiqr3@mobilestation>
 <20201209202552.GE4790@sirena.org.uk>
 <20201209203042.oqbcijwaxqt5aa7b@mobilestation>
 <48bf85a0-4a98-7e81-0802-c5fac762234f@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <48bf85a0-4a98-7e81-0802-c5fac762234f@microchip.com>
X-Cookie: Your step will soil many countries.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 10, 2020 at 08:58:18AM +0000, Tudor.Ambarus@microchip.com wrote:
> On 12/9/20 10:30 PM, Serge Semin wrote:

> >>>> Right, in general we aim to do this sort of fixup on the transfers
> >>>> and messages rather than the devices, I guess we might be missing
> >>>> validation in some of the flash acceleration paths or was this an issue
> >>>> seen through inspection?

> We miss validation for the SPI controllers that provide the
> spi_controller_mem_ops with its exec_op() method. In this case the SPI
> core does not check if the max_speed_hz of spi_device overrides the
> max_speed_hz of controller.

> This was seen through inspection. There are octal SPI NOR flashes that
> can run at 400 MHZ, and I've also seen SPI controllers that are limited
> to 200 MHZ (microchip's sama7g5 octal SPI for example, which is not yet
> in mainline).

Right, that's the hole :/

> >> Ideally the driver wouldn't have to check though (no harm in doing so of
> >> course).

> Right. I thought of doing this in the SPI core, rather than doing in (each)
> controller driver.

Yes, we should just make sure things are OK in the core as much as we
can so there's less work for driver authors.

> > If so then we'd need to have a dedicated speed-related field in the
> > spi_mem_op structure, which would be accordingly initialized by the
> > SPI-mem core.

> We do need a max_speed_hz in the SPIMEM, but probably for other purposes:
> NOR flashes, for example, can discover the maximum supported frequency
> at run-time, when parsing the jesd216 SFDP tables. One may consider that
> the run-time discovered max_speed_hz should have a higher precedence than
> what we fill with the spi-max-frequency dt property, because the
> manufacturers/jesd216 standard know/s better. Of course, if the
> manufacturers put a wrong max_speed_hz in the sfdp table, that can be
> updated at runtime with a fixup() hook, on a case by case basis. Other
> thing to consider here, is the max_speed_hz supported by the PCB. For
> example if the SPI flash supports 400 MHZ, the controller 200 MHZ, but
> the PCB only 180 MHZ, then we'll have to synchronize all three. But this
> seems like a discussion for other patch.

The potential for board issues suggests that we should be taking the
minimum of what the board DT and runtime discovery say - if the board
limits things more than the parts we should assume that there's a system
integration limitation there.

> Let me know if you think that this patch is ok for now. I can update the
> commit message if needed.

It does work for now but it'd be nicer if we were doing this through
recording the decision on the transfer.

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/SP94ACgkQJNaLcl1U
h9AOwgf+KUAUCPTHIq0yy+UcFieHbKjLnKaQxJVd3pKP8XFAAZXtDwXw2oStbP8m
Yw61sRICosi+SQLxHLvbavpHfolqnpTTya6DLN8xONhRUKiTmV9CV8N2rnfHpFeO
V4VTAdLFLl5WpEvVHcNvdY48khOSy1Jzycv1CdogWz3LEoJLiRmSkbF0bBIa2kbj
P1T8cmy1hVAXJPixZJjiF8psXB8Rs0Evz7CvMzAZZV4YR+h23No6XOCehZH8udvC
kw2fly1yxHP+aWNWgzT4MWyPUaOPRXklOjCz/ERfUs8KXj1Yq07D9XL0bkbvURzJ
mS3VmG+zbZmOsL/vHiDzcscubZ6WIg==
=kW3E
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
