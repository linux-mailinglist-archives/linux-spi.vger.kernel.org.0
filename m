Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC332EA102
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 00:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbhADXlC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 18:41:02 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:33560 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbhADXlC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 18:41:02 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EE78A1C0B8C; Tue,  5 Jan 2021 00:40:18 +0100 (CET)
Date:   Tue, 5 Jan 2021 00:40:18 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pavel Machek <pavel@denx.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jiri Kosina <trivial@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>
Subject: Re: [PATCH 2/2] spi: rpc-if: Remove CONFIG_PM_SLEEP ifdefery
Message-ID: <20210104234018.GA19909@amd>
References: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201230145708.28544-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVCD52-eTnEwftGz8ExMkZkJRyM=3M8zU11yhn1UNPxxA@mail.gmail.com>
 <CA+V-a8tHVkGxCECspfcV9c1UW81bod4N4YzRLJwU8zJ0+awJUw@mail.gmail.com>
 <20210104213005.GK5645@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20210104213005.GK5645@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > >                 .name   =3D "rpc-if-spi",
> > > > -               .pm     =3D DEV_PM_OPS,
> > > > +               .pm     =3D &rpcif_spi_pm_ops,
>=20
> > > You're aware rpcif_spi_pm_ops is now always referenced and thus emitt=
ed,
> > > increasing kernel size by 92 bytes if CONFIG_PM_SLEEP=3Dn?
> > > This may matter for RZ/A SoCs running from internal SRAM.
>=20
> > Hmm didn't realise this would be an issue on RZ/A.
>=20
> > Mark, could you please drop this patch from your branch.
>=20
> Please send an incremental patch with an appropriate changelog.

Let's fix this properly. I'm pretty sure we have some macros that can
solve this without re-introducing the ifdefs...

(Besides... 92 bytes. How big is kernel these days? 4MB? More? How
much SRAM do you have?)

Best regards,
								Pavel


--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/zp2IACgkQMOfwapXb+vIUvwCeNviCDHyH2Q1jICAEtksWQ/tu
seIAoIyfFO9DveDWbCBw43VUCXnqmAMV
=Q+pX
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
