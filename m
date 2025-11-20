Return-Path: <linux-spi+bounces-11419-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02674C751F8
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 16:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BE933661E7
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953A7376BF0;
	Thu, 20 Nov 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGzNRPlO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C92D7806;
	Thu, 20 Nov 2025 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653262; cv=none; b=Dp6eyH+itGGvijZQG5GaXdFxFALmCNtoO1R4SMQAlIo+bkkiLxjU2YzyK8aHkokk2HNtxwSdLPUSchMK2wR0vOAZDaeC0hhWfTETBxlqI1WdudFnRiMqEnXoGIl/ps55kssa47u12qMcyojCL7nlSj1AU3CvuggAs7YesaGGuos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653262; c=relaxed/simple;
	bh=0hY7oqaKrN/l/NqnjJ3E9raGrfa7kCrwvlrO+yXm6Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6dkSbSj6stevm/yabh6Myc5eXKoB7ZHTbv6vMK/bNPH/w9c9fQc8o6YjuQxfygwMWNHITrq+8eBbmJKRs9iTSOdcyP2lu6Bdh3ki56IG/l9I2+kBeibPK5VlxmnvKtT1YeAvfCmjW/XaEFO2Unbzkutv3GqzsqUL1j5CUd0eos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGzNRPlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0BBC4CEF1;
	Thu, 20 Nov 2025 15:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763653260;
	bh=0hY7oqaKrN/l/NqnjJ3E9raGrfa7kCrwvlrO+yXm6Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGzNRPlOKyW789+cPDChpz5r5xsSoRyMD+kqy4CIfRpJEA0JnImhvy0jK+hKQ+mO4
	 T7PHC8QwtOgD1K+rGzgjUsgCc/HJnzriyLux3VfaERuCZwMUMbryZbhJGaY5Agx1Hz
	 Mc1LvsRY65ZTsopyxVnOXEwgNzYbpY/mmCzI2zs4kiKCENhJ6SdrNNB7oKx0XuqMwt
	 /uAe1KoPlUQO5bs1rlmWyk3XVbkcN0SmTzDReo+BD7L/dpt7+u3FHMHf2a8hNIrkp1
	 FJxsFj7gqRaxKx+8mQ70I9e3qa8ypG+Yi6QhCciDyqiYqzVQY/HxQQJhnRIp+DS/ud
	 EV/nvzTh4UwLQ==
Date: Thu, 20 Nov 2025 15:40:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable+noautosel@kernel.org
Subject: Re: [PATCH v7 4/9] spi: cs42l43: Use actual ACPI firmware node for
 chip selects
Message-ID: <f37ba9cb-7ed6-41b2-b423-3ad3cf9b371e@sirena.org.uk>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
 <20251120-reset-gpios-swnodes-v7-4-a100493a0f4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JsE2zsHk8MEHlqtJ"
Content-Disposition: inline
In-Reply-To: <20251120-reset-gpios-swnodes-v7-4-a100493a0f4b@linaro.org>
X-Cookie: Smile!  You're on Candid Camera.


--JsE2zsHk8MEHlqtJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 02:23:59PM +0100, Bartosz Golaszewski wrote:
> From: Charles Keepax <ckeepax@opensource.cirrus.com>
>=20
> On some systems the cs42l43 has amplifiers attached to its SPI
> controller that are not properly defined in ACPI. Currently
> software nodes are added to support this case, however, the chip
> selects for these devices are specified using a hack. A software
> node is added with the same name as the pinctrl driver, as the
> look up was name based, this allowed the GPIO look up to return
> the pinctrl driver even though the swnode was not owned by it.
> This was necessary as the swnodes did not support directly
> linking to real firmware nodes.

Acked-by: Mark Brown <broonie@kernel.org>

--JsE2zsHk8MEHlqtJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkfNoMACgkQJNaLcl1U
h9CFFwf/ThK/ORvrdAYrN14PWvivAGfH6zY6C0jHi94oohgnypcc2n1pGrAEcCz3
DZv+JPPrnNJaJNM3IGdI2xT2xfkOnLa6IusyMficnitbTt6NdWTBdhqOsCb7HIxU
XLTE8nMXUlyLmZgoXN/GIVXo3n18+/gThghH0Rs7t+dvYpby1pSCWduaW7JzRdjg
tCgjK8UAKg1nhQOY69UOfbFx/KyeYzG+jvHR6ZWQ6SIh8CeVCZkcUeA+Z20GZ4vE
19PhoK5GYO3i3CKkryQ199kLuNIN5Yvmk50+aszK4jVSJ7/HghgImOJKplYnjjOR
A1Og4Hbn2ysTJMM6n7b4mSJUsHbXsg==
=e6Ug
-----END PGP SIGNATURE-----

--JsE2zsHk8MEHlqtJ--

