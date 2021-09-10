Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D3406DB9
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 16:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhIJOqc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 10:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233128AbhIJOqb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 Sep 2021 10:46:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD2C0611CB;
        Fri, 10 Sep 2021 14:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631285120;
        bh=Wc9uNNc6NEx+AyIpNzRW4FvMaS9VoFEvCpU39lxJ3k8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnsNUElUTF+UpCYjgy98q30nsuLIbW1Xy1xVeOC7KMnfERwaCWwni9PwBBp1aZ7sw
         QQ0XxaLxeVdFgvqyTWAirVIuw6RmgNwt5gHweFXLF0x0iIYtlZDXOtmFQwVDiwvSag
         lOMWC6GbCFm4BByfNwRu88vLw28T1GXZ9JNPlUU7jlgzVZG5FaXLjzhKFczskGjSZt
         EkkLZxP1Tx9RhB/m5xeZK7JyBpGxtIOrVhNZGEZynA3Pge+yL0qOrg6kMXoW3DcOJO
         mRn6d4rN5QxBRLil2rY5MWaQio4AEscCVdinFI+YYjxIRC+NLm4/kTmTWtbUE1mMP1
         Zi6Nqlyz1lSEw==
Date:   Fri, 10 Sep 2021 15:44:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 03/10] spi: Add flag for no TX after a RX in the same
 Chip Select
Message-ID: <20210910144442.GD4474@sirena.org.uk>
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
 <20210908113450.788452-4-tanureal@opensource.cirrus.com>
 <20210908123734.GF4112@sirena.org.uk>
 <7dc20785-95da-6599-49dc-8e5f805d6a14@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <7dc20785-95da-6599-49dc-8e5f805d6a14@opensource.cirrus.com>
X-Cookie: You are standing on my toes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 09, 2021 at 11:51:21AM +0100, Lucas tanure wrote:
> On 9/8/21 1:37 PM, Mark Brown wrote:
> > On Wed, Sep 08, 2021 at 12:34:44PM +0100, Lucas Tanure wrote:
> > > Some controllers can't write to the bus after a read without
> > > releasing the chip select, so add flag and a check in spi core

> > Nothing you've added ever reads this flag and I'm not sure what anything
> > would be able to constructively do with it so why add the flag?  I don't
> > understand what the use case is.

> __spi_validate checks this flag and makes sure the message can be received
> by the controller.
> __spi_validate can't fix the message, so it only rejects the message.

Given that this is hardware that can't possibly work how useful is that
validation?  It's a fairly unusual thing for devices to do in the first
place, only applies if using the native chip select (which your patch
doesn't check for) and I am not sure that this is a general enough
pattern in controllers to have generic support for.  I suspect that a
lot of controllers with similar restrictions will be even more limited
than this, for example only supporting one or two transfers with limits
on the data, so it's not clear to me how useful this capability would
be.

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE7b1oACgkQJNaLcl1U
h9DXGwf+NsQSSeNthNc4XvpJJN66EDXpfaBT1ScTmJnD8QVkQ+UvQljH7GTtifpI
Kf0BUk0eqjnfQGH71oS3r+FsaX6vtY6CJ33LjEunROl/wXvR4t799e7Ei/SOdTPe
zjAJsFtMob2hXToXGztubOvxIC4HnGUC7SrshUtO2dF4GG5ypAEsNBposfCbHcms
XtJaHpR4ULFC35BcSNNf4T4rEpXd71j+bqy5qX13uHc5xtK7BsyCvIY3Ys3HEaOJ
lHDHG9znRZAdQ3UcWDQV1rTVB/+2wpQwtlq+CvfrqCTpNnK2hbVN81gOW8fFx9jq
tZbGgYIJ8sCUHDR3FmF9I6Jli+/c2g==
=0dk3
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
