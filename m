Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2B3696CB
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 18:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhDWQWB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 12:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhDWQWA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Apr 2021 12:22:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B27F61076;
        Fri, 23 Apr 2021 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619194884;
        bh=Du6lrJKXMMsCR3cPrKGmwGJJyqUjppjm0rJTM8RTBNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJ+B6KFU3EgpUaiVBMfLcmSLWayGiNKRvoBe9kA+AsY6DJtOHZwxDXB+db0JX3nOq
         x/TZqUsuUT/Wzf3OUrTJe/3vUijBLpbbpRoROsQRXjeHS040Zv4GPJGHdEjFTXasZN
         K/tmTF+aiMeIgEXbNEanY7LY51bIT8jPYLmxEEx9UTgrar5wUeeL2tFDVPdCCfgBXO
         kZ0PosAhYfaZ/QUF67sHJqxnULhCQiHNyHarAjqPAy5H29ZMidmJN5D9/rMMb9UW9x
         mPx+nV9K6LUEm8VaODtcnn91IsahmEwVi+4k5V4HUwf7mdV9JY7DHgReHbWDQVls4l
         bubgH+WXZ8Ujw==
Date:   Fri, 23 Apr 2021 17:20:55 +0100
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
Message-ID: <20210423162055.GE5507@sirena.org.uk>
References: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
 <c087ba2c-7839-02d1-a522-b104d8ffb8d2@gmail.com>
 <7c9f9376-1a80-b624-7b9e-0f6d04437c02@devtank.co.uk>
 <271ad212-a606-620e-3f0c-d6bff272be3c@gmail.com>
 <380624c4-82f3-0e6e-8cdb-8a9732636db8@devtank.co.uk>
 <20210423115724.GB5507@sirena.org.uk>
 <672e8d77-ee5c-f10f-0bd3-f8708dfc24c8@devtank.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
Content-Disposition: inline
In-Reply-To: <672e8d77-ee5c-f10f-0bd3-f8708dfc24c8@devtank.co.uk>
X-Cookie: This is now.  Later is later.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 23, 2021 at 03:12:11PM +0100, Joe Burmeister wrote:
> On 23/04/2021 12:57, Mark Brown wrote:

> > I wouldn't expect any controller to be OK with that?  Drivers can store
> > per-client data in spi_device->controller_data which doesn't need
> > scaling (but is also not so helpful if you need to look at clients other
> > than the one you're currently controlling).

> I can see a number which certainly wouldn't. Though I don't want to
> assume that all don't.

Yeah, some won't - some do also rely on system specific assumptions
about what's possible but there's not really mechanisms for declaring
that.

> If we are happy just not letting the core expand num_chipselect that
> does stop the condition on everything.

> Any controller that can go higher without issue could them have their
> num_chipselect set to what their real limit is if this enforcement
> causes an issue.

Part of the issue here is that there has been some variation in how
num_chipselect is interpreted with regard to GPIO based chip selects
over time.  It *should* be redundant, I'm not clear why it's in the
generic bindings at all but that's lost to history AFAICT.

> >>> Not sure I follow you, if we have the overlay before
> >>> spi_register_controller() is called, how can the check there not
> >>> trigger? And if we load the overlay later when the SPI controller is
> >>> already registered, why does not spi_add_device()'s check work?

> >> I think it might be a RPI thing. I think it is merging in the overlay
> >> and giving Linux one already merged.

> > If the overlay is handled by the bootloader then from the point of view
> > of Linux there is no overlay - sounds like there's an issue in the
> > overlay, it should be overriding something that it doesn't?

> Does it matter if the final device tree was compiled like that in the
> first place or merge into that by the bootloader?

It matters in the context of a discussion of ordering between loading
the overlay and spi_register_controller() - it's clearly not loaded
afterwards.

> Of course we could just raise BCM2835_SPI_NUM_CS to 8 or more if that is
> preferred. Does seams like the dynamic solution is less favoured.

The best thing would be to have it not have a single array of chip
select specific data and instead store everything in the controller_data
that's there per-device.

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCC8+YACgkQJNaLcl1U
h9DEEAf9GQ05ZPI/yujR/34Ofd3FvuiVwve/4suxGMcw1afbBIcgShZfQjwoPCwz
AX+qTV1PjwlCpUUlPOjfRPEfcuV5Bcw4WzG7bQkKrYyqQLSJ02LTxMVTtLuxgCHL
vPLgBJu8ZMlFvOPXtzsYFhK5qCbemC9AAqKbQXjsGVcQR7G7rZd4TLoP1x73idr7
UgbPlXBX0RhXi1CDLPmb3tEP0tJNbECRYDTqUk64FwHrNW9k5cGBv7p7Rcoib3dn
eiTCBZZC4tb9IFRhqXifjJbNuWSIf40ij0TAHSnEzldLrTl8o00YsJbfDJRG2NcD
90l+UobbZtvVX4pSU2dmVEE1/PIpZw==
=bjuX
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--
