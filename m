Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43D5BECFB
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2019 09:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfIZH7r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Sep 2019 03:59:47 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54771 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbfIZH7r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Sep 2019 03:59:47 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46f6lh06K4z1rQYn;
        Thu, 26 Sep 2019 09:59:43 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46f6lg6YKtz1qqkL;
        Thu, 26 Sep 2019 09:59:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 0ZxA9ZV_k4tv; Thu, 26 Sep 2019 09:59:42 +0200 (CEST)
X-Auth-Info: HfnPDiM+3Ll2KMuyM8YcqLFRGVX3LUDByNYxi9mVV+w=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 26 Sep 2019 09:59:42 +0200 (CEST)
Date:   Thu, 26 Sep 2019 09:59:41 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] spi: Add call to spi_slave_abort() function when
 spidev driver is released
Message-ID: <20190926095941.0615f335@jawa>
In-Reply-To: <CAMuHMdXseZppE74D8XW=5ZWNNNLXZFLTSiqqe_qoZ8C1rAFQSg@mail.gmail.com>
References: <20190924110547.14770-1-lukma@denx.de>
        <20190924110547.14770-2-lukma@denx.de>
        <CAMuHMdXseZppE74D8XW=5ZWNNNLXZFLTSiqqe_qoZ8C1rAFQSg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5s0ODXtpIoabspOUcWPgLRh"; protocol="application/pgp-signature"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--Sig_/5s0ODXtpIoabspOUcWPgLRh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> Hi Lukasz,
>=20
> On Thu, Sep 26, 2019 at 3:33 AM Lukasz Majewski <lukma@denx.de> wrote:
> > This change is necessary for spidev devices (e.g. /dev/spidev3.0)
> > working in the slave mode (like NXP's dspi driver for Vybrid SoC).
> >
> > When SPI HW works in this mode - the master is responsible for
> > providing CS and CLK signals. However, when some fault happens -
> > like for example distortion on SPI lines - the SPI Linux driver
> > needs a chance to recover from this abnormal situation and prepare
> > itself for next (correct) transmission.
> >
> > This change doesn't pose any threat on drivers working in master
> > mode as spi_slave_abort() function checks if SPI slave mode is
> > supported.
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> Thanks for your patch!
>=20
> Yesterday I saw this appear on spi/for-next, but I couldn't find the
> email in my mbox.  Today it has arrived. Looks like gmail had some
> troubles ("Delivered after 138401 seconds", ugh).

I've already sent v2 of this patch, as Intel Linux test setup spot the
error with lack of #define guards.

>=20
> > --- a/drivers/spi/spidev.c
> > +++ b/drivers/spi/spidev.c
> > @@ -627,6 +627,7 @@ static int spidev_release(struct inode *inode,
> > struct file *filp) if (dofree)
> >                         kfree(spidev);
> >         }
> > +       spi_slave_abort(spidev->spi); =20
>=20
> Looks good to me.  Just wondering if this should be done for the last
> user only, i.e. in the "if" block above, like resetting speed_hz?

I also thought about this. However, from my use case the user must end
the transmission with CTRL+C on his user space program, which in turn
communicate via SPI with /dev/spidev3.0.

There might be many (potential) programs using the /dev/spidev3.0 at the
same time, so the usage count may be not one.

For the above reason I've moved it outside the above if().

>=20
> >         mutex_unlock(&device_list_lock);
> >
> >         return 0; =20
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

--Sig_/5s0ODXtpIoabspOUcWPgLRh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2Mb+0ACgkQAR8vZIA0
zr18ogf+Nkm6YALkd0PZS43sKVKplV00GjN15f39tfe1iYqHDzToQk2HTKQgJYFJ
q713F216HIdJTpNDTpc+EZkMARIlPAAse5HphE0WIUUk41ZW6Gi038tJtzrgJFRF
xkgQSVPFy3mIfheTBenYzYgvF0CKCDl0hOScBsmXoYQ4A6doQXZoniENZp1f3ybc
vb+ruj9PjepQyp/jHjYO7KiQC9nPY+azM3qkp8AHkYXY9iN3SnIrFg5hqCE2zSnZ
NyCgt+380i6WlXpLua0oxvp5ypxSbufWFkKjIo0mjU67A/cgWe1WUZWCIkrG+J+y
Y/g3fKvcaeW6LwWO5Jc67yBQ3HQm2g==
=cdef
-----END PGP SIGNATURE-----

--Sig_/5s0ODXtpIoabspOUcWPgLRh--
