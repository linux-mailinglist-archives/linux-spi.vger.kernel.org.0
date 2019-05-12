Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCC11AD45
	for <lists+linux-spi@lfdr.de>; Sun, 12 May 2019 19:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfELRFr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 May 2019 13:05:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49464 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfELRFr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 May 2019 13:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ndywyr82/NFXN1lC+orQHknEu4sY+tlBor1wOLnwHSE=; b=Opwi9hM51BLy0cPkDfwO3cqSQ
        9nRzofIkcNCQfT+hrTfUv8FrTcrP+2t9/YRayPL9C5CxWkqF87Eq4uLN6LmvutKsUXNq/MiTQgzp9
        DR7LWfSifYzHzl7+qeL1P5R0BQJpvra4fXMJ5RWFfYbVK/mkELLD+MONxJ6qfYY786dVQ=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPruu-00044k-9y; Sun, 12 May 2019 17:05:40 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id BB886440059; Sun, 12 May 2019 09:54:09 +0100 (BST)
Date:   Sun, 12 May 2019 17:54:09 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Martin Sperl <kernel@martin.sperl.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Message-ID: <20190512085409.GM21483@sirena.org.uk>
References: <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
 <20190115192619.GG5522@sirena.org.uk>
 <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org>
 <20190115212539.GK5522@sirena.org.uk>
 <EA757B47-A264-4B4D-9E5F-16611ABA0278@martin.sperl.org>
 <20190118191202.GG6260@sirena.org.uk>
 <EE52ED32-CBB4-40D4-8615-CA814158C826@martin.sperl.org>
 <20190123175609.GG7503@sirena.org.uk>
 <CB6BCD42-60F9-493A-B05B-FC27C125E982@martin.sperl.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jB+02Y6wHc2pEa2x"
Content-Disposition: inline
In-Reply-To: <CB6BCD42-60F9-493A-B05B-FC27C125E982@martin.sperl.org>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--jB+02Y6wHc2pEa2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 09:47:08PM +0200, Martin Sperl wrote:

> While thinking about this again maybe an idea:
> What about implement a second spi_transfer_one implementation (together
> with a message pump implementation) that would handle things correctly.

> Any driver then can select the old (default) or new implementation and th=
us
> would allow the optimizations to take place only for verified working dri=
vers...

I'd rather avoid having yet another interface for drivers to use, people
already get confused trying to choose between the ones we already have.
It'd have to be something where the existing drivers got actively
converted and the old interface retired rather than something that hangs
around.

> What I would then also like to do for the new implementation is modify the
> API a bit - ideally I would like to:
> * Make spi_sync the primary interface which the message pump is also=20
>   using directly
> * move all the prepare stuff early into spi-sync, so that for example the
>   Preparing (including dma mapping) would get done in the calling thread
>   And only the prepared message would get submitted to the queue
>   - special processing would be needed for the spi-async case.

IIRC the mapping is deliberately done late in order to minimize the
amount of time we're consuming resources for the mapping, there were
some systems that had limited DMA channels.  However I don't know how
big a concern that is in this day and age with even relatively old
systems.  The idea of spi_async() having a separate path also makes me a
bit nervous as it's much less widely used so more likely to get broken
accidentially.

Otherwise pushing things out to the caller makes sense, it should have
no real impact in the majority of cases where the thread is just getting
used to idle the controller and the actual work is all happening in the
calling context anyway and if the pump is being used it means it's
spending more time actually pushing transfers out.

For the case where we do have the message pump going one thing it'd be
good to do is overlap more of the admin work around the messages with
other transfers - ideally we'd be able to kick off the next transfer
=66rom within the completion of a DMA.  I need to have a dig around and
figure out if I have any hardware that can actually support that, last
time I looked at this my main system needed to kick everything up to the
thread due to hardware requirements.

--jB+02Y6wHc2pEa2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX3zAACgkQJNaLcl1U
h9BPIQf+IXs6QkyGGEDlkcfJDDpZrmikAxecDDwRGwsR0dIdbhHaiZp+bNayRaaX
ygo+j+63kO8AJ6fOHI3tPyLlCPcktVWeIMIbI2BGiOa5+Y58ZuJd1zCODDVOElK1
YHmzWKZZaeYGsZ+3McBRBRjURVPVxKXkLYaVBOLskI4gS2t7qedUXQrwqX+75YIe
jRI53hs7tuL1Hlq31Fpy9wqibKjb6L41WkbL1c4eTpYEM5zR5umw//HJXheDW84r
94g7Q2+fvwaLt3fi7TXjJOMS6tRjQEupWfbxcd6bmySW65b5CNx/i3WaFs+26xbh
yqrApK5wdTIXj637t8vHGfE9WpxMnQ==
=22+6
-----END PGP SIGNATURE-----

--jB+02Y6wHc2pEa2x--
