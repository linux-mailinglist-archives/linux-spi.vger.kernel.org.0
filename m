Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C272207A80
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jun 2020 19:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405641AbgFXRoV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Jun 2020 13:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405639AbgFXRoU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 24 Jun 2020 13:44:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DC0320738;
        Wed, 24 Jun 2020 17:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593020659;
        bh=bvusmCWIESHEAj0e+z3a1cGAYmpjANA+c6koHZdoHoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyXen/QaFox7J1zFBnpVX4/PK81hmX8JLHCM155tV/YRT6FXQSmg57opeqx8XsYvd
         kErfA2rh5Kyyz5kFbezKJwIbmVPB06thKUmi5X6rkoBf4s4yIJmWeeS26kZiKU8LfY
         KQPY6dLasmXWkgkkGWjVMbv8EmjyZGlxfXeg4qac=
Date:   Wed, 24 Jun 2020 18:44:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, bjorn.andersson@linaro.org,
        agross@kernel.org, robdclark@gmail.com, robdclark@chromium.org,
        stanimir.varbanov@linaro.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v6 6/6] spi: spi-qcom-qspi: Use OPP API to set clk/perf
 state
Message-ID: <20200624174417.GM5472@sirena.org.uk>
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
 <1592222564-13556-7-git-send-email-rnayak@codeaurora.org>
 <20200624170933.GB39073@google.com>
 <20200624171537.GL5472@sirena.org.uk>
 <20200624173948.GC39073@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I4g3zIzscEHdx6fd"
Content-Disposition: inline
In-Reply-To: <20200624173948.GC39073@google.com>
X-Cookie: So this is it.  We're going to die.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--I4g3zIzscEHdx6fd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 10:39:48AM -0700, Matthias Kaehlcke wrote:
> On Wed, Jun 24, 2020 at 06:15:37PM +0100, Mark Brown wrote:

> > Aren't there dependencies on earlier patches in the series?

> Not to my knowledge. Patch "[2/6] spi: spi-geni-qcom: Use OPP API to set
> clk/perf state" depends on a change in 'include/linux/qcom-geni-se.h' made
> by "1/6] tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state",
> however that's not true for this patch.

Wait, so *some* of the series should go together but not other bits?
But you want them split up for some reason?

> I wonder if it would have been better to split this series into individual
> patches/mini-series, to avoid this kind of confusion.

Yes, if there's no dependencies then bundling things up into a series
just causes confusion.

--I4g3zIzscEHdx6fd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7zkPEACgkQJNaLcl1U
h9C5Ygf/eV7zcb0/VTGIuud8txsdBua20mrq0v0NJgg3eJsuQ6dIRslZTDgvayp7
gusdaqd6gG5MVof8R2japp1a5S2XU7GNEBKnkSQIJK2ytFdcr+9Jbm+6AIisDg47
UsRnOxCxuMvpC/P7J8+n9tnENxfQ8eN0vlrw3j+YH0DiQqrqFfxxR9qLlA4ccAAH
dbpKrCr7Y/dz4W9JL8j1l0xiXvoDjgdH4JW9y/BfdU3F71N7SfQkQhWHe6Zc+EMZ
TCMhZUE1b08cL+joxAxkE1Jn6V8i667Cy/VzKYDY63+18FKBGi/MzzvPwvxxuxUM
jQLWU2TmIsu1hxy6fDy4xvidDxmxUw==
=eBq2
-----END PGP SIGNATURE-----

--I4g3zIzscEHdx6fd--
