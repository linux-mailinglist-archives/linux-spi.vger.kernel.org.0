Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB09212633
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 16:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgGBOZQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 10:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgGBOZO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 2 Jul 2020 10:25:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFA69207D4;
        Thu,  2 Jul 2020 14:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593699914;
        bh=fIv6KhWcY90lOm99p6vzIc3gJje6cz5azcmmqihbq+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaBjXyMZ3wtwuRUCeQF3k6Eqq3eSkrkGF026aS7/UJIW7AIyzqSytmJqG1PvUtYT/
         7BToIt/ftzWEpoOSOG8Y9AowrK575DA3HjM5E6P1ny262dI3G23mLatnavSxgr8JlI
         wd8saNesWYnjsRp611TnZd7QGgLCvDzXHY9IDWdw=
Date:   Thu, 2 Jul 2020 15:25:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
Message-ID: <20200702142511.GF4483@sirena.org.uk>
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline
In-Reply-To: <20200702141846.7752-1-frieder.schrempf@kontron.de>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2020 at 04:18:46PM +0200, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> Allow external SPI ports on Kontron boards to use the spidev driver.

I'd have expected this to require loading a DT overlay for whatever's
attached?

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl797kcACgkQJNaLcl1U
h9BXDgf/YXWTeAKOyhNP9dNccDlETXMQ0jNpvL7iXYd9ZGM7BC0Mq2FCCif5cnal
l3DXEtr2Zuw/bCmU89LOdtxTJX4U4i+a0BKU6HahaXaBWp0Pw433pO6/Eo+hJzDW
bnx1O7zQ9cG/KJA+lK0FvwtHKzr9EDlcH395QF+q5QyoxlKZOT71TfqUiNhVIMEI
KndSn/RKct6WinNUUhKzUHbyJ/4I8MbZNOSARuZPF2XjLZAQw+csAFhnEWNRMrno
XYQc6Oh5AT+P52Yv6mQsqpTcWjPkkWyFxQY/K0FAqw16r1R5ZowvkI9TJN8QS5Ea
kbW2LWzmR8L9td0hoC3oOoGNaW6fgA==
=v0p5
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--
