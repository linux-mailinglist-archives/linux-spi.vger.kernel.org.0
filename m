Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5435E162764
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2020 14:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgBRNuY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Feb 2020 08:50:24 -0500
Received: from foss.arm.com ([217.140.110.172]:52690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgBRNuY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 Feb 2020 08:50:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAC021FB;
        Tue, 18 Feb 2020 05:50:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ECE63F6CF;
        Tue, 18 Feb 2020 05:50:23 -0800 (PST)
Date:   Tue, 18 Feb 2020 13:50:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shobhit Srivastava <shobhit.srivastava@intel.com>
Cc:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        furquan@google.com, rajatja@google.com, evgreen@google.com,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH 0/1] Enable SSP controller for CS toggle
Message-ID: <20200218135021.GI4232@sirena.org.uk>
References: <20200218134906.25458-1-shobhit.srivastava@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e5GLnnZ8mDMEwH4V"
Content-Disposition: inline
In-Reply-To: <20200218134906.25458-1-shobhit.srivastava@intel.com>
X-Cookie: No alcohol, dogs or horses.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--e5GLnnZ8mDMEwH4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2020 at 07:19:05PM +0530, Shobhit Srivastava wrote:
>=20
> SPI CS assert may not always be accompanied by data. There are cases
> where we want to assert CS, wait and then deassert CS. There is no
> clocking or reading required. On Intel CNL LPSS controller, it was

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--e5GLnnZ8mDMEwH4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5L650ACgkQJNaLcl1U
h9ADRgf+ICIk+9HogX5my0zjXhvZfYd0hbmxco9LskbJW49ggOsx15biJ4X4Zq3K
lZ89OD8Y6+pqvLZnNorTACnqoP/aq/zfBow5ULHUefblv8NWIQeRJ6D/N9f/ZAIo
JWuyV6Qbrtthji+3ZoMTf9N/dX3mleiGWLBvWnDsz+gYba7LM+CNS9/oHroIycdB
j7zrZRatG7+x7zO270HN0bga1PBxIfSyP16VELeL4MJ9eoquvqVnUkOWQ6S2NFSz
Z1j6w/pKmmt3DzoSzzCBrT7p6HddBGFTRvprSJtQvaFaT5FMvPflNGagP8zC8VRN
TvcVZjSOu5bf7lYCTQViJwWKIocyWw==
=00VJ
-----END PGP SIGNATURE-----

--e5GLnnZ8mDMEwH4V--
