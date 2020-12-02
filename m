Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98E12CBF80
	for <lists+linux-spi@lfdr.de>; Wed,  2 Dec 2020 15:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgLBOXd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Dec 2020 09:23:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgLBOXc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Dec 2020 09:23:32 -0500
Date:   Wed, 2 Dec 2020 14:22:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606918972;
        bh=KfXX/d0r4/IGTwvkiuflhaINS+tauXU6IUSKfuqTfDs=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsIgBlBrB5PQXL3UBqWbzsHqK7ulACvncvCXxbSr3pz3MfQdnq+AvMDrFCOmXMIhs
         fnEb1MokOwJEySudQLDWM2g8h1UH/dbp1splIYE50k1LtUKMdzQRXM9sxDlovxIVSt
         sJzjudiUlHEc0yZVLaw5DrSUpUWrvTrkE9fcqlpU=
From:   Mark Brown <broonie@kernel.org>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     olteanv@gmail.com, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-dspi: Use max_native_cs instead of
 num_chipselect to set SPI_MCR
Message-ID: <20201202142220.GE5560@sirena.org.uk>
References: <20201201085916.63543-1-fido_max@inbox.ru>
 <160683107678.35139.1439064414776102118.b4-ty@kernel.org>
 <e19002f8-a8a8-6201-6680-ef0b586c6367@inbox.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline
In-Reply-To: <e19002f8-a8a8-6201-6680-ef0b586c6367@inbox.ru>
X-Cookie: Sauron is alive in Argentina!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2020 at 05:20:00PM +0300, Maxim Kochetkov wrote:

> Should I resend it?

If the patch isn't actually applied then yes.

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/HoxsACgkQJNaLcl1U
h9AFoQf/X499HEHwUPm+D/DwjNrJ7HsiYp6t9hoRI5NA5KdS3LtwUfyRk9WytzsA
Nu/eHwTmwlEfDXCub/xLYxp3bObR7GIzQvcSBdW6FnXhEfMDU9Y4493eoXfcNUX9
/sJPPjzErPF18QiQwi9sA1LEN6e++hPK6dTFp1wMItAxsV7+PRbIwqK2Drdadl3D
SDv7zxB776ZGX01vHF2UgoPV/FJb7FvlaY2N9EmCDl4XJmMpYoi/K0Tvq1RsNxUM
pU6UyzOBQqqWc2RC/4/TBJbBmv4HhfmUN6/skY4/cNuQ/C/rRLARcRFrCQufXxyH
Vp4I7jfYK5yrT5tL3AbyvvACrnF78w==
=iDgk
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--
