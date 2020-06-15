Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBB11F954C
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 13:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgFOL0z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 07:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgFOL0y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 07:26:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E56320663;
        Mon, 15 Jun 2020 11:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592220413;
        bh=AlmSpOqWFZ3eVUddo28omMXWg5/pX1RtU4kaDdyET7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCqYlNq36hQrO/FMlpkCvgwlh5vXvjqZmEbE+RmhD4GDkiacwgI6qnxCNO+ChR0yD
         8y9gNq2ola39ObDpUAzuvs1E/xeV3XjBje5IB5bHBO2mOYvXQPJZ9Ovlc+0s5cI9NQ
         lRrCF3mSJxnx74/2uzMOLmVQioCHQPAPK6vut+lk=
Date:   Mon, 15 Jun 2020 12:26:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] spi: bcm63xx: add BMIPS support
Message-ID: <20200615112651.GD4447@sirena.org.uk>
References: <20200615080309.2897694-1-noltari@gmail.com>
 <20200615090943.2936839-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <20200615090943.2936839-1-noltari@gmail.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 11:09:39AM +0200, =C1lvaro Fern=E1ndez Rojas wrote:
> BCM63xx SPI and HSSPI controller are present on several BMIPS SoCs (BCM63=
18,
> BCM6328, BCM6358, BCM6362, BCM6368 and BCM63268).

Please don't send new versions of patches in reply to old ones, it makes
it hard to keep track of what's going on and can bury things back in a
mailbox.

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7nWvoACgkQJNaLcl1U
h9DEdgf/WbsEopffAeHd8Ul9GNjtjCukqiVk2fBTROY4nGzZkGXiw2hSGXwOWTFL
7ZIYDNMkuLm+VnGjGIYFD9j1b53xYWzG4kC+DrPUzHKAwP2vbsWkG58s9Ey4olxn
e7bKMD9bpVxmHfQ+/3qwlWeqru+h4qk9s6CwIABjck8TyhjSgEIG4Vz9O/ciECvP
oFaZ2rH8wiB4K/B+V67gaTcRVG/dw2ZOzIQTZR9e4lX267ICY+vgy/B+x68XdxsX
vJPd6Kj0OJxtYkv5LObTkn7omVdFOtYUEVjMeENapQ/fQGJX6HEBjV1KyoxE0Vj2
F2CcPwiKa2XIJ7gAgzfo/V5zzJI5NQ==
=KHrG
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
