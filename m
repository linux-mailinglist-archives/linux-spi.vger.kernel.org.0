Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0DD218DDC
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 19:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgGHREn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 13:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgGHREn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jul 2020 13:04:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9245B206F6;
        Wed,  8 Jul 2020 17:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594227883;
        bh=yLokUIyv/FU4YEOgFc19faEG4D/5r8C7dVCPb2W8VKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B4fGq/TjVKblcyVpd+3BSFcb4aG3qWs8twLOY2l9+H0b7hPZNquD9y7S/9+wwypur
         p6O8z0qz6FQx/f6LDNZWalhDPlbcNmOdMn0R1RSHHgXammZP7fzFwKU8waVgTCqe34
         moa+v0Pjrv6xYXtvCU540jqTxqG89NXtdUDd9ano=
Date:   Wed, 8 Jul 2020 18:04:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>, mka@chromium.org,
        Akash Asthana <akashast@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        ctheegal@codeaurora.org, mkshah@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: spi-qcom-qspi: Set an autosuspend delay of 250
 ms
Message-ID: <20200708170437.GA4655@sirena.org.uk>
References: <20200707201641.2030532-1-dianders@chromium.org>
 <20200707131607.2.I3c56d655737c89bd9b766567a04b0854db1a4152@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x0Bbm7aQwrWvLJ2v"
Content-Disposition: inline
In-Reply-To: <20200707131607.2.I3c56d655737c89bd9b766567a04b0854db1a4152@changeid>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--x0Bbm7aQwrWvLJ2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 07, 2020 at 01:16:41PM -0700, Douglas Anderson wrote:
> In commit cff80645d6d3 ("spi: spi-qcom-qspi: Add interconnect support")
> the spi_geni_runtime_suspend() and spi_geni_runtime_resume()
> became a bit slower.  Measuring on my hardware I see numbers in the
> hundreds of microseconds now.

Acked-by: Mark Brown <broonie@kernel.org>

--x0Bbm7aQwrWvLJ2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8F/KUACgkQJNaLcl1U
h9Cp1Qf+IuvU3z2932//dAuuBPhrFIl4jQdCf72pvLneLSlMVValMaZ/7YXWkr9h
RCvD/pRRIYepo77AScE60wMM0GU5qd+Pph5OfbVgGxageCY3U0T7wJBj1+0uGsqM
QbET1A/6UFagqJJ3vijjkPzzyChpwRE1WB/xpGkHD5i5gdK7ReZ7jfvCCML1nxZ3
Zlv7uqEmxBpakYPytTZNXcmsErv77d4bWEXGmXp4Ihx/KsOtsgqAQiOUwjHztbnG
Xfe6SS7zRPR0aCerD7sxsboQTRMLZqRpEZmEOonvLG3j40IN6RKuEYD/1Rrxk2uR
b0qLEn1joZMll2MpTqXx15MFHW/fOA==
=LK3f
-----END PGP SIGNATURE-----

--x0Bbm7aQwrWvLJ2v--
