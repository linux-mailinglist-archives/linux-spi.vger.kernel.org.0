Return-Path: <linux-spi+bounces-11545-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE11DC875EA
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 23:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79C604E3A50
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 22:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38492EC09B;
	Tue, 25 Nov 2025 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJX83OXx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79C1EFF80;
	Tue, 25 Nov 2025 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110536; cv=none; b=JsMZCPtFAO6JbQGLtUr0E2WGryeY+ylZgFRGXVfi2jcXeFtHB5N1/dCbSn398qh0u+kzGFMBzC9a2aKgoLUJAcU70qAS7e2DBs/pyoye5T3Ju8lIQaqaQPU4PjKmkKwKXd/UNIqvs+nJRknj9y7aahJHsaDsfAY14crjOX6X82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110536; c=relaxed/simple;
	bh=0BGQ1ywOPTwcj7kBFirTpOpSy2qz3x+iSNssj2F6ElI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBC/1hBfzgwarec1Dk0d57P6kDfI/wIpTkKMeJp5X+KmDWSzvB8mwrdq0BQ8KHRLkcXspyfOlNu5w4E9Tpg+S4zavrai58vxBBLnjY+pJW29nGjM87kz4oiAWkZ399VCFgzKMOQ/7VXBMBqI6u2/xjGxbwvmldinpCzCFdljakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJX83OXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C59C4CEF1;
	Tue, 25 Nov 2025 22:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764110536;
	bh=0BGQ1ywOPTwcj7kBFirTpOpSy2qz3x+iSNssj2F6ElI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJX83OXxS6d3U/cIwDDI76/31yS+LinvdNSkeM/PzmMsuIznM8m8cP9vh9rfGSejI
	 bSvvMBVog0+fRBgytA1W4Ka06RNDkupJTpadoX9by6AS46o3F7shaAy8Sypzu3QPAs
	 Y6ZolBilBLH9nqYyqBracrqHQNoeE1Yy8zedb3JUdP83D2FfSy258BXbqh+u2S2TLf
	 V97zsIRef5oAr/mc8PLrg8SenQ27pt7uRYw/NPRpWHRbDnyFgMXgfIFWE7xp0QCkuc
	 kwTOn8OGXG4jsGQ3aFll07ZTSngztKYgGin9XSiZ4uSOjwA5BFrQKAP4OQkntczrMS
	 Fmt4JJ232ZrIA==
Date: Tue, 25 Nov 2025 22:42:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/7] spi: microchip-core: Make use of device properties
Message-ID: <8d4c9c21-63ea-4217-9579-c8a3bbb58946@sirena.org.uk>
References: <20251125201700.1901959-1-andriy.shevchenko@linux.intel.com>
 <20251125201700.1901959-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uaIBPnrPJwWTlKxO"
Content-Disposition: inline
In-Reply-To: <20251125201700.1901959-3-andriy.shevchenko@linux.intel.com>
X-Cookie: Too ripped.  Gotta go.


--uaIBPnrPJwWTlKxO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2025 at 09:15:32PM +0100, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.

Are we sure that these properties are tasteful and sensible on an ACPI
system?

--uaIBPnrPJwWTlKxO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkmMMMACgkQJNaLcl1U
h9CclAf+P44RUDiYe3FN4a4BNUderd0EgXjhLLJb/umaPNizfbpqOC/kSIltImYK
4BBi49mc1/wuFVnib9SKrGmygS4IcGZvKu+6jWaBkCY5kFVOMXNm5Fnope3lA8Vy
e+l+8p9fCTd6kfh3cqGHPbh1bTx7OAJ/LWWX+NflixPReMlD7RnxQi8qaIcsUOci
jlgXnX0eUwjqLbBy53AI33DQJH/zu6ZVtRkQ/CBgy9P1N4Uu6EnrfPYrQjPdd/Re
zhmGoLtSdM7Nuudknla1vOlgY1S8YeUQSN8F3UeGU+XifpYN9KuIF+zKqBGARoVg
nQEDtOpLbo2ATbJsEOHY0Y6Cgmbbbw==
=Kafm
-----END PGP SIGNATURE-----

--uaIBPnrPJwWTlKxO--

