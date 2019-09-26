Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF463BF354
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2019 14:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfIZMtW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Sep 2019 08:49:22 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:42317 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfIZMtW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Sep 2019 08:49:22 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46fF9p506vz1rLl7;
        Thu, 26 Sep 2019 14:49:18 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46fF9p4R3fz1qqkC;
        Thu, 26 Sep 2019 14:49:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id mj6C8m35U4jn; Thu, 26 Sep 2019 14:49:17 +0200 (CEST)
X-Auth-Info: MdsOK4uFv5BR+/mpn2P3RFb8Yfu7nrrDkPCW1OkUUmY=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 26 Sep 2019 14:49:17 +0200 (CEST)
Date:   Thu, 26 Sep 2019 14:49:08 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver
 is released
Message-ID: <20190926144342.327a3c66@jawa>
In-Reply-To: <CAMuHMdVBrKnA3TJnOEG0G0FVKf7VwQUvLzkmJc7DAX4kvHYWYQ@mail.gmail.com>
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
        <20190926121438.655f1f10@jawa>
        <CAMuHMdVBrKnA3TJnOEG0G0FVKf7VwQUvLzkmJc7DAX4kvHYWYQ@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UfJeLkvHfZKcV+qDFcF0LF4"; protocol="application/pgp-signature"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--Sig_/UfJeLkvHfZKcV+qDFcF0LF4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> Hi Lukasz,
>=20
> On Thu, Sep 26, 2019 at 12:14 PM Lukasz Majewski <lukma@denx.de>
> wrote:
> > > Static analysis with Coverity has detected an potential
> > > dereference of a free'd object with commit:
> > >
> > > commit 9f918a728cf86b2757b6a7025e1f46824bfe3155
> > > Author: Lukasz Majewski <lukma@denx.de>
> > > Date:   Wed Sep 25 11:11:42 2019 +0200
> > >
> > >     spi: Add call to spi_slave_abort() function when spidev
> > > driver is released
> > >
> > > In spidev_release() in drivers/spi/spidev.c the analysis is as
> > > follows:
> > >
> > > 600static int spidev_release(struct inode *inode, struct file
> > > *filp) 601{
> > > 602        struct spidev_data      *spidev;
> > > 603
> > > 604        mutex_lock(&device_list_lock);
> > >
> > >    1. alias: Assigning: spidev =3D filp->private_data. Now both
> > > point to the same storage.
> > >
> > > 605        spidev =3D filp->private_data;
> > > 606        filp->private_data =3D NULL;
> > > 607
> > > 608        /* last close? */
> > > 609        spidev->users--;
> > >
> > >    2. Condition !spidev->users, taking true branch.
> > >
> > > 610        if (!spidev->users) {
> > > 611                int             dofree;
> > > 612
> > > 613                kfree(spidev->tx_buffer);
> > > 614                spidev->tx_buffer =3D NULL;
> > > 615
> > > 616                kfree(spidev->rx_buffer);
> > > 617                spidev->rx_buffer =3D NULL;
> > > 618
> > > 619                spin_lock_irq(&spidev->spi_lock);
> > >
> > >    3. Condition spidev->spi, taking false branch.
> > >
> > > 620                if (spidev->spi)
> > > 621                        spidev->speed_hz =3D
> > > spidev->spi->max_speed_hz; 622
> > > 623                /* ... after we unbound from the underlying
> > > device? */
> > >
> > >    4. Condition spidev->spi =3D=3D NULL, taking true branch.
> > >
> > > 624                dofree =3D (spidev->spi =3D=3D NULL);
> > > 625                spin_unlock_irq(&spidev->spi_lock);
> > > 626
> > >
> > >    5. Condition dofree, taking true branch.
> > >
> > > 627                if (dofree)
> > >
> > >    6. freed_arg: kfree frees spidev.
> > >
> > > 628                        kfree(spidev);
> > > 629        }
> > > 630#ifdef CONFIG_SPI_SLAVE
> > >
> > >    CID 89726 (#1 of 1): Read from pointer after free
> > > (USE_AFTER_FREE) 7. deref_after_free: Dereferencing freed pointer
> > > spidev.
> > >
> > > 631        spi_slave_abort(spidev->spi);
> > > 632#endif
> > > 633        mutex_unlock(&device_list_lock);
> > > 634
> > > 635        return 0;
> > > 636}
> > >
> > > The call to spi_slave_abort() on spidev is reading an earlier
> > > kfree'd spidev. =20
> >
> > Thanks for spotting this issue - indeed there is a possibility to
> > use spidev after being kfree'd. =20
>=20
> Worse, this makes me realize spidev->spi may be a NULL pointer, which
> will be dereferenced by spi_slave_abort(), so caching it before the
> call to kfree() won't work.
>=20

The patch as it is now can be fixed as follows:

static int spidev_release(struct inode *inode, struct file *filp)
{
	struct spidev_data	*spidev;

	mutex_lock(&device_list_lock);
	spidev =3D filp->private_data;
	filp->private_data =3D NULL;

#ifdef CONFIG_SPI_SLAVE
	if (spidev->spi)
		spi_slave_abort(spidev->spi);
#endif

	/* last close? */
	spidev->users--;
	if (!spidev->users) {
		int dofree;

		/* free buffers */

		spin_lock_irq(&spidev->spi_lock);
		if (spidev->spi)
			spidev->speed_hz =3D spidev->spi->max_speed_hz;

		/* ... after we unbound from the underlying device? */
		//
		// [*]
		//
		dofree =3D (spidev->spi =3D=3D NULL);
		spin_unlock_irq(&spidev->spi_lock);

		if (dofree)
			kfree(spidev);
	}

	mutex_unlock(&device_list_lock);

	return 0;
}

The question is if we shall call the spi_slave_abort() when cleaning up
spi after releasing last reference, or each time release callback is
called ?

> > However, Geert (CC'ed) had some questions about placement of this
> > function call, so I will wait with providing fix until he replies. =20
>=20
> Seems like this needs more thought...

Could you be more specific?=20

Do you mean to move the spi_slave_abort() call just before dofree
evaluation ? ([*]).

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

--Sig_/UfJeLkvHfZKcV+qDFcF0LF4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2Ms8QACgkQAR8vZIA0
zr29dAgAhLnHUyReAqSs/S5HMJMiLJqfq51KXKU2fcLheawsyLGj9IYMAmGayIb/
b1GC1pS+2xsu59Rcy8z0EerEuesFmM7Ij72yur92LodZgY/fvilWxyJ4tVaJZU6p
6rpPyGwxhbLEyovxhyKyBcZ1orAY++Pm+e5g+r+dipFKvLaAEKfMj2K4OwhZ2QvY
TJusa1UdRldT5ZY0WIXGQ4L+ctNq04HX2UVOiFNUuLzKWQb2Ix8z7Tu/sdimcTqK
FkgFrHrCp5wdWsNJLojhSvgSp9Bl3P1hTgu41J5eEI3XAgNJYultbLKl6+/nGTEI
fdaFXTfzPpE0d+8ZLY8GGXnNHWDQjA==
=LkCd
-----END PGP SIGNATURE-----

--Sig_/UfJeLkvHfZKcV+qDFcF0LF4--
