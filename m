Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA9EBF4AA
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2019 16:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfIZOG4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Sep 2019 10:06:56 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:44225 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfIZOG4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Sep 2019 10:06:56 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46fGvJ6qtLz1rNln;
        Thu, 26 Sep 2019 16:06:52 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46fGvJ5ddSz1qqkC;
        Thu, 26 Sep 2019 16:06:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Z7Tgw-1r7UsK; Thu, 26 Sep 2019 16:06:51 +0200 (CEST)
X-Auth-Info: 51HmMqjBpiy3aS367YdzrQvJGvdgYQ+A0+Sxw0fOkhI=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 26 Sep 2019 16:06:51 +0200 (CEST)
Date:   Thu, 26 Sep 2019 16:06:45 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver
 is released
Message-ID: <20190926160645.0a2623fa@jawa>
In-Reply-To: <CAMuHMdXm+vUB4iRTsTq64Kg2KC2p7AA1TwFgjc7FuCeiS9EG=Q@mail.gmail.com>
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
        <20190926121438.655f1f10@jawa>
        <CAMuHMdVBrKnA3TJnOEG0G0FVKf7VwQUvLzkmJc7DAX4kvHYWYQ@mail.gmail.com>
        <20190926144342.327a3c66@jawa>
        <CAMuHMdXm+vUB4iRTsTq64Kg2KC2p7AA1TwFgjc7FuCeiS9EG=Q@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qY5Xd/6oAmzfMIHDKk1fXdK"; protocol="application/pgp-signature"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--Sig_/qY5Xd/6oAmzfMIHDKk1fXdK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> Hi Lukasz,
>=20
> On Thu, Sep 26, 2019 at 2:49 PM Lukasz Majewski <lukma@denx.de> wrote:
> > > On Thu, Sep 26, 2019 at 12:14 PM Lukasz Majewski <lukma@denx.de>
> > > wrote: =20
> > > > > Static analysis with Coverity has detected an potential
> > > > > dereference of a free'd object with commit:
> > > > >
> > > > > commit 9f918a728cf86b2757b6a7025e1f46824bfe3155
> > > > > Author: Lukasz Majewski <lukma@denx.de>
> > > > > Date:   Wed Sep 25 11:11:42 2019 +0200
> > > > >
> > > > >     spi: Add call to spi_slave_abort() function when spidev
> > > > > driver is released =20
>=20
> > > > > The call to spi_slave_abort() on spidev is reading an earlier
> > > > > kfree'd spidev. =20
> > > >
> > > > Thanks for spotting this issue - indeed there is a possibility
> > > > to use spidev after being kfree'd. =20
> > >
> > > Worse, this makes me realize spidev->spi may be a NULL pointer,
> > > which will be dereferenced by spi_slave_abort(), so caching it
> > > before the call to kfree() won't work. =20
> >
> > The patch as it is now can be fixed as follows:
> >
> > static int spidev_release(struct inode *inode, struct file *filp)
> > {
> >         struct spidev_data      *spidev;
> >
> >         mutex_lock(&device_list_lock);
> >         spidev =3D filp->private_data;
> >         filp->private_data =3D NULL;
> >
> > #ifdef CONFIG_SPI_SLAVE
> >         if (spidev->spi)
> >                 spi_slave_abort(spidev->spi);
> > #endif
> >
> >         /* last close? */
> >         spidev->users--;
> >         if (!spidev->users) {
> >                 int dofree;
> >
> >                 /* free buffers */
> >
> >                 spin_lock_irq(&spidev->spi_lock);
> >                 if (spidev->spi)
> >                         spidev->speed_hz =3D
> > spidev->spi->max_speed_hz;
> >
> >                 /* ... after we unbound from the underlying device?
> > */ //
> >                 // [*]
> >                 //
> >                 dofree =3D (spidev->spi =3D=3D NULL);
> >                 spin_unlock_irq(&spidev->spi_lock);
> >
> >                 if (dofree)
> >                         kfree(spidev);
> >         }
> >
> >         mutex_unlock(&device_list_lock);
> >
> >         return 0;
> > }
> >
> > The question is if we shall call the spi_slave_abort() when
> > cleaning up spi after releasing last reference, or each time
> > release callback is called ? =20
>=20
> TBH, I don't know.  Is it realistic that there are multiple opens?

I'm using on my setup only one test program to use /dev/spidevX.Y and
/dev/spidevA.B (loopback with wired connection).

However, you also shall be able to connect via ssh and run the same
setup in parallel...

>=20
> > > > However, Geert (CC'ed) had some questions about placement of
> > > > this function call, so I will wait with providing fix until he
> > > > replies. =20
> > >
> > > Seems like this needs more thought... =20
> >
> > Could you be more specific?
> >
> > Do you mean to move the spi_slave_abort() call just before dofree
> > evaluation ? ([*]). =20
>=20
> That means the abort is called only for the last user.
> And only if the underlying device still exists.  Which means that if
> it has disappeared (how can that happen? spidev unbind?),

In my case, I just disconnect some SPI signals and the test program
just hangs. I do need to ctrl+c to stop it (or use timeout).=20

=46rom my debugging the .release callback is called each time the program
is aborted (either with ctrl+c or timeout).

> the slave
> was never aborted.  Non-spidev slaves can do the abort in their
> .remove() callbacks (at least my two sample slave drivers do).
> So probably we need some explicit slave abort in the unbind case too?

As I've described above - after "introducing" distortion to SPI I need
to explicitly exit the hung test program with ctrl+c.

>=20
> The more I think about it, the more things I see that can go wrong...

But for now we don't have any way to recover the slave after corruption
on SPI transmission.

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

--Sig_/qY5Xd/6oAmzfMIHDKk1fXdK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2MxfUACgkQAR8vZIA0
zr3DDgf+MWqRy795Uik8aTrn7+/AJuNiE9oDqYMkwtZTKgoJBilhge+0b1q8pmxa
GstRKQEUh+jWPubA9SqbS9M8JbiNmGGQ3aSsrEXuZdMKHzstmZkGoIa4ZVSy3PSm
LHMXMPO70DagZ11cLqaQqDdsJHUz70hjaSsCuePRuJ6UUegTLQqA6VfVhZapqjp0
eQWyDAKMKnzoUlhWZa8JMdKaxhjyUcy86dzwLCwrfW9bCxakPCfQGd/LzTv8k+Nl
FSck+eZOME1JyGO8pyeq0aq0xT8USFI5PXFJngdzWoBp0TO5VM/bTir2SuYy/83a
m/js7DiymW2nLi+TpXJTv4eDfJQ8EA==
=VxiE
-----END PGP SIGNATURE-----

--Sig_/qY5Xd/6oAmzfMIHDKk1fXdK--
