Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645811F9DFE
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 19:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgFORAe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 13:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731104AbgFORAe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 13:00:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2213620656;
        Mon, 15 Jun 2020 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592240433;
        bh=pjNF9x2RDPj8kZJYuvgsDx7Y5A6qAlByLppUV8O4V7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ykZg4D1WVda3DXTdJX5l0ZNtXOQVaoBZMW53mCeTqP5/BvWrjzSYGKXOaE5RjuSHL
         qD0aM9rtiTVOu88XF56dUtwE5BI9uxSavO7+S0OM5eG3bo0KhQhI8Ba1m3tEstjOYc
         CxIW/9zM3i9cSjjTCVvhTek75ILPzbpK0weS5GZU=
Date:   Mon, 15 Jun 2020 18:00:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, lukas@wunner.de,
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
Message-ID: <20200615170031.GA4447@sirena.org.uk>
References: <20200604212819.715-1-f.fainelli@gmail.com>
 <142d48ae-2725-1368-3e11-658449662371@arm.com>
 <20200605132037.GF5413@sirena.org.uk>
 <2e371a32-fb52-03a2-82e4-5733d9f139cc@arm.com>
 <06342e88-e130-ad7a-9f97-94f09156f868@arm.com>
 <d3fe8b56-83ef-8ef0-bb05-11c7cb2419f8@gmail.com>
 <a6f158e3-af51-01d9-331c-4bc8b6847abb@arm.com>
 <20200608112840.GC4593@sirena.org.uk>
 <bb9dbf11-9e33-df60-f5ae-f7fdfe8458b4@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ofekNuVaYCKmvJ0U"
Content-Disposition: inline
In-Reply-To: <bb9dbf11-9e33-df60-f5ae-f7fdfe8458b4@gmail.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ofekNuVaYCKmvJ0U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2020 at 09:34:58AM -0700, Florian Fainelli wrote:

> OK, so this has been dropped for spi/for-next right? How do we move from
> there?

Well, I actually have it queued up for applying so unless I pull it
before my scripts get that far through the stuff I queued over the merge
window it'll go in (I dropped it due to it not being a bugfix).  If it
were me I'd go with the two instruction hit from checking the flag TBH
but otherwise I guess __always_inline should work for compilers that
misoptimize.  None of this is getting in the way of the framework so if
everyone involved in the driver is happy to spend time optimising it
and dealing with the fragility then it's fine by me.

--ofekNuVaYCKmvJ0U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7nqS4ACgkQJNaLcl1U
h9C/sQf/Q3a6fPdDE/0SszY8YBwi3lo7IhvhUsM32lAT1geHoCRQZMcFUSMjktHG
nv7SU6QcpZSidvlFYnamRdn5jMZSGEUDvNEASoCZ+aqhJhFG/Gb5ks94ILJMEhF8
b4tk7QCWkn+w6n99PyrNMCh9dExt3yRkHXG2M9a6a5UHxCO2JW12sA0eyEfBW30Q
8QNyzNCpYeclwKH0MW91BpjbUwKCPXDRcDOgmSIRX6ACrVbs6xU5BUGVdZRjMcb9
x8zWxbr6yIZtuGKsPTyVGQDmO/wroEYA84CbYpHOEl0Oe81nhQp9nm6rJzT3IGhn
jcdeWnCufYRam1maBk4xhwDZV6o/pA==
=6wIF
-----END PGP SIGNATURE-----

--ofekNuVaYCKmvJ0U--
