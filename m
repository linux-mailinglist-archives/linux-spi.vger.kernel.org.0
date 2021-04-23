Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB133691A4
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbhDWL63 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 07:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230431AbhDWL63 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 07:58:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02C5560FE6;
        Fri, 23 Apr 2021 11:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619179072;
        bh=XHhUEsWfWTLuM2T3rYpeV+q3eu/vxOPKqov8USBod8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KlsIf7gDmCUFe63JZrQcKGw3TpMYWWBKVFGoKAcLJemQo2BXM8sh/JklJWQy4aOEW
         7xY/iEUnXtDn6iXiD+qkvvBo9Roa51Nr+LizCJzD1SwOCkAOB9T6hKCXN+U6Il5r1f
         oSHswGUQOHWUHXqj8wcIv61T5aoft2iJVP7DpiLH9Geh8VpM5sce/+1vuKK8Y0AwY1
         xvXdqCrL2mrxdKXuiOMcBLNIM2XfAyBiNMPEwoy41doIxjynwVthWwP8ypXqTepXTm
         GBxIA47eNrV6mBjkzNlguwynHKNkpwzCo2Urv/gJpWECZUpvxDwzQmZS/uyn+zhYIW
         W/z89NBU5JpAw==
Date:   Fri, 23 Apr 2021 12:57:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joe Burmeister <joe.burmeister@devtank.co.uk>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nsaenz@kernel.org
Subject: Re: [PATCH] spi: bcm2835: Fix buffer overflow with CS able to go
 beyond limit.
Message-ID: <20210423115724.GB5507@sirena.org.uk>
References: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
 <c087ba2c-7839-02d1-a522-b104d8ffb8d2@gmail.com>
 <7c9f9376-1a80-b624-7b9e-0f6d04437c02@devtank.co.uk>
 <271ad212-a606-620e-3f0c-d6bff272be3c@gmail.com>
 <380624c4-82f3-0e6e-8cdb-8a9732636db8@devtank.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <380624c4-82f3-0e6e-8cdb-8a9732636db8@devtank.co.uk>
X-Cookie: This is now.  Later is later.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 23, 2021 at 11:03:22AM +0100, Joe Burmeister wrote:
> On 23/04/2021 00:49, Florian Fainelli wrote:

> > Right, which means that we should probably seek a solution within the
> > SPI core itself, even if you can only test with spi-bcm2835.c chances
> > are that the fix would be applicable for other controllers if done in
> > the core.

> I'm not sure it's possible to do in the core alone. The numb of the
> issue is the core changes ctlr->num_chipselect to what is in the device
> tree and some drivers are cool with that overs quietly stomp memory.

I wouldn't expect any controller to be OK with that?  Drivers can store
per-client data in spi_device->controller_data which doesn't need
scaling (but is also not so helpful if you need to look at clients other
than the one you're currently controlling).

> I've got a simple little patch to warn when the core expands
> ctlr->num_chipselect. This warning won't go off in bcm2835 with my patch
> because I am also extending ctlr->num_chipselect to the amount in the
> device tree before the core does that expansion. Hopefully that new
> warning would make people investigate and fix problem drivers.

> >> There is protection in spi_add_device, which will catch extra added
> >> later, but not ones in the device tree when the spi controller was
> >> registered.

> > Not sure I follow you, if we have the overlay before
> > spi_register_controller() is called, how can the check there not
> > trigger? And if we load the overlay later when the SPI controller is
> > already registered, why does not spi_add_device()'s check work?

> I think it might be a RPI thing. I think it is merging in the overlay
> and giving Linux one already merged.

If the overlay is handled by the bootloader then from the point of view
of Linux there is no overlay - sounds like there's an issue in the
overlay, it should be overriding something that it doesn't?

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCCtiMACgkQJNaLcl1U
h9Dwcgf/RhxsmRv+fSZkggMBeXhfQdCHVV9N6DSV57v+ahuQ8VCNWLfk/35iJjhl
tDd52TaNUx0yFF1suhpqhh6QeSugO1jxCa1n6i2fdjIH41VMdbJ8JUMN4MdQBQhx
7m1kLoHhq9p2RiAuwmD9nYo3A0oq9XqJf5dM2cMtnJMuOJZlOy34x/Fpm2b57wFt
tm6HNuCr6NGP/+QHomA1TUzir+ce3Kz3noDdkLcOhI7Xyzu21/zV7wir4cd9MuOy
rJrRknfYiUc+TAn75cI3cRozvyguuI5QmEVVl3CN65m/Z00docIaHpR/IN8CFqgB
UGuGG+IVAd/rMlxT+AwPnFD2P/3zrA==
=uofI
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
