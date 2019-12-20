Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40F6127B80
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2019 14:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfLTNId (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Dec 2019 08:08:33 -0500
Received: from foss.arm.com ([217.140.110.172]:50654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbfLTNId (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Dec 2019 08:08:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86B2C30E;
        Fri, 20 Dec 2019 05:08:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02B7C3F719;
        Fri, 20 Dec 2019 05:08:31 -0800 (PST)
Date:   Fri, 20 Dec 2019 13:08:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jean Pihet <jean.pihet@newoldbits.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Arnout Vandecappelle <arnout.vandecappelle@essensium.com>
Subject: Re: [PATCH 2/3] spi: spi-ti-qspi: support large flash devices
Message-ID: <20191220130830.GH4790@sirena.org.uk>
References: <20191211193954.747745-1-jean.pihet@newoldbits.com>
 <20191211193954.747745-3-jean.pihet@newoldbits.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="smOfPzt+Qjm5bNGJ"
Content-Disposition: inline
In-Reply-To: <20191211193954.747745-3-jean.pihet@newoldbits.com>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 08:39:53PM +0100, Jean Pihet wrote:

> +			if (op->addr.val + op->data.nbytes > qspi->mmap_size) {
> +				max_len =3D qspi->mmap_size - op->addr.val;
> +				op->data.nbytes =3D min(op->data.nbytes, max_len);
> +			}

This introduces a massive warning splat for me (just one warning but
it's very verbose):

  CC      drivers/spi/spi-ti-qspi.o
In file included from drivers/spi/spi-ti-qspi.c:9:
drivers/spi/spi-ti-qspi.c: In function =E2=80=98ti_qspi_adjust_op_size=E2=
=80=99:
=2E/include/linux/kernel.h:844:29: warning: comparison of distinct pointer =
types lacks a cast
   (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
                             ^~
=2E/include/linux/kernel.h:858:4: note: in expansion of macro =E2=80=98__ty=
pecheck=E2=80=99
   (__typecheck(x, y) && __no_side_effects(x, y))
    ^~~~~~~~~~~
=2E/include/linux/kernel.h:868:24: note: in expansion of macro =E2=80=98__s=
afe_cmp=E2=80=99
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
=2E/include/linux/kernel.h:877:19: note: in expansion of macro =E2=80=98__c=
areful_cmp=E2=80=99
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/spi/spi-ti-qspi.c:535:23: note: in expansion of macro =E2=80=98min=
=E2=80=99
     op->data.nbytes =3D min(op->data.nbytes, max_len);
                       ^~~
=2E/include/linux/kernel.h:844:29: warning: comparison of distinct pointer =
types lacks a cast
   (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
                             ^~
=2E/include/linux/kernel.h:858:4: note: in expansion of macro =E2=80=98__ty=
pecheck=E2=80=99
   (__typecheck(x, y) && __no_side_effects(x, y))
    ^~~~~~~~~~~
=2E/include/linux/kernel.h:868:24: note: in expansion of macro =E2=80=98__s=
afe_cmp=E2=80=99
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
=2E/include/linux/kernel.h:877:19: note: in expansion of macro =E2=80=98__c=
areful_cmp=E2=80=99
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/spi/spi-ti-qspi.c:545:22: note: in expansion of macro =E2=80=98min=
=E2=80=99
    op->data.nbytes =3D min(op->data.nbytes, max_len);
                      ^~~

Using compilers from Debian stable.

--smOfPzt+Qjm5bNGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl38x80ACgkQJNaLcl1U
h9C+iwf+KEEse5f37jLeLbUxpqF0cg2l7wlT8uV/LW8cCXYxcFb11ZtkXYPnXiFc
ZitPGB599iSYzjcVAgJR6B2hhnkZ002pAzFhVDktCeFmT7jYbPKXCtbo7oHXl1+G
ZDptKxL+clIXreNyRbImv1oqLO75e5JXRKrHTSAHPZLh+FftBU4f9RrMHFTGq1h0
63rtgNSkB+PFG3e49aNpaZenwzO2lIJJtPq9kKz0uQFdOMVTFCYBYGHcyTDo5GWr
phGlluq0AVto+cppQPXLqcZetB42SFWI97BRkuayVbwsRH6Bv6b+scuR/YRHIeZ1
JklzDFHTIRaYtIb5A4sJFcTpCOVObQ==
=ZUEs
-----END PGP SIGNATURE-----

--smOfPzt+Qjm5bNGJ--
