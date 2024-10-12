Return-Path: <linux-spi+bounces-5212-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1143B99B2F7
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 12:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F6CBB22B4E
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09437154426;
	Sat, 12 Oct 2024 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHaiz2Uf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED71514F6;
	Sat, 12 Oct 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728891; cv=none; b=tdAtbQBxURHCkZpc7a4/v7Ss3L5V3hEL0TNh1rbsTUBZT/2QAa2WahsjPYYXmF1wd+3qSDKCinnxm/CXKD8od/f4YbDM8jHSDxvcu8eWFABZ6tk4LOdpHreXHmB9hyQKgpXndp+5+t+dJoyUKI9hFDN1kKIX122l/xEfYiqQFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728891; c=relaxed/simple;
	bh=V5TffGA41tc8RrTnK+VSW/zZSfAn0/67lE8bdW++1fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNbmwa931cq4+1jRX42mM+0aHfu6IidCK4vsaRIWnZ4boMevqdMEZyO+2g5Z5KTbDESsX8X9NgIbaBNOzngd33jhMoW4nuFn/foOt3vNs7dMatNyEXpHnNnH+qyuWUPEvzaWInEiK92GQ70/IdYrAZLucSzyuYWn4rj7Nxpd4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHaiz2Uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCC9C4CEC6;
	Sat, 12 Oct 2024 10:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728728891;
	bh=V5TffGA41tc8RrTnK+VSW/zZSfAn0/67lE8bdW++1fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHaiz2UfEmcslnhf9fnfIU+vT4OBJdluFVQL86sodhg+hzQiQWaPFi02SGdZZfs8T
	 DOSb4nsYmaV6AvCcGVDtZqlTzhtSjv8jDTceNnVUwL6qu7DOOW3b5S1RZR3P4Jkk4h
	 mrjqV+9PUkeh6IIX5pMW3m4oFAd9etvM4VOYP7LMscU//X8vhr0CcZv49/tljdWFgR
	 +qDiKwVE+8Tfij+otAmii4nx/B2tYOjwFkMnmxpAF6IizrnzcQ0cx0RDvUTlsg5jRO
	 5SRZRfxqcKYM9cxLSSqD5K7gAgNO45hdV5D5W0aLJhK+M4Q+AbSzBHaQPmOKt0pG99
	 +vKn8uohjZLAQ==
Date: Sat, 12 Oct 2024 11:28:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] Revert "spi: Raise limit on number of chip selects"
Message-ID: <ZwpPNFVx8g1an3__@finisterre.sirena.org.uk>
References: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
 <20241012-spi_multi_cs_cleanup-v1-5-dc491113880d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bsjcJf77nBeivIV5"
Content-Disposition: inline
In-Reply-To: <20241012-spi_multi_cs_cleanup-v1-5-dc491113880d@gmail.com>
X-Cookie: Editing is a rewording activity.


--bsjcJf77nBeivIV5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 11:53:39AM +0200, Jonas Gorski wrote:
> Now that we removed the limit of chip selects for the controller, we can
> reduce the amount of chip selects per device again to its original
> value.
>=20
> This reverts commit 2f8c7c3715f2c6fb51a4ecc0905c04dd78a3da29.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--bsjcJf77nBeivIV5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcKTzMACgkQJNaLcl1U
h9Cyygf7BYvSVivJsyFTb8siwE6YjCD5sTEZKxa4Bs8jKy0uxhhhOLvMWFMv76dD
QwWU/AfU/YmO6U0dARgD6mbn+c116blF9yUf4VXQVJzq+kjqzLd3iTTXW86enx9O
RnVFd6ailDhniIhWDU1gqccS1N7xjlYQVVTzAgtfWqToF3egss66PwT51qiRXNef
T98Ey+XejV9tfYWZUzwEAuAhcAljK/SmkX0wgXnavYeduENky8yZf+xvaiN2cAub
bt/PXcrZW4g7uw7+JzdPecM9zQrayrjPTgueZS+rRgi2uoIyuMXkSgwv+xE/bMYm
CFl6jdRt2r57c6dHC43PPvk0jbSWdQ==
=BR4W
-----END PGP SIGNATURE-----

--bsjcJf77nBeivIV5--

