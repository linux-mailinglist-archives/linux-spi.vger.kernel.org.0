Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4452005C9
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 11:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbgFSJyU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 05:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731048AbgFSJyS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Jun 2020 05:54:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E6120776;
        Fri, 19 Jun 2020 09:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592560458;
        bh=b2se84h3l52DyW04Q6ULrra7Nh1wmtClcpg6wu/oHFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QEsjuS4HYPXHzz8/m/2jC5cXNsBwfCYCKxumbFdkqH6xVxlDMveQvusjboG2Dj7o/
         gs6LnYG3n3PmejAkcAV0ip6pnkylUbqSAIUIAPQ47ZdOaIg4t4KRJUlo4O0Tk9K7uE
         HaqDsY7TvkPrFf0LDf65MeWbZhY+/+QPh+ajee8Y=
Date:   Fri, 19 Jun 2020 10:54:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6/5] spi: spi-geni-qcom: Simplify setup_fifo_xfer()
Message-ID: <20200619095415.GA5396@sirena.org.uk>
References: <20200618150626.237027-1-dianders@chromium.org>
 <20200618233959.160032-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20200618233959.160032-1-swboyd@chromium.org>
X-Cookie: Robot, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2020 at 04:39:58PM -0700, Stephen Boyd wrote:
> The definition of SPI_FULL_DUPLEX (3) is really SPI_TX_ONLY (1) ORed
> with SPI_RX_ONLY (2). Let's drop the define and simplify the code here a
> bit by collapsing the setting of 'm_cmd' into conditions that are the
> same.

Please don't add extra patches after someone else's series like this, it
makes things harder to follow and really confuses tooling which tries to
parse serieses off the list.  Just send a separate series.

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7si0YACgkQJNaLcl1U
h9DGNgf/dEFbdjb6kLp+Q0o2czzyuD3ZIRvlSfE/PF6C8M6Zk2av7RL+CC+X24ve
pVOAFd8BKA4qVKaYKQMzXI+YvyH3nj9UnYAkaYhp+4e0seLzFqqibuT3oC0Zsvcu
43/leUWUjRG1IwqAO34o6khhPYGZq86xm8vZVHZdzlag8Z+xsi2fSOG9FX90zloy
hH+FfH/vR1otM7fsOFRcg6fKZsz/KrRtkdskQQiJcLXCHgrqsuQvrBEPUvpVR0PR
qDDU3uqVb8TuhHeAlf5VYfjb4SjzpOFsXyhh5fukLEjtbiNcCvvJeWGM0uNuw4XM
cRR/1HsNX7N3YmX60sd3h/SQcPJfaA==
=NiTl
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
