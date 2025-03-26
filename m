Return-Path: <linux-spi+bounces-7311-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B39A71547
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 12:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93FB87A5439
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 11:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E387D1C8638;
	Wed, 26 Mar 2025 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcW1iWfI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F01ACED7;
	Wed, 26 Mar 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742987118; cv=none; b=S3tJono8FNw8vB72y7L6H0i6NrbAm3Uvn4M+TVLgzpn7qVBU5BtDs39kq9Imm6t5di3Aqlqgw0acq9bdMyL7oQHp+wRvrcsyo8GJbzIKd0w7VzV+Ewb8ZqM7C1DYsbZEtBoBkOf1zewmhc3bXsL2VpxBA8nY3ILXfvWX3beQAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742987118; c=relaxed/simple;
	bh=O/NrNDBWcq4yxiKi3t0WOltAx3N2JfHYhLCVbbxkKYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh4X4Q9DetMIt+OVq8Iua+RQWwZgOaU4S+uoUKnua4ghzDaivrddQfrRgIjTgVEmi2BbrMOgVPsletAgaKoRh1sy0sPsZf7F4h2ZOL09cbbu7kPaGOp3VJRmAuti3jxdErHNkJAAEWc7+wvlJw6v5mKqDnlrcJFzJoc23KF9PzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcW1iWfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088B1C4CEEA;
	Wed, 26 Mar 2025 11:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742987117;
	bh=O/NrNDBWcq4yxiKi3t0WOltAx3N2JfHYhLCVbbxkKYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JcW1iWfI1VDs+i1O4khq+5GS9ZQuIJxUfUEogQVXFPXK+Ln+QQdAlomVajfrer7d1
	 YdR2Y/ijPdDKzD+YwZBLZ0dhTZ4Y75qaldfJ7OgfwA3klcpHTQI1O4A/wdeGaFavDj
	 yKl7YcGbb1m+Qjjy5nuJvXjOBFlPKYS30DfyMKCUAIJYSHttbh5/n9gX/aSLRxWm/t
	 9LrqlUPDxEuSPmR/m3piiI0i4JaagNETMnAFStfW4g+RMLDZQIl0aHKm3E6UB/3vAD
	 d3gCxY/a/eyfpY9FSAcWMHBkrESGiBqRnRyWRTS8l+0xGk3WtVYeGNhJqye6kT9bfI
	 9J1b0kI7Tw98Q==
Date: Wed, 26 Mar 2025 11:05:13 +0000
From: Mark Brown <broonie@kernel.org>
To: "Rangoju, Raju" <raju.rangoju@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	krishnamoorthi.m@amd.com, akshata.mukundshetty@amd.com
Subject: Re: [PATCH 00/10] spi: Add driver to support AMD eSPI controller
Message-ID: <6a67247e-0b20-42fc-ac0b-7d4a8cef410c@sirena.org.uk>
References: <20250313183440.261872-1-Raju.Rangoju@amd.com>
 <e41947bb-7a2d-4b64-b680-d38dd9935a00@sirena.org.uk>
 <55ad37f1-0fbe-4a83-a998-80f2fd94a883@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dF3WLSg8MViE8dc7"
Content-Disposition: inline
In-Reply-To: <55ad37f1-0fbe-4a83-a998-80f2fd94a883@amd.com>
X-Cookie: To err is humor.


--dF3WLSg8MViE8dc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2025 at 03:25:21PM +0530, Rangoju, Raju wrote:
> On 3/17/2025 7:44 PM, Mark Brown wrote:

> > I see nothing in this series that registers a SPI controller with the
> > SPI core.  You need to use the standard frameworks the kernel offers to
> > provide standard functionality.

> The AMD SPI controller hardware has only the chip select line enabled, which
> is connected to the EC slave in AMD EMB platforms. Currently, there is no
> support from the slave device to register as an SPI slave device with the
> SPI framework and provide SPI communication.

> For this reason, the AMD eSPI driver is designed to handle device
> initialization itself and provide a character device file as an interface
> with user space for dynamic interaction and configurations.

If you want to ignore the SPI subsystem and just write a driver for your
embedded controller then you should put the driver in the subsystem or
subsystems for that embedded controller (possibly MFD if it does a bunch
of things), not SPI.  Even if there is no flexibility you may still want
to have the controller side in the SPI subsystem in order to help with
reuse with different controller/EC combinations but if you're going that
way you need to use the SPI subsystem.

--dF3WLSg8MViE8dc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfj32gACgkQJNaLcl1U
h9Bwwgf/YPwDtZ4zs6XsB93rG5ZVFOFOWco+SyXRlDY24VhG6NI8XQSUtvGAKmGn
HfX736kC/LtjLXWSuDzeFPJtgsB2BsRlfFp61bAkcA4ZGvl5Ifct2Hr32wS9KpVY
akUK+iDJhJ35i5wWnM5gt+BYMtSqSwknb45j9SgiA8A/i0sxOh5ph0gpe2P8iQ8y
Zg476BXRcF/zCQKLzRjqLMBp5kAAVyFxAtoNRNNeOnzYlMst9Kcl3nQ/4AQoZvqA
W9Ob7vXV1E14V7duwJ3EF4/5NYAbOCvrHTNw06YMIlPDf7cInbQxfwgM7G2NG9r8
4TQ9MnhR2hyrqRXD6KOB+5d67DNf5g==
=qoOI
-----END PGP SIGNATURE-----

--dF3WLSg8MViE8dc7--

