Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAEF403A05
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 14:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243535AbhIHMj2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 08:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351767AbhIHMjT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Sep 2021 08:39:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3F4661155;
        Wed,  8 Sep 2021 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631104691;
        bh=HKHLhO5DiFefsqPRea4B33ydG4yRpWbGcqAZx8DdXWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lyv4qUrXLCQpsimKFyd1TDSY9J+Wa5o10PbRnS+YvkgUWwWmKzdArrPnHrVdu72Dl
         36vvOLYz5M5Lcmr2jotP4r4HuBYRSl83ydTK+1S6X3Ay6QVJYCZezcLxGt/pN015VK
         1O201zSXdUrydzbb24kYaWrAjSIeWzzqhMdNgfMJoAQ33SXanylHMyrJMS3TIjZ1pi
         BRELMK6//aPmCZivp3oShQyHnN1mdSU6HEgy5lkRYYlVEhYU5+IGWr824VbLCnH5oT
         HVBGzRi459iP/sEQxvsrByTmnMtMUYEU0/cRf88GpXqZBt4cfGGe4OG5Iaug2iZEVV
         zCJEHSiggbLwg==
Date:   Wed, 8 Sep 2021 13:37:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 03/10] spi: Add flag for no TX after a RX in the same
 Chip Select
Message-ID: <20210908123734.GF4112@sirena.org.uk>
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
 <20210908113450.788452-4-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <20210908113450.788452-4-tanureal@opensource.cirrus.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 08, 2021 at 12:34:44PM +0100, Lucas Tanure wrote:
> Some controllers can't write to the bus after a read without
> releasing the chip select, so add flag and a check in spi core

Nothing you've added ever reads this flag and I'm not sure what anything
would be able to constructively do with it so why add the flag?  I don't
understand what the use case is.

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE4ro0ACgkQJNaLcl1U
h9DOvQf/clMHHKqPoQr5y7MSb07txZsOnUjbvRf5oUZMsxb6Q3P2g3/fAz4thzpE
L2w+B9OD3BMO4gW63I1iUI2GmN4gF0EpDv2zSPeGy28FHkTP/Ygo/lQFUxbVVlhw
ep0pN/syPsQ9DoHGIxxv90usLPhq0bFxsSvG6IzFOjPT9NzO8PsyWi4PLHs6+Dw0
ktPSzH3mICPDui45wRw/jWxpLOJu+DU4UGiD+G7tXOcSl2D1MOZ3OFmKen3yAEw9
rIgC6AzUbtQPi5aH1ccCnnIt3k4H2KDLyXdTHsV+I71z/3vGZKGr9jab2z644Dkj
nno3DG+ygyAgIHEUcMs8nYCYoc8r4Q==
=Bkgx
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
