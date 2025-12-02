Return-Path: <linux-spi+bounces-11728-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA68AC9C74B
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 18:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E083A8245
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 17:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D70257AD1;
	Tue,  2 Dec 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUzQhVDw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92E20E005;
	Tue,  2 Dec 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697615; cv=none; b=TWELDvqaTPRHb8KVd4rgSWrhfi/HcMFV+4IoOM6d5ULkfBF+g1JdR/HeB4uICBGPH6UVggcpdX97QJVM3ZO2V2H/9qAsHt43hVYilW4QOpUUJb9dagDCNMTFEXzkDSuhUbZV3XyC4SfmyUZWg8OversF0w3jV2o13ErczsGGD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697615; c=relaxed/simple;
	bh=FoOWGQVSILSY2LCwnjOUdG9c23DhH2skDKSWL1XhrLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DM0i6qzH/3AAS3DI0hwlJ8HhlV1FD5+zWOmegl3B6lomRYxeloPX5ldXs6oGwJ/LH/sr9Gaj5LTXVe5YCPbdluYz4/cNqJ7+Wr4KsnRU2HhnWPU/cTiql0P5I1lWJ+efCBGVid8P67apkQJ8QMx3RSm88A3KRixlxvPgx65Craw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUzQhVDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3585C4CEF1;
	Tue,  2 Dec 2025 17:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764697615;
	bh=FoOWGQVSILSY2LCwnjOUdG9c23DhH2skDKSWL1XhrLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pUzQhVDw7V3KLNNsqu2Na27VDRYnccmRAheyvC/ThXyFOei5OjD8FAqmJ1MH+pkZe
	 64A1jFG9HgV+0xHmFZazUbLLGxioyDZ97QxAidJA979pccUyr+GZSvPt4PiQGdZhZt
	 hu6u7FnMPXJ75bDYvunIlmEg8wylfAwuvN7IQ3+UEs4TeJbEJf+Z7daqT/rh0wOjuX
	 GzV/GDNEgQ3aWRb9tMiOEVcodY07Zuw0GuEZw+dvUAwu0geQMOyh5gbpnxmRVGdeIZ
	 04S4b9xk5cJyUP6kjslstjXKXOQmgTEQmWWN1HsYdOzjbxCbo/P1JX6oKMk/oJ7JLe
	 Ryt8gGt8UXHvg==
Date: Tue, 2 Dec 2025 17:46:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 12/12] spi: fsi: Convert to fsi bus probe mechanism
Message-ID: <0cd8f471-19d5-414b-b531-467e774e7fc3@sirena.org.uk>
References: <cover.1764434226.git.ukleinek@kernel.org>
 <a64cde17039056d71a1bd14ecc36bcb67305b31e.1764434226.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jkNpanR8JoUwIaZ/"
Content-Disposition: inline
In-Reply-To: <a64cde17039056d71a1bd14ecc36bcb67305b31e.1764434226.git.ukleinek@kernel.org>
X-Cookie: Beware the new TTY code!


--jkNpanR8JoUwIaZ/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 05:57:48PM +0100, Uwe Kleine-K=F6nig wrote:
> The fsi bus got a dedicated probe function. Make use of that. This fixes
> a runtime warning about the driver needing to be converted to the bus
> probe method.

Acked-by: Mark Brown <broonie@kernel.org>

--jkNpanR8JoUwIaZ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkvJgkACgkQJNaLcl1U
h9DWlgf/YauL8+iSEfKXXLYmJVoUpl2hBcsGwqzC6yJfju7r1LwtzEQ+beiOdjhX
cULXHZKL6vAtmYNkb+VCiddGAgSVNhVrnW+Zsy7foqSCEjBCpfbnsnTZzcgRcVWK
Yvya29mipC6h7UNgdB+WyUme5t/QQ04qWZAvLsRFabKAjF7XQJQTBv6yseN73Oz4
SVTEKoqJoMLvK7l4l/yaQGCdgbyWpFNshaHoHVUiyQ3NiMuyBDAlgom6tIVfkxUy
8s51A5L2e8bun4zmYgP8lMGF0ARP/k0Y1x2g/lDbJfFh8t8Y53dHmi8O4dPi5rKM
irD3GbHh8cu4/hdedS+O2yFnQOxS8w==
=MacC
-----END PGP SIGNATURE-----

--jkNpanR8JoUwIaZ/--

