Return-Path: <linux-spi+bounces-11679-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4793C97792
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B73CF4E0644
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF12B2F6574;
	Mon,  1 Dec 2025 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRFBCtcq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576F2D8DD9;
	Mon,  1 Dec 2025 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764594414; cv=none; b=aFOY7wK7yA5tjclMKYB9OsV6PAsXfauktjNSmVWAEP48MQ6ndOO5n14tMMZvk3n+pIlCZnipU+V7B5eTel1tweztAMF0f05MhltE07eqjxbQED7K9akiwqkizEx/7IqqfsKOgTgse59zts9bYqyDkAIlrgW9zrL4axZQ0OWZb7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764594414; c=relaxed/simple;
	bh=1+5RnnNN7CvGAZVMoxwh5pYU45Fm/I253wz8XwsbOtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abaZ5fXLQpSIlx27qdjrsHDWcszyFzSMPJ2PvAPxPJ7Hrs1oKPPhYzPck5HawLJgORI+SJ1aOxxNqaZpxTOxuO0N9BYMnpRhQ5N701+d8bRNQV6HHq741mugoIhQQIAJ1QNoTMNaFV6p2fTKsw460l9TO0ngcPQaAOHBw7qbucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRFBCtcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51F8C116D0;
	Mon,  1 Dec 2025 13:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764594414;
	bh=1+5RnnNN7CvGAZVMoxwh5pYU45Fm/I253wz8XwsbOtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRFBCtcqh1cjkNQYZHNPwVop7Aj8C/KbYyOBNkNWRJh4HC/PDi1ylyfuWgN1+lPlA
	 LFX5dQzZ9URVl8nCFVIAQzeUR29qeK6AiIttrno7nlceR5sSD6vSXbAfz5aowFEbw5
	 ZeVYtjEx6DR4oY/z3zeOgWBz4dNJalcCMJGD/iO4vEdI+uTyGzrDNzkunbpqxBJ750
	 RGOhVe7jY/PArcSRmzQtqJAbj/N1a4vdgnxv45PrjynZH0YqZ4VBlP87fx5Dd4Hmub
	 vtQewJWPpw9HUdyipgUU2ksv2IGASAUob3dy7IHm5eq/JJTNm2Hiphnx3CTDpWMVEs
	 s57vwhctODVng==
Date: Mon, 1 Dec 2025 13:06:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, a-dutta@ti.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH] spi: cadence-quadspi: Fix cqspi_probe() error handling
 for runtime pm
Message-ID: <e7ccef20-a490-45cf-9e55-16c9b2e01f44@sirena.org.uk>
References: <20251119152545.2591651-1-s-vadapalli@ti.com>
 <20251201072844.GA6785@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XLS+8YH9SW5fPxZ/"
Content-Disposition: inline
In-Reply-To: <20251201072844.GA6785@francesco-nb>
X-Cookie: Mene, mene, tekel, upharsen.


--XLS+8YH9SW5fPxZ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 01, 2025 at 08:28:44AM +0100, Francesco Dolcini wrote:
> On Wed, Nov 19, 2025 at 08:53:53PM +0530, Siddharth Vadapalli wrote:

> > Commit f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier
> > to avoid imbalance") relocated code but missed updating the error handling
> > path associated with it.

> Our CI just hit this WARNING with 6.18 kernel, on verdin-am62. To me it's a
> regression from v6.18, specifically from spi-fix-v6.18-rc7, we did not
> had any such WARNING with the master build we did run last Friday.

Does this fix the issues you're seeing:

    https://lore.kernel.org/r/20251130091251.12120-1-alitariq45892@gmail.com

--XLS+8YH9SW5fPxZ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmktkugACgkQJNaLcl1U
h9AiQQgAg/iMo3RtO0PDTE/HmwfQLuFLjH344aHIKJApkDXpOLkev3NcjJ4X3C1k
+WS4NdzwKH3sY6/ufWwavk0PFbzIWowuKaAh4LGUKJaV8JZdpeFnd2JegHdvqfsi
I1V2IoTVEwW9oJ/dEjhm3ewt2mCKKz0xWQ9w8rOeF1LItdlnWMENeGXyhqjK8N0u
pLK6o2aHhMaRe/W9HGZjEMETifpVpXg3wEdLVSUfO1JGwUbDAywHFK+kg00ASyaj
0PdmqjAARd+mRAioLbWFEKNboDPgRtU5ZaBEr9fKrzWgQgffPTKZV6FkLvGXa0ch
dOW+epKCXo4vF+1INSgvNm4Rwh6log==
=ls81
-----END PGP SIGNATURE-----

--XLS+8YH9SW5fPxZ/--

