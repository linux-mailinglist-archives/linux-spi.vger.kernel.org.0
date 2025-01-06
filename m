Return-Path: <linux-spi+bounces-6229-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4889A02628
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 14:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 183137A20D5
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 13:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F31DD529;
	Mon,  6 Jan 2025 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUDeXyN1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA827726;
	Mon,  6 Jan 2025 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736168899; cv=none; b=KUy1X2zf3QMINTwHUfi9h77hi664qKnHXqYEKkHx05TErijOZkWhv1BxHUefPNGIHfdYH0C1wAjlxqmzz193kGRtDaLiXtLqO64htc1vGS48dhf0DkWMpFBysollnHxdan7KbwJCwWCL40XCQw4EJvvvPeD+GSnxC5dKfuRkHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736168899; c=relaxed/simple;
	bh=Odx9Mi78CnBl/areN0tvg+kryNXSjlbRYjIftgM5H8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWhRb14iTNUKnpkNl3cCTgzHEFOXOhiIilvx9GZZ0Hx2rcIFjUT0q4E7VteadJO2b1fEos5e4qNwHlXdodw/899ZWWpJNHT6HLOqvrqgCW2Cr0mGCIhtDAjApLBKvNvORTQ7v6TRLkXn5De2cCeCrTAr00cPJzT/5k86QUJC/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUDeXyN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997E8C4CED2;
	Mon,  6 Jan 2025 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736168897;
	bh=Odx9Mi78CnBl/areN0tvg+kryNXSjlbRYjIftgM5H8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUDeXyN1Jlhl/AxkbRlfAf2u8WA31or+eOCr5Y7MMHiOuy80W6WA+gJjc14yb/dAR
	 jI8DFjz03bz/c3f6SivfQuByjI3oOnbsG8TTlZc0nyos/TjyLu57qMMbs35e/mdor2
	 EU2DaplKu0ygrgNvJw4wXAfqU8teWx7y6WapfRtfU8vSQ9duGGrjTTZPc/6b1v5/+B
	 mQjBpjmqRR99R1DWkCZhtnyDrJfO9TMRHSCDdUy/ANsEZym7aOAlBbDIMZxWcsMl44
	 oDjFCT6tfN169qJdVEJu0ezMiXe0E/Wdgh01/WAieVnqtUh2OilVLu7egU3i1RnXN9
	 4/nBKZmMrd5TQ==
Date: Mon, 6 Jan 2025 13:08:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH 0/6] Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Message-ID: <eec9caa0-0029-4774-842e-af1d1290ad97@sirena.org.uk>
References: <20241229-update_pm_macro-v1-0-c7d4c4856336@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="emAp2yveWLVSOdEe"
Content-Disposition: inline
In-Reply-To: <20241229-update_pm_macro-v1-0-c7d4c4856336@gmail.com>
X-Cookie: Do not pick the flowers.


--emAp2yveWLVSOdEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 29, 2024 at 12:32:39AM +0100, Raphael Gallais-Pou wrote:
> Prevent the use of macros, and rely instead on kernel configuration for
> power management.
>=20
> This series makes the same change over six different drivers:
> usb-st-dwc3, sdhci-st, st-spi-fsm, ahci_st, sti-dwmac, spi-st.

Is there any actual interaction between these changes?  In general you
shouldn't combine patches for multiple subsystems into a single series
unless there's some dependency or other interaction since it just
complicates management of the patches.

--emAp2yveWLVSOdEe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmd71bkACgkQJNaLcl1U
h9AGHwf/V/ekmXWwVL15xDEBbZZ+uqPpz0aLMa1v6gvSRA3S9ugHT9vW0elxEGf0
2+0EU7GuIo88DOYxKpOYDd1XHk6xkBI7Whic7ijl1+LK8Kq6Rec0zpzlsv7Rcja1
TmoHi68uCDrHguH5BH94YBKZVfT2U0gSc20ljleO66MKEJQEYob46c3649Gbpxwl
UPiwHVuWa6eMXfzJsS+vZgMEE58Q57GLiVmbZcN0u0FC1QM83kVDExYTCXuTtwx0
g5fiTrBVg4O93cd003jWflIlqao9U/nMREgX5M9/CytGX32MeXIPLlt73A15itVF
DQJXk1CapG8Sm0o+2Y/tH5c6IVJqFA==
=p10y
-----END PGP SIGNATURE-----

--emAp2yveWLVSOdEe--

