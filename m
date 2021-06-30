Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DEE3B8234
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 14:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhF3MhP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 08:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234510AbhF3MhP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 08:37:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E41461446;
        Wed, 30 Jun 2021 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625056486;
        bh=Z9x3GPXX5UDNNSeGBtZIhbnKqfm3VGMh8OJUpTt4KAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vzm1nfHNN+6KM8/TSNktE3t3iPV6Azfw4y79YkRbMhexF+XgHZuJXJw0iN9OarujM
         y7DaHW5bMLzUFR4Ew2mzt1KUKZtWR2Oby0BrxFqkNFxhOvMQGxXJO1dJWGRfqicdLc
         A2uW0u7SFFgMelau9rSInKvsxRT223PdeQ1GFq6YQS5asUFFD9FTbZLTzRhkJn6utQ
         0bSGez6IdzXPABGNiaybfIttg7fn16VCgZws3cNldwnjS6lZNRQygcBWhL5NNiUm6/
         Vwe5eBfWPlJxHf+zn3DD11wFNFUcHMlCpAhie15qTfZv+CNreHRrCFfLecM60y410G
         5CUvTgF8lDKhw==
Date:   Wed, 30 Jun 2021 13:34:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     amelie.delaunay@foss.st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@foss.st.com
Subject: Re: [PATCH 1/6] spi: stm32: fixes pm_runtime calls in probe/remove
Message-ID: <20210630123418.GC5106@sirena.org.uk>
References: <1625042723-661-1-git-send-email-alain.volmat@foss.st.com>
 <1625042723-661-2-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <1625042723-661-2-git-send-email-alain.volmat@foss.st.com>
X-Cookie: Use at own risk.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 30, 2021 at 10:45:18AM +0200, Alain Volmat wrote:

> +	pm_runtime_set_autosuspend_delay(&pdev->dev,
> +					 STM32_SPI_AUTOSUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(&pdev->dev);

The driver wasn't using autosuspend at all prior to this patch so
there's no fix from that part of the change, the enabling of autosuspend
ought to be split out into a separate patch.

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDcZMkACgkQJNaLcl1U
h9DXLgf/dpUymBzs+75+EMb8O8mDM+gMWDyMhP8TO8gcDlEkvTSasetcZbaMyz88
E3/TS2v4YQ1mp1lRti627C1p0nqWhJfGiDQO9G9ihuFQnn/9MwcqmYNj60ycWUDr
aDdHGDoeH4mUSyONrOT56m8+/cNzUu7OopXuG9YGwIXFuy0WIGmb8TzRwOVK9Go8
vNze2q5aSmuBB7aTAVpvqkdw8aUc2di5Td/RV0KxGOFG8TjRXu4jA2KU8acQmsSs
ePWxx2I/jqK+xCTKyFP9wCs0qQxwv5FA6jPY/OBoH1OmP3vI0aii2f4sQW7s6kkd
EiTKkxFYdPz9fIxABY6uB7qnzCwo+A==
=QyYV
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
