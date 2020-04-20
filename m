Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5426B1B0FC0
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 17:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgDTPRw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 11:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgDTPRv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Apr 2020 11:17:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E81DB206B9;
        Mon, 20 Apr 2020 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587395871;
        bh=NR9eij5fAZ2F4GMX8r7wjGK2n8gim5kWT5snSmUaZtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvjCxTVyILnUvseqf7yNKSG5kyjIENn+YTUDkQ/MkbBAuIYGJXvaU2RC1suIG5XUw
         gae8NkJ9g5I2z3WfPICpbQI1lQbVrpK3OJ4QDYHt5YkzBotzJwz/4iTDBxiHeSK+Hn
         gK2hXNPVVQE9ECSyMaab2jFtkz1fW4oeZZpPcnds=
Date:   Mon, 20 Apr 2020 16:17:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2 3/9] spi: bcm-qspi: Handle lack of MSPI_REV offset
Message-ID: <20200420151748.GE10045@sirena.org.uk>
References: <20200419192339.32023-1-kdasu.kdev@gmail.com>
 <20200419192339.32023-4-kdasu.kdev@gmail.com>
 <63176468-53b6-c11a-9e33-2ca9dd06f7a3@gmail.com>
 <CAC=U0a1mOWo3ucMJ7x5wuWQ44NRA2+Dj6fKAi1dbevNaxcYJzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline
In-Reply-To: <CAC=U0a1mOWo3ucMJ7x5wuWQ44NRA2+Dj6fKAi1dbevNaxcYJzA@mail.gmail.com>
X-Cookie: Hope is a waking dream.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2020 at 11:12:21AM -0400, Kamal Dasu wrote:
> Yes missed this one.
> Should I send a v3 of the entire set.

Yes.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6dvRwACgkQJNaLcl1U
h9C0WAf/cyzvCvLfQuHf1luVV6CarAaC3lE0lb4NHmdgRh7jrFN0JkDEERFLkVGV
cE1XJSS3fEIOd4W7UPoRPfsVud/ApmMFc7lqF225T1a5BbWXOHMsNi+CwKO+eYUQ
0VEFQDlS0ciT3jPWBqlj3sidevwtMRUgQkH6P8Ra9M6aLbFKkPxwCA0mYo0H76nw
kf3enT4gTbGHFIcFZQJatsipS/fOJrcYuN8sxEb9IAAHLKa1Adm+ZCaBuZm4V0Of
yfAA2AnJ5IIgTWMt20bjXcYtHGrsQVAVJs9oXFHV41X2baFkpZi5FRPaZUHiprUI
zBXyBGf49q7QV0E5vC+8fRKKHzhESw==
=ULEV
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
