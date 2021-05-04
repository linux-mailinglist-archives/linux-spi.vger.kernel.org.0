Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FBB3729B0
	for <lists+linux-spi@lfdr.de>; Tue,  4 May 2021 13:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhEDLxB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 May 2021 07:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230089AbhEDLxA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 4 May 2021 07:53:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 511A360240;
        Tue,  4 May 2021 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620129125;
        bh=CYlTF8vPOUGmP1yrj7WXGHoZZMuyrNVYYEyGYgffhQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9USfbjjXhLtVfch5jWn/Z3G+U9DCpzZ6IpciENXXJSVOTDjJrWwokOxltdsRqO9h
         bIaG6mNG27BKjX4+ieMquX/Y/eV0kQzpzl5x0UoWcn74Ndr3OgCbqYVkCdxhIzsNPg
         MKWro3VGJKzDzSRui4MFkqT7CH4OvAGM9cKqU7Jk9y+f4uMmOj0gSNkCvvxyOr+s5j
         eD9kibxr/8N5vQkT/GR0dE2bNqIIZD8vwl3NybBdkSMO2yujuewgGkxWk23f/RUYa4
         BLTc2oqbzXas8Zeif/sZGypzN4Xwa06Or8VEJH/ZkVXt7OBL56kDav35SJ+3VpjV//
         UjpKR1w+nJJwQ==
Date:   Tue, 4 May 2021 12:51:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nsaenz@kernel.org, phil@raspberrypi.com
Subject: Re: [PATCH] spi: bcm2835: Fix buffer overflow with CS able to go
 beyond limit.
Message-ID: <20210504115130.GA7094@sirena.org.uk>
References: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
 <c087ba2c-7839-02d1-a522-b104d8ffb8d2@gmail.com>
 <7c9f9376-1a80-b624-7b9e-0f6d04437c02@devtank.co.uk>
 <271ad212-a606-620e-3f0c-d6bff272be3c@gmail.com>
 <380624c4-82f3-0e6e-8cdb-8a9732636db8@devtank.co.uk>
 <20210423115724.GB5507@sirena.org.uk>
 <672e8d77-ee5c-f10f-0bd3-f8708dfc24c8@devtank.co.uk>
 <20210423162055.GE5507@sirena.org.uk>
 <20210501195135.GA18501@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20210501195135.GA18501@wunner.de>
X-Cookie: MY income is ALL disposable!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 01, 2021 at 09:51:35PM +0200, Lukas Wunner wrote:
> On Fri, Apr 23, 2021 at 05:20:55PM +0100, Mark Brown wrote:
> > Part of the issue here is that there has been some variation in how
> > num_chipselect is interpreted with regard to GPIO based chip selects
> > over time.  It *should* be redundant, I'm not clear why it's in the
> > generic bindings at all but that's lost to history AFAICT.

> It seems num_chipselect is meant to be set to the maximum number of
> *native* chipselects supported by the controller.  Which is overwritten
> if GPIO chipselects are used.

This gets fun with the controllers that have for various reasons open
coded some or all of the GPIO chip select handling.

> I failed to appreciate that when I changed num_chipselects for
> spi-bcm2835.c with commit 571e31fa60b3.  That single line change
> in the commit ought to be reverted.

> And the kernel-doc ought to be amended because the crucial detail
> that num_chipselect needs to be set to the maximum *native* chipselects
> isn't mentioned anywhere.

Can you send patches for these please?

> > The best thing would be to have it not have a single array of chip
> > select specific data and instead store everything in the controller_data
> > that's there per-device.

> Unfortunately that's non-trivial.  The slave-specific data is DMA-mapped.
> It could be DMA-mapped in ->setup but there's no ->unsetup to DMA-unmap
> the memory once the slave is removed.  Note that the slave could be removed
> dynamically with a DT overlay, not just when the controller is unbound.

> So we'd need a new ->unsetup hook at the very least to make this work.

There's the cleanup() callback which seems to fit?

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCRNUEACgkQJNaLcl1U
h9DsmQf/UKHAwxHaMURxnn5hgYu8xFWNaqLHCJM2/x2xMcPvDWe1QWDAtzr7CXg8
BsQ9qd/qGyPFHQyyJVbYK7ahxIkVFdhTkASvHGmn4uGAyKVN2QNNM5Miom5diVzA
U88F61K/5WkDEcG5y85IoZKMTKlcUxL11VlWBMCYvYLNzky6iWpWlt8MPj+TBVmu
QNIhRRVNEEMFEBNcg7YNHkdf+farFIu8oCaRmxFGSGLFZNx5FOBIsHL/y6djiCMZ
CotSqF62zku4CDADQDFVHMzpl4JOcqWqItfl4sir3QIux6aV6KJvLDK2V7lj4noo
8VIITEOCIcvfIDGRZt6wANRN3FV/sw==
=QRb8
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
