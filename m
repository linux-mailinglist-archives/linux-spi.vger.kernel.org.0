Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F78173CBC
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 17:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgB1QVA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Feb 2020 11:21:00 -0500
Received: from foss.arm.com ([217.140.110.172]:40920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1QVA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 Feb 2020 11:21:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED7B431B;
        Fri, 28 Feb 2020 08:20:59 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FBA73F73B;
        Fri, 28 Feb 2020 08:20:59 -0800 (PST)
Date:   Fri, 28 Feb 2020 16:20:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, andriy.shevchenko@linux.intel.com,
        linuxarm@huawei.com
Subject: Re: [PATCH RFC 3/3] spi: HiSilicon v3xx: Use DMI quirk to set
 controller buswidth override bits
Message-ID: <20200228162057.GC4956@sirena.org.uk>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-4-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline
In-Reply-To: <1582903131-160033-4-git-send-email-john.garry@huawei.com>
X-Cookie: There Is No Cabal.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2020 at 11:18:51PM +0800, John Garry wrote:
> The Huawei D06 board (and variants) can support Quad mode of operation.
>=20
> Since we have no current method in ACPI SPI bus device resource descripti=
on
> to describe this information, use DMI to detect the board, and set the
> controller buswidth override bits.

Hopefully this is something that the ACPI people will be looking to
address going forwards :/

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5ZPekACgkQJNaLcl1U
h9BxUwf/TDuNgCXr7WDgjO72Sd8M518jpCW63B2SJ/nhlOul+uSQtPp38AvFbOKG
xdPHKVoh82UV1cn6w79H71fMVmDy3y9uPlIB+GTxvnGze9F03HHo0ybJuAD6pvmb
gW4TsG3xZ9TatTMfM5n3sc0APvcfxXe3DjqWOhsdw9zlGddgfpObtyTApRiScQWK
UBZQnih2B8Fkgfbb5QSCjMEuxd4Hwp6lz/EkxKbBvgG3m8H41ONev6XKRkPCNagd
8tS65tJb0nhEuP6X8F0NpkkyQaDwsWSybWp06Zo8X1f5E2yxdhgc0qCbPThGFnil
f30KtWcvkDjZRu0eymnJ+Zab1jvEHQ==
=T+F5
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
