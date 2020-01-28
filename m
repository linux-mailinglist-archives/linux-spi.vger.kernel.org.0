Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D44A14B3E7
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2020 13:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgA1MFd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jan 2020 07:05:33 -0500
Received: from foss.arm.com ([217.140.110.172]:55952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgA1MFd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Jan 2020 07:05:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 676551045;
        Tue, 28 Jan 2020 04:05:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D922A3F52E;
        Tue, 28 Jan 2020 04:05:31 -0800 (PST)
Date:   Tue, 28 Jan 2020 12:05:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] spi: spi-fsl-espi: add GPIO chipselect support
Message-ID: <20200128120530.GC4689@sirena.org.uk>
References: <067ed094-fa5d-f472-8abd-c22f4c0dba03@inbox.ru>
 <CAMuHMdWiWqquohF93jssKuu0GFhs0QHtyXsTse5WN9rUjPGd4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWiWqquohF93jssKuu0GFhs0QHtyXsTse5WN9rUjPGd4A@mail.gmail.com>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2020 at 10:20:24AM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 28, 2020 at 8:26 AM Maxim Kochetkov <fido_max@inbox.ru> wrote:

> > eSPI controller can't send transactions without hardware chip selects.
> > So, to use GPIO chip selects with eSPI controller we need to use one
> > dedicated hardware chip select signal. To specify shared chip select for
> > GPIO use "fsl,espi-shared-chipselect" DT property.

> Do you need a property to specify this?
> Can't the driver just pick an unused native chip select instead?
> Recently I've added generic support for that to the SPI core, cfr. commit
> 7d93aecdb58d47e8 ("spi: Add generic support for unused native cs with
> cs-gpios").

The only reason I would expect for needing this is if there's no pinmux
control so you need to make sure that the chip select used isn't going
to cause electrical problems.

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4wI4kACgkQJNaLcl1U
h9ADRAf/Y03I7ojskz2VRSttCwF5mPVZ8f9FuZbuns0qAlsZfboYpHBgTd62JX1Y
CVjMxdh4nYxsfK3jWX1bOjXUI0n/czEGmFDL7TDa83yVs0lDEzsHIzVG/HXVHlw/
5fcf6AChhdSWGiM9MCcoZucRGxx/iDGA6bejPGnWMO6/zHPtsiFuANP9cLneB7HV
J9RWGKOIVXUU/VD1lV81Yjq65r3XctbFSah/Ga91ZfUThq6RO13JB7ZwwugrtOeQ
un3kU7XPFW5cKkAiAT7syIEvP8nelDuXF2hZuEVoVfg6YZp3Z3puyNjcNCXiZ/el
uj4ZW9+0rY199hakdsKxYAFnvwJIWA==
=FRSf
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
