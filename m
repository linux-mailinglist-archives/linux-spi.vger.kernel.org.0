Return-Path: <linux-spi+bounces-9972-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49E4B523DE
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 23:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96645163109
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E399D309DD2;
	Wed, 10 Sep 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7q8mayP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AEA2D1926;
	Wed, 10 Sep 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757541156; cv=none; b=S5D63HwtfqkjLYLVEB7fzS5eY2K8L3xnlii7WxTCJTlC2ybujCEoEHPA59AIZ6aD9Y8IqP1QzwohSU0kib5o5KcZxm88E+8eSyZFYWgN7HEqIdHDD8+drhJF2WehRJ5vT9asp/3fK/GeVtmoprLTaOjMzzgdnqfpCfTdHXS0Wzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757541156; c=relaxed/simple;
	bh=I8E14UOPH8nShUkHDdlOhBPuTaihR9JrpK2VPAQCM3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqJDG2vVaHrF0BFM4uS0xfDeHVEHJSZ90h0U0tnO8skSK/0RVgBOxoVNyJfvnQMzuf+jJVGCBfeVZ8LXXt3+aCTDJaVFVzdLOX4iP/Ige/G6ogy2wFMAmVWgGHtPiRS29SCI9BvmCRMyCXMWIzjRe3850JPydJfRiNQ20D42Re0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7q8mayP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39284C4CEEB;
	Wed, 10 Sep 2025 21:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757541156;
	bh=I8E14UOPH8nShUkHDdlOhBPuTaihR9JrpK2VPAQCM3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7q8mayPUM7YzWehf/K7A0V2YA+Yjo8FN4/b0P9yt3Yq4QeiwigsAo8CzaYoV+IQ2
	 auli2gD7StigdNjliRSYJGkVrEDyLKs5oxPlfVU6fOqu+EcqqrW52BA8g842wctNRw
	 51HYXsZrkAyMNd9q/Pswx8K80CBF5ebJ8Axzd+xhQpF70CuxI8rQibUBkBGy+917Wj
	 nv14VABQE2uP7PpKra1fRVd8jcjrSeEF5ROJDUjg/1ocDczIgvMbfYhLIHnVwQDbRk
	 hG/RlaBfiCMVimxIqn8EtbAFvIwFPaZEdmwiApyNrUVb66hlglVv4/jCs6C/Ejk8L1
	 Y9sa3ZiR+Mkew==
Date: Wed, 10 Sep 2025 22:52:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr
Subject: Re: [PATCH] spi: Convert lock/unlock to scoped_guard
Message-ID: <62598bc3-d4d3-457d-9060-a2db6c4a6c21@sirena.org.uk>
References: <20250910205003.421067-1-karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KR8AaO+v6rfU+K60"
Content-Disposition: inline
In-Reply-To: <20250910205003.421067-1-karanja99erick@gmail.com>
X-Cookie: I think my career is ruined!


--KR8AaO+v6rfU+K60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 11:50:03PM +0300, Erick Karanja wrote:
> Siplify the lock/unlock pattern with scope based cleanup.
>=20
> Generated-by: Coccinelle SmPL

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--KR8AaO+v6rfU+K60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjB8x8ACgkQJNaLcl1U
h9CUqwf/Qejgpl/52j/41f4MSADCN43JDvykgLN+kC01jKcpR5gxmJ/hSEgVTkCr
eU8htgeR1cY3fAezdRjPH0bfQKiXH1xsMByxwfKQPpyhW0qgrlAIAbsWggII/wbh
6EtuqW/pLbAbDCHolfAigq+y7GkAhSGXp29kTjsgFzHHBbuumEhrDrgOqMkWu4Wm
tB7Kj7jfe5XjPhtrNvLRS3uNW+JuwiH9cmX142v/XEl0Zag9oHxMpqIwToAMaWdx
DI/aGtfkFFx+X9LnHoiJW7Wg8Q62sXWDmPK70LcTYwC9jqb36D4u3LPW1oEfZTfk
vLjFeS6hdli6VE+qItGb6O6NvGaDSA==
=lsZQ
-----END PGP SIGNATURE-----

--KR8AaO+v6rfU+K60--

