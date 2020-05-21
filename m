Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047401DD914
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 23:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgEUVI5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 17:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbgEUVI5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 17:08:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4916207F9;
        Thu, 21 May 2020 21:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590095336;
        bh=bq3nfY2FHxD6+erwGvYnFzlknI2N+zMNIxoeBzsuMVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zY2En2y5UEXbWZpyjwa/I5GUbCpu4P22OtT46zIHNHDX/CBgwccWGg4nD1jP2mxof
         /Cojfv4QevmZ4xUrz8YrbkbJX/6UP3hWbpaPNI51JR/a78J2Ja1jo6RR6lkL87PdMQ
         aU3wTCXPYltvhNTZXHGPTaCXFoZPxDYPCpZHUwMg=
Date:   Thu, 21 May 2020 22:08:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Timo =?iso-8859-1?B?U2NobPzfbGVy?= <schluessler@krause.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, Jan Glauber <jglauber@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
Message-ID: <20200521210853.GK4770@sirena.org.uk>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
 <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
 <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
 <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de>
 <7b85e098-b9a9-dd14-203f-100cdf2e703e@pengutronix.de>
 <CAJ+vNU06DHVS25OQR1Kqyzy2ZxLVq-HdwenGv-jN5Rb3r8F86Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="apbmkPN6Hu/1dI3g"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU06DHVS25OQR1Kqyzy2ZxLVq-HdwenGv-jN5Rb3r8F86Q@mail.gmail.com>
X-Cookie: Keep your laws off my body!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--apbmkPN6Hu/1dI3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2020 at 01:19:16PM -0700, Tim Harvey wrote:

> Should I be submitting this patch with logic that only does
> half-duplex if the spi controller doesn't support it (if
> (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)) or is it
> acceptable to simply make the driver half-duplex like this for all
> cases?

It seems likely that making the transfers explicitly half duplex will
perform better, especially for PIO controllers since there's less FIFO
stuffing to do but also just generally on longer messages.  You will
get some overhead setting up two transfers on write then read messages
which might offset that but my best guess would be that it'll be
negligable on most controllers.  It's also just a more accurate
representation of what the transfers are actually doing which seems
nicer.

If there *is* a performance win for doing full duplex messages on some
controllers we should probably look at optimizing this in the SPI core
since it'll affect a wide range of hardware and we already have some
code for forcing full duplex anyway.

--apbmkPN6Hu/1dI3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7G7eUACgkQJNaLcl1U
h9AOJQf+MicpOYZXR/CuHGZ9nB2XYZVgilr2bOVHAgmW9Ptv934QL7ohdwoxOi6/
envwoCqrTmi8Ii1y2aVCj4/fnoFzYhYOEIAifJyecrnU8HJVouLN55z7OtMcd1W2
hT/hVhXtPkT16rWo2/hMxJvljs7xRG3ezBy7kfsOgrvkN8T7P7pGo9IZrStLWM22
FLUt6FH54mF1A8eqCHevlaIIzP6deQ4WaWyi+tpwc8zoJXSDWAVlYqOugiVSYRvC
5UFPKCQXLVaymi0BcHpXkZv9ctDmpQHH3ZKsi/uuePlqMmyHxe+IAv3kZBJY6R1F
xLQSJezpEy6QAujKHOtwiM9zTPEsCw==
=Mz9E
-----END PGP SIGNATURE-----

--apbmkPN6Hu/1dI3g--
