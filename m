Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2C34667C
	for <lists+linux-spi@lfdr.de>; Tue, 23 Mar 2021 18:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhCWRg3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Mar 2021 13:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhCWRgP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Mar 2021 13:36:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8543619C3;
        Tue, 23 Mar 2021 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616520974;
        bh=oDC/AlOMNNqiI3w/qogsybWspWiOPV+oFkeENBLzUMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myKgCJ1K9JXiNlZrZija6Srb7E89+e5UhlYmdYsJAmdeWS1+WGF+cB/ZTW9yUPXLi
         omGoWJIkIXPBBE5APjgWtvMAWnlqpXpg1g3GsDzTXVH7b7o7vmDJLA/TIY1y3vDvdx
         5jgJOo8ISO0oCa8lJ7wTExA6EBkZ000uPDv7iNNvZhfT2afK87hMJdw5+0Fi5wV/Gg
         7ASWUDUXxXTRjwFbfpxY7a9KvAGDMy7Bs81oNzoi10ZtvkLtwEq6RE0mddT6FlnfDP
         srpH41snZB5JJ9thyCUq95Ybk6HyZp8VK3lTwSC1gFzJp87q2O1OlqmbGa9MiBXRWO
         DkNPqOMDPycgQ==
Date:   Tue, 23 Mar 2021 17:36:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: ensure timely release of driver-allocated resources
Message-ID: <20210323173606.GB5490@sirena.org.uk>
References: <YFf2RD931nq3RudJ@google.com>
 <20210322123707.GB4681@sirena.org.uk>
 <YFjyJycuAXdTX42D@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <YFjyJycuAXdTX42D@google.com>
X-Cookie: Formatted to fit your screen.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 22, 2021 at 12:38:15PM -0700, Dmitry Torokhov wrote:
> On Mon, Mar 22, 2021 at 12:37:07PM +0000, Mark Brown wrote:

> > This feels like it might make sense to push up to the driver core level
> > then rather than doing in individual buses?

> That is exactly the issue: we can't. Driver core already releases all
> resources when a device is being unbound but that happens after bus
> "remove" code is executed and therefore is too late. The device might
> already be powered down, but various devm release() callbacks will be
> trying to access it.

Can you provide a concrete example of something that is causing problems
here?  If something is trying to access the device after remove() has
run that sounds like it's abusing devres somehow.  It sounded from your
commit log like this was something to do with the amount of time it took
the driver core to action the frees rather than an ordering issue.

> devm only works when you do not mix manual resources with managed ones,
> and when bus code allocates resources themselves (attaching a device to
> a power domain can be viewed as resource acquisition) we violate this
> principle. We could, of course, to make SPI bus' probe() use
> devm_add_action_or_reset() to work in removal of the device from the
> power domain into the stream of devm resources, but that still requires
> changes at bus code, and I believe will complicate matters if we need to
> extend SPI bus code to allocate more resources in probe(). So I opted
> for opening a devm group to separate resources allocated before and
> after probe() to be able to release them in the right order.

Sure, these are standard issues that people create with excessive use of
devm but the device's remove() callback is surely already a concern by
itself here?

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBaJwYACgkQJNaLcl1U
h9BoyQf/f2ROjm2etfrH/N3efFqG1QWOvF+H63dZdFFDyZbRvY4BxxI66hV7Pke4
aOOpTQWfbTKL4mydhrbhlV10yjU7U0rZgq68bL14Dk8y+5X1pUhJkcPx1hfIp81y
4o1Os0ZmbsiMO5wiJ4ZIPFMsPd7Ya0pamF1TFV7PA2V0YJioyktMP3+ik69C16wf
l6nu365V8DSdOs2OWc7/HX2LSwDsUqSDCFAG1DgOlzMql8nOT5kGPujGa1jcBzyb
SgU+2T8C8ONPeno+n47hXoFQ56kh9JaK9QrA3q2PlgZ2icUhAnpHpnbiSEDU6u/1
nGlNpKrdGEhDsGgVns3Q99gwEP5tIg==
=xtvY
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
