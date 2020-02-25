Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A903916EA98
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2020 16:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgBYPx5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Feb 2020 10:53:57 -0500
Received: from foss.arm.com ([217.140.110.172]:52506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730309AbgBYPx5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Feb 2020 10:53:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B96681FB;
        Tue, 25 Feb 2020 07:53:56 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DF223F703;
        Tue, 25 Feb 2020 07:53:56 -0800 (PST)
Date:   Tue, 25 Feb 2020 15:53:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Herbrechtsmeier Dr.-Ing. , Stefan" 
        <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: Execute spi transfers inside FIQ (NMI) or panic
Message-ID: <20200225155354.GF4633@sirena.org.uk>
References: <b22800b8-9c03-63a5-7ade-d8b63c562580@weidmueller.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Content-Disposition: inline
In-Reply-To: <b22800b8-9c03-63a5-7ade-d8b63c562580@weidmueller.com>
X-Cookie: Booths for two or more.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2020 at 02:27:27PM +0100, Herbrechtsmeier Dr.-Ing. , Stefan wrote:

> would it be acceptable to add an additional function to the struct
> spi_controller which handle a transfer inside a NMI context or a panic? The
> new function will transfer data via register polling without any lock.

That would need to happen as part of a wider change that made it
possible to use such an interface safely and did so, off the top of my
head it's not immediately obvious how one would do that.  You'd need to
get the hardware into a sensible state and then do whatever needs doing
with some cooperation from the client driver in all this which is a bit
of an ask.  It's not a trivial bit of work, but I do see the use case
and it's absolutely valid.

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5VQxEACgkQJNaLcl1U
h9BInAf/QelYi6vedS0fjXl7PL92uXstsOeFOuEGEl/vYzP803jTtV9R0y9+kmoX
eeKw19ZFzYETL46DA/qGVExWzl4QX2Gx/fE47+v6Fg0G+Cp9hvWztHmXzP+hGAWF
fPYSkkHON5jwV7vk0kw0WsPJs5dhtghRVWtHv2IY2VoA6582rPJzJ/y1ZLcMrFDv
JDQJ1hF/vDDZ5SLp5/9VLhVOypzC67KeVYqA/FLlM842afPApvG6K++dPHEosRzg
L+BzEPP7xSBh3zTNbJghvwSwiHFYFvNTadJ85pFcBLi+nsPebkpmPhzuH3UBkOfp
H4TNpg+SjABi7ZtHh2MBiBnO2kGj0w==
=Er1+
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
