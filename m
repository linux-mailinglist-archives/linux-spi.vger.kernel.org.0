Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64539184648
	for <lists+linux-spi@lfdr.de>; Fri, 13 Mar 2020 12:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgCMLye (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Mar 2020 07:54:34 -0400
Received: from foss.arm.com ([217.140.110.172]:53532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgCMLyd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Mar 2020 07:54:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 681EAFEC;
        Fri, 13 Mar 2020 04:54:33 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1B943F534;
        Fri, 13 Mar 2020 04:54:32 -0700 (PDT)
Date:   Fri, 13 Mar 2020 11:54:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ashish Kumar <ashish.kumar@nxp.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>, Han Xu <han.xu@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] spi: spi-nxp-fspi: Fix a NULL vs IS_ERR()
 check in probe
Message-ID: <20200313115431.GB5528@sirena.org.uk>
References: <20200312113154.GC20562@mwanda>
 <CAOMZO5CJ7G7yJZEEPfsm1P2SnrJ7kmOPmZCWiKwrvDZjPNOnWw@mail.gmail.com>
 <20200312121816.GC4038@sirena.org.uk>
 <VI1PR04MB4015D509DC78B0C7EA649CC995FA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4015D509DC78B0C7EA649CC995FA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
X-Cookie: This page intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 13, 2020 at 04:16:44AM +0000, Ashish Kumar wrote:

> This patch needs to drop, until further debugged, since flexspi is
> shared ip it is not having desired result on few boards, but it is
> needed for i.mx series, This is one of the comments from han xu. I
> believe further modifications will be needed, if not commit msg and
> other things can be update.

Please send a patch doing the revert with a changelog explaining why
it's needed.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5rdHYACgkQJNaLcl1U
h9DFCQf/UPqYCaPsBLcZEOTW72elTQpFxi4KP6BJ+mTkTETBkeHVQOP/U3FWwdDM
THoABWIEq+t24rOwkNaro3dl6b85fkI513FBNy1vqqRA/VrjpkCRTgHAAKD/D7+g
HQp3R/3GX5FkGJYNnmoOOQodhmR9UxklAfUASOtpiTS6wpzQw9puswv/eQO9Yumg
526+cxrq0hePl72ZsmZlV9EkxMCkuW7X01JTLwmmC0EaFHp0E8LMU/hvAPxO9RCZ
I9uT4S8tjPzEUZiwCm7sryHvnZePMK/8/BOv+IiZeQDXqwiW0JW6GGLK56MWH4SQ
AwPhEnuNRd+LD/dUU6vWSvmAgMJ66A==
=AmBc
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
