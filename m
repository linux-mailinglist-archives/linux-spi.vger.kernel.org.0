Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAA6362058
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhDPM4q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 08:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235159AbhDPM4q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 08:56:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9214D610F7;
        Fri, 16 Apr 2021 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618577782;
        bh=23ztddlsot1OiQSW+jzU3lc5crCjHpuBOHg6FE7NOCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P972PMau0T07t60h85tJxSn33x3UtULfNyKnBNRM5nHmj4MfPU3BooB+x/C4p1Llg
         P7oPK0cLuVWbHfXf8vVzq7SmjjtAvZ4vvdSJmr81cir37VEMu7R0auoPZ5gJmTvI/p
         iphIlcwbC9RPlOXJ13yyN+knbnZSTf8Jm027993ChzA91chBKh4pExyaNzCblvEFY3
         14qc0XeiEujNFSft896KpijgiRH4xds17tpODiP8UkE6OzO15TqdXWx9U95rRI4/Xm
         ZRPjsvr1B9Mpz/Z8JIzWa39xTBWoikb8Xt4PyfyfoPo8OwDQ9qZb1sVNbwmilwwCYL
         nI25mWeNnvUQw==
Date:   Fri, 16 Apr 2021 13:55:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     quanyang.wang@windriver.com
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: spi-zynqmp-gqspi: fix clk_enable/disable
 imbalance issue
Message-ID: <20210416125558.GA5560@sirena.org.uk>
References: <20210416004652.2975446-1-quanyang.wang@windriver.com>
 <20210416004652.2975446-2-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20210416004652.2975446-2-quanyang.wang@windriver.com>
X-Cookie: Snow Day -- stay home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 16, 2021 at 08:46:48AM +0800, quanyang.wang@windriver.com wrote:

> Since pm_runtime works now, clks can be enabled/disabled by calling
> zynqmp_runtime_suspend/resume. So we don't need to enable these clks
> explicitly in zynqmp_qspi_setup_op. Remove them to fix this issue.

> Fixes: 1c26372e5aa9 ("spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework")

Are you *sure* this fixes is accurate?  The patch (and several of the
others that flag the same commit) doesn't apply against for-5.12, though
at this point there's not really enough time to send another pull request
so it doesn't super matter though someone will probably need to help out
with stable backports.

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB5iV0ACgkQJNaLcl1U
h9BrBgf9E/nnQ0hiXYFB/JYFD0fau71PNa16pFQ7bKnHt3CfKxLrtbdnmB4Y3VTR
tfgTrNfwJ2dTMzRiaI8O5uZKuWu++rlIGeqgtNWd+IfRF1q//9U8CYGCUFvsLsyX
x39mt7kX3E2SrBV7kS4UUREl6NBZ7FFSXr/3L6VV3/4c720m9DkRh1wEB7T3+iKZ
z4ivj0z8KC/IjH8PgWdL8ZQEJ7NgKiMjJSoMA7teMrVVYBxsDaDa+d0jotU/BORq
mYv6B7C1ih5zmGbhMp16eTk64/qfKuIW58J0G+0KiNtscsFStpWClOz9CowdKqtk
I/ZBrcJk+bZXCvezq3JVVvDpzHBPRQ==
=jZVz
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
