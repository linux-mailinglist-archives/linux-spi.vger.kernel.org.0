Return-Path: <linux-spi+bounces-3268-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 014BE8FD850
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 23:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D701C23D32
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 21:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545B315F321;
	Wed,  5 Jun 2024 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcTFtAHj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42519D895;
	Wed,  5 Jun 2024 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622500; cv=none; b=TS+XTLHLVv8JsUQxfRR62ukS4rfg5QFoi6wlQsMkmxQTPSD7Iz7LPIPuR7gC1qJSAyHyE8XNTkPEnPejA8kZCSJHsbfLQPjgp1r0o/oPu3ru6Rt2tLdQS0YtOMa9QmORluRwxE+J+rukZ/VzEN9qjRyBR49wAOrGtQebaxKyzMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622500; c=relaxed/simple;
	bh=mq+46fD/yCdLIjl9uybgKM+xFkcxzhrkXDzV0ipNP5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DojdSRV/LoNC8Jlxe9Z5QgeTioOlbpZg8XSOfxc/1p8HKLaIwqKoMiqUpR9TYOvoPFXoGzFRSodB/Nw/gnI+eDHBZsac5LMGOeVfrebV0zo6xWikS31WxS4cUUDNWhBzCIJu9N6qZ+Hp4txbGTIrzQyS/RsyiIzx8rUvm4HP4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcTFtAHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C91C2BD11;
	Wed,  5 Jun 2024 21:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717622499;
	bh=mq+46fD/yCdLIjl9uybgKM+xFkcxzhrkXDzV0ipNP5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tcTFtAHjYX2yrdvbXTyu8NnuS4qAS5hXplWxAa8nGL0bGX46QKVDSo8kehxhY5bnB
	 spjYVVmAFh321dNPknhZqapQQNUEMwPTQ6UOwOAUN4FsIFOgxx8ciPEHqu2MM6B4Bj
	 RhNh+8Ou80UkwB352FfOcqSKjIrhs0WVe8m1xKqntoWQmMNAssAD4turgXMfgP05bD
	 vv42GaAgtltrRQI9zAwwQkh5nbYQIzrkvjUzXVnQPDOSeM26gUqKcTdiq8y6PGsffh
	 WPFV3972U7Ua1E8m49g4TLJs2P2BUaidzxVFJFwMZw/LEbEgAZc5AMuO/0rrexfD2k
	 WKonOkd8c/UEg==
Date: Wed, 5 Jun 2024 22:21:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] spi: bitbang: Clean up the driver
Message-ID: <444b20d3-9096-4372-917e-1b997e59cef1@sirena.org.uk>
References: <20240517194104.747328-1-andriy.shevchenko@linux.intel.com>
 <ZmDTgtONF49f8cBr@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bgpco7hh+3zikyRs"
Content-Disposition: inline
In-Reply-To: <ZmDTgtONF49f8cBr@smile.fi.intel.com>
X-Cookie: Simulated picture.


--Bgpco7hh+3zikyRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 12:07:14AM +0300, Andy Shevchenko wrote:
> On Fri, May 17, 2024 at 10:40:19PM +0300, Andy Shevchenko wrote:
> > A few cleanups to the driver. No functional change intended.
> >=20
> > Andy Shevchenko (3):
> >   spi: bitbang: Use typedef for txrx_*() callbacks
> >   spi: bitbang: Convert unsigned to unsigned int
> >   spi: bitbang: Replace hard coded number of SPI modes
>=20
> Hmm... It's not the first time I noticed that the series
> (despite even appearing in the CI, but then disappearing)
> left abandoned without clear feedback,

> Should I do something here?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--Bgpco7hh+3zikyRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZg1t8ACgkQJNaLcl1U
h9DECQf+OJsH0MWYqzm5O2Hn9MDTykYS6fBdEa+ddBkwp3umBF4JiaK4cIFUBQIa
GdFoOub3gdhB7GU0wSaVKzudrBrwblA2ianiCyK/tL+vk9kGs3zj/265JKCW/Dq8
OgczloHMAIcKz846YdUAloaOY0KQwsxLf+b6HUkxeWqXwcaC/gzcdh5mVkc6bxxn
kv3AZpxJzbAHHb/w4Ygf9/BkYxI4mF3QUsY6Qa+grk9HLmg29861hS+Xm6hHjHX1
/zGgT/aqpiphf7WaXyvA9BwsrUVKZtvIXc86JlOj9yKOIPRput1/cMhmYp7qzHxD
fVXiTa5R2zjevt9SZlLRuFsn1mdK2w==
=T2zi
-----END PGP SIGNATURE-----

--Bgpco7hh+3zikyRs--

