Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457211EFC78
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 17:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgFEP1m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 11:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgFEP1m (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Jun 2020 11:27:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7F722075B;
        Fri,  5 Jun 2020 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591370861;
        bh=cwE6lN0oRc3R/lRo7XRlwrgGSlMb3orxHCcOBwJlZXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5Jmn118NsrWlHCB8CdqciMyPXagQuykia3JVFkCcJCzYTmb1v3C3l6d+WqCBuuxg
         X2D0lPfLpPM/iw1FJuKwWoyG8o5jVxndq+h3q1ezTpdrSa4BM+BkILAyqPPcR3NN9X
         0xR/4sbzqBqkW8UAQT5sfhnTNG3o1kdFnjP9RbwA=
Date:   Fri, 5 Jun 2020 16:27:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>, lukas@wunner.de,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200605152739.GH5413@sirena.org.uk>
References: <20200604212819.715-1-f.fainelli@gmail.com>
 <142d48ae-2725-1368-3e11-658449662371@arm.com>
 <20200605132037.GF5413@sirena.org.uk>
 <2e371a32-fb52-03a2-82e4-5733d9f139cc@arm.com>
 <06342e88-e130-ad7a-9f97-94f09156f868@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Content-Disposition: inline
In-Reply-To: <06342e88-e130-ad7a-9f97-94f09156f868@arm.com>
X-Cookie: Air is water with holes in it.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2020 at 03:41:27PM +0100, Robin Murphy wrote:

> Ha, and in fact having checked a build out of curiosity, this patch as-is
> actually stands to make things considerably worse. At least with GCC 8.3 and
> bcm2835_defconfig, bcm2835_spi_interrupt_common() doesn't get inlined, which
> means bcm2835_spi_interrupt() pushes/pops a stack frame and makes an
> out-of-line call to bcm2835_spi_interrupt_common(), resulting in massively
> *more* work than the extra two instructions of simply inlining the test.

Whichever compiler I was using (clang-11 probably) did manage to inline
the tail call so it really was the two instructions but yeah, in general
this approach is going to be fragile.

> So yes, the overhead of inlining the test vs. the alternative is indeed
> non-zero. It's just also negative :D

And variable!

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7aZGoACgkQJNaLcl1U
h9AX6gf7Bm5ytifNBvydJuvs4NzgM67Urhjfzt+XzOq9aPGD/YyTV42HNCmGAqGy
SK5nGgR0rYbNixHVpe8BR8sR7ouoD+RplUaa6HByo8h538lDdtImQw5mxOM7jSqj
YqJQrm1hwA4Exl+b3ko3Ec3LfHP8Z+IPS0pbuhibX42asNbhDsUc7dKMVGOPsA0m
M06K9koGLwc5XEs7+4ylBVfqhTKIQSiHeg8K1TJ3VQEFBqOCBoURI0TLPUPo3PYV
vg5NvWtlPqYwBj/gWm4+jdTPM2Ru10LTa+jU3KnroOtJSBil2tErrvKb31iWGgS5
ECVrLTGILzwbt5Gq0ojVE1LsJVSmqg==
=/uNB
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--
