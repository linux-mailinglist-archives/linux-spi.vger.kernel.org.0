Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4512AF68F
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 17:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKKQcS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 11:32:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgKKQcQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 11 Nov 2020 11:32:16 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95440206F1;
        Wed, 11 Nov 2020 16:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605112336;
        bh=72CkBFpUBSDsvXuGAkNdpZijpYjYImRaVmVjuqTUVSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2hPhikYb426IkOVPIC3MrzCFHFFGowsTGGP9W+7zyN2WVeHWWvDlNLo0YTpIc14Cl
         4kMiFfMUpyUQby7aqWmQpQHmXv+//df6OZWIQfRbKkEK51K4foczvQCK7ZoJZcbw7A
         Dlg0/B1WCirPhIo3ozdMghQ5HMuVWTGLGfDj6oGg=
Date:   Wed, 11 Nov 2020 16:32:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Simon Han <z.han@kunbus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO
 descriptors
Message-ID: <20201111163200.GC4847@sirena.org.uk>
References: <20201106150706.29089-1-TheSven73@gmail.com>
 <160510968064.12304.14797288117651443603.b4-ty@kernel.org>
 <CAGngYiVAdPSCEQm5pJdFQ+3VpwNH1vGD6rPNK1_SQK3Uvfbt5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <CAGngYiVAdPSCEQm5pJdFQ+3VpwNH1vGD6rPNK1_SQK3Uvfbt5A@mail.gmail.com>
X-Cookie: I'm not available for comment..
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2020 at 11:24:14AM -0500, Sven Van Asbroeck wrote:

> Now that our minds are still focused on this subject, should
> commit 138c9c32f090 ("spi: spidev: Fix CS polarity if GPIO descriptors
> are used")
> be reverted?

If you think changes should be made to the code please propose patches
making them - reverts are just normal patches with changelogs.

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+sEf8ACgkQJNaLcl1U
h9CmaAf6A0ij5B2nu0gr76TVf+bSTOgpbMF9zasf5KZtW4r9mjsLt9cG8UL7EV/d
y1K9ISunQ1OrYvORnXa2zi/NDR+sc7hZ3Qv3yF4Uow4YBhCQb8Kgl2+IsuwKbSFG
jt6WGWseblvCeg320k6JWlDrv2yKzEJUOeCHf7uWH6cm9wF0/87EE/XJ88O/13iG
juxL85pM05WwiqYGcjdZA0EiyrzX0V5bOQqQhjtDg29QpnugizUh1itHJrMEJaGH
H6ZBcXhSmWMltY6gqUV840P1sdsNLYGlL8i7cLAlg63LJVuM/GOC5iP/Ck2tGTnw
bkrL7HIbmV/zRL8T+Z1/bFjZND0uZw==
=JgJA
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
