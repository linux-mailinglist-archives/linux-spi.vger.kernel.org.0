Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0DF23D2B3
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 22:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgHEUPR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 16:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgHEQUR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 5 Aug 2020 12:20:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 616D7207FC;
        Wed,  5 Aug 2020 10:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596624686;
        bh=x3ZHXxquKDbAiA2NrYdhb8ekIS3wwnWPgFDvfXsCgjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tz9/O3MwNWVUjnDemRDBvIBHLVnCwzcZU9KwGVAfLwJL9klqT5BXqz1Xdd8jPqNwM
         JihxqNRzl/tuH3X1xIDDy5h7jYfjdribFzyTkod95UguTpz2DDZsDpOs0iFqDPn3aZ
         SwLoSRPWz174jubsykqQiQ8naeWwRJ0IJ1ilLquY=
Date:   Wed, 5 Aug 2020 11:51:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@st.com>
Cc:     amelie.delaunay@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
Subject: Re: [PATCH 03/18] spi: stm32h7: remove unused mode fault MODF event
 handling
Message-ID: <20200805105104.GC5556@sirena.org.uk>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
 <1596610933-32599-4-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <1596610933-32599-4-git-send-email-alain.volmat@st.com>
X-Cookie: Fast, cheap, good: pick two.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2020 at 09:01:58AM +0200, Alain Volmat wrote:
> From: Antonio Borneo <antonio.borneo@st.com>

> Accordingly to STM32H7 document RM0433, "mode fault" MODF is
> a special mode to handle a spi bus with multiple masters, in
> which each master has to "detect" if another master enables
> its CS to take control of the bus. Once this is detected,
> all other masters has to temporarily switch to "slave" mode.

> Such multi-master mode is not supported in Linux and this
> driver properly disables the mode by setting the bits
> SPI_CR1_SSI and SPI_CFG2_SSM, thus forcing a master only
> operating mode.

> In this condition, we will never receive an interrupt due to
> MODF event and we do not need to handle it.

> Remove all the unused code around handling MODF events.

What does having this cost us?  Hopefully it's not doing much but if
something goes wrong with the hardware and this does get flagged up for
some reason it'd be good to know about it.  It doesn't seem to be having
a big impact on the code or anything.

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8qjxcACgkQJNaLcl1U
h9C+kAf8CK9hJ/6Jc4BQ05hn0nAaypIJAYNq1bv8lExUjoH1m3AeiTfTBbh8Aq25
W/1u3hhb83akhry/0vcVC2vSF5UGKInNhyeb6FRRoqUaiBD2krRo55ZDgmYeD7Ta
F34U8K3C4QbYMpQeKO5ceuZZOadkfjxKrgX4h+ZkFwGXaUn8tIGN9MDZLKyQ85md
ecRl77X3Wt9kX9OxEml6f5UFJvbaVA//arSxikBmyBnFDAe4udEu9PVXHtdJ1pNy
jvw6E20aw6tBoteFTfL1iv36f8kImbVrjGWJjgHEUu2ujyEgQgJfg9xrU3wWIykr
OlTao50KMlI4sHvYI2leN01XzXGJdA==
=gL3F
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
