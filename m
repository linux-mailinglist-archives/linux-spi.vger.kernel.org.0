Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C1D1CAA1F
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 13:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEHL5p (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 07:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgEHL5p (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 07:57:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE63E21473;
        Fri,  8 May 2020 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588939064;
        bh=IaPvVZXTHvGm+ATBUiQ/C7oCQtJbpR8kBilGLTr3sG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZW494kp61NfLUQYAXfePRSRyleDGJxwtcVFZqJvIgsF/94FsXRzA+vt03/ffDxoG8
         6YTwRIsL5i6OwHuFwAoQ5EGnUSQ24pera4q8pAG+luJq54zZABnGGSBNIYUXOgfHG9
         D9J0C7lNzG5H2olH1jVZiuKuP7+fOgR1xI72rA0I=
Date:   Fri, 8 May 2020 12:57:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 2/6] spi: spi-geni-qcom: Use OPP API to set clk/perf
 state
Message-ID: <20200508115741.GG4820@sirena.org.uk>
References: <1588507469-31889-1-git-send-email-rnayak@codeaurora.org>
 <1588507469-31889-3-git-send-email-rnayak@codeaurora.org>
 <acc7baf9-86a3-6c78-4d62-99d4b1baa12e@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QWpDgw58+k1mSFBj"
Content-Disposition: inline
In-Reply-To: <acc7baf9-86a3-6c78-4d62-99d4b1baa12e@codeaurora.org>
X-Cookie: Give him an evasive answer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--QWpDgw58+k1mSFBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2020 at 10:30:43PM +0530, Rajendra Nayak wrote:

> Mark, would you be able to review/ack this patch so it can be
> taken in via the msm tree? 'PATCH 1/6' is Ack'd by Greg, and its
> going to land via the msm tree as well.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--QWpDgw58+k1mSFBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61STUACgkQJNaLcl1U
h9AbIAf/ZLO/7q8DC9SAKDmvIPrErrowNDCXJzdHt+TuIix+rKRTOcnCJPf5Jdri
SBgkU1oqegEOQoQ+bBo8RJy8j4OYQfIL1+tgwQTb+Ld9gNtCqC34BZi5caCppXR/
wM/n0QzaWakbnRAHrh6MS2kxu8nqxkV1zk1FfS4mRQs6mLnnObnNQU4kT61eryLy
AdpSCObETekb+wRAv6nKIGY4zD11Pnw23De7Ghs/+HnVohzPylvEmdBQwJfpXAth
IZjPGFWf5DXtFrkuCgJ5WHifyBVQDhvzux9O+lbUKbVy5xCpA9fYUUdypw2xk6/D
ALxErrqF/sZStMojWcRGSZkvUd77uA==
=TBng
-----END PGP SIGNATURE-----

--QWpDgw58+k1mSFBj--
