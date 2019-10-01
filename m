Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37CBEC31FF
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 13:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfJALH0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 07:07:26 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:44334 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbfJALH0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 07:07:26 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46jGgs6lMMz1rhsg;
        Tue,  1 Oct 2019 13:07:21 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46jGgs5ZDDz1qql3;
        Tue,  1 Oct 2019 13:07:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id FEVJJvJNUS56; Tue,  1 Oct 2019 13:07:19 +0200 (CEST)
X-Auth-Info: 93MR/orNrEe2jhKJjzkEZxd48FBIEA3YGLYZuH1w+pY=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  1 Oct 2019 13:07:19 +0200 (CEST)
Date:   Tue, 1 Oct 2019 13:07:13 +0200
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
Message-ID: <20191001130713.6eafb728@jawa>
In-Reply-To: <CAMuHMdWh7xPZqp4J1qG22dXk_g=Q1WtQ9Xu-r3wiFOL3kW+WBg@mail.gmail.com>
References: <20191001090657.25721-1-lukma@denx.de>
        <CAMuHMdWHTaPkzTdzz-j1rFeT=aAEG+J46fgKiPYrXoAR_DTvtQ@mail.gmail.com>
        <20191001113420.032dbfef@jawa>
        <CAMuHMdWh7xPZqp4J1qG22dXk_g=Q1WtQ9Xu-r3wiFOL3kW+WBg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/BmcV7SX+cE.Huey1lpa1dZL"; protocol="application/pgp-signature"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--Sig_/BmcV7SX+cE.Huey1lpa1dZL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> Hi Lukasz,
>=20
> On Tue, Oct 1, 2019 at 11:34 AM Lukasz Majewski <lukma@denx.de> wrote:
> > > On Tue, Oct 1, 2019 at 11:07 AM Lukasz Majewski <lukma@denx.de>
> > > wrote: =20
> > > > Call spi_slave_abort() only when the spidev->spi is !NULL and
> > > > the structure hasn't already been kfreed.
> > > >
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> > > > --- a/drivers/spi/spidev.c
> > > > +++ b/drivers/spi/spidev.c
> > > > @@ -600,15 +600,16 @@ static int spidev_open(struct inode
> > > > *inode, struct file *filp) static int spidev_release(struct
> > > > inode *inode, struct file *filp) {
> > > >         struct spidev_data      *spidev;
> > > > +       int dofree;
> > > >
> > > >         mutex_lock(&device_list_lock);
> > > >         spidev =3D filp->private_data;
> > > >         filp->private_data =3D NULL;
> > > > +       dofree =3D 0;
> > > >
> > > >         /* last close? */
> > > >         spidev->users--;
> > > >         if (!spidev->users) {
> > > > -               int             dofree;
> > > >
> > > >                 kfree(spidev->tx_buffer);
> > > >                 spidev->tx_buffer =3D NULL;
> > > > @@ -628,7 +629,8 @@ static int spidev_release(struct inode
> > > > *inode, struct file *filp) kfree(spidev);
> > > >         }
> > > >  #ifdef CONFIG_SPI_SLAVE
> > > > -       spi_slave_abort(spidev->spi);
> > > > +       if (!dofree)
> > > > +               spi_slave_abort(spidev->spi); =20
> > >
> > > Can spidev->spi be NULL, if spidev->users !=3D 0? =20
> >
> > No, it shouldn't be.
> >
> > The "dofree" is only set to true (the spidev->spi =3D=3D NULL condition
> > is checked) if there are no references (spidev->users =3D=3D 0).
> >
> > The if (!dofree) prevents from calling spi_slave_abort() when
> > spidev->spi =3D=3D NULL and spidev is kfree'd. =20
>=20
> If spidev->users !=3D 0, the block checking spidev->spi =3D=3D NULL is ne=
ver
> executed, and spi_slave_abort() will be called.

Yes, this is correct. My other patch [1] clears the FIFOs in SPI IP
block and ends (if there are any stalled) DMA transactions.

>=20
> I'm wondering if spidev->spi can be NULL if spidev->users is still
> positive.

I think that it cannot.

=46rom my tests [2] - when I do enter spi_slave_abort() function the state
of
spidev->users: 0 dofree: 0 spidev->spi: 0x51337072

So it is possible to call the spidev_release without previously setting
spidev->spi to NULL (which is done in spidev_remove() function).

IMHO the above behavior also seems to be correct, as during distortion
the slave losts synchronization from master.

The spidev_remove() callback is part of spi_device struct and is
called when the device is removed (rmmod spi_fsl_dspi).

=46rom my tests the spidev_release() is NOT called after spidev_remove(),
so the code in former seems to be a dead one.

Or maybe there is an use case which causes calling spidev_release()
after spidev_remove()?

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20

Note:

[1] - https://lkml.org/lkml/2019/9/24/245
[2] -
https://github.com/lmajewski/tests-spi/blob/master/tests/spi/spi_tests.sh

HW setup:  HW loopback with two /dev/spidevX.Y devices used

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/BmcV7SX+cE.Huey1lpa1dZL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2TM2EACgkQAR8vZIA0
zr22NQf/R5mfFd/b6MTcfGxaoSiilulAObqBQ/0HBVTAQFbBK0EFU2/b3Jgoy0Nu
NaGoOOT/hHUAmVf9oZR1h5FsdV0rzSG/jbSkOMA+uN+7QlhlwqaBg4BWanrPcSEi
xpP7gsbTPj+yiDDtdRoUDxz5P+TMvaf/DrLPn6fkau+YpPAzGTy1AYkdXbDp19SY
EoJjxBet0qDfK4/r7hssANNvT2iAeF4jInswxhtjFR8+WN8tT69kOP1n+skXN7eH
hbNn7ghgjNsos+iT+kWLOvdr6vdjR6eh1fCEdZwYhKbyyoMHgnZAicC1tA5TDWqR
70fH/6TXos2MgYjiLYpq2GgzAQUgSg==
=JhoH
-----END PGP SIGNATURE-----

--Sig_/BmcV7SX+cE.Huey1lpa1dZL--
