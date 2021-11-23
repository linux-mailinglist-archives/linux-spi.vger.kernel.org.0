Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392A845A458
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 15:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhKWOG1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 09:06:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbhKWOGZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Nov 2021 09:06:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16B456044F;
        Tue, 23 Nov 2021 14:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637676197;
        bh=MfdpF27zth5o06hamPdUUAzizLvQgUV6lxyD7kDC6Y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWjmlxvqKcThteULWCaKQIS6t4YAQptGvIBydpqsXecyF5eQ+3B1KKnaHHPmq5LvI
         B759/Xy2avRqkJlprkCdb43RzjQ5xWDdfIOsDEcJE5UupDMXyHTafW07lGL9Zrwf+r
         JwY6sEaVtcx+fTHzyrLPaMGqxIczf+I70oN6uo6ICPf+Yb487PiA7h0CHMO7yX7mzr
         /XO2QQtbp3wxoFd5E6RDEgy/jD7E3nzk/u4/VXaTdYuhRl22DWHbkawFXqYwI+b5gC
         yISEU42VQKjA21RSj+eqqYtpcskTN3hjUDzY9ckjPsnFpnsEdjIi7M6R8zlZW5JSSW
         M2/pXVNnbo4rg==
Date:   Tue, 23 Nov 2021 14:03:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "LH.Kuo" <lhjeff911@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: Re: [PATCH v3 1/2] SPI: Add SPI driver for Sunplus SP7021
Message-ID: <YZz0n6Mpjl3tKmMe@sirena.org.uk>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <cover.1637547799.git.lh.kuo@sunplus.com>
 <e5f2549224cf875d81306ef5f6e98db1cfd81c2e.1637547799.git.lh.kuo@sunplus.com>
 <CAHp75Vd2=OHbrpGtsU8AMXdtNfvSPhpc7vhzkWnahaV48XbfUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EbBiJSwwSpqu59hm"
Content-Disposition: inline
In-Reply-To: <CAHp75Vd2=OHbrpGtsU8AMXdtNfvSPhpc7vhzkWnahaV48XbfUQ@mail.gmail.com>
X-Cookie: A closed mouth gathers no foot.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--EbBiJSwwSpqu59hm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 23, 2021 at 12:09:54AM +0200, Andy Shevchenko wrote:
> On Mon, Nov 22, 2021 at 4:34 AM LH.Kuo <lhjeff911@gmail.com> wrote:

> > +// slave only. usually called on driver remove

> Why is it so?
> Also find use of proper English grammar (capitalization, periods, etc.
> Ditto for all your comments.

Please don't go overboard on changes you're requesting, the important
thing with comments is that they're intelligible.  People have different
levels of skill with English and that's totally fine, it's much better
that people feel able to write comments than that they stop doing so
because they are concerned about issues with their foreign language
skills. =20

> > +       unsigned long flags;
> > +       struct sp7021_spi_ctlr *pspim =3D dev;
> > +       u32 fd_status =3D 0;
> > +       unsigned int tx_len, rx_cnt, tx_cnt, total_len;
> > +       bool isrdone =3D false;

> Reversed xmas tree order here and everywhere else.

Again, please don't go overboard - this isn't a general requirement for
kernel code, some parts of the kernel do want it but outside of those
areas it's not something that we should be asking for (and TBH even when
it is required you should explain what it is, it's not as easy to search
for as it could be).  I certainly don't care.

> > +               if (of_property_read_bool(pdev->dev.of_node, "spi-slave=
"))
> > +                       mode =3D SP7021_SLAVE_MODE;

> There is no need to check of_node for this call.

OTOH if we are checking it anyway it doesn't hurt to have all the
property reads in the check for of_node.  Either way it doesn't
fundamentally matter.

--EbBiJSwwSpqu59hm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGc9J4ACgkQJNaLcl1U
h9CTQwf/eALQf94u4Kg1BbFvFp/ZDVojKfNjqUMKWJ+CVkLhAeflFrq+zZ2Occc0
iOGhInsfekve/ASSNzdyplZcWmSy8uPyU41ho1khO68e/rrjsXI7SAJpXVVylMaf
ns+VWjoUHBHaA0PLz3/HKa7Ehj4C3Nyjo+9ZLDXP3WP+4jVSjx9FjX7sLU5wDkvj
ZjVGbcsJx7A5H4SmlcB1UjeUhrJH0hQaMYXi0mAgm+vILBAeBDiLbXPWcrHdEb/i
KKhyBY4EK4HE1l2UER7OQJvD2okd3jXiSo+iZdENqxdmWU606+U/vJsbKXPARRh1
U5Nlfv2V26Z/3a2B5ygRFCi3RaMejg==
=mj2D
-----END PGP SIGNATURE-----

--EbBiJSwwSpqu59hm--
