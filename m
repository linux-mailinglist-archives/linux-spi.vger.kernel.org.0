Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FA4200629
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 12:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbgFSKXY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 06:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732332AbgFSKXT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Jun 2020 06:23:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 296D92080C;
        Fri, 19 Jun 2020 10:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592562199;
        bh=83+sXFoflRuZHwP/XSFWwh5Bw+aJkOhKPwddfQde9jQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDhMjjqHWbvePWaOg8IDnYjyicZTMLupM2NJTlyUGnqpgPUUNVkI5Wcg5yIUyixYS
         NzB3tLB34+YAWkRBlwh4J7Gdx5GxLsV8k3rc92Uj1L3lG5TlFTjSrDb1t/K6bAx1eo
         J2wXA/bVH2junYFyK61CEPJljjbnKh7TgETAXTxc=
Date:   Fri, 19 Jun 2020 11:23:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mani@kernel.org
Subject: Re: [PATCH] spi: spidev: fix missing octal defines
Message-ID: <20200619102317.GB5396@sirena.org.uk>
References: <20200619074345.4041673-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <20200619074345.4041673-1-vkoul@kernel.org>
X-Cookie: Robot, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 19, 2020 at 01:13:45PM +0530, Vinod Koul wrote:
> Commit 896fa735084e ("spi: spidev_test: Add support for Octal mode data
> transfers") adds support for octal mode but failed to update userspace
> header with octal defines causing build error for the spidev tool

This was already fixed.

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7skhQACgkQJNaLcl1U
h9D9yAf/XQvacdfyrPIV1ZmRYSjHGdp+H4uWcdjRGdw6nf+FF/1s+kF2b0vazZYE
LjXHCVrqf/cm9IjclGr+GCsuoUHWc5TS4r6VveICtEAyZsSU8+voN3LzW+Uhz2Nu
ppSeRp9hhFXSCzfmjP6wWjIKK06ATEdjbMw7KXhvISPTTwxGCYHiYpZopUseN9oC
OhwhCJJN/5mQ1OHqG2sr31WA71xn23FHw1E8MeAn1jnEjFsqdwHBQXAGD83MK9Ze
CHXmc33QFXW3Q6a9dJMCaJOt+rNkypJCmVZHJNLre6linqnGtfVW0/aMnYTgzSJy
6ghwaEKKfT4OWIcCGhE14Nzff/Keyg==
=45Bw
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
