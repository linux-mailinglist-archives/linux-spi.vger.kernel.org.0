Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB782BB002
	for <lists+linux-spi@lfdr.de>; Fri, 20 Nov 2020 17:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgKTQS4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Nov 2020 11:18:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:54946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729444AbgKTQSz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A298ACC6;
        Fri, 20 Nov 2020 16:18:54 +0000 (UTC)
Message-ID: <2b7f555bee663a033e2e8fc50f019c9b580a7c66.camel@suse.de>
Subject: Re: [PATCH v5 2/2] spi: Add generic SPI multiplexer
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Date:   Fri, 20 Nov 2020 17:18:50 +0100
In-Reply-To: <104152dd-a51e-1893-cc6b-022aecd89250@alliedtelesis.co.nz>
References: <20200204032838.20739-3-chris.packham@alliedtelesis.co.nz>
         <20201113154633.21542-1-nsaenzjulienne@suse.de>
         <104152dd-a51e-1893-cc6b-022aecd89250@alliedtelesis.co.nz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-nPpUsDmncpRH0ei3magB"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--=-nPpUsDmncpRH0ei3magB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-11-17 at 00:08 +0000, Chris Packham wrote:
> On 14/11/20 4:46 am, Nicolas Saenz Julienne wrote:
> > Upon registering spi-mux's devices through spi_add_device() the kernel =
gets
> > stuck waiting for the 'spi_add_lock' mutex to be released. The mutex ha=
ppens to
> > be held by spi-mux's parent SPI bus, which unluckily, is waiting for sp=
i-mux's
> > probe to finish before releasing it.
>=20
> I just re-tested my system with v5.10.0-rc4 and didn't see any problem.=
=20
> My dts is pretty similar to yours the only obvious thing missing is=20
> `mux-control-names =3D "spi";` and I also set `#size-cells =3D <1>;` (let=
 me=20
> know if you want me to post the whole thing).
>=20
> It might be dependent on the host spi controller. The re-test I just did=
=20
> was on a board using the spi-orion.c driver and I tested my original=20
> change on a board using spi-bcm-qspi.c (I haven't got the board handy=20
> right now but I could go and find one if necessary).

Found the issue, something silly on my side. Sorry for the noise.

Regards,
Nicolas


--=-nPpUsDmncpRH0ei3magB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+37GoACgkQlfZmHno8
x/5GZgf/R2nkIl4aPSZPwKJzMdQQE60+w/KbP6MCNKterlddKumSwb5DnIEWXyil
s/OeckEQUlZ5V09WUnPkNlARrH6tZDYWQLboQEpYReSWeLmvgcSHCp7PYBU/rXj8
gqtkTd5AK8EFhZQUOHNQsG3O9VeB7GvNXrWuqOjciDiMmoPfe443na1T97R2K9Fj
K3Fmj/2bNz52+9C99ZDCvxEurco91atavZvzpcJ5ISaTHOeJE5XZ2yyrJBcGNMZT
uHDgDku+o61+ZoeWGz6HYUFp/ec6Da2JPhdsZ2U0cgruhUKpa7RHzNjqlkmdz8fL
SjWiw1/Cci3o6sfAwjQjQ7MRUh8KYQ==
=sdk7
-----END PGP SIGNATURE-----

--=-nPpUsDmncpRH0ei3magB--

