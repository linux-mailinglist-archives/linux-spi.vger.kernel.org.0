Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D9B212672
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgGBOjM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 10:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgGBOjM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 2 Jul 2020 10:39:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 925D92065F;
        Thu,  2 Jul 2020 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593700752;
        bh=qh+QrqZ1UHNEbqazeXUIg0KX2EhsudHzr0KVBgTRLgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fiOI/5Dq62/t9KUduPh4pr90Red/TPP5UuvgNx5PBbB+g6KkgPO0vxLPKsY0ANkPG
         oAHXqxz5mBCSNYASAC30/UAUAjBTJuvh48x9tC3vBpXk8fXOxsIERDRpKE7UeUENky
         9Oar+nlPmNTI3zrVjIrYgvBYvWykTwGGl23Nho5Y=
Date:   Thu, 2 Jul 2020 15:39:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     nicolas.ferre@microchip.com
Cc:     linux-arm-kernel@lists.infradead.org, sre@kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: Change Maintainer for some at91 drivers
Message-ID: <20200702143909.GH4483@sirena.org.uk>
References: <20200702134224.3750-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BXr400anF0jyguTS"
Content-Disposition: inline
In-Reply-To: <20200702134224.3750-1-nicolas.ferre@microchip.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--BXr400anF0jyguTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2020 at 03:42:24PM +0200, nicolas.ferre@microchip.com wrote:

> I kept these entries together as it may generate conflicts if handled
> separately. I suggest that Mark take the chunk as maintainer of SPI and
> Audio sub-systems.
> Anyway, don't hesitate to tell me if I should handle this change
> differently or at another time during the development cycle.

That works for me (though I'd be a bit surprised if it generated
conflicts), Sebastian?

--BXr400anF0jyguTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl798Y0ACgkQJNaLcl1U
h9DNkgf8CXzfu1HBWQjLABvOUjJTv8R3dJZAz4XSEss7PxmXnFF0VwTpt7Xh3gLS
sp4hUskO70QgqH+f7CtFOPQ2i12u55qu6hHVyB6bEyYrl8xXRgg+oxt9iIrGmf3Q
gC9OJmWEJy4+ZaRL8x/QnDbQTbAv7B/yexPqll4qG5/RlbHj7nqrL4z8NSuuMmm/
atsaFx3fmY5kEfyjEBECMQ6fYXEbf+T0ySVWT4Y3eMEdMpAGOM3c7KvGNQpi07gw
lkRVCa9lO0PkmC94nzW60H2ocdgZdn+pXt4fYcPFl9ijCFJjXG1ijg7mE1YasQ0F
cRTKaVC87piSsTwYo/L2C6O1MlkKxw==
=7g5B
-----END PGP SIGNATURE-----

--BXr400anF0jyguTS--
