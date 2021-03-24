Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E8C3483C8
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 22:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhCXVcl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 17:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238488AbhCXVce (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 24 Mar 2021 17:32:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A80AB61A01;
        Wed, 24 Mar 2021 21:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616621554;
        bh=Rb5aGgF5XSHVHPvvz0Biht5ShVFVbaxFO6erPbXbWRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psapsN6KxcLfNEO9rGI8wJGzJoV5zV/B8oTJuMQGLBIcmOtCH6MG1gfszKpNf122o
         w2gYUNkqL3HZDF5TNOZu2xHor/OSOEAnmX1dSSu8jQ4CfkUjEfh7CfpryJgvd3+LUN
         YKpRQYAnc/ebJrWA33iJsfsIavNEeXczjLkn+byjDMPa0+CcE/MtfEh0lSt9xRCBtf
         taY4LpiQMKmTp2z4fUiLeJVRZ7u7ZmJ72Y4jEMRigRUyreiqnZKLGGiP8Qu/1gM0Dr
         CaxNO1kW55kNXh3D/gcSAMOrWRFJlggunPjwdWGO7+opD5/0O3E8Q6PeQGYtXGDhL3
         0e3QGzn1QpH7w==
Date:   Wed, 24 Mar 2021 21:32:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: ensure timely release of driver-allocated resources
Message-ID: <20210324213225.GD4596@sirena.org.uk>
References: <YFf2RD931nq3RudJ@google.com>
 <20210322123707.GB4681@sirena.org.uk>
 <YFjyJycuAXdTX42D@google.com>
 <20210323173606.GB5490@sirena.org.uk>
 <YFo7wkq037P2Dosz@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
In-Reply-To: <YFo7wkq037P2Dosz@google.com>
X-Cookie: The eyes of taxes are upon you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 23, 2021 at 12:04:34PM -0700, Dmitry Torokhov wrote:
> On Tue, Mar 23, 2021 at 05:36:06PM +0000, Mark Brown wrote:

> No it is ordering issue. I do not have a proven real-life example for
> SPI, but we do have one for I2C:

> https://lore.kernel.org/linux-devicetree/20210305041236.3489-7-jeff@labundy.com/

TBH that looks like a fairly standard case where you probably don't want
to be using devm for the interrupts in the first place.  Leaving the
interrupts live after the bus thinks it freed the device doesn't seem
like the best idea, I'm not sure I'd expect that to work reliably when
the device tries to call into the bus code to interact with the device
that the bus thought was already freed anyway.

If we want this to work reliably it really feels like we should have two
remove callbacks in the driver core doing this rather than open coding
in every single bus which is what we'd need to do - this is going to
affect any bus that does anything other than just call the device's
remove() callback.  PCI looks like it might have issues too for example,
and platform does as well and those were simply the first two buses I
looked at.  Possibly we want a driver core callback which is scheduled
via devm (remove_devm(), cleanup() or something).  We'd still need to
move things about in all the buses but it seems preferable to do it that
way rather than open coding opening a group and the comments about
what's going on and the ordering requirements everywhere, it's a little
less error prone going forward.

> Note how dev_pm_domain_detach() jumped ahead of everything, and
> strictly speaking past this point we can no longer guarantee that we can
> access the chip and disable it.

Frankly it looks like the PM domain stuff shouldn't be in the probe()
and remove() paths at all and this has been bogusly copies from other
buses, it should be in the device registration paths.  The device is in
the domain no matter what's going on with binding it.  Given how generic
code is I'm not even sure why it's in the buses.

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBbr+kACgkQJNaLcl1U
h9Cragf8C50+G8gLDvLBvBvm+Ko43dFwGt2cZIwVyrwRJleFlHvl1Ao+1xVNBDvW
h1KWWY1LhXRDrRIxmDPKsstiFb8HSDjmZPea/lZ/OG7E/plYmgtg2VTT2mKEUp06
+vD2ciF90VODAgBqlJX10/kFI7K23S55NW/6J167vKd11kfG5y7KtVBeD2Rp1w2u
795aNs4LyGKr1DSEq1GMoif1wILj7ruXF5Iq5gZdrIePRW1tQ+3ZriWgr7SXM5i6
A5c9Q7NaiS4EoOLlxwgd9yltViJmt6ROBLpUM0ASqi+lxtaJ84/V4UgZm3g7h/MH
vXUBrg/FarZKaHuR8A5q/i1yI3oPTw==
=uQy2
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
