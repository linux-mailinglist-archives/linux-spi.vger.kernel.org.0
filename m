Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A468726A929
	for <lists+linux-spi@lfdr.de>; Tue, 15 Sep 2020 17:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgIOPzp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Sep 2020 11:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbgIOPzn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 15 Sep 2020 11:55:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2A7F20756;
        Tue, 15 Sep 2020 15:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600184944;
        bh=9ZgnWEkgsW5a8amSbqeecoqsniIrBiEPbs+VWpBwskc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Je/fEe7EiCMOkJ3+bp9pl0JjWEgVj7u/S26To1dZZua27cuAC9+W3ejxwSuq8wnIS
         1rVBHJsTBcbThnRdFbhqlPTbSGkREm40eKRVXi0g5MgdM5bsqkOXqGgbg+OMidZ1e8
         irmM8Chp9Ln4aMek/wYL+mSrsjdoPkGIhgoYHTEo=
Date:   Tue, 15 Sep 2020 16:48:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-spi@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] spi: bcm2835: mark polling_limit_us as static
Message-ID: <20200915154814.GD4913@sirena.org.uk>
References: <20200915132311.1112865-1-mkl@pengutronix.de>
 <20200915140808.GA4913@sirena.org.uk>
 <243f7d21-149b-1c96-585f-2558c2ae44ad@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <243f7d21-149b-1c96-585f-2558c2ae44ad@pengutronix.de>
X-Cookie: Linux is obsolete
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2020 at 04:34:41PM +0200, Marc Kleine-Budde wrote:
> On 9/15/20 4:08 PM, Mark Brown wrote:

> > Thanks but I applied a patch for this yesterday.

> Doh! I rebased to current linus/master, which doesn't contain the patch yet :)

Oh, the issue affects mainline rather than just -next - I've applied it
for -next rather than as a fix, better move it over.  Thanks for letting
me know!

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9g4j4ACgkQJNaLcl1U
h9B9Twf8DM3Ocq2GTs8k+/Kb+6pKNRCGflS70re6XZ+OFqJ+mAdb5eikzLCH7vpz
DHk5bsNMG5hH1+ZzP1K8UQeJ4GlkIvomLd/xk8WMjJxymZrVDMUaXvK1dXddfh+d
qjVZDtBJDyh5UacaUVNbKO4HsQn6oi0sHcyBEbTKlYPtcSvXUhEXkl669mT9ctUJ
RFkYrdSrQRqZjbBKSUCn9N08Bu7L3tojgTmRSo2BgNHgXgd3z1uKObNSVQmkQweN
8fNVx6zGf5qsp7ZElH619lcHokwS2RJIaQN2yJWa2Wuj1dt7ZQ+gyegkAbPR3fpd
hHY6kGYDXS6qIRidOE2b/6kjsmojRA==
=j4mx
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
