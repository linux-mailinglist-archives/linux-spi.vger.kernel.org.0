Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48483207B54
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jun 2020 20:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406019AbgFXSQE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Jun 2020 14:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406007AbgFXSQC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 24 Jun 2020 14:16:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3636420738;
        Wed, 24 Jun 2020 18:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593022561;
        bh=6gJ0pgJAf9oyxHpg6NQAlLYoWpIzQ4H/FOZWmg2B91k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w+72KTkZx+PH4X5DuLggcqlOgq878ARjHiNhQHuOsttvs5KEzps0SFFjKkEjZB39m
         xzIlZbbGOtmbhGA1jAVCiJf5f10gAHbbRRiuZMIGw91qz3R1anMDfng0eBidKXbeRF
         51SwSD0nWVVl2suldTN/WDe1NODDaYWUZ/ktgh6w=
Date:   Wed, 24 Jun 2020 19:15:59 +0100
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
Message-ID: <20200624181559.GP5472@sirena.org.uk>
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
 <1592222564-13556-7-git-send-email-rnayak@codeaurora.org>
 <20200624170933.GB39073@google.com>
 <20200624171537.GL5472@sirena.org.uk>
 <20200624173948.GC39073@google.com>
 <20200624174417.GM5472@sirena.org.uk>
 <20200624175536.GD39073@google.com>
 <20200624180005.GO5472@sirena.org.uk>
 <20200624181245.GE39073@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nVYOjVWOcH+Ezkzp"
Content-Disposition: inline
In-Reply-To: <20200624181245.GE39073@google.com>
X-Cookie: So this is it.  We're going to die.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--nVYOjVWOcH+Ezkzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 11:12:45AM -0700, Matthias Kaehlcke wrote:
> On Wed, Jun 24, 2020 at 07:00:05PM +0100, Mark Brown wrote:

> > I'm not really reading any of this stuff for the series as a whole, as
> > far as I could tell I'd reviewed all my bits and was hoping whatever
> > random platform stuff needs sorting out was going to be sorted out so I
> > stopped getting copied on revisions :(

> Sorry this caused you extra work, I only fully realized this when the series
> was basically ready to land :(

It's fine, mostly it's just checking to see that I'd reviewed all the
relevant patches which takes moments.

--nVYOjVWOcH+Ezkzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7zmF4ACgkQJNaLcl1U
h9Bgggf8DwSZc/JTuxWtxv+ehiv1EkC5dOKvBpCnYphj56b9f3A0XwlExxVwy59a
O6kBdJ9PvTV4dBbYRmmx4uUs+XddJN5yScZOLWxbZEZKAYlZrjWYJpqMVVqbB4uN
DtmlqGPM86PmesWpjIXnfzmSrO3vQCCU2/fdgTaN75AIm6hsaGk5mYPWgh7gIH3t
a/aZY1VHgJZEbDE8NdJlUw8vInJJeJqsJjnubheKMj3bZJR/Aoaix5Odr2/MZg2k
88rnw4RDG+M6qUUdaU9cUuBKHUHB0U7R6n6AJnsS1fbO/YOipS8j4DUDEIV+nXQk
wwrozbaUBw5VtqkQ/j6jhgj3wrB9bg==
=abhq
-----END PGP SIGNATURE-----

--nVYOjVWOcH+Ezkzp--
