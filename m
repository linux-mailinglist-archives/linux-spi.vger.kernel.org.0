Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B773C3398AA
	for <lists+linux-spi@lfdr.de>; Fri, 12 Mar 2021 21:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhCLUs3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Mar 2021 15:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235073AbhCLUsW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Mar 2021 15:48:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4904864F4F;
        Fri, 12 Mar 2021 20:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615582101;
        bh=/XMXUxTFOXG/ohVMyBKky01OWeEbHdqSnYFUhvmw1dI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZHB8kKRpDwoL/t7AQbJtyT3TyUcDpimLJnj9lvLP9jPDKb/3w9SCfRaVu5TCT54T
         LP7s8Jox5Rhd1ZChZE4GRNY1shOwrghzqjXkSLuPKEXrzO/PwQiUTIAXOoR+OZuvkZ
         J8viu++q0JjBnvhIPD1Hmql6xMTjgaTxIRWjYFyYl59zUMMa97qLfM2E8aVnTsDiUG
         5+HmJpczd7B2bKunuct2bi94eXX0ptuc2PBAK+R2Kqh2+g/igjncGkNWrvgY6q4eNc
         Nc5HxLcVztRiXeI4ckymSTEPCAsMekvO/IW8+nODOgwiOSo7MuyKYRgcUpgPZbPc4p
         7Rw007YGkpvEA==
Date:   Fri, 12 Mar 2021 20:47:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] spi: Adding support for software nodes
Message-ID: <20210312204708.GM5348@sirena.org.uk>
References: <20210303152814.35070-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bZ2MuwyI/0uB8yuJ"
Content-Disposition: inline
In-Reply-To: <20210303152814.35070-1-heikki.krogerus@linux.intel.com>
X-Cookie: Lake Erie died for your sins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bZ2MuwyI/0uB8yuJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 03, 2021 at 06:28:10PM +0300, Heikki Krogerus wrote:
> Hi,
>=20
> The older API used to supply additional device properties for the
> devices - so mainly the function device_add_properties() - is going to
> be removed. The reason why the API will be removed is because it gives

This makes sense to me, OK to apply the PXA patches via the SPI tree?

--bZ2MuwyI/0uB8yuJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBL00sACgkQJNaLcl1U
h9C2Jwf+KSe+06U3nl5gd7TKg71kSd3x6YZc07UnJK+u1jp5/bqaUHemS+Q3C5gV
I6ZHExnAnriDxkN1/a7OkdDi8q3LoIUY3X3HTEPwMMfjqC1Dy6dqpFS0avXxRHAF
aoiAa+JjB/sl56HQBQNYgRphnMw2lfb1nuNCcmpPLIKqnJiLU02WWQVcI2krJryT
dpKzUCtad54slZh7QJAi4Ehgkn1JYcikHnjajRyw3o0Gx7C3zfXKigf+E7JV2qMS
V14W3q9zre2t/wJYV9+5eqZUEx53Ri+61qwUsCIakVxILLEXbQeD6Lb0FypxNRuJ
t36v0PSAhEUu4NvsVfzM0dl4Lu03kg==
=gs0W
-----END PGP SIGNATURE-----

--bZ2MuwyI/0uB8yuJ--
