Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A593C3C7044
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 14:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhGMM2x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 08:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236042AbhGMM2x (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Jul 2021 08:28:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED6286115A;
        Tue, 13 Jul 2021 12:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626179163;
        bh=r68WaL5XhWRO4f/KtcNmPtdPmJAvPFH6gkMAy5cA2ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QBi/3tShFL+gndd3vuJyXQtnd20rJP1XlMuz1cw4MFwIJRAraHAZigxY5DSGhBGPC
         UxL+38NdpSIs80ZSu/iSXm1CRRG/1wfMIc5qPDG9hcdgSY0wM4yG86trkN5s2nNRO4
         ly4VEs75hT/EvSSswsrh2NTsNucynX5AU0M2eOzFyKGY+sFzH4qbIqiCIpBEzg4I/3
         WDYAobEFPksTAEFL0wviu+ZhoUFHUiOwsBnpNibuYPrBDkF1r2cXFytVkRb894HRKZ
         pXs4nFamufFe+U85HixEyM1+ISsYX3YUNPHgxXm0/LEjG6qvIIR8VRZDX+9R6bYMaG
         CTZBb8gduaE/w==
Date:   Tue, 13 Jul 2021 13:25:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yoshitaka Ikeda <ikeda@nskint.co.jp>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Masahiro Mizutani <m.mizutani@nskint.co.jp>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH] spi: spi-cadence-quadspi: Fix division by zero warning
Message-ID: <20210713122528.GB4098@sirena.org.uk>
References: <1406d756-1edb-6294-116b-91c7a9d29b71@nskint.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <1406d756-1edb-6294-116b-91c7a9d29b71@nskint.co.jp>
X-Cookie: Keep away from fire or flame.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 13, 2021 at 07:23:12AM +0000, Yoshitaka Ikeda wrote:
> Fix below division by zero warning:
> - Added an if statement because buswidth can be zero, resulting in divisi=
on by zero.
> - The modified code was based on another driver (atmel-quadspi).
>=20
> [    0.795337] Division by zero in kernel.
> [    0.797878] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.12.0-xxx-xxxx+=
 #1
> [    0.803782] Hardware name: Altera SOCFPGA
> [    0.806481] Backtrace:
> [    0.807628] [<807fd2b0>] (dump_backtrace) from [<807fd554>] (show_stac=
k+0x20/0x24)

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDthjcACgkQJNaLcl1U
h9BwuQf+KHaCYX/pyj6DL3ey+h7BeXDAVZp8WSW2ZHaOyih7hpMtrBoRUtTDax4j
DW9M0+QSxAQcqZV5hdD9nW4JAEXNzSk64IcE6RQrIF+rxW1IgF+CXucTwQip0+3/
Dk/LUtz9jsHuTFutK6q0EOJEva2YKKljaigt3FRAWDe6zNPaUwgcuJFG/WG+lW1R
8c20Z9w7FhtYKnyWZQIVBVHCWfOwdzUcMWK4J15GNxKP8Hpe9zpuqiZji3i8ixO7
dCIrxAaGXoF0S1X3HbYyxoDzWDq+v6s5fAzit8Bt+XzitC4kgtxc2Ya4VcUANWzT
BsZQKjioldAnPvg9VUz3bC4foZ9bUQ==
=iQ20
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
