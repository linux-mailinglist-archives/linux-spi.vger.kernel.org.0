Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 243CDBFB55
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2019 00:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfIZWiz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Sep 2019 18:38:55 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:37737 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfIZWiz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Sep 2019 18:38:55 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46fVG32DL0z1rHDN;
        Fri, 27 Sep 2019 00:38:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46fVG31ZWQz1qqkK;
        Fri, 27 Sep 2019 00:38:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id eoUNuvpdoF09; Fri, 27 Sep 2019 00:38:50 +0200 (CEST)
X-Auth-Info: T4gi+k/J81z1w6C5CCVuXCM2o5ZnJe6B4J3WO0ShyCU=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 27 Sep 2019 00:38:50 +0200 (CEST)
Date:   Fri, 27 Sep 2019 00:38:49 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver
 is released
Message-ID: <20190927003849.0c9e4335@jawa>
In-Reply-To: <20190926151752.GU2036@sirena.org.uk>
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
        <20190926121438.655f1f10@jawa>
        <CAMuHMdVBrKnA3TJnOEG0G0FVKf7VwQUvLzkmJc7DAX4kvHYWYQ@mail.gmail.com>
        <20190926144342.327a3c66@jawa>
        <CAMuHMdXm+vUB4iRTsTq64Kg2KC2p7AA1TwFgjc7FuCeiS9EG=Q@mail.gmail.com>
        <20190926160645.0a2623fa@jawa>
        <20190926151752.GU2036@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MWul8reh.Rz47nd.lOSx1tl"; protocol="application/pgp-signature"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--Sig_/MWul8reh.Rz47nd.lOSx1tl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark, Geert,

> On Thu, Sep 26, 2019 at 04:06:45PM +0200, Lukasz Majewski wrote:
> > > On Thu, Sep 26, 2019 at 2:49 PM Lukasz Majewski <lukma@denx.de>
> > > wrote: =20
>=20
> > > > The question is if we shall call the spi_slave_abort() when
> > > > cleaning up spi after releasing last reference, or each time
> > > > release callback is called ?   =20
>=20
> > > TBH, I don't know.  Is it realistic that there are multiple
> > > opens? =20
>=20
> > I'm using on my setup only one test program to use /dev/spidevX.Y
> > and /dev/spidevA.B (loopback with wired connection). =20
>=20
> > However, you also shall be able to connect via ssh and run the same
> > setup in parallel... =20
>=20
> It doesn't seem entirely realistic, but I can imagine cases like
> fork()/exec() where we end up with two copies of the file open
> but end up immediately closing one.
>=20
> > > That means the abort is called only for the last user.
> > > And only if the underlying device still exists.  Which means that
> > > if it has disappeared (how can that happen? spidev unbind?), =20
>=20
> > In my case, I just disconnect some SPI signals and the test program
> > just hangs. I do need to ctrl+c to stop it (or use timeout).  =20
>=20
> > From my debugging the .release callback is called each time the
> > program is aborted (either with ctrl+c or timeout). =20
>=20
> Should be on file close IIRC.

Any ideas on how to solve this issue?

Maybe, it would be sufficient for now to move the spi_slave_abort() in
spi_release() before we decrease (spidev->users--) the use count?


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/MWul8reh.Rz47nd.lOSx1tl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2NPfkACgkQAR8vZIA0
zr021wgAiv7whL2JbgJhEsGJ7+wE8+VstDmdil3dJj2370tZ1TV6dToiTi/UcAIt
ivYET/WG1RxKE0W58RfOvjo/D24kad2MT+RIujWZoWyu3kVVyGOpS1cQe6QUocXx
jXiCRBavxoCn9CEFOmJZ/ypxea62I4gKFQ/VAeGuJJLBCNQnuzZAcAADPfQMKkCj
l0ZYOLF6yQbz47gRdgHxuunPpUDjqw9sdlc7Hv2zMEcW021bi4pYni9Hb6ZAeIJ9
geoh0ep5tWNoS8Vvw+TuG5jGOigRDEazqX1X8uVuRVa1wu3B6wXLjMMwBSUC2rE9
sUS5ctBukWrLZndmHt3CiYIaDz1Rmg==
=nmDF
-----END PGP SIGNATURE-----

--Sig_/MWul8reh.Rz47nd.lOSx1tl--
