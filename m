Return-Path: <linux-spi+bounces-10265-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73984B98ECE
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 10:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346BB1614CB
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D57528851C;
	Wed, 24 Sep 2025 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrjEEQrB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2836A285C89;
	Wed, 24 Sep 2025 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703094; cv=none; b=WQi1iKjTwSEh86eckp5ejKL14aoDgZ+kGCjal8Nx53vMeTzpqSJDVKYzi5ubsx2BrEkZONyhW5s27dd6ob0K8dHPOiPyNUszWywIWg952+Zszsmubx3ElXYWPBq71Xr22J67KKaWxNfNnaJDFItss7Gttp9GS3kLW0gY0PWCf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703094; c=relaxed/simple;
	bh=LYuHbf3X6DV3fONWB8529ftaJPFravWwKtEHngOaLxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxVB26/J4+MzCjPocUM8qcnfs/Lscs8me5LcaGTM9tBncUMGGkJ1d9WpxKN8+7ktm0GO3avdZY397U57I5j7yJE/rhuAtA+u7qXHg1CsujWBf9wN/r+kzAWNWkXdhI1uA2JZsRERMzCA8/Gpmb/hbXZc7p6BoBdRwlASVcCXuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrjEEQrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D96C4CEE7;
	Wed, 24 Sep 2025 08:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758703093;
	bh=LYuHbf3X6DV3fONWB8529ftaJPFravWwKtEHngOaLxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrjEEQrB4G7GzDNEh5LtRJOjh7un59kTXyKDwoD8G/JqFQC2TjSUNE060w1Rxd1rB
	 mf0rMb7ori0QWz+PYLDTWRw2u5W1QzMuGyC1lXiAOyStu2XZW9wQkwLPkNmaVjGaSU
	 yAmzGJvK38hf20bKRWSOiZ4HXj21wL3awJH4wbITpGB/vQT2AAwEA/bwanlKX7MgSj
	 9fOe124PO7nF0NriS1jjMNbNLONnUk+ZwUsgEg0jsIvUtidWu3v+elat5CNQOztmFD
	 XvFnR79h9BGlZNi69mpgestifqXGh+zulwnx7mj5e0tl/34z01kj1a5TNLt3to4sDB
	 c4yw5krKgvtug==
Date: Wed, 24 Sep 2025 10:38:09 +0200
From: Mark Brown <broonie@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-spi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Matthias Fend <matthias.fend@emfend.at>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 16/16] spi: cadence: Remove explicit device node
 availability check
Message-ID: <aNOt8VS8l1qr_Zbx@finisterre.sirena.org.uk>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-17-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HNWgzN9p1fTapGgI"
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-17-sakari.ailus@linux.intel.com>
X-Cookie: Filmed before a live audience.


--HNWgzN9p1fTapGgI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2025 at 10:46:02AM +0300, Sakari Ailus wrote:

> Don't check the availability of child device nodes explicitly as this is
> now embedded in device_for_each_child_node().

Acked-by: Mark Brown <broonie@kernel.org>

--HNWgzN9p1fTapGgI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjTrfAACgkQJNaLcl1U
h9DioAgAg3JKw09AiYKmuLbspKZcE/HivhJWWFKV+GD9Cu/js/nAmm+xpTqcCVFm
BYFM2Ubt9T51fNWCbLsyYLa1VJiE5a05gj4l2c4MHWJZ8QVx7/cMsHN+Tt8+Vueh
Ha1j9aCK8iPH08dIR81XdsFFOcEBcoqelRUCCHf4XEUyJPUp1F2OVdfPy5h+KwKp
Eo14XaYCdvkkk+Ei6zQDqrFnK2fBXXkfYN0hcYtinQI7G2cugNnr6QIUnnQrbhFi
uLwJe8MocnI7Yclco6XZ7kSaOC7GdaA+1BOXJxfnQIB2mi4p3xW2WwvhVylkfdxl
jaQBBbBuMhVGt0LKNWqCH4Tmkzr63w==
=/Mvr
-----END PGP SIGNATURE-----

--HNWgzN9p1fTapGgI--

