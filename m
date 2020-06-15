Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BB91F96A6
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 14:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgFOMf5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 08:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbgFOMf4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 08:35:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67AC6206D7;
        Mon, 15 Jun 2020 12:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592224555;
        bh=bK7xnMNO32LjNVdhxquamLIt4CNPuSKX3tUtMf1VOH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RnslLA8y44+qEBt1UcgQpOlAoS8fYlwkJBrQqPZn/CI6GGftG9buwdzrJbOJ5EnV6
         kkDadIVNUZkx2q1HkVr6dvQaX3OyUyGZDvUIKt5RJwzRE6jCYtR5dMfT2DDo7aHBSS
         Dc6jNSlFc5IMjIVoR/DDJkYX7gUPB8I8NlA3HNmk=
Date:   Mon, 15 Jun 2020 13:35:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 RFC 1/2] spi: introduce fallback to pio
Message-ID: <20200615123553.GP4447@sirena.org.uk>
References: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
 <1591880310-1813-2-git-send-email-yibin.gong@nxp.com>
 <20200611134042.GG4671@sirena.org.uk>
 <VE1PR04MB66383245FAD2AE33CFEA76F789810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612101357.GA5396@sirena.org.uk>
 <VE1PR04MB66384013797FE6B01943F2A889810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612141611.GI5396@sirena.org.uk>
 <VE1PR04MB6638B43E3AC83286946DABCD899F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zfao1/4IORAeFOVj"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6638B43E3AC83286946DABCD899F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Zfao1/4IORAeFOVj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2020 at 01:04:57PM +0000, Robin Gong wrote:
> On 2020/06/12 22:16 Mark Brown <broonie@kernel.org> wrote:=20
> > On Fri, Jun 12, 2020 at 01:48:41PM +0000, Robin Gong wrote:
> > > On 2020/06/12 18:14 Mark Brown <broonie@kernel.org> wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > No, I mean that the reason the DMA transfer fails may be something that
> > happens after we've started putting things on the bus - the bit about F=
IFOs is
> > just a random example of an error that could happen.

> Sorry Mark for that I can't get your point... The bus error such as data =
corrupt
> seems not the spi core's business since it can only be caught in spi cont=
roller
> driver or upper level such as mtd driver (spi-nor) which know what's the =
failure
> happen at spi bus HW level or what's the correct data/message. In other w=
ords,
> spi core can't detect such error by transfer_one().

If we see an error in transfer_one() it could be from anything, we've no
idea what happened on the bus - the controller may have got part way
through the transfer before failing.

> But despite of that case, do you think this patch is valid for transfer_o=
ne() failue
> in dma and fallback to pio?

No, not unless we know that nothing went out on the bus.

--Zfao1/4IORAeFOVj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7naygACgkQJNaLcl1U
h9AKiwf+K/TO3gWH9vQYkVSNuWGp+wzROetikqE2P9cbQxa+EuwVUJ5cU8EOCUJV
jUiCbGsdl41kpqm98zYU5CZy2M5hvulcfdFOi19uGDGXn8VGNRYELhUG39RvKxSM
w+toG6fA6tvkm2nDoiiKG3N9f7mH3DgLTRw5MX631cATsLhZ5jlZnxmZOx7RH1KG
t3Cz7VEz/t4IK+HgEhk+s2Tr0fwioHjAuFuaor6s1CFkkxeRQ95bTqIJy/nLC8ws
Y5B+i4ul0d3lL5HAx7kssr41wpo7Iy/gTaG8/EEecEtpXOt3bJjhOnwYYUJ4oD7t
oKFeiaZtcsy2T2uo9sH/54P9RFN2KQ==
=5gqF
-----END PGP SIGNATURE-----

--Zfao1/4IORAeFOVj--
