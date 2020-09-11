Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D01F26677A
	for <lists+linux-spi@lfdr.de>; Fri, 11 Sep 2020 19:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgIKRnt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Sep 2020 13:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgIKMfZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Sep 2020 08:35:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2838F221F1;
        Fri, 11 Sep 2020 12:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599827714;
        bh=yi8RSiV9h0A/J1gT7uMmEVmlVSr6q32X2u1m9UKoE30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFNATJIQUxWE1UyDJGyip/IEOHsNU08z4ZV3hXbxIx+v/KbjbjEuJ4Dhr2VIT4X8x
         ou8VhSBHigKbzKgAeoWBPW6cHm7IBiwd0fPpBkYF5CTAXwklNv3kTj6DzOQjPCUGsJ
         6ryTD6Dj1FmhvPQhQTh/We7jqE5kjKxVRf1cmjFI=
Date:   Fri, 11 Sep 2020 13:34:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ashish Kumar <ashish.kumar@nxp.com>
Cc:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>
Subject: Re: [EXT] [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
Message-ID: <20200911123428.GF4895@sirena.org.uk>
References: <20200911082806.115-1-kuldip.dwivedi@puresoftware.com>
 <HE1PR04MB31962FC006C6EB964AC2DAE895240@HE1PR04MB3196.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Content-Disposition: inline
In-Reply-To: <HE1PR04MB31962FC006C6EB964AC2DAE895240@HE1PR04MB3196.eurprd04.prod.outlook.com>
X-Cookie: Only God can make random selections.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2020 at 12:28:47PM +0000, Ashish Kumar wrote:
> > Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>

> Please capture version change summary.
>=20
> Regards
> Ashish=20

It's there:

> >=20
> > Notes:
> >     1. Add ACPI match table, NXP members are added to confirm HID for F=
SPI
> >     2. Change the DT specific APIs to device property APIs
> >            so that same API can be used in DT and ACPi mode.
> >     3. Omit clock configuration part - in ACPI world, the firmware
> >            is responsible for clock maintenance.
> >     4. This patch is tested on LX2160A platform

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9bbtMACgkQJNaLcl1U
h9AX9Af9E8b0ZBffT3f/HP/GQeeFiFtQto/59VLFp18dYbCeMGNc0qEMnBcTCFO3
RvkcdTOx9ikmg2sxczO17Ue5M/K55qStE5s2ikjyhFFeR7Wi1NsOak3MDJAEjpjt
0P0Ox73nxNnJDO58pg9xi+M4h6ZvlPxk124cyVP8o4kAdl+5WVqTdKBTnNJt4NDA
9yfP80ceBy6CjZ6qH3l3bSXKzzCmiKhWE1IOBa7utRhu1iAf5do8U0asMZCntoOe
aet8AAy2sqBv5e0DJLC7DHUAtPx4ZisCPW7VaJ5d1R8BXx6QJb7HSItR0zjP3IqN
ADj6u+3/Us1cV+MSsV16O3Rlc5kqRg==
=R6Rq
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
