Return-Path: <linux-spi+bounces-4858-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB1C97BD3E
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 15:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8D81F23423
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A493E18B476;
	Wed, 18 Sep 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDOpX9Cj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1E118A95D
	for <linux-spi@vger.kernel.org>; Wed, 18 Sep 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667114; cv=none; b=sID+YjjKCenLqz520/EkM1vfK1s1xCv8RArUQksZ5VtRx+FDX3ivWD+qW+GAakYHqdJfdbRqw50PT1ufw8t+uVme84y9J0RmCrhJ7NNEzKNPz0LVptxv6GtUO590AzKgaL+nz9FeINLbNu8O7qQaTkY7LoKAq6xdp8mE8NmCIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667114; c=relaxed/simple;
	bh=cL6lpSz/kdR6T4KeqPH7EEkrh+WFPe2uL9PykCNsqqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbRZm0YmhMNRWJg3dQQujlEfAoYMQ2v7u05J3m174OgLx836UCnVffztSOk8orfnS5jiGxjRXGbi32KtlBBvK3w4S5fvO5X7fDJrZ6TMg8B5zRe/qB1nsldCOCMSUESFE7JAl9saFtP2wrqVvkxiTzat6p7Ii/ov95aLfpTcCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDOpX9Cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95F5C4CEC2;
	Wed, 18 Sep 2024 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726667114;
	bh=cL6lpSz/kdR6T4KeqPH7EEkrh+WFPe2uL9PykCNsqqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDOpX9CjSUgIJakr6qUKjN5axzMtd8hgKuof/Sdcp5Nycftg8xK/C7FXXdSYEJ6RY
	 rF2arMHrM5eHns0mgfL4ag/MTKsKgc8bHXAPzT/bwILqhw7OWKPCSpqmhl5goy5eQD
	 hT6dXCh+UzloN+FYe2OOvJ9dDuAWDqU7HUHjUpDQJTz656Vkk2127KpSVstIOuLy+4
	 1od+pJwL/MAl+H3aQkoplS5sDz2Pr1NSVmwiqDCNyjehCVY2Ikd36bl9rg6wAlac/g
	 l47uTubbe1Tb/5G9HJXfJYSR+HzceovEWL+4R47XpkaxIewKWeOnfEjv8qjahUGwb2
	 PTufLyENcV4gw==
Date: Wed, 18 Sep 2024 15:45:11 +0200
From: Mark Brown <broonie@kernel.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-spi@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v6 00/12] spi: add driver for Intel discrete graphics
Message-ID: <ZurZZ1pzmbWifjAD@finisterre.sirena.org.uk>
References: <20240916134928.3654054-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bs8sGvs52rAy0duI"
Content-Disposition: inline
In-Reply-To: <20240916134928.3654054-1-alexander.usyskin@intel.com>
X-Cookie: Editing is a rewording activity.


--Bs8sGvs52rAy0duI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2024 at 04:49:16PM +0300, Alexander Usyskin wrote:
> Add driver for access to Intel discrete graphics card
> internal SPI device.
> Expose device on auxiliary bus by i915 and Xe drivers and
> provide spi driver to register this device with MTD framework.

As far as I can tell this does not actually provide a SPI driver, there
is no call to any SPI API that I've noticed here.  The SPI framework
does have support for SPI controllers with specific flash support via
spi_controller_mem_ops but this does not appear to use them.  Either it
should do that or it should just be a MTD driver.

The series is also split up into too many patches with minimal
explanation, making it hard to follow what's going on.  I would
recommend making the first patch be a minimal functional driver and then
building on top of that.

--Bs8sGvs52rAy0duI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbq2WYACgkQJNaLcl1U
h9BCZgf/W29Rkg31k8d/BbDhUYZW8jjlXYf12ChmIOuQyLVOpr4YRUpMoFKl1KGz
iu+tQ3AK35GqadvAzuEC3U4cyrM0bdthCUNFlH2I7zC5gMFFutdGumdF9D7EYke7
ygehHFnVZ/bHZg+Nt7zCqPpJtlboc8Tf130goHxzBougrUA4+HCH0r00lPgnVwJP
pOOAFgyYXEhvUKbZffE4jTorrTGcWGZm17TnTA6VtDL+KYBYls2ltLbB1pseRelB
tmGZMqJmU7cyJY1tVl4Hh4wsnziLPCyi/JAzZnS5WwFWgq3si4ZV1V9mTXkq6MM/
JqOpqfUJbVvxSSXkYUVoFFqqwjjcWQ==
=JQuG
-----END PGP SIGNATURE-----

--Bs8sGvs52rAy0duI--

