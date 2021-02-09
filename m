Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00753159E6
	for <lists+linux-spi@lfdr.de>; Wed, 10 Feb 2021 00:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhBIXLo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Feb 2021 18:11:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234552AbhBIWbv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Feb 2021 17:31:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6BB764DEC;
        Tue,  9 Feb 2021 22:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612909871;
        bh=w7T608Q6sIBtugY8EWYFaF2gDmCXirnHsPDnBwKISHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PmMallxrg49c9T3/O7B24Yc8QF+vHPMUZhsxsmIA3AYTCPjSXBZdttdZWSlrlkF7t
         NYFw3OHI4R8nOXlkGD9kkAbeJZHFvaz1muvqjCOsVryfpvD2NLJDyQQNIwEIFwMnHd
         XDVy126fR8JWavHG/mdG7irrh+6besHVrvPfSsRyURgvjm9p46T9DdVrm7cPdQwyrc
         iE72rodMIU7KJvexaxB+krJyWAmdp9puA+TPnu1y719kZyQysBiyQp6OyBIvkvBHhX
         MZ9eqkXv9gfxDNJSS/uXPe+j6321+ncpNHvE3Q4kLZdh771KSW/2r1eqr4g3lmqn66
         QcR3VVnYsbkfA==
Date:   Tue, 9 Feb 2021 22:30:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: mpc52xx: Avoid using get_tbl()
Message-ID: <20210209223018.GG4916@sirena.org.uk>
References: <99bf008e2970de7f8ed3225cda69a6d06ae1a644.1612866360.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Content-Disposition: inline
In-Reply-To: <99bf008e2970de7f8ed3225cda69a6d06ae1a644.1612866360.git.christophe.leroy@csgroup.eu>
X-Cookie: Put your trust in those who are worthy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 10:26:21AM +0000, Christophe Leroy wrote:
> get_tbl() is confusing as it returns the content TBL register
> on PPC32 but the concatenation of TBL and TBU on PPC64.
>=20
> Use mftb() instead.
>=20
> This will allow the removal of get_tbl() in a following patch.

Acked-by: Mark Brown <broonie@kernel.org>

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAjDPkACgkQJNaLcl1U
h9DIDAf+PfQCzvmSV62gREXxoOf6uW42RTKr/G1+QpxhzKRx0uIr/LobLhb7MJWj
dmwCZP+NqyviQCFy1dsAUZSommXfxd7WbfhSKFRTV+KBZlF/wy4QzfNBTAn+UIC9
UsDnYBWthhw7d1rJ0FaWU4jn6cewk8VIOoZ0comyvzBdPDGi99YsVukpSlmbKFbf
fD/uZJdMmdMsQlob6Ajd+h/tUYGr0zLUkBX5vsFwnTJmy9Lv9Y30PNu5mzGOMxo8
3BT7cZ+DSgJZM4dsd72sW3eN1ER/G3FLjjr5hhffxw9XzVmKTrS01FNeAaGQO0ah
QFqtkGS40qUehSgnuIac6q0B+yWFbQ==
=jS1n
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--
