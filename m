Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F421BF81E
	for <lists+linux-spi@lfdr.de>; Thu, 30 Apr 2020 14:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgD3MT3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Apr 2020 08:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgD3MT3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Apr 2020 08:19:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDAE92076D;
        Thu, 30 Apr 2020 12:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588249169;
        bh=N9rKaTsZFrUvyvsuP9lOc4Wzmprx5voNQJlTVM2rGf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUAkY5ypXbCmOb1J6dz7spcNrSx8SjCBuT8ha4oxfvY5gTGWEPVdtk14Hpg+O4PBl
         Qj/56KbHndZm/zVKyt3Sn42jlYyvBevEtJJdc2RAZYMcLcdX91zOnVrswvPKexje0u
         4TPMM4s4MnfBnUOCPqX9zSl5uoEUM+0WfU7etRYE=
Date:   Thu, 30 Apr 2020 13:19:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v4 02/16] spi: atmel-quadspi: reject DTR ops
Message-ID: <20200430121926.GC4633@sirena.org.uk>
References: <20200424184410.8578-1-p.yadav@ti.com>
 <20200424184410.8578-3-p.yadav@ti.com>
 <20200430113243.GB4633@sirena.org.uk>
 <20200430121737.37dghomlluzqcxxi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
In-Reply-To: <20200430121737.37dghomlluzqcxxi@ti.com>
X-Cookie: Sign here without admitting guilt.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2020 at 05:47:39PM +0530, Pratyush Yadav wrote:

> Most other controllers either don't specify a supports_op function at=20
> all, in which case spi_mem_default_supports_op() is called, or do their=
=20
> custom logic and then call spi_mem_default_supports_op(). In both those=
=20
> cases, DTR ops would get rejected because of the call to=20
> spi_mem_default_supports_op(). So they do not need to add the check=20
> explicitly there.

> The two exceptions are atmel-quadspi and spi-mtk-nor (which I missed=20
> updating). They don't call the default supports_op, so they need to be=20
> updated to explicitly to reject DTR ops.

OK.

> Earlier versions of this series discovered the DTR capability from=20
> devicetree. In that case, no change would be required at all, but review=
=20
> comments suggested I drop those changes. Instead, the controllers should=
=20
> accept/reject DTR ops in their supports_op hooks.

It definitely shouldn't be in device tree, this is something that the
silicon supports so we should already be able to figure out if we can
use it with just the compatible.

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6qwk0ACgkQJNaLcl1U
h9CGPQf/RnFFO+2GEO20wzuUOjiIgXpgOfBnSKgMTXOWAmba2YafGkKYwsymVpGY
zt5Q9vkcx9dsgudhY892WkRo/l9+xJOkSYbp38ld0QR+YNfXbPUPeuvhK2F39YTJ
YjMbZw8hbYyMqF+yXbJXJrj7PGbu9ISesfBgC73i3ywZC8S9epUKQZp7HssURy/M
GJEMzoM40Vam/V48VAPrMHa0Dut9Bum74W9jzW5Fpnxz00AkY47aeMzGSOD+IyHD
zP97bFTE4NUym4FES9c9efA61FuUJxOK8YRN5Hmfn22BwxxQ6ZT1B+7jRv+Fj32J
GfvAqmI+mYhLpW/bHI7PCh/eP/eO0g==
=dS3u
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
