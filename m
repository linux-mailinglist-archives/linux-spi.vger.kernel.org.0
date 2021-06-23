Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F0A3B17A5
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jun 2021 12:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFWKEd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Jun 2021 06:04:33 -0400
Received: from www.zeus03.de ([194.117.254.33]:51982 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhFWKEd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Jun 2021 06:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Iof+5ukudeJ8nvqBtjFn6xtru8Vq
        gj9i+l+FNi+E998=; b=rHg43FtItaUE3c2Er7AVceT0h7RVMippz7zwNXSIDauu
        7qTZHInMPsLkztc5kzANzLfXm3OHCP5GUlPxCj84DKGnSS8oz00sS1TbccVctQ4p
        3U21+1tGhSMySPU3g9XDP7aPuXSIO4DDpk1qAV+VU/Ch1xZc8u1MdtTMmtew1N8=
Received: (qmail 2553404 invoked from network); 23 Jun 2021 12:02:14 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Jun 2021 12:02:14 +0200
X-UD-Smtp-Session: l3s3148p1@DHU5AGzFIKogARa4RfhaAavnjlTTqzSz
Date:   Wed, 23 Jun 2021 12:02:14 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 0/2] spi: use proper DMAENGINE API for termination
Message-ID: <YNMGpoYe/ZukgbTA@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20210623095843.3228-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5tBgKQb4BWhfIpR8"
Content-Disposition: inline
In-Reply-To: <20210623095843.3228-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5tBgKQb4BWhfIpR8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 23, 2021 at 11:58:41AM +0200, Wolfram Sang wrote:
> dmaengine_terminate_all() is deprecated in favor of explicitly saying if
> it should be sync or async. Update the drivers I audited.

I am very sorry to have sent the SPI and I2C patches to the MMC list as
well :(


--5tBgKQb4BWhfIpR8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmDTBqIACgkQFA3kzBSg
KbYIFQ//S/LPK7TnYp2F8J7ZrJsCwcrA4chCf5KNcprrPkuoqEjC82HxkrNy9/N5
PTFc9VB7lsLXEcijlI6mXY9NDgDL/LoEWVBBjXbFBMLKBjG8zmmXUlmrliLUd5u+
bCvcROWNrVGtiyLd9gysrh5WpdIhOUtozvUIwSrOSh6tJ7tyXDc33u2PdE22iupY
gn3vHHXfK1LRCVZy32naF9euxREy+TPMvvleKv9Fhu7r6+oSQgqKaS/rdHeZmszF
TvRxXNObm0IbmoO5zh3cBpJ8cRW/MzWjZHbyMqI6nvJ0QwOmzH8rTKTGwZ9zgX1n
V2A/MnHkIeyM3O7GMbA10gecUiTEavk7YGAnX4MVMEJmpbhQI5mCh9f4GUrtM8a4
U4lQFb8UbT7FPct3TtVmy8kEIvLb0VV42OpRMuwt6xq41McVM8aVWVY5G7qoNucd
gkJ4Z3d42hPlw7UBSx27zRDGKNul9l/DhNuNroueFX2345EKZDGILzpkwgfwLPde
qzYcxS1ihhNSvXqx1NLOOI2r+S4HzyBtEpGg4OX4Sp7mUbaFxLXfcpK0af3LjyZH
9gdpvOuVUY+TfWfvBbR66UcpjrBO2QvJT5xYTHuyd5oPRrM58FK0Yw3hXGvIgWIE
/7bMvjqOriFUMKKVC+YCoFgNaIKbcssyveK8DhJWlZIhBmMcRYI=
=bsfP
-----END PGP SIGNATURE-----

--5tBgKQb4BWhfIpR8--
