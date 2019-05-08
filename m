Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9423B172B1
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 09:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfEHHjD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 03:39:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47096 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfEHHjD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 03:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6K1Rt+UqFHqJVjcVj5C1jBXFCflebrolwRwMUFbBsXg=; b=fF70EpON4ML3dgEb0p/H00HFw
        qp+/uy91WAo6EYwfr9MzqrAbzIyFOJlqL0ERYA+MArYJPcJ1AinleNnd8XxjKcvV4HNmXjwX4OnWL
        qjZtfAm8qbKSvfU7KgDWjiFtWI4uVI5yr5ufP0FcAC8+Suz1t4UZm30IlU6r2LUj5s5wU=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOHAL-0007LX-6f; Wed, 08 May 2019 07:39:01 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id E38CB44003B; Wed,  8 May 2019 08:03:41 +0100 (BST)
Date:   Wed, 8 May 2019 16:03:41 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Jochen Henneberg <jh@henneberg-systemdesign.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: New driver for CP2130 USB-to-SPI bridge
Message-ID: <20190508070341.GR14916@sirena.org.uk>
References: <1557144380-19935-1-git-send-email-jh@henneberg-systemdesign.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Y9mfvbaELdqM67d"
Content-Disposition: inline
In-Reply-To: <1557144380-19935-1-git-send-email-jh@henneberg-systemdesign.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/Y9mfvbaELdqM67d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2019 at 02:06:19PM +0200, Jochen Henneberg wrote:
> This is a new driver to support the Silicon Labs CP2130 USB-to-SPI
> bridge. There are some warning left from checkpatch.pl but I would
> consider those as false negatives as they will reduce code
> readability.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--/Y9mfvbaELdqM67d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSf00ACgkQJNaLcl1U
h9BgCQf+PasIs7LOTAj8HA942pt5b/s9I8C3Z5U1nJBuQZEcBvqzME4b4wDkCFJh
RA0KimJyONDttiox/9tsY2h8xBlJwDGsPOYry2x8EgGncoRT6pYX8L+FDDUiZ+h+
3uVN3yShL+7y9aP4yL4fyGZNoxAW4Wt3rLS0BtmLDc9Y3ZiVI8JFr/0CgYz/tUmW
jmUTFRRQsHCvg8m4bU5o5nnU/eL75R+6tx+xffhNp3nZo0oxae9RKJWs+P9MzJLy
8oXgvFc2bZXpy87aI6EAvTwuxrddwiZ22JlOYHZlTdWXF1QL5M1pO3NuWDGaiEH8
LvZbUdLpVQ18xu5lZ85EgDQszJ08mw==
=h0RQ
-----END PGP SIGNATURE-----

--/Y9mfvbaELdqM67d--
