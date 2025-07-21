Return-Path: <linux-spi+bounces-9145-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1722B0C5C6
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 16:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6EB3AE265
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3248E292B22;
	Mon, 21 Jul 2025 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfToHOwT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078D825760;
	Mon, 21 Jul 2025 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106679; cv=none; b=ozyRD6dVr69gvnspMo0LQyWAY9LJvtB7EaVnM3Kifr4LI0HADQUomG/SHPIe6hSQuA4/de/1ZI7wyGdRtl0ElFbbF0cxncCIN1aTy4bKC8dFTJhU0jMdPVdHQHXPBqIgvVfXpa4HDkpB/KLX0XzQ2Ni0uuF4ROcJzG7Jwzdj6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106679; c=relaxed/simple;
	bh=ZRFSItDRtsrkuR9rheQjoPP+y9yHZtan8WCMiLO9Ffc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK5axumBmslBNuVapiE0DVkpybJHtNIrU7TTIMI+pdRGqQ8K5chpXMcpkLh0yIjC7yIUefnqxoQNZtT4tt0CtMTxqIPzVq9lnk+c8rw0wW1WZM+kgnTRze5Z+ZvKrQ4QyG9UuWjilzbNQ4Uke5ZQlK92KeoJSLrtVqOyLZ88W6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfToHOwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349C0C4CEF6;
	Mon, 21 Jul 2025 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753106678;
	bh=ZRFSItDRtsrkuR9rheQjoPP+y9yHZtan8WCMiLO9Ffc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfToHOwTr0a14oiBpRqljFKUgpT31x7VxRPnBJPHLJ3GKg+GjUMj5o1Idi0TQ4wd4
	 PUiSTPnZxIrIrryEUSKWW/TuqiDPaeCLn5d/tl6D0pByTdR/22tKXaR3gjR7uYSEFF
	 /z0ZUYtM4Od1LjU5rITjYMsTwlmi2WW6p4gYlUyXtgJv0VzJckaJmLQGslq+KMlXq6
	 BHc9NFdX465Uhge5OsxMzI19rpdtAioXw2DYartFzDZmEwXb1t69e/H+ed9K3FNOec
	 JvZrfdB7p4jh4InhhWXfvNyd/L90sdHOIQ5KTmGttkx1jvvq9RC6moG8aJyDZmph5t
	 H0O2ucR7fNR2A==
Date: Mon, 21 Jul 2025 15:04:33 +0100
From: Mark Brown <broonie@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] spi: spi-fsl-dspi: Store status directly in
 cur_msg->status
Message-ID: <a1f01911-8cba-418a-8393-1d6ad3badb2f@sirena.org.uk>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-2-178dba20c120@linaro.org>
 <20250627213041.vp6yfcgf4xysdklf@skbuf>
 <eb704af4-5800-49b6-9915-c990c5b23fa1@linaro.org>
 <20250721133958.dhityxa7vvtqov3d@skbuf>
 <e23bac2c-c39c-4446-9305-e7e51eabcb4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aMtzLzsOA1vyg0LI"
Content-Disposition: inline
In-Reply-To: <e23bac2c-c39c-4446-9305-e7e51eabcb4b@linaro.org>
X-Cookie: Microwaves frizz your heir.


--aMtzLzsOA1vyg0LI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 21, 2025 at 03:02:09PM +0100, James Clark wrote:

> I'm also not sure if it would fit with can_dma as that starts mapping stuff
> in the core layer. We want to avoid that because we need to write that
> control word for each SPI word. We could still change mode conditionally in
> the DSPI driver though, or make can_dma more flexible. But on top of this
> for sure.

Even if you need to open code the infrastructure the idea of a copybreak
should still be useful.

--aMtzLzsOA1vyg0LI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh+SPAACgkQJNaLcl1U
h9DpZgf+MdtFYAGs9n+vc1jIjGnB48vgl+5FmAp59DjbjL+tkhyv0h2qjTJ+gf+i
SwE9pkbEScK/vElogElVJAVWt1xW9F/v3XJyrwJqZWBnGs1USBtafHUBxd3qovLt
W/ook1uKpYTY9UwNPKev3eFVaRiT7H35lVf/nb75jJix8yGsMd/lLPWU9DHq//pp
SQURHCCohq1tK55hQb6YpynEwQJcmv/ib6mxJGLfPy/0Ex5bnczkGE7O4gkwxlG8
v0a1ALL5+or1dWySYO0IiRtPHn3U+tfZ5x9h9zjaGVt5x/XvGyyxFjlGedBMXm80
HXCsQ35DUbMpNKIedcL2FKA/vCEXtQ==
=Mo7R
-----END PGP SIGNATURE-----

--aMtzLzsOA1vyg0LI--

