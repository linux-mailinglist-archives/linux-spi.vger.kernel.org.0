Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4492A9813
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 16:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgKFPK0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Nov 2020 10:10:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbgKFPKZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Nov 2020 10:10:25 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ADB322227;
        Fri,  6 Nov 2020 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604675425;
        bh=qThnILg5nCb2Hmeq+KRlqMIjinhD+Gy6r+f/5IjtZiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfKvbldlEjCUrMNJLyz6fMKmY16F90mXAb0rAyB1oXKnd22Z8cE41SI1B7o4oPWX7
         VWYOnlKUOLf3h+uRmL3y3+Hs9/Mc8PVRIOq1h6MbC+CoI7jO8PpPhzb/SGglWGdToj
         2oZ8sjwhQv2fFDzzIAgc9xlPTk+/6o7lPCylfiJs=
Date:   Fri, 6 Nov 2020 15:10:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Cheng-Jui.Wang@mediatek.com,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Daniel Mentz <danielmentz@google.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v1 2/2] spi: Populate fwnode in of_register_spi_device()
Message-ID: <20201106151011.GE49612@sirena.org.uk>
References: <20201104205431.3795207-1-saravanak@google.com>
 <20201104205431.3795207-2-saravanak@google.com>
 <20201105171201.GF4856@sirena.org.uk>
 <CAGETcx9_En10j0DwktXtPDrx=Aqdr2iWEuHmYB-=SnfODTmMfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <CAGETcx9_En10j0DwktXtPDrx=Aqdr2iWEuHmYB-=SnfODTmMfg@mail.gmail.com>
X-Cookie: It's the thought, if any, that counts!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2020 at 11:26:44AM -0800, Saravana Kannan wrote:
> On Thu, Nov 5, 2020 at 9:12 AM Mark Brown <broonie@kernel.org> wrote:

> > >       of_node_get(nc);
> > >       spi->dev.of_node = nc;
> > > +     spi->dev.fwnode = of_fwnode_handle(nc);

> > Why is this a manual step in an individual subsystem rather than
> > something done in the driver core

> It can't be done in driver core because "fwnode" is the abstraction
> driver core uses. It shouldn't care or know if the firmware is DT,
> ACPI or something else -- that's the whole point of fwnode.

Clearly it *can* be done in the driver core, the question is do we want
to.  The abstraction thing feels weaker at init than use after init,
"init from X" is a common enough pattern.  If it's done by the driver
core there would be no possibility of anything that creates devices
getting things wrong here, and the driver core already has a bunch of
integration with both DT and ACPI so it seems like a weird boundary to
have.

> > and wouldn't that just be a case of
> > checking to see if there is a fwnode already set and only initializing
> > if not anyway?

> Honestly, we should be deleting device.of_node and always use
> device.fwnode. But that's a long way away (lots of clean up). The
> "common" place to do this is where a struct device is created from a
> firmware (device_node, acpi_device, etc). I don't see a "common place"
> for when a device is created out of a device_node, so I think this
> patch is a reasonable middle ground.

That is obviously a much bigger job that's going to require going
through subsystems (and their drivers) properly to eliminate references
to of_node, I'm not clear how doing this little bit per subsystem rather
than in the core helps or hinders going through and doing that.  I don't
think you'll ever have a single place where a device is constructed, and
I'm not sure that that is even desirable, since there are per subsystem
things that need doing.

I'd be totally happy with eliminating all references to of_node from the
subsystem but for this it seems more sensible to do it in the driver
core and cover everything rather than running around everything that
creates a device from DT individually and having stuff fall through the
cracks - it's been a year since the equivalent change was made in I2C
for example, we've had new buses merged in that time never mind SPI not
being covered.

BTW I'm also missing patch 1 and the cover letter for this series, not
sure what's going on there?

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+lZ1IACgkQJNaLcl1U
h9DyUgf9GVIIEgVFeiFwfpBxRp9KUtKikyJJ4G/Plgv+Bogc094JDTo+SIaMoQbG
cmwe2/ku3ir8I4FL8ud8W572cFMJbzHdG+giRDMDzb69A+mmfwUiW8D48ZhVX4ks
LGqvriy1bH0BKfzAvoduiZTjGxeIEeZ7/k2i1r4oq9X35GLl3o4po4045SW8uWVQ
XQ9Gdy0PgMcUEcdwDnWlaRzXmUUMmYRpVdhliGYiAoQJ754UPh2Vl9dCj3nhw1vI
uI0s2QMjWdYju1fJtjkStB8b8mZkSWyoeoMJSZhi+d8Ie3bEi7u5QPc+F4f9Ln59
IJVRNPipUqgtxuadJaa6Ak57PilcXA==
=zoTL
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
