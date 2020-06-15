Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E4B1FA028
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 21:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgFOT0e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 15:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729854AbgFOT0d (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 15:26:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B9420756;
        Mon, 15 Jun 2020 19:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592249193;
        bh=AvkDF1W+evs4ACyDeBmJZSphxtaBgYojELjru6qP34U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AL6Ge9s0gex0hxoxM3nzvCoe5DV/SPRIHO8CUoZbbay9M628GxRDagsRytBs1A9hF
         IsifoHGmtCVGfPlnC3zKNzsG6zYkedW5VzfUXPM9n6gdKYZVYEA+h/q2CB3/L5Qk9H
         XMKdQOOeOQeTwF6cws0Y/DjmJP/RimvZu81zBaXI=
Date:   Mon, 15 Jun 2020 20:26:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, lukas@wunner.de,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
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
Message-ID: <20200615192630.GC4447@sirena.org.uk>
References: <20200605132037.GF5413@sirena.org.uk>
 <2e371a32-fb52-03a2-82e4-5733d9f139cc@arm.com>
 <06342e88-e130-ad7a-9f97-94f09156f868@arm.com>
 <d3fe8b56-83ef-8ef0-bb05-11c7cb2419f8@gmail.com>
 <a6f158e3-af51-01d9-331c-4bc8b6847abb@arm.com>
 <20200608112840.GC4593@sirena.org.uk>
 <bb9dbf11-9e33-df60-f5ae-f7fdfe8458b4@gmail.com>
 <20200615170031.GA4447@sirena.org.uk>
 <692bc94e-d574-e07a-d834-c0d569e87bba@gmail.com>
 <2f354ed0-9fb7-59ea-ddd1-78703d9c818e@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dOtxUVmLoGkyu1PA"
Content-Disposition: inline
In-Reply-To: <2f354ed0-9fb7-59ea-ddd1-78703d9c818e@arm.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dOtxUVmLoGkyu1PA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2020 at 06:31:58PM +0100, Robin Murphy wrote:

> Now that I've been inclined to go and look up the documentation, are we sure
> this so-very-contentious check is even correct? From my reading of things
> we're checking whether the RXR interrupt function is *enabled*, which still
> says nothing about whether either condition for the interrupt being
> *asserted* is true (RXR = 1 or DONE = 1). Thus if more than one SPI instance
> is active at once we could still end up trying to service an IRQ on a
> controller that didn't raise it.

OK, I've pulled the patch from the queue for now :/

--dOtxUVmLoGkyu1PA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7ny2YACgkQJNaLcl1U
h9Dlcwf/TI9wOgBtOFPjlWSb4Y2ZgnY4A2yEniFWHZl5+Z/hDkPg8DQB5gpHbOJB
aq6nJ/zdl7Ls8/2fAZFBLoKdl1x02xn0g50XxakTsSSVgaumCRRjx/bZkpnWDRMi
hOv3B7MZ/8QIJaoW4XW9h4Gr+FUmYL7OGkVcE0ZfPkN+raFcKBhRC6J3CZODGONN
xa7O7JtoQu8TFEnp97ymMxfxpWdiyGRfkz0eCJMiFLjv+1CUcneJEMDJ+RRZzQbZ
/KAoGLuKCfm0fFD5QlI9XwsSEVpPa0BHmSWbGa+cxxRZMqq0EnmYzL4TT9twKHXi
QK/ulZP2pSHvw+ZBQfDln2Mm1nPbhQ==
=3Gjc
-----END PGP SIGNATURE-----

--dOtxUVmLoGkyu1PA--
