Return-Path: <linux-spi+bounces-11871-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A60CB8009
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 07:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CAE030336B7
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 06:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1331321D00A;
	Fri, 12 Dec 2025 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHnRVMbI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F878F3E;
	Fri, 12 Dec 2025 06:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765519644; cv=none; b=TztfeqfIsAOnuis2b8NnEwneLGOT9IHKp9w3NISkyRfQd35Ndh/y3l+6lNEtZ3vW3qCKgqbftdP4kS9i4he+gLOUuJuU/w+tLetYDIPwxJ9NNKDBoH9jAUVohu0yAFBxGQsaS7GeJXoafSwnXJCid0vURLCGhYk8cvChF0886ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765519644; c=relaxed/simple;
	bh=ZExTVsolaX4z42xWW/DjmglH0XscV5qUve/fqsjqoPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnwIx/jZbfL/sk2Z/Hn5CDqPJNmlqOm1eY7WT/lbRNhjy+YXRekf4YTTXL7LeAuwQiroz/lEO7UOBq7FZUSEZsnK/YQuVJu6l5WSx0v/PHYt9sgyKyYEWOOQcWpUH26DyWVQSfssjb5sP+O4OkGn+Hbfjkw9pe7cxhEpsSzv++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHnRVMbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2EBC4CEF1;
	Fri, 12 Dec 2025 06:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765519643;
	bh=ZExTVsolaX4z42xWW/DjmglH0XscV5qUve/fqsjqoPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHnRVMbIHnDzx0UMDf5oOySvFxzm1KyaKjwoCOPlvaowEVSEFng3tmU0iEEWTIGno
	 wfddxif7XUvFQn5ir6DOdfIZEuOcUW4Tjj4q08FnHNLW8BZ3COJFpY/PemXKlUfYqd
	 sXN+ASPzZtsGc89ZSQzynosC1bNoPmaSz7i7QpKFTO7BnfFegI1PWh46oiKRXNqx0F
	 39/klXn1p5/OKZO4uBJi6aUn7um7cPYdTJ+Dv2QJ+9Ew5ZKsZdDLT6OfTgAVYbJUI3
	 oCabzvp94tSxvqhBS0syrVwohaGbb5OCJq4UzYomjS7c0TKAEJxdyoIu7SGR5Jy5Zp
	 IQx9BH6yZ3UJQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 8FD0A1AC52A9; Fri, 12 Dec 2025 06:07:20 +0000 (GMT)
Date: Fri, 12 Dec 2025 15:07:20 +0900
From: Mark Brown <broonie@kernel.org>
To: "Dutta, Anurag" <a-dutta@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Francesco Dolcini <francesco@dolcini.it>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Gujulan Elango, Hari Prasath" <gehariprasath@ti.com>,
	"Kumar, Udit" <u-kumar1@ti.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
Message-ID: <aTuxGAn_XvIK-mJG@sirena.co.uk>
References: <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
 <20251204140530.xax5didvuc7auzcd@problem>
 <4d6b857e-4bfe-45ef-a428-6e92f218f0c5@sirena.org.uk>
 <2fcf5235-cc94-4202-9164-4889356c5264@sirena.org.uk>
 <cd95320b-6852-476e-bc8a-2e8d1ac77a9e@ti.com>
 <f804d7a7-4ffb-4d2a-bbaf-ca0a076a11ab@sirena.org.uk>
 <5525272e-7220-4352-bb08-ac66631108e0@ti.com>
 <cf8e7003-ebca-4817-8350-f29332d75fab@ti.com>
 <aTf6RRAveRdVnWQZ@sirena.co.uk>
 <1542ee8a-620b-4349-92fb-ab1f6c5b5eab@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="805IoqJJsVTp0gQ5"
Content-Disposition: inline
In-Reply-To: <1542ee8a-620b-4349-92fb-ab1f6c5b5eab@ti.com>
X-Cookie: It's clever, but is it art?


--805IoqJJsVTp0gQ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 12, 2025 at 10:04:47AM +0530, Dutta, Anurag wrote:

> > Let me send a patch with pm_runtime_get_sync(). If changes are required,
> > please let me know.

BTW note that we do need to have a clock disable for the case where
CQSPI_DISABLE_RUNTIME_PM is quirked in as well as the with/without
runtime PM cases.

--805IoqJJsVTp0gQ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmk7sRQACgkQJNaLcl1U
h9CVTwf/b6+QWWMWM2g/Ytbd/07iXjK68VYyjffKanasAUHq07ih6TFb/PAsoFgK
iruYEjWDA7ak6nA9TS4ga7H+XlcyVM1cCtoVbSXjkimRdy/C17jN5BgX3bN2pefV
BaHze9ik6S2bU3mGF1+3J5kXKHbMdFKhO2bQNgT0VCSXOABNyPdzKEprb5z2ZXnS
Xgnp4DI1yslWqEv14c64Y6HaVTDmCKBE8iAr8TbTHUrYJtXQcb3fTGxHeckZNrdM
2qe837paBakSNrX4YrGGG2zlIS9B6vfdXIUnG8jbBmVhgXFLRtqFYis9Id9EH+eI
EhP8+az1msZPw9qBkv7lUktjwOxn/w==
=PzKI
-----END PGP SIGNATURE-----

--805IoqJJsVTp0gQ5--

