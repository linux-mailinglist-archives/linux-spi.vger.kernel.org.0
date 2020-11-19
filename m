Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED42B9AD2
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 19:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgKSSoC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 13:44:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbgKSSoB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Nov 2020 13:44:01 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C52822259;
        Thu, 19 Nov 2020 18:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605811441;
        bh=1joi0BzfJ34EGDkWFg1yHrDA9K5NxjxinTyZsWFIOp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGoTRw9U7AJH7/W+8WrLd4hfOlWrwRetLZpLu+G/78zIcmRbk3c8PlcGK5tp46M7d
         LXr2JR/KEj5k7QSupYSIPi/cl/kUt90LntUtMZO4s2IGfsWcKvpCKZwL16FuTMfnz8
         OEnyOLPnfrcS8CjH4wpCkAwoQn3ubrLgD3Hwkcrs=
Date:   Thu, 19 Nov 2020 18:43:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] spi: Take the SPI IO-mutex in the spi_setup() method
Message-ID: <20201119184340.GJ5554@sirena.org.uk>
References: <20201117094517.5654-1-Sergey.Semin@baikalelectronics.ru>
 <20201118131604.GC4827@sirena.org.uk>
 <20201118162931.sdpofyw74yyr5n5z@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Content-Disposition: inline
In-Reply-To: <20201118162931.sdpofyw74yyr5n5z@mobilestation>
X-Cookie: Chocolate chip.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 18, 2020 at 07:29:31PM +0300, Serge Semin wrote:
> On Wed, Nov 18, 2020 at 01:16:04PM +0000, Mark Brown wrote:

> > Yeah, problems with it are very common as the documentation has noted
> > since forever.  IIRC there was some problem triggered by trying to force
> > it to be serialised but I can't remember what it was.

> Does it mean nack for this patch from you? So you suggest to fix the controller
> driver instead, right? If so the best solution would be to just lock the
> IO mutex in the set_cs callback of the DW APB SSI driver...

I'm not 100% clear what the original issue was, given that this is a
constant source of errors in drivers it seems like it should be better
to change the core but since I don't know why we have this the way it is
it's hard to tell what special cases we might have that could explode if
we try to do so.  I *think* the main issue is things that don't actually
have separate per device registers trying to configure the single set of
controler registers shared by all devices in which case the locking is
fine and helps with this specific case where it's a read/modify/write
operation on per device stuff and this makes sense.

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+2vNsACgkQJNaLcl1U
h9CL2Af/VvS0zGWDsgo71torPajAWSYTPk6YdmcG4eS31C5LQZOEJvIObq+4TeFG
XKJE5L+IJhRzNUP2IwBam1Mfy+NuGBHWeYdieiZyWokg+b9CqkiVV6XOmLuJ2r31
WwWFf5dcScT0V/6BtmvbwgbvBPx8+emcPga6kGCFCdOhfxhFrTmqB5QEC8ifv0A7
KvT0Qn4tgynMzESe+ba8aQ/ggHW3WRgKPisK785/gKdfYRkytiyN2yDT8obcfGh6
hkXm7sWPG8FaWL7wmhJxD1HTrwHtxrDLnzCke7qmiNmcq6mIlFy8aUxEEvx/p/T2
A+e50+l+u5DpDXJobylwbKcGTfYw6A==
=oXk6
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--
