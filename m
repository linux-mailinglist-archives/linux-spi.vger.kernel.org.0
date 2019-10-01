Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB950C304A
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfJAJeb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 05:34:31 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:58599 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfJAJeb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 05:34:31 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46jDcg6Kl0z1rh1N;
        Tue,  1 Oct 2019 11:34:27 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46jDcg5Tytz1qqkg;
        Tue,  1 Oct 2019 11:34:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id tsy_TKrL4bHL; Tue,  1 Oct 2019 11:34:26 +0200 (CEST)
X-Auth-Info: wHdtrZ7eEaIvMY+PQWDo/jAgayEP2yvkEtcM0nBf1Sc=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  1 Oct 2019 11:34:26 +0200 (CEST)
Date:   Tue, 1 Oct 2019 11:34:20 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] spi: Avoid calling spi_slave_abort() with kfreed spidev
Message-ID: <20191001113420.032dbfef@jawa>
In-Reply-To: <CAMuHMdWHTaPkzTdzz-j1rFeT=aAEG+J46fgKiPYrXoAR_DTvtQ@mail.gmail.com>
References: <20191001090657.25721-1-lukma@denx.de>
        <CAMuHMdWHTaPkzTdzz-j1rFeT=aAEG+J46fgKiPYrXoAR_DTvtQ@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/_NuMKD1CeMwaipxVqIJqYmB"; protocol="application/pgp-signature"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--Sig_/_NuMKD1CeMwaipxVqIJqYmB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for a very prompt response.

> Hi Lukasz,
>=20
> On Tue, Oct 1, 2019 at 11:07 AM Lukasz Majewski <lukma@denx.de> wrote:
> > Call spi_slave_abort() only when the spidev->spi is !NULL and the
> > structure hasn't already been kfreed.
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/spi/spidev.c
> > +++ b/drivers/spi/spidev.c
> > @@ -600,15 +600,16 @@ static int spidev_open(struct inode *inode,
> > struct file *filp) static int spidev_release(struct inode *inode,
> > struct file *filp) {
> >         struct spidev_data      *spidev;
> > +       int dofree; =20
>=20
> bool?

It may be bool, yes - I took this "int" from the original code (further
down in the patch), as I've moved it a bit up.

>=20
> >
> >         mutex_lock(&device_list_lock);
> >         spidev =3D filp->private_data;
> >         filp->private_data =3D NULL;
> > +       dofree =3D 0; =20
>=20
> Why not initialize it at declaration time?

I wanted to have it protected by mutex_lock() above. However, this also
shall work with the initialization at declaration time.

>=20
> >
> >         /* last close? */
> >         spidev->users--;
> >         if (!spidev->users) {
> > -               int             dofree;
> >
> >                 kfree(spidev->tx_buffer);
> >                 spidev->tx_buffer =3D NULL;
> > @@ -628,7 +629,8 @@ static int spidev_release(struct inode *inode,
> > struct file *filp) kfree(spidev);
> >         }
> >  #ifdef CONFIG_SPI_SLAVE
> > -       spi_slave_abort(spidev->spi);
> > +       if (!dofree)
> > +               spi_slave_abort(spidev->spi); =20
>=20
> Can spidev->spi be NULL, if spidev->users !=3D 0?

No, it shouldn't be.

The "dofree" is only set to true (the spidev->spi =3D=3D NULL condition is
checked) if there are no references (spidev->users =3D=3D 0).

The if (!dofree) prevents from calling spi_slave_abort() when
spidev->spi =3D=3D NULL and spidev is kfree'd.

>=20
> >  #endif
> >         mutex_unlock(&device_list_lock); =20
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/_NuMKD1CeMwaipxVqIJqYmB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2THZwACgkQAR8vZIA0
zr2dgAgA1S92SIco0K0aIQNe2B7Yy06PATAG039pcQIraWn4LPI1Ya7e7bwWJKHL
cB7ovrdc/ej+hoi2qfL2Pp0jyGeGAuysIRq2XRrP7O+ApaIwJuMU3rjQdsMDA/tD
z6grGAizrX+KnrpQRBIAVp+YDsvf34MEvQbPAefTaS8CQ9ynGrAV5SOBCcTEG5+o
PpK6WHAC8jstOjlObA5vzlR6vZUl17s5WulIJTUIHC267fFcMhiO8XRRQuvrWt+0
LiqdKUSWLexvX78BuJtcg9h+2FFDQMZU0ag2YSwpg5dY9wVDjiIq/ntgYVRBm3nA
pIVLYoErJUNMh9NEdFr540X8x5aE8A==
=BMNC
-----END PGP SIGNATURE-----

--Sig_/_NuMKD1CeMwaipxVqIJqYmB--
