Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F8E42BF6B
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 14:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhJMMFn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 08:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhJMMFm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 08:05:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D505960EB4;
        Wed, 13 Oct 2021 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634126619;
        bh=v7eLYuPVrIreN7y6L8ibPd1Q5G9BQfM3auGSZXrUVl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNAbXXB1bFIpVsL8AzqIFeKky5c2jiq/w9yGskRXFLMz60WE2mmuaT6wNo4F9DHtA
         5PsJgRaSYKVAYAWMdQEuDAdpb5B6nnSiUrdN6jENBqYJXB7gYeg0uBmE5jBpZvYvXa
         OdiESeucActtmrdchGFdhCqmqvYWJNGE1N/OM7EsgEbk4j9G4oNgnHylbGuQFk43pq
         8qbTe0lzn+V546xQUHEFV5RKEF7eiWr2IUNs3XAsQyiJ8Ghzpa+gg5+gSzTxAH9oyS
         A5l84S1D9KiypfmYAxlpITJZVcnY1yO6bxdFnecHZR8MgizvVkOeht+iscXeTV9udU
         MUt9ld3td6qKQ==
Date:   Wed, 13 Oct 2021 13:03:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] spi: Make spi_replaced_transfers private
Message-ID: <YWbLGOUQlA0ahCE7@sirena.org.uk>
References: <20211013092711.2672557-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X3JcgWdDA5f0e4T8"
Content-Disposition: inline
In-Reply-To: <20211013092711.2672557-1-u.kleine-koenig@pengutronix.de>
X-Cookie: Where do you think you're going today?
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--X3JcgWdDA5f0e4T8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2021 at 11:27:11AM +0200, Uwe Kleine-K=F6nig wrote:

> There are no users of struct spi_replaced_transfers and the
> spi_replaced_release_t typedef apart from spi.c. So move their
> definition there to not clutter the public namespace.

There may be some out of tree users with the Pi stuff, this was added
due to some aggressive optimisation work which was going on there.

--X3JcgWdDA5f0e4T8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFmyxgACgkQJNaLcl1U
h9DuPQf9E2doQbtrEdsbg7WqJLVCSU3m0uvadcRFRK4tgRqFzcLZuMbKGZTYp6pv
o2pQ8vo4eKilUSJKX4yF3SBD1wV/K+oRvCds3CX6wFhXn9DvvbqtdybfyQ6krScs
htFu8iqxp9K+S/gWazv6SSxTnkAiquO4PWeA8luevtLnDMzVbqlZs+1Hy9Ys4Sx9
9zM1uKHlQ8HaSNHYZ219E4/n1+uoAjaUoezVQFSZRvy61k1pRKe0XkMzlXkGZgOC
c7BFaAQPQytnOTyfl6m14bBH9mnU7sMxggHAkewyymW2DaABBJzbVIfbMhnF7+kk
uRKCGNUUWMsiep2PHVILlBQrcPr5ng==
=ODT1
-----END PGP SIGNATURE-----

--X3JcgWdDA5f0e4T8--
