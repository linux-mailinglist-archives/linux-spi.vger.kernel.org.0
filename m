Return-Path: <linux-spi+bounces-3353-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AE390097C
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 17:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B731F228E9
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A4815B133;
	Fri,  7 Jun 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZFFEyxM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AF942069;
	Fri,  7 Jun 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775148; cv=none; b=Y+t7h/aVh5jBiFXBKF2mj1rFDpFIwOEoGPBpQO683wxP3n0raCascLrXBcjTovarI86CRW6pN6blrckNZg8xjL2oosRXY05W0kEriBDLt6NXnNRIj1I+B3au6WN4cws2fdV+72Z8Ymu8bpGn/YKOAnNu0guOzHgYnjmfmv1PTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775148; c=relaxed/simple;
	bh=rav38UP9d6uv9hGYcm4SeUoR+z+rLAOzlQWhpDKv/AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfULVzqI9Vt6yA0zC/UiRGAmzVRWpK9ZzqRgx1lVTcgfAASCwuj8IkMfvqEXDnz8DLOZOizVyVzYUWQzr4EJLQatx0rzN2ZTyY2ESqVxCgatPFhqbQVqg2hMUn5kZJC/f+uZ3mtUJ++///JH+ggjlh4tpHD/Fi/4Gg/BkE0WPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZFFEyxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E71C2BBFC;
	Fri,  7 Jun 2024 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717775147;
	bh=rav38UP9d6uv9hGYcm4SeUoR+z+rLAOzlQWhpDKv/AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZFFEyxMBLDap1GFuVgZPj+E38BvfPzCm19XlXF+yYH+17YBFJxAFPhuX5U+yWXv0
	 xECFJ5dYV2m0VbogCZPk2DXuExrMS5lj7meL6CABUbJf6+x5vjEc8h0LQ2idezXc8F
	 AuMaYeryFIfCLbLSawZdnhNDvpI9/gBEfSOxEmwAo/6CtLbgqJ0hBNzhJ/0Oy3oqYN
	 VsKLhJhTDZ7Zhb00zvRThXuf7lAwjj7RnIb1rJIodWdKcnCVgbNmHWApvOQnSKICmo
	 slTRyqgB3ZiOuDOV7izFbe94zyw1CCNhEN3L/vZSHf6sKYo30VPW0xz4+dYmoznfL8
	 Kfa8U4fe4NCoQ==
Date: Fri, 7 Jun 2024 16:45:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Colin Foster <colin.foster@in-advantage.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com
Subject: Re: omap2-mcspi multi mode
Message-ID: <ZmMrJ8uaw85a03Ce@finisterre.sirena.org.uk>
References: <Zl/V0dU6SjAMkpLG@colin-ia-desktop>
 <ZmFt7yfZFFJdsZuJ@localhost.localdomain>
 <ZmJ7E305ow91ez2U@euler>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="88zhgfWyCbymPqEy"
Content-Disposition: inline
In-Reply-To: <ZmJ7E305ow91ez2U@euler>
X-Cookie: Your love life will be... interesting.


--88zhgfWyCbymPqEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2024 at 10:14:27PM -0500, Colin Foster wrote:

> So I think the question I have is:

> Should the CS line be de-asserted at the end of "spi_write"?

Absent bodging with cs_change after any spi message the chip select
should be left deasserted.

--88zhgfWyCbymPqEy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZjKycACgkQJNaLcl1U
h9CyDAf9FQ7n1KTkwsOgAdcwiKzU5p+e9XPOrlxFy+2ZX2suyxLi6rWA2MbtsaGL
yNGxridrsd1r9JUjw8Uh75u0cJ3I3UvTqqIgBz9UnunA5bnpPXwnFp8XjWno8JeH
tqjVaBvwPrdQONP6I3dIF9oweznbIE8MENcJiAE7/hfyXBE4OD6H9wgrhzJM0nj7
vuedB/4wZvRbiV/vY17p5NfqQqq9aiVqnO+B5q7I1oo6HOw8gLIjZHh25CnajbQ6
mtw0BIoUAxGwm08BMuR6isyylJbONpq8B7b1BvJgt4IjIRh2qwPxbb2Ia+7C6qh9
H44kv01tBP4j1tTUkQpps0pbnJ9Vnw==
=dqLF
-----END PGP SIGNATURE-----

--88zhgfWyCbymPqEy--

