Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAC22ED4E6
	for <lists+linux-spi@lfdr.de>; Thu,  7 Jan 2021 18:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbhAGRAG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 12:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbhAGRAG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 Jan 2021 12:00:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 237CE233FC;
        Thu,  7 Jan 2021 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610038765;
        bh=dhZEZmOzOGBIyE1OlsruJxFWlIM9M/fElcOJsHOXQIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMFXggiZz+mB2PLr4TYUfTK35QeggbVhQi3mbFVOP5PwjmHcMC/6tI5vtSYXTSYTu
         2SrGaZSJ93HhA1gMoMFqKRjY3NGgf7pWrmzsnLE9ygaKSfYBGgjqxPzjZfwgOhfSps
         //APWs0nbEvwH5Y/eFap+14m7q8imS2UBs06lCRCAoFjjsFftOoegbly6MVijw1MCQ
         uKWIxhUVYC3XA3nV4Lit1emwee1T7C7ArEi1t8YEd89hTKTvP47j9/iK77DrZyPHYC
         2fqeyZbRXbYiis89MD3ab5uSzxwDjJnibcRjV1Yk5PhuYNI80B/HPrKU8dgrj534Y2
         M2uwgZ6gZmuIg==
Date:   Thu, 7 Jan 2021 16:58:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] spi: bcm2835: Set controller max_speed_hz
Message-ID: <20210107165855.GG4726@sirena.org.uk>
References: <20210107164825.21919-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline
In-Reply-To: <20210107164825.21919-1-rf@opensource.cirrus.com>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 07, 2021 at 04:48:25PM +0000, Richard Fitzgerald wrote:

> If the controller max_speed_hz is not set, the spi core will limit all
> transfers to 0 Hz so only the minimum possible bus frequency would be used.

That was a bug and is now fixed.

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/3Pc4ACgkQJNaLcl1U
h9D0Ewf/fFivZMKOY5EJJDOKmwXgIBQl0vokcM/wz0pSM5M4oE/orEod0MReVHCS
CUlnzyu0s0FmaCZ0G945U6LmC2GDemvZTvFujqY78fyyaMfLwErPzuxqpRyES2MN
It1RyFigQuZOoy9SNCI01WvLMxgGBqe30me98U3lFpt89xU2zFECnRGmQfU6PfZ8
6zBFWtNkpXyCaC9LTkGPu93T6aQfg+ppKuiZ6UY4xGVZO9Bo1OyoEzmwsRYslcE8
74iUoQMGUENXH3EnwHZDF5OGiDIJXTL/8xY2dC2jGEDhYxFYAXdp7GoSbJhEhcXr
raUjT6ibjsaJ90Pcw7mDYq0h1g44/A==
=Eo8Z
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
