Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C273AB40C
	for <lists+linux-spi@lfdr.de>; Thu, 17 Jun 2021 14:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhFQMxt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Jun 2021 08:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231757AbhFQMxs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Jun 2021 08:53:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91F3A611CA;
        Thu, 17 Jun 2021 12:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623934301;
        bh=H2fT8hqje6WTi+InK+PnuiNbOt43avFsdwJxXo3eyuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bg45Pa+iM+e7xwXtpdzjA5G2NjtdUmBWLW18iALSJZ1xGFEOTAFnjispa7sWoLPrX
         t+aMfkuA9wy/EFS02nQnCfbL3qaC9WXpFWb/UZ77OhzesHoj3B6AlVXDRS1J0DC8q0
         tpWUKozbdi+/aTfxfKP8e4p4mB12CSa3w9AaNzB+8531z4Iy92KwhoBsUHiUCkPD1j
         b56+b/QqOOh5tu9LNr1WCt4GfPd40KAPCy80acKO38HaZf/yA1L+KDq31PeVsr+AFz
         /pwYuj4YFtCY95WRUQfnL2apBoTV4DzMcLiAldBMX39BD/AhZgJfh1aQ4fj02p/3be
         4Y0gCSzMIhPdQ==
Date:   Thu, 17 Jun 2021 13:51:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 1/6] spi: add ancillary device support
Message-ID: <20210617125120.GA14944@sirena.org.uk>
References: <20210609151235.48964-1-sebastian.reichel@collabora.com>
 <20210609151235.48964-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20210609151235.48964-2-sebastian.reichel@collabora.com>
X-Cookie: So much food
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 09, 2021 at 05:12:30PM +0200, Sebastian Reichel wrote:
> Introduce support for ancillary devices, similar to existing
> implementation for I2C. This is useful for devices having
> multiple chip-selects, for example some microcontrollers
> provide a normal SPI interface and a flashing SPI interface.

This doesn't apply against current code, please check and resend.

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDLRUgACgkQJNaLcl1U
h9DvQQf+MQ61hJiWh+EZt/3wqJRsGgT5FbVj37Smy30cyY6i9zJq27svHsxvIpfH
iIlo9dwUND8pIewXnQYIcmwWnGeM6mCgywrtB6F+PweYhttSStv6c1/G/lA9Bicn
QOZr42ZTcKAlsufRTsuL/LItdAOpwGJhWe0z/QRNlzTgBvSjAA5ex+AxzgsFUpYB
6pQLgQA2LQXfNPgtfgh49EGMiUsh9RT1GbBw6yG8qFnymaff3wfkVWSaZHE8lRlc
JLRFO0C+Nb4uq09vWzhAz/IB9Fot278iFVMPj5f1L0JK8Z+JW/HI+hEW+a3u84DP
iBIyQrbP+ATCd5ll0OP5nAd9HniPzA==
=XVlv
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
