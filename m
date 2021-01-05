Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2192EA90F
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 11:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbhAEKnR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 05:43:17 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:51692 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbhAEKnQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jan 2021 05:43:16 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 040721C0B7D; Tue,  5 Jan 2021 11:42:35 +0100 (CET)
Date:   Tue, 5 Jan 2021 11:42:34 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Pavel Machek <pavel@denx.de>, Mark Brown <broonie@kernel.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jiri Kosina <trivial@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>
Subject: Re: [PATCH 2/2] spi: rpc-if: Remove CONFIG_PM_SLEEP ifdefery
Message-ID: <20210105104234.GA29908@amd>
References: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201230145708.28544-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVCD52-eTnEwftGz8ExMkZkJRyM=3M8zU11yhn1UNPxxA@mail.gmail.com>
 <CA+V-a8tHVkGxCECspfcV9c1UW81bod4N4YzRLJwU8zJ0+awJUw@mail.gmail.com>
 <20210104213005.GK5645@sirena.org.uk>
 <20210104234018.GA19909@amd>
 <CAMuHMdUjevJ+DgJGnPUN0+ctxm2ML1NYSTgYsjC4c8tDqjUkxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUjevJ+DgJGnPUN0+ctxm2ML1NYSTgYsjC4c8tDqjUkxQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Tue, Jan 5, 2021 at 12:40 AM Pavel Machek <pavel@denx.de> wrote:
> > > > > >                 .name   =3D "rpc-if-spi",
> > > > > > -               .pm     =3D DEV_PM_OPS,
> > > > > > +               .pm     =3D &rpcif_spi_pm_ops,
> > >
> > > > > You're aware rpcif_spi_pm_ops is now always referenced and thus e=
mitted,
> > > > > increasing kernel size by 92 bytes if CONFIG_PM_SLEEP=3Dn?
> > > > > This may matter for RZ/A SoCs running from internal SRAM.
> > >
> > > > Hmm didn't realise this would be an issue on RZ/A.
> > >
> > > > Mark, could you please drop this patch from your branch.
> > >
> > > Please send an incremental patch with an appropriate changelog.
> >
> > Let's fix this properly. I'm pretty sure we have some macros that can
> > solve this without re-introducing the ifdefs...
>=20
> There's pm_ptr(), but it uses CONFIG_PM as a selector, not CONFIG_PM_SLEE=
P.

Okay; so we could introduce pm_sleep_ptr().

Or we could just put single #ifdef CONFIG_PM_SLEEP around the .pm
assignment? That would be improvement on the original, and still
result in the same binary, right?

> > (Besides... 92 bytes. How big is kernel these days? 4MB? More? How
> > much SRAM do you have?)
>=20
> 92 bytes is indeed not much (on 64-bit it would be doubled).
> Still, it's good to make people think about innocent looking changes,
> once in a while.
>=20
> RZ/A1H and RZ/A1M have 10 resp. 5 MiB of SRAM.
> RZ/A2 has 4 MiB SRAM, which is sufficient to run Linux when used with
> XIP (requires a one-line Kconfig change rmk has been vetoing for
 > years).

Aha, that is a bit smaller than I expected.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/0QpoACgkQMOfwapXb+vKbWgCgptuU+iF7DWVlD/RG7ZKYXcgm
SI8AoKMVB2V+RfTH4L+ahzlVFhP/HlNd
=29YJ
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
