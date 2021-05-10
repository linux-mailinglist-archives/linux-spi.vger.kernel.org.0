Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD6E37900D
	for <lists+linux-spi@lfdr.de>; Mon, 10 May 2021 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhEJOCN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 May 2021 10:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:32972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243988AbhEJN64 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 09:58:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A4BA610A7;
        Mon, 10 May 2021 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620655068;
        bh=pwPZlCAZTi6VxknfHc55oXvTvxE0RLtzRQtnKA2Tjm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ApwvqKKljUpNmini5cWhy1lDstlG7JinBAUQYQIMMYPr8CX/b7gE2L6s+MVzxrNhB
         mgJsSfpb5OKotYLsEP5tWpOL4mV4Uo9Kurpv8q1ALoL4bxQy6CGRbWMPXV03S3XGnY
         JdaR45+yotvIyTzURz21odTuSZfZCLaKsU0wMeqBt9IO/Pghl7EpR2uCczKngsiiRU
         oD3tjg4UWLMVZFx/zIWtRhCsjxrgeZ3yLx9RYc8Vj8FQw/wSZ9zuY7dMys1VgKlcPE
         IcPHviTEKu8Ca1iZRuwwbmO2AeeUud0tdJuFtnQoe23QZtMIngbbCxbxADvLQkgHas
         uhbVvoJANin1Q==
Date:   Mon, 10 May 2021 14:57:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2 07/14] spi: pxa2xx: Introduce int_stop_and_reset()
 helper
Message-ID: <20210510135709.GA4496@sirena.org.uk>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <20210423182441.50272-8-andriy.shevchenko@linux.intel.com>
 <20210510120953.GA15173@sirena.org.uk>
 <YJkpYDfoUg04UEMy@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <YJkpYDfoUg04UEMy@smile.fi.intel.com>
X-Cookie: Beam me up, Scotty!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 10, 2021 at 03:38:56PM +0300, Andy Shevchenko wrote:

> Okay, I will resend against spi/for-5.14, but I don't see the issue here.

It'll have been against 5.14.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCZO7QACgkQJNaLcl1U
h9DqqAf+OSmnLzwMA7xOTPi2A4I1nkk6BXNdzfJLX/E8tCcWdsfKtXOdq40yRxtC
dBhP6lY0aiBaxY7xUHROvFWrotpBlp/ZXJJu9d9ScTq2Rmx+rCjT+OeTxtbOjbfq
Ft/WEE992xJ4I7qFRwoP0OEc+OyQ8gxapXT8iL1r73rSJNL0E55QqLLJZ1cwNC7+
1GeHJugSj6aWh0Th42NuDn1GlvKRGcyG5xDeRK40v91KIJzdb4vYJsLGcBlq0f0h
nxjYKj3h4fLBRq1XDH/KhX2X2i7ayy61vhWKuonBIto0ojZ37B32hqLZUagz2wLP
eZmTTlhwJZM1Meiq+A7r4phoQc5P3A==
=ZN6h
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
