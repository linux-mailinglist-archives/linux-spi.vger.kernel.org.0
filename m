Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C3D3FFF1B
	for <lists+linux-spi@lfdr.de>; Fri,  3 Sep 2021 13:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348763AbhICLZh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Sep 2021 07:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348457AbhICLZh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 3 Sep 2021 07:25:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37A966108E;
        Fri,  3 Sep 2021 11:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630668277;
        bh=FldLdOOii3TaES/s3G6Az9sltzzQVKuDfUEUq49AxMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBM4aePsqZz3pwEdpWsZFuxd8z9DgQ+mbZt7aBK42sXdVLBMNAh5ag5aycTxZ78FB
         uq156f9R+yW1OsEgNDl0a8nDrKRJQWVTnvos0K34299w2hifqP5dMh51w7Qzq/caue
         ZIWH7iZ7VdVBlESuoEt+YV4ilUueoWCGz254CfGRwNx8XVtFo/FJkghTYEPG5K6LYW
         MtddIYqn2kSs6G3dT5OWOpGbv2mCNS9R1M+4ok9TKhcnFfgGDMQXRL97OYI+Oquhpq
         I4vsYoRBR4+O/GYXrS5oCJDzmXK0rAf3Ixcl6vIg3mhf622wcuLjCCCb2toG6sklIj
         szhJfOaHgijIg==
Date:   Fri, 3 Sep 2021 12:24:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Parshuram Raju Thombare <pthombar@cadence.com>
Cc:     "lukas@wunner.de" <lukas@wunner.de>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: Re: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Message-ID: <20210903112403.GF4932@sirena.org.uk>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499858-20456-1-git-send-email-pthombar@cadence.com>
 <20210902143947.GC11164@sirena.org.uk>
 <CY4PR07MB27577F9A6DBF3F4985B014ACC1CF9@CY4PR07MB2757.namprd07.prod.outlook.com>
 <20210903101837.GA4932@sirena.org.uk>
 <CY4PR07MB27579742A452BC2E71D9A946C1CF9@CY4PR07MB2757.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline
In-Reply-To: <CY4PR07MB27579742A452BC2E71D9A946C1CF9@CY4PR07MB2757.namprd07.prod.outlook.com>
X-Cookie: Darth Vader sleeps with a Teddywookie.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 03, 2021 at 10:47:50AM +0000, Parshuram Raju Thombare wrote:

> Oh, ok.  That is done at power on reset by the controller in 2 ways.
> 1. Using device discovery module, controller try to auto detect the valid=
 protocol
>     mode by trying to read SFDP signature in various modes.
> 2. Particular protocol mode can be selected using bootstrap signals.

> I think mode_bits need to include protocol mode which is auto detected or
> set using bootstrap signals. I will make that change in next version.=20

Yes, that sounds better.  I guess at least in the case of autodetection
the mode can be overridden by software later, but that can always be
added later if someone actually needs the feature.

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEyBdMACgkQJNaLcl1U
h9DuYQgAgSZTn04sUnbkUr72r8XjZjqJ1gGhXu7jKUXv6eu9XulkgnAncKPgNvmQ
q8s7wmn6pG/TVNjw91m8DbjQm/FSrzCecyhAWS19kO/86ntl5Ugc2iHD19SXsIhd
UqIGaPRsKhTZLa7AtrSm61GkAKU4CbFXZNsFgoD/fsvS7JU4c7vzHhcNP8MJy8cW
5MxdC/qlbY2FapN+lNZfVmraTQeLWy8+XyDZ2LCZQKfNjQS1FWUwBJaH39KcDvsK
mgshERQiC+LNAlGfkF35V5QE4ooT57HO5052xbV9noySZoHcGTwCxteXi1wuGYku
PhKN5FMFmLCHDyXpqmxzzpQG1wHrwg==
=6PJJ
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--
