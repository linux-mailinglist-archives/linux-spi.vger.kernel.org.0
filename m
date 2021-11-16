Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B2C4537DC
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 17:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhKPQoN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 11:44:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235700AbhKPQoM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Nov 2021 11:44:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA604617E4;
        Tue, 16 Nov 2021 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637080875;
        bh=wYaKRXAw4iovjmksMjsNHyHt51/EkpwyzwQOTxNSERg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=laVXp186WyFjbhdICmOej4HlVdTCCIXhsqR/2dOlUXzMCTA2sZlJWpMX6KGAw9nbG
         aBqXUcjhqGIZOe241yXN+QRmdObFEz4MVCaKq5nlX3/7EOMFBdhAYpisySoEnmU+Vm
         dkOWMkT5y/H68Y1mslCKB1E7/QRh9JoamBZDlRqjM8tHX4fKqHhvBSHq9wwlHQspcq
         V1/2kdtuFR2CNpfrofQkUOhmpZjTmJgAcR+lEKxgM5iTovdW4ZILV572Us10SKB9Qk
         tu0ccPIaJps5eshTKzvnOfubR5JpS+UriONEKTZUa1EV4io4aC5Jb9ToPHi/rMhWTp
         JIYnwAh19s7cQ==
Date:   Tue, 16 Nov 2021 16:41:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] spi: spi-geni-qcom: Add support for GPI dma
Message-ID: <YZPfJtkvo3bsfaCg@sirena.org.uk>
References: <20211020060954.1531783-1-vkoul@kernel.org>
 <CAD=FV=VDjqQsnGVOf0FPsk74xgP87iBnk3MznEi1TjTKHP0Ldw@mail.gmail.com>
 <YZPVB84Eq9Dn3Znv@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6VBpWUIJltEBJBZk"
Content-Disposition: inline
In-Reply-To: <YZPVB84Eq9Dn3Znv@matsya>
X-Cookie: UNIX enhancements aren't.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6VBpWUIJltEBJBZk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 16, 2021 at 09:27:59PM +0530, Vinod Koul wrote:
> On 03-11-21, 14:17, Doug Anderson wrote:

> > if (result->residue) {
> >   dev_err(...);
> >   return;
> > }
> > spi_finalize_current_transfer(...);

> Should we always call spi_finalize_current_transfer() ? This way we
> timeout... What is the way to signal error has occurred..?

Yes, set an error in the transfer and then finalize it.

--6VBpWUIJltEBJBZk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGT3yYACgkQJNaLcl1U
h9AS3wgAgrgBnS/enGXVKvoU8xbx7KmkI3YCPuNwbGja6IeJcvd7EE97mhkMhJwO
PYV9jEdnP5K9ROCSlPa8+ZoYqCRA2x3k5GC+LuvRa3jnI/C9czrMf6m7fq1a0nol
wPy/WPpIJV8VaDr8uM8/nEK3vyAWNqpL9HU2HndALcKKHT1PhKvZ0rYb2ZpWsIII
K3tEjPQPZqQnzRbNtHvjYscD95GdjKaHa3UzX3fIT/Rf+qf9SqkDSqrlO999l5sp
mtASwgwzU3NECGryWy/ZcBFAfyWy0F0LXghL67lcUiuSVZtKDCle4vDOtvxZBQ8h
kI250I8ocYg2A6R+lom1IWT5x0tFSw==
=gmvG
-----END PGP SIGNATURE-----

--6VBpWUIJltEBJBZk--
