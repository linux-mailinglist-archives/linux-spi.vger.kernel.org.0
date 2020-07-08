Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667F5218DD5
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 19:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgGHREZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 13:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgGHREZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jul 2020 13:04:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B2BA206F6;
        Wed,  8 Jul 2020 17:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594227864;
        bh=IlGFoPEuvpiTmmWUgcvgenltwkXzgCwVKvpprIlvSv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzLi/TSZ4mT16gwsa8dYah5LASPBcD9lavU0/HVW8sHIeqfQo62PA7RMLhPwStlTo
         PBIVPNp1ObxDv3BY46aES8jjTZizSrYcgeaSrqcuJRFmEu5XCmaVfayXhIznsTyTDu
         sKX4FAi2cWFIX2Wn/PNvVXZfdHGILBH1U4UPAAco=
Date:   Wed, 8 Jul 2020 18:04:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>, mka@chromium.org,
        Akash Asthana <akashast@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        ctheegal@codeaurora.org, mkshah@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: spi-qcom-qspi: Avoid clock setting if not needed
Message-ID: <20200708170419.GZ4655@sirena.org.uk>
References: <20200707201641.2030532-1-dianders@chromium.org>
 <20200707131607.1.Ia7cb4f41ce93d37d0a764b47c8a453ce9e9c70ef@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l4GQ7sizse6iPvDe"
Content-Disposition: inline
In-Reply-To: <20200707131607.1.Ia7cb4f41ce93d37d0a764b47c8a453ce9e9c70ef@changeid>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--l4GQ7sizse6iPvDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 07, 2020 at 01:16:40PM -0700, Douglas Anderson wrote:
> As per recent changes to the spi-qcom-qspi, now when we set the clock
> we'll call into the interconnect framework and also call the OPP API.

Acked-by: Mark Brown <broonie@kernel.org>

--l4GQ7sizse6iPvDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8F/JIACgkQJNaLcl1U
h9ASewf/Qco0RI67DNoTYF+gueLZS92Y7IqejChGBBxd44wZe4PiRkAG7PLGdBbs
NQpsOfM7WCDv4njTaGwTl6wkQ+hG5ndQGpzSBmyb1iEGSw4osykO3dtg1D7xb8kA
dZjiglV5C8CoS0FGe5PqAFYdu5g6G0N5pc4MUKgO6zhYZzkdTNV1XalyJgLwxU3J
SiuPdGKxb/kWRNpJpzNhmshzGeA18HMd+7UhU2Zi2mbqUxaIKTS2qb+R3V4HiRR8
vQ+3kkBVGZNtwMIywBBmPozc3zTKOt+BFc8JVNezpOI9z07YbNxA2UAWUodxS51G
CnVAh+IeSbzXIq1Fu8JRdVKMVElDHA==
=x/5H
-----END PGP SIGNATURE-----

--l4GQ7sizse6iPvDe--
