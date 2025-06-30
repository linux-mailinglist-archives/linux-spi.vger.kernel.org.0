Return-Path: <linux-spi+bounces-8890-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 731DEAEDAAD
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 13:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 160917A4038
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 11:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCD623A987;
	Mon, 30 Jun 2025 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D13f7Ub4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AB723BCF2;
	Mon, 30 Jun 2025 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282411; cv=none; b=U+dIW+Iu2+ozpm4VfhXqbTTPrKZGfpi5zppQL6Iwc9ejB4RdSZAjHfz44+LTZsBJYdyTc43eh2SXJDDY047ObukxzHk7F6qF+nfm1oKFhgvrF+Lhtf0WIljRVWT5uVpn9YR5Qyy/FOU9fC29nX0u6PJ18q313OFH9U1hc8FbTd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282411; c=relaxed/simple;
	bh=9rBTDJ/Pce3XGAqMFO/6ZU1Cr+dyYVpm8N2+a5ACXSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=damXqyjbHKHmyHPdHyhwjYDsEbuq6gpVKT2xOv5i30yeTrv7FiOe8SUSHUUO2Tdm2th9CTmzaEEU6ut4j5g0dKrFIdZCDX2ZZZLjInj6zdk1Dzhr2ZJNF8JHy1S13wK/2vktqlYA1hfnS+fDWEsnaJJcOsyGXT9kaBkH6Dgo3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D13f7Ub4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11475C4CEE3;
	Mon, 30 Jun 2025 11:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751282410;
	bh=9rBTDJ/Pce3XGAqMFO/6ZU1Cr+dyYVpm8N2+a5ACXSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D13f7Ub4BN4yAwB3RBgvRG4yQNNeXJL5AVLZDS0XwfD2u+9YTM+M/gSw6/hHyOL+v
	 HN9NnVq06ERB/qjtlFmBvfcN5BqsZcZxEQfuffupcShL4D9iuO6VSB+xx+cqd/d0BY
	 FdrGIeWdz9E3J4nDBNb+lFK/bwn1g16v3v+xariZJJuVBFQ5wptVP8G4+uaUrVRAth
	 AXSKIw0IGxf/ffpaaEHxrMx+q4modao/UkAagb8HMogs4Paor4+v99PoqCdRuZG0sh
	 pQ17AzhygtAUzwdIhM7esrNy5H71AO93MipDLxyYjptFNLXYOyhuqVvHA85GHN2ckr
	 1xVTcfnkv2Mhg==
Date: Mon, 30 Jun 2025 12:20:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>
Cc: Antonio Quartulli <antonio@mandelbit.com>, linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH v2] spi: stm32: fix pointer-to-pointer variables usage
Message-ID: <192fb276-1e5a-4f69-8815-133f6bcd36b3@sirena.org.uk>
References: <20250630081253.17294-1-antonio@mandelbit.com>
 <5e61da51-cd02-41fd-9773-8bd776e1db62@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8ubtRjEq0eUrZSJ8"
Content-Disposition: inline
In-Reply-To: <5e61da51-cd02-41fd-9773-8bd776e1db62@foss.st.com>
X-Cookie: Say no, then negotiate.


--8ubtRjEq0eUrZSJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 30, 2025 at 10:28:50AM +0200, Clement LE GOFFIC wrote:

> Thank you, LGTM
> You can add my Reviewed-by

If you want to add a Reviewed-by you should actually write it out in the
mail, people rely on tooling like b4 to pick them up.

--8ubtRjEq0eUrZSJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhicuUACgkQJNaLcl1U
h9Ab+Af/TLVz/Hq9TCf2YxneUgc7AN12JRozk2EqamXE2v+Yb6rTtIil8B8ebrzi
FfOaxYAzi5KJDeESYSTn3yPDx0Fx6BA0p2iJN81BglYrhweGnTRepTTxipockKR1
Rvdj2lJFlq1gG6wtmZWlVRxvLZgNMw9YedXUzDFBtpjZoWQiAeEw/zWioip11i+l
inR4ruch1/w48o7zh5Ays2lOQd3exzmLp1lAH/myowkR3v4qP6yzs7QLHmhAWOqy
BlNC5jVfocXWi7eWO+VC+etgczf5bINLcC8VYUM79z2WNJszOKx/1AMtCBqfVYyF
MFhM8P+Ykvqa6VXqRoBSlmT5PUYYpw==
=boE2
-----END PGP SIGNATURE-----

--8ubtRjEq0eUrZSJ8--

