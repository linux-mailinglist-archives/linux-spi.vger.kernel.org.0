Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC44ABEF5A
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2019 12:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfIZKOu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Sep 2019 06:14:50 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:39560 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZKOt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Sep 2019 06:14:49 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46f9lT5NQ4z1rGRZ;
        Thu, 26 Sep 2019 12:14:45 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46f9lT4q9Mz1qqkT;
        Thu, 26 Sep 2019 12:14:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id zmy4OmtRTKzy; Thu, 26 Sep 2019 12:14:44 +0200 (CEST)
X-Auth-Info: BM3VhxhFj1lMlfukQ1+SR5/+hPqY5KoiiWFeZ+N4+d4=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 26 Sep 2019 12:14:44 +0200 (CEST)
Date:   Thu, 26 Sep 2019 12:14:38 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver
 is released
Message-ID: <20190926121438.655f1f10@jawa>
In-Reply-To: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/X=HjYTciBWNPBESkWNyLgtO"; protocol="application/pgp-signature"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--Sig_/X=HjYTciBWNPBESkWNyLgtO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Colin,

> Hi,
>=20
> Static analysis with Coverity has detected an potential dereference
> of a free'd object with commit:
>=20
> commit 9f918a728cf86b2757b6a7025e1f46824bfe3155
> Author: Lukasz Majewski <lukma@denx.de>
> Date:   Wed Sep 25 11:11:42 2019 +0200
>=20
>     spi: Add call to spi_slave_abort() function when spidev driver is
> released
>=20
> In spidev_release() in drivers/spi/spidev.c the analysis is as
> follows:
>=20
> 600static int spidev_release(struct inode *inode, struct file *filp)
> 601{
> 602        struct spidev_data      *spidev;
> 603
> 604        mutex_lock(&device_list_lock);
>=20
>    1. alias: Assigning: spidev =3D filp->private_data. Now both point to
> the same storage.
>=20
> 605        spidev =3D filp->private_data;
> 606        filp->private_data =3D NULL;
> 607
> 608        /* last close? */
> 609        spidev->users--;
>=20
>    2. Condition !spidev->users, taking true branch.
>=20
> 610        if (!spidev->users) {
> 611                int             dofree;
> 612
> 613                kfree(spidev->tx_buffer);
> 614                spidev->tx_buffer =3D NULL;
> 615
> 616                kfree(spidev->rx_buffer);
> 617                spidev->rx_buffer =3D NULL;
> 618
> 619                spin_lock_irq(&spidev->spi_lock);
>=20
>    3. Condition spidev->spi, taking false branch.
>=20
> 620                if (spidev->spi)
> 621                        spidev->speed_hz =3D
> spidev->spi->max_speed_hz; 622
> 623                /* ... after we unbound from the underlying
> device? */
>=20
>    4. Condition spidev->spi =3D=3D NULL, taking true branch.
>=20
> 624                dofree =3D (spidev->spi =3D=3D NULL);
> 625                spin_unlock_irq(&spidev->spi_lock);
> 626
>=20
>    5. Condition dofree, taking true branch.
>=20
> 627                if (dofree)
>=20
>    6. freed_arg: kfree frees spidev.
>=20
> 628                        kfree(spidev);
> 629        }
> 630#ifdef CONFIG_SPI_SLAVE
>=20
>    CID 89726 (#1 of 1): Read from pointer after free (USE_AFTER_FREE)
> 7. deref_after_free: Dereferencing freed pointer spidev.
>=20
> 631        spi_slave_abort(spidev->spi);
> 632#endif
> 633        mutex_unlock(&device_list_lock);
> 634
> 635        return 0;
> 636}
>=20
> The call to spi_slave_abort() on spidev is reading an earlier kfree'd
> spidev.

Thanks for spotting this issue - indeed there is a possibility to use
spidev after being kfree'd.=20

However, Geert (CC'ed) had some questions about placement of this
function call, so I will wait with providing fix until he replies.

>=20
> Colin
>=20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/X=HjYTciBWNPBESkWNyLgtO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2Mj44ACgkQAR8vZIA0
zr2RVAf/RsM6loK8yXKEEfi1JBemrB194ucZYBOo+tmulnC7ev/KXq/BD8yWMjoj
9UqkU8imI1AWUtOs87oti6OV0vxW818mEG/jEahTnpOgOOj7K7yhWZfGQvCHQtTs
iFm5gubARdK+68E9iPd7TNA1q/fYwg5WRl9PyDFJL9jliTLfi3XK5NyTENbQ3buW
qEEj2M6VOoj+AONMMwoRJX9t/xOzkMW+Mxv/SD7ulJPF9M8ABTPxsQ8wyJsDMKvx
kZJry+6sl7jbHHPYrVFW6snT+RXhsg++NsWJy4dUq7TMc9baaFyvnDTZD0Owok6v
KJKLNCjZp1bH8WkrnHyo9yfSVH8Czg==
=8gl2
-----END PGP SIGNATURE-----

--Sig_/X=HjYTciBWNPBESkWNyLgtO--
