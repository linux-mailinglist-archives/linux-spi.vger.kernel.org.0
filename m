Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B0D23CAFB
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 15:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgHEN2D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 09:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbgHEMfj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 5 Aug 2020 08:35:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8C252250E;
        Wed,  5 Aug 2020 10:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596625148;
        bh=+2lw8wUwUPwm/XzVJd+nqaX1hg96uRr12C5gCcpfKoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBcAbW+zXAbPlvfbb65l+Ab9q749VR8RuVLj2MsKc0s+uEm+R9CzZjOj9g527C4n3
         ilv2g40RzksDSXh/2LIjhDot6mAMbIjU34SXet9LDLpXL/lasFnC8nnJZLUrQri9so
         xlMG4udt6aSgU2+BOzqaCnIoXAxLdQiNM0ITOyGc=
Date:   Wed, 5 Aug 2020 11:58:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@st.com>
Cc:     amelie.delaunay@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
Subject: Re: [PATCH 10/18] spi: stm32: wait for completion in transfer_one()
Message-ID: <20200805105845.GE5556@sirena.org.uk>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
 <1596610933-32599-11-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline
In-Reply-To: <1596610933-32599-11-git-send-email-alain.volmat@st.com>
X-Cookie: Fast, cheap, good: pick two.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2020 at 09:02:05AM +0200, Alain Volmat wrote:

> We could make transfer_one() blocking till the end of the transfer
> and bypass the wait/timeout mechanism in spi_transfer_one_message().
> But if for some reason, we never get either an error (OVR, SUSP) event
> or end of transfer (EOT) event, xfer_completion will never "complete".
> That's why a timeout is useful here to avoid a hang. Timeout delay is
> deducted from the transfer length, the real speed and the optional delay
> we can add between each data frames. Timeout delay is doubled compared to
> the theorical transfer duration.

> While doing it to address irq mode only, take benefit of the new
> code structure and wait also in dma mode so an eventual error can be
> returned to the framework.

I can't tell from this changelog what this change is intended to do
which makes it very difficult to review.  If the timeout is too short
for some systems under extreme load it would be better to provide a
generic way of configuring it rather than open coding timeouts, or
otherwise improve the generic code.

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8qkOQACgkQJNaLcl1U
h9AT+gf/aYEfYx3HrSnttobpG07/UmGe0VbGFm0wNeUPlZjHOsiUR0/yYb1gUUlj
TnvCzi1lkQ/K4B0+Xv/SlNbozVhxJgjxcTZ2pYdPLtK/N3mlwk+TtvrRdfRfrhfp
uP0o6kFcWaLObk6NacJRpO7eTLgxLs/mA9yO/Q9fMGwD3vuYmtnfsC2Fq2D8CiLX
ryKPQ7Vj1qrQMKZIbyhNUThsUeX10IGbbk7Ogb+yN7tovA5yDPWlRI28VRGFVBF1
fG3vKTH505EfwHcztddZJyTL9fveYtt76RsQ30uDfJF9NOAleRiRbNdhM9gHqAXf
14Yy/ZXfSKkgz9WHGRPyOgJSgeeM+A==
=ikJv
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--
