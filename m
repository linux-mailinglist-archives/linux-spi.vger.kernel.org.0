Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6918D348567
	for <lists+linux-spi@lfdr.de>; Thu, 25 Mar 2021 00:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhCXXj5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 19:39:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239026AbhCXXjn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 24 Mar 2021 19:39:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9960261974;
        Wed, 24 Mar 2021 23:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616629183;
        bh=qr/w/ECHWsqgq3RnQdgz/oNY+gnwbVI76xS+wOY8LEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8ofVoFyKegwsQPd7o/QQRGRXhvLBni+moVYG0tRV4kQbecXVPEd3WJpCzMy8oocs
         xxao5CbkfLMKvhgib+QUiNGJRLMhuXqLk+SU4XtamqzaxOZ0PGMcwcj5FpdEjl8PI5
         9XEkxzBeDogRq7NZjn7XzHmF2Z24w0CnFsk9nkgLqTAWZ8RfMvghW9zMpOvLsxx7K6
         H98m3mbNPoJK9IJY3sljc6Ve0CI9fw7AVAdeOiL5kGZB50eF3P8Vm2g/fF3Zr+PtJk
         E6TTNN3pOYKoGUTKBxzA3ljR5BRII7fnOOFTyUmqIDlBhCyDBZ9wha5uZ3seGCxKxP
         bAGhRFwKiO7RQ==
Date:   Wed, 24 Mar 2021 23:39:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: ensure timely release of driver-allocated resources
Message-ID: <20210324233935.GE4596@sirena.org.uk>
References: <YFf2RD931nq3RudJ@google.com>
 <20210322123707.GB4681@sirena.org.uk>
 <YFjyJycuAXdTX42D@google.com>
 <20210323173606.GB5490@sirena.org.uk>
 <YFo7wkq037P2Dosz@google.com>
 <20210324213225.GD4596@sirena.org.uk>
 <YFu8y9CuG6Mouxnq@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lkTb+7nhmha7W+c3"
Content-Disposition: inline
In-Reply-To: <YFu8y9CuG6Mouxnq@google.com>
X-Cookie: The eyes of taxes are upon you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--lkTb+7nhmha7W+c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 24, 2021 at 03:27:23PM -0700, Dmitry Torokhov wrote:
> On Wed, Mar 24, 2021 at 09:32:26PM +0000, Mark Brown wrote:

> > TBH that looks like a fairly standard case where you probably don't want
> > to be using devm for the interrupts in the first place.  Leaving the
> > interrupts live after the bus thinks it freed the device doesn't seem
> > like the best idea, I'm not sure I'd expect that to work reliably when
> > the device tries to call into the bus code to interact with the device
> > that the bus thought was already freed anyway.
>=20
> That is not an argument really. By that token we should not be using
> devm for anything but memory, and that is only until we implement some
> kind of memleak checker that will ensure that driver-allocated memory is
> released after driver's remove() method exits.

I pretty much agree with that perspective TBH, I rarely see interrupt
users that I conside safe.  It's the things that actively do stuff that
cause issues, interrupts and registration of userspace interfaces both
being particularly likely to do so as work comes in asynchronously.

> You also misread that the issue is limited to interrupts, when i fact
> in this particular driver it is the input device that is being
> unregistered too late and fails to timely quiesce the device. Resulting
> interrupt storm is merely a side effect of this.

My understanding was that the issue is that the driver is generating
work because the interrupt is firing, if the interrupt had been
unregistered we'd not be getting the interupts delivered (probably
they'd have been disabled at the interrupt controller level) and not
have the problem of trying to handle them on a partially unwound device.

> > looked at.  Possibly we want a driver core callback which is scheduled
> > via devm (remove_devm(), cleanup() or something).  We'd still need to
> > move things about in all the buses but it seems preferable to do it that
> > way rather than open coding opening a group and the comments about
> > what's going on and the ordering requirements everywhere, it's a little
> > less error prone going forward.

> From the driver's perspective they expect devm-allocated resources to
> happen immediately after ->remove() method is run. I do not believe any
> driver is interested in additional callback, and you'd need to modify
> a boatload of drivers to fix this issue.

Not a callback for the device drivers, for the buses.  This is
essentially about converting the unwinding the bus does to be sequenced
for devm.

> I agree with you that manual group handling might be a bit confusing
> and sprinkling the same comment everywhere is not too nice, so how about
> we provide:

> 	void *devm_mark_driver_resources(struct device *dev)

> and

> 	void devm_release_driver_resources()

> and keep the commentary there? The question is where to keep
> driver_res_id field - in generic device structure or put it into bus'
> device structure as some buses and classes do not need it and we'd be
> sawing 4-8 bytes per device structure this way.

I guess bus' device :/

> Another way is to force buses to use devm for their resource management
> (I.e. in case of SPI wrap dev_pm_domain_detach() in
> devm_add_action_or_release()). It works for buses that have small number
> of resource allocated, but gets more unwieldy and more expensive the
> more resources are managed at bus level, that is why I opted for opening
> a group.

If the driver core were doing it and scheduling a single callback the
bus provides then that callback could do as much as it likes...

--lkTb+7nhmha7W+c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBbzbYACgkQJNaLcl1U
h9A2nwf7BjmiOmCimK2+EhDoIftIg4kOuThQb96cl9IedNwKzISIRMqghrEpf8a8
0EpE5+GfkhnVLfqbtR0/ESURMJ6uGuzhRNG5cCeb7L2e8WRPqTd1G2/5awu0tEFI
xN7YxXaAj/92D8pE64+L4D3ES7E2fr3SyBEntGsmctrcPqoGCf9Uxx0XaONIhgsy
2kiOEMQT5+MFzIOdDJsvgJIPfuqPc4opoobW1taQaNOTmfNv1yojlZ+LgTzIR527
pwshufPubRkR3ASAak3zgoVjyMo9jD/tS2dw97uc6DuJHNE+3amHYO85sjc1ek3u
PLNn+FCbpOuRODy36/SLS65Uwu2zNQ==
=9R9k
-----END PGP SIGNATURE-----

--lkTb+7nhmha7W+c3--
