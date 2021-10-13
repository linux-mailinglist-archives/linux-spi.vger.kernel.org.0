Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF6442C781
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 19:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhJMRYY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 13:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhJMRYY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 13:24:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C28E61040;
        Wed, 13 Oct 2021 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634145740;
        bh=nG2EoRRdJa5eBOPONd3hnjhh/SBbCXGjbTtICsGwx4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=px6o+DSCIdrfu20p2jXsmCTFORME13kwcDshmld9ZVqfwe4SJDFWnOHI2u2wNB+F4
         Jpmhc5lXyLIasmt8DoyZ5+PoEdHy+X7lPBx4geN9CfJqmpXPJm6yChgxXww8Yp0a+2
         51Ero/IJbnaMsO5i9wpxa7xc8tBebj9MP6l1foftAbNuRwmFbBWce8QIdsj9oVhzXm
         DWpqH3fb4IENAg0WcKUFTKWSdZdAYhNUcg3QwvWItNro6V88TafHM2y8zGSATNVwnU
         zuEAkWqktutcoveqy1zVK/+ILf0sAKdKFm/JUVCjImQBACsIYMUJrWxYRg98Rw0vZu
         PtOm1zkghcyqA==
Date:   Wed, 13 Oct 2021 18:22:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: Make spi_add_lock a per-controller lock
Message-ID: <YWcVyaw6YN3bRfcq@sirena.org.uk>
References: <20211013133710.2679703-1-u.kleine-koenig@pengutronix.de>
 <YWb5gUxgdiczqV5Q@sirena.org.uk>
 <20211013161033.yrquwcgwzqxwfszo@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="noiCMqsGHJTG/Zf0"
Content-Disposition: inline
In-Reply-To: <20211013161033.yrquwcgwzqxwfszo@pengutronix.de>
X-Cookie: Where do you think you're going today?
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--noiCMqsGHJTG/Zf0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2021 at 06:10:33PM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, Oct 13, 2021 at 04:21:37PM +0100, Mark Brown wrote:

> > I'll go ahead with my copy of this (partly as I've already got it
> > ready queued).

> That's what I expected, I just sent it that the base for patch 2 is
> properly available e.g. for the autobuilders. Did you modify your patch
> since you sent it? If you resend or apply to your tree I can rebase
> patch 2 on top of it.

It's rebased (actually the public post was rebased).  I'll let you know
if yours fails.

--noiCMqsGHJTG/Zf0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFnFckACgkQJNaLcl1U
h9AnUAf+KY+yVi/K9+3oN6pRIEzCuVGvCu0mVse8KrFYTnLFuT+3n6zAZtnU/8vL
fg/v00bniGAfzh4xDTZjl/Prx7Yl0GJO1rvWInbD3uQECeCLDyfwSBCuH1fD2ScC
eB2ERsBK6JtK+d7b+EcZWuFddrZHDE6spZh0FyV47BIlL0cMZMOv5K3bgoenZim8
3uYcf8h4k8ao3koeUM059JADmKQB0uLBgldHXWJPLB74tiqxXS1H9nJh6LIAU997
izHOLheaKzr7aVASrSpyL5GhgSN08+Ma1XNiYJ38FgmVYX/CSOqRc2BrMvQu+kie
bA/5TlOxHGcLutPUITSixBtHvqFSbA==
=P0RB
-----END PGP SIGNATURE-----

--noiCMqsGHJTG/Zf0--
