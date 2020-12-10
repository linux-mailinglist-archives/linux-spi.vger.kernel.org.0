Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1A62D64C2
	for <lists+linux-spi@lfdr.de>; Thu, 10 Dec 2020 19:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403898AbgLJSRY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Dec 2020 13:17:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404142AbgLJSRT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 10 Dec 2020 13:17:19 -0500
Date:   Thu, 10 Dec 2020 18:16:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607624198;
        bh=7IZC/FrtsCtLP8agrMBBowmGAoKsyQl86sQD/PfKEZU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUzOOvJyOHp5GCflFjoiyG4VB59OavtXbV9jSVhyoXaC12lCSvmzpTFd1xyY+S1Qy
         fT/k5H14BlNQaligoStbWwpF1W4OPaHRFhmoU23yTSTUB5q69pumMqCbHzZeJZP6aH
         q4LjMoEXp2D2SqIdiKT65jSYUHbeoD623TQYapCGn7g1k3YAjo4XyxtaaVyskqwRAW
         kBwCp+73e6NN6E2muAAI93fAb1FZRLPKtEvl2XeVAmbitYBAgahP0ZfuWKk1X06a3P
         qAooP42dP/cYmBZ2u0pGOxwF9Su5omBoGSBH51h8OrCOk66ATS+MtRFgdIgW2/ObVT
         fO2YD3xEa0MUg==
From:   Mark Brown <broonie@kernel.org>
To:     Tudor.Ambarus@microchip.com
Cc:     fancer.lancer@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] spi: Limit the spi device max speed to controller's
 max speed
Message-ID: <20201210181630.GE4747@sirena.org.uk>
References: <20201209173514.93328-1-tudor.ambarus@microchip.com>
 <20201209194636.32f4ioxxdggezklr@mobilestation>
 <20201209195420.GD4790@sirena.org.uk>
 <20201209201535.32g4kwpzo45jiqr3@mobilestation>
 <20201209202552.GE4790@sirena.org.uk>
 <20201209203042.oqbcijwaxqt5aa7b@mobilestation>
 <48bf85a0-4a98-7e81-0802-c5fac762234f@microchip.com>
 <20201210153351.GB4747@sirena.org.uk>
 <6e182961-fb4e-d7f6-fe05-abfdd99d2ac5@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
Content-Disposition: inline
In-Reply-To: <6e182961-fb4e-d7f6-fe05-abfdd99d2ac5@microchip.com>
X-Cookie: Your step will soil many countries.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 10, 2020 at 04:32:02PM +0000, Tudor.Ambarus@microchip.com wrote:
> On 12/10/20 5:33 PM, Mark Brown wrote:

> > It does work for now but it'd be nicer if we were doing this through
> > recording the decision on the transfer.

> Ok, we can drop the patch, as nobody complained about this until now. I can

TBH I've actually got it queued to apply and test, we can make things
better incrementally but it seems fine for now and it's backportable if
someone does run into trouble.

> work on a better approach. Are you saying that we should calibrate/adjust the
> maximum supported frequency on each operation/command? Most of the commands
> can work at the same frequency. I know an exception: on SPI NOR flashes, the

It's the way that everything else works.  It's a bit inefficent though.

> jesd216 standard specifies that the READ SFDP command should be run at 50MHz,
> even though the rest of the commands/opcodes can run at a higher frequency.
> It is common that flashes can run this command at 50+ MHz, and nobody bothered
> about adjusting the frequency at run-time until now. That being said, maybe we
> can calibrate/adjust a generic max frequency for most of the commands and
> treat the exceptions on a per operation basis.

If the spec says 50MHz for that one op we should probably stick to that
by default - the chances of it making a difference seem low but better
to stay in spec if we can.

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/SZf0ACgkQJNaLcl1U
h9A8nAf8DsnPV/slJruHMN4NMzGuJ7qZj/2TSZS3LxvSaIl5ottupNbWmXKwQxKn
OGommhk1DVNihHALOz+XOyorMgL7HJSaRSb152LGQr1pbpy7YcLmkauNsqoougzo
t1r3F/qqAgWnvUzj7KLXhShP7cPZCFQxIEfqaXDnconB7zqosfmFFTh66JyNhmwJ
KkWObRMIgJblJCACY8F6Xve4r9OOlt86iHKB663iNY72PEBwQaQIYTE96gHNf0mI
zVEqkUbKWufrTUDA2CsMAAV3annuAKM6rySuQ/6Mqg16xCejZnigGfo4zwaApl0T
86xO0M1HEjpypZneDn1gtniJT2+mlw==
=XJ24
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--
