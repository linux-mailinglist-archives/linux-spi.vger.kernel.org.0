Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CC31EF8D3
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgFENUl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 09:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbgFENUk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Jun 2020 09:20:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5F12065C;
        Fri,  5 Jun 2020 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591363240;
        bh=8BjtpV0ecJEgsvWK1ul8PsDdqfyLu30JW/S3Yqv/vGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1v1uwO8oSoExJnTbaNzm0VXW7Zl1MvMc119/QvOAbE7qh1tXndCPo0BkPisP1ReJR
         v7/OIXvCo7vyHQe1J1N/w1iEq8jqKHFD95mSV18DIj+OArLVfblrmtiKQIGCVkIGoL
         BZyOkkIORbn8a1ip7RS/L5YtOlIIkC2KHPcpHXTE=
Date:   Fri, 5 Jun 2020 14:20:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>, lukas@wunner.de,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200605132037.GF5413@sirena.org.uk>
References: <20200604212819.715-1-f.fainelli@gmail.com>
 <142d48ae-2725-1368-3e11-658449662371@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Content-Disposition: inline
In-Reply-To: <142d48ae-2725-1368-3e11-658449662371@arm.com>
X-Cookie: Air is water with holes in it.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2020 at 12:34:36PM +0100, Robin Murphy wrote:
> On 2020-06-04 22:28, Florian Fainelli wrote:

> > For the BCM2835 case which is deemed performance critical, we would like
> > to continue using an interrupt handler which does not have the extra
> > comparison on BCM2835_SPI_CS_INTR.

> FWIW, if I'm reading the patch correctly, then with sensible codegen that
> "overhead" should amount to a bit test on a live register plus a not-taken
> conditional branch - according to the 1176 TRM that should add up to a
> whopping 2 cycles. If that's really significant then I'd have to wonder
> whether you want to be at the mercy of the whole generic IRQ stack at all,
> and should perhaps consider using FIQ instead.

Yes, and indeed the compiler does seem to manage that.  It *is* non-zero
overhead though.

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7aRqQACgkQJNaLcl1U
h9DI1Qf/Tz5aGiXqtwU/k3+gw6+ficRLOe7pkUSPRyQIDVciDPUy7ytsm0jw29uw
8SGzHF424tB65sfcrF+DHOEYXQRxMhKGJfZgQlPpENPIzuN/6keGkfQ9F8iNgUHe
e8yOJRLUXEte7TB+5GOmQJnFY3prtrRTIE6nl3NJaOiO7zoX87nVXAJmt/+scwjm
/RPUYi1A76q3Wj8ntaakVEyxYG1G6tKk8Fq9UF8AfTiQ0MC2EZmfzd/refGIJfD8
L2QTTwMIB7erragBJbjTX9alKe3/qkYlSS27+HGIg/HC+P2mODP9hJg67ZqLVPPr
AeJLVJyfEzBWbzeii15aKq82J0fXsw==
=aGmF
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
