Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C3C1174F4
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 19:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfLIS4L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 13:56:11 -0500
Received: from foss.arm.com ([217.140.110.172]:42086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfLIS4L (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 13:56:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22EB2328;
        Mon,  9 Dec 2019 10:56:11 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 978AF3F6CF;
        Mon,  9 Dec 2019 10:56:10 -0800 (PST)
Date:   Mon, 9 Dec 2019 18:56:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jean Pihet <jean.pihet@newoldbits.com>
Cc:     Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
Subject: Re: [PATCH 3/3] TI QSPI: optimize transfers for dual and quad read
Message-ID: <20191209185608.GJ5483@sirena.org.uk>
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-4-jean.pihet@newoldbits.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bWEb1MG/o7IKOlQF"
Content-Disposition: inline
In-Reply-To: <20191206160007.331801-4-jean.pihet@newoldbits.com>
X-Cookie: We read to say that we have read.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bWEb1MG/o7IKOlQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 05:00:07PM +0100, Jean Pihet wrote:
> By reading the 32 bits data register and copy the contents to the
> receive buffer, according to the single/dual/quad read mode and
> the data length to read.
>=20
> The speed improvement is 3.5x using quad read.
> ---

This is missing a Signed-off-by.

--bWEb1MG/o7IKOlQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3umMgACgkQJNaLcl1U
h9BbEQf9Fhh9PxSZGuuWSlzSAD2UMtGAHXmKzu4y97D8+j0BatW+Jtv3+POJEJEo
pi4PdUl6XkeWkyuXn2KXIHTjY1p0KehlQvZt0xstoULsTR7n3BDixww7jxzXqz6b
BR9+KW2oKmnaocXiL+82ZzIwMBOtyfvrUHVOA/nw8yws052Szymi3Z8L4VaNrINz
qYIpBKKfNfVZKWwZDS7hl2I5S//u8ROBZXUEit09/PmifVVj+7PbW3wUG0uD4zKB
sMOTgZzIuoWUH5D7ljar2BptN+cFbcUf0KimL0VkRaymsgf/lGs2gIShk+k1CPKP
6LchNzvwhrRXLOFI78fNaaXAbXBU7g==
=JM62
-----END PGP SIGNATURE-----

--bWEb1MG/o7IKOlQF--
