Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3149304423
	for <lists+linux-spi@lfdr.de>; Tue, 26 Jan 2021 18:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbhAZGB1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Jan 2021 01:01:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbhAYMtg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 Jan 2021 07:49:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1716E22D50;
        Mon, 25 Jan 2021 12:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611578271;
        bh=ssQqDM0hD2SsqIY9J1TXGam73KnE+UIiuVS8gXVJT08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQ8QfW3Iyo5j2SNESL3+m7Lj4uBhniM9jBrRKysETC6eW7vioQbfehkkQzdg2O2Od
         d23AdRwOtQo/mOUYf6bm2LIVS3UHz7UtZA+GBhVH4essaljKudjD0PNNSn26mR4aLj
         oRLtTezjBbnfm3Y8gIs5fPSsDkryFEAX7FFBA2rQbAijIBn+N3tWrYnnRgBZHcwUpC
         udpO2NHmjiExWTUTWWuKqeTUUD/5410ekKcFyF0XsCY7lnMel8qlh/Ko6AA+FxUlhT
         yGBWJRqafZkwIMUme7TlVM1IOBeYm8aib2vi1poPcp1+dt8McjPy3lIlPMAdTjcZBV
         ETjat9qhfI3aA==
Date:   Mon, 25 Jan 2021 12:37:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     jassisinghbrar@gmail.com
Cc:     linux-spi@vger.kernel.org, ard.biesheuvel@linaro.org,
        jaswinder.singh@linaro.org, masahisa.kojima@linaro.org
Subject: Re: spi: spi-synquacer: fix set_cs handling
Message-ID: <20210125123709.GA4510@sirena.org.uk>
References: <20210124221755.1587718-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20210124221755.1587718-1-jassisinghbrar@gmail.com>
X-Cookie: Drive defensively.  Buy a tank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 24, 2021 at 04:17:55PM -0600, jassisinghbrar@gmail.com wrote:

> Respect the set_cs() request by actually flushing the FIFOs
> and start/stop the SPI instance.

set_cs() is a request to set the chip select not flush the FIFOs or
restart the hardware - what's the actual issue here?  Transfers should
happen in the transfer callback, the driver shouldn't be assuming there
is anything going on with chip select when completing transfers.

>  	struct synquacer_spi *sspi =3D spi_master_get_devdata(spi->master);
>  	u32 val;
> =20
> +	if (!(spi->mode & SPI_CS_HIGH))
> +		enable =3D !enable;
> +

Let the core handle SET_CS_HIGH, this will double invert so is buggy.
It's also not called out in the changelog.

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAOu3UACgkQJNaLcl1U
h9DQJAgAhsQHWVvpR7RIiQIoEegZHgDws90Uu9IAgCAUWJe/F6R+Q5nP8u4ngUfd
FmKhnpu4doGKIOPXduaKdVPwsB42BWumUf53f05RWTmlJkve8VjKmhIkAwlEQeZG
m/9kg6ZaHrVn5EQnJlpfWneBzLOK4kuQuwAEWyI+q2j+dQZFBBYvn5WZ5IQR4C5X
6QsevNnYwYUmWVPxgnnZCb+k+W01VT53Q4f3SSZqA+ackwYwIGqtpk7Kqnn589Qr
1g5S3ePeYDQTYbL4NpbZSMSS/Z6ye4neoC5f6VXhKaJGNLaooxouwvvpF7mW8Q1a
1frAnqE56QcZaEPEWLC/9BcFeWFw4g==
=3j6f
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
