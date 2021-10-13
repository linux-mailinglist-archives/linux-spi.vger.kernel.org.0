Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4577342C4B6
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 17:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJMPXo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 11:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhJMPXn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 11:23:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB8B56113D;
        Wed, 13 Oct 2021 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634138500;
        bh=t5e10G65gjp3B3qar5cAgb4SCPB6qq1fHssfgl10Nj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nlvH/X2dFOznl8z7Q0go5UOxuCyl/P6orsyzoeAowrhefyh9c5aFxDNXey1JWQ0pg
         1Sesh1ZzA6La0+v+/Pnv6QYJHoylIGUgYbJPOuZGv+4whym/1B/zkdl90ihlpvpTg1
         pkVLzMbROqmswiJD38aWlhnyLmmxx6gmV+BYvTyTZG6SJa/D8PEcSXCecdWSAD/55t
         SiRZpCdHzGkP0o2MXvF4LOLpv2zQfPLlx6ZgjnPkhQWXWNcuwv7Cv7T1takX4c9jPF
         r/K/WkiiMnOrT3GUU30VDJDzwxvQD/asVJlXn7/C1lEeKkEUY/41HF2TuFnkQCOH2O
         a197IxJCAnHKg==
Date:   Wed, 13 Oct 2021 16:21:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: Make spi_add_lock a per-controller lock
Message-ID: <YWb5gUxgdiczqV5Q@sirena.org.uk>
References: <20211013133710.2679703-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gGe1FY2Lb9AR1aQZ"
Content-Disposition: inline
In-Reply-To: <20211013133710.2679703-1-u.kleine-koenig@pengutronix.de>
X-Cookie: Where do you think you're going today?
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--gGe1FY2Lb9AR1aQZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2021 at 03:37:09PM +0200, Uwe Kleine-K=F6nig wrote:
> The spi_add_lock that is removed with this change was held when
> spi_add_device() called device_add() (via __spi_add_device()).
>=20
> In the case where the added device is an spi-mux calling device_add()
> might result in calling the spi-mux's probe function which adds another
> controller and for that spi_add_device() might be called. This results
> in a dead-lock.
>=20
> To circumvent this deadlock replace the global spi_add_lock with a lock
> per controller.
>=20
> The biggest part of this patch was authored by Mark Brown.

I'll go ahead with my copy of this (partly as I've already got it
ready queued).

--gGe1FY2Lb9AR1aQZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFm+YAACgkQJNaLcl1U
h9DNEAf/RKHJSjMNiPJHZ8/hQjzV3mnp+TH3DoT8TAkD9h+6giyDE0Z/O97xF4dA
MwVlzv+Q4rV5BUwRTjIaMqs1gvSx000Xc3VQsEFWnF7s9KmWfzSwqP2csPAyTObx
1aSY2kA3usfmp2btk2OS3Cot6j98/GeHejCGZxuM1QC4XM5qAiu/BOfSeS+UF4FM
mqdPHXLk6I0KyW5viuuCbd21LkEYxdOo8N+Prg0C6EeR1nyJjcZv1M/txILBsfbD
7kEG6HZs/H+Ht5x2MMLWkFnkKcyO3JmfQzc8Xp9bSu+cI+yn6dD8IULrcDsKMoOw
tpAqRIeokiZoV8T9JhzFy4BH8XPKZA==
=KqJE
-----END PGP SIGNATURE-----

--gGe1FY2Lb9AR1aQZ--
