Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DD02A81E3
	for <lists+linux-spi@lfdr.de>; Thu,  5 Nov 2020 16:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbgKEPJF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 10:09:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731074AbgKEPJF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Nov 2020 10:09:05 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20AA520715;
        Thu,  5 Nov 2020 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604588944;
        bh=D2JgNaVO7/v+NMSWbv1jTB9LjsefocwYfuMTBHME4gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3bQyPtxuYUYnDNliqn1oWmZ5bgAhtPDUAI9NFui6Fh8TErByBtX8Vjx5dwkYUoIz
         1oINJoZAu+6gKLC73EPaDmkvsnEYPHNdQzZOcoIa3lFGOMnZp/UXMQwdOKXeS0ZGGC
         Evtg6DNd1M79W4dJK7VKhLyLsXh+HUJfwPwqIWdA=
Date:   Thu, 5 Nov 2020 15:08:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] spi: bcm2835: remove use of uninitialized gpio flags
 variable
Message-ID: <20201105150853.GD4856@sirena.org.uk>
References: <20201014090230.2706810-1-martin@geanix.com>
 <20201105090615.620315-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <20201105090615.620315-1-martin@geanix.com>
X-Cookie: It's the thought, if any, that counts!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 10:06:15AM +0100, Martin Hundeb=F8ll wrote:
> Removing the duplicate gpio chip select level handling in
> bcm2835_spi_setup() left the lflags variable uninitialized. Avoid trhe
> use of such variable by passing default flags to
> gpiochip_request_own_desc().

Please don't send patches in reply to old threads, it buries them and
can make it unclear what is a new patch which needs review.  Send new
patches as new threads.

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+kFYQACgkQJNaLcl1U
h9DLQwf+IY6ZUeKN6LZpR8BdpMEzU2EICJ6txyKs3L3bqqMYs2D54HKzdjmrJvOK
klYvs8f/zhnitGrd57+suKBQLUGvD8AZqbqYyjpv435maMfpQEP3hEKOc4T1ksir
7OPjvMtwRupnCMU2kAFrn6iCKzkdonLxKGPcpqa6W6GDXyVRm4vkcTh8C2xUYhCv
xXoXTkrrKfBPhs3FhSPHMUDZg9mTlpYykRwwjCK0ilOF+PghmKLaPIHW0cnCShKU
1U7tISpcnNtPLTG2xD+DuCDLVMV3uaKOMA3A+5R0CgpzE0Gv7+iEuK66js4UGeIt
24K97h9NjsdvjgT8V81ys7nfqXFH5w==
=7rMt
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
