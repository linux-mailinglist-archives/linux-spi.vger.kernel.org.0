Return-Path: <linux-spi+bounces-3747-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9171927783
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 15:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83367283895
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC9B1AED29;
	Thu,  4 Jul 2024 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOVqxexr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED171ABC25
	for <linux-spi@vger.kernel.org>; Thu,  4 Jul 2024 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101197; cv=none; b=XYiBZm4kwuFpAJ/WqmHNs8DWeraSMzOvGkk+jEmqHYvjAR0+MQJ6j9aN4ZqkGhVmQvG4gRasYWZDfyfmjmLnq+2YNsTz5NhWuKTX13lt/cT0kPsCZBC54T2/cBz7SsQLr2Ccqy4F/ByR2sImfcQiY+XKm9MOV/niMK0vZxbmzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101197; c=relaxed/simple;
	bh=Fswm1z1gTa5nwAo7btt3tiVR0nwPP+hie3Vm54QcE0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEW+40iDQ8knah6z8R+p7eEC8Ez/Ayjd7VwR+qWA3TTDZBj1k5W5WOVZG6cKKaGKaKHQ+HZDFQY4ATvwqwMrZcX1iZqEgz9cCMNUyZtjz90dNYGUielNLr7VTBMJspsj2wQPwcpu3vFCfy4FOrcUQfnp1fONF3Dih7cH5vBA3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOVqxexr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D008CC3277B;
	Thu,  4 Jul 2024 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720101196;
	bh=Fswm1z1gTa5nwAo7btt3tiVR0nwPP+hie3Vm54QcE0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOVqxexrtMWkgXJe9PO3Xf7xyfY0DWCwhBUrIckrn7Mo1z4/4mD6w45VIyYFU1Peu
	 +Inydqela55l6zPDes+Fef/4tYtmStdnC8sYFxHOPAYvnUkKRZ9NYNUGCXs8G5nxrU
	 wo9Ytp58wVi0xspV+Z3WhWSf8GKR5dRF81MUnPSjhyrbs3fRArD5ztm/6z6bpHLQfk
	 0OEv+BHlmdChJXocpjm/qlHeB0jF6X5vph9jfjHxxsKNVxwtV4eyxFczGxuNAGgkcz
	 9xcfqOkuiAkIOB21KWgjQleCVnNXhVQSW24fIiL6jcjfH+01e5A0EseHPWp3bow6Nv
	 rWiaIUXZ79PAQ==
Date: Thu, 4 Jul 2024 14:53:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 1/4] spi: xcomm: add gpiochip support
Message-ID: <3ca36d0d-581c-4e24-9466-fb30a3a22d71@sirena.org.uk>
References: <20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com>
 <20240704-dev-spi-xcomm-gpiochip-v1-1-653db6fbef36@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sJHEJofNP8TRQkNC"
Content-Disposition: inline
In-Reply-To: <20240704-dev-spi-xcomm-gpiochip-v1-1-653db6fbef36@analog.com>
X-Cookie: Today is what happened to yesterday.


--sJHEJofNP8TRQkNC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 04, 2024 at 03:49:12PM +0200, Nuno Sa wrote:

> +static int spi_xcomm_gpio_get_value(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct spi_xcomm *spi_xcomm = gpiochip_get_data(chip);
> +
> +	return spi_xcomm->gpio_val;
> +}

It seems like the hardware doesn't support input at all so should there
even be a get operation?  gpiolib appears to cope fine with omitting it.

--sJHEJofNP8TRQkNC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaGqUgACgkQJNaLcl1U
h9AkmAf/asv3qDNoiXdl80dAnZfakhbf/7PNzB4XnS2lh1+e+tjCiR6Zm+O4cENx
A24/XkHUcYppGyBP1BHtDRFrAm8Z9NdgVTATdhpd9/ogGWt6cNsXsDnpA/HdDmD+
Hodu4xWG/9ifEGzVIlNqoJLKyLk/qgZEFlmX0eJ9RztoyAbGS+qMmG15Vsz81NCF
J6NjQs94wXd2haUV61mt8x15rI/2KiwFz1R0p3tW68HTvZ6oL3YPdzyw1ZsaMlNo
/HeuBVaD4gsEZQ32K17loOTaLJ7qwWZb89x3XAUiNaGZ0BzVaA4O4KUgeUKOZGBC
q1mFNJX6Dh4/RotGX6/ghKHTitOG/Q==
=LMKn
-----END PGP SIGNATURE-----

--sJHEJofNP8TRQkNC--

