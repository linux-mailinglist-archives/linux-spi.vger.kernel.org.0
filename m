Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2679379D27C
	for <lists+linux-spi@lfdr.de>; Tue, 12 Sep 2023 15:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjILNhG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Sep 2023 09:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjILNhG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Sep 2023 09:37:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578A910CE
        for <linux-spi@vger.kernel.org>; Tue, 12 Sep 2023 06:37:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046EDC433C7;
        Tue, 12 Sep 2023 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694525822;
        bh=wYJ8yKp7ajfNaJDIcAw7/RR8MBJtt232urChN4s3j4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INT9NgEkljBpOIgEmZBC7z4jC0vurEx2ZraXAr8zyISwMkv0cmbtSAW/6KTC9s8kM
         0HAs0wg1JQaHS0t40xhMmBBFHgHXnidlpMQNhM6shALUq98LkQ1ORt+iPZtHeH7bM8
         odwrpsuS3pqvJ8tAMDBeatrI4VVH7ks2qU1d+3R3bSEnW6hOJ/JPTZX6IiLN+LS+vE
         wYw1jEtTmcLaQLCvTyFvaYOSWSGB6ADoklo+O8gGvl1lBlAn+LGhXQJO848OZXEu9Z
         +XYcWB78Ns9yvfFH2FXD+mqB64LaJbkTU7aEIAKoGBK4tN5jrmo/BFTDdiQ8wip6u1
         JjyOex+qcxerg==
Date:   Tue, 12 Sep 2023 14:36:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 00/10] drm/i915/spi: spi access for discrete graphics
Message-ID: <ee4a85be-aa87-4c40-916c-0a796688ad6f@sirena.org.uk>
References: <20230910123949.1251964-1-alexander.usyskin@intel.com>
 <20230911094233.326fd936@xps-13>
 <CY5PR11MB63667FBB6AF5B4331419BDAAEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <0d60a78b-0305-4cb3-babe-4eefe5001b29@sirena.org.uk>
 <CY5PR11MB63667AB9958A23970B4B0D3EEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <20230912152102.0dfe7558@xps-13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+a3x98bDpQ9nV2FW"
Content-Disposition: inline
In-Reply-To: <20230912152102.0dfe7558@xps-13>
X-Cookie: Victory uber allies!
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+a3x98bDpQ9nV2FW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 03:21:02PM +0200, Miquel Raynal wrote:
> alexander.usyskin@intel.com wrote on Tue, 12 Sep 2023 13:15:58 +0000:

> > > No SPI controllers are directly visible to userspace, some SPI devices
> > > are selectively exposed but that needs to be explicitly requested and=
 is
> > > generally discouraged. =20

> > What are the options here? Explicitly request exception is the one.
> > Any other way to add access to flash memory connected in such way?

> Register a spi controller with at least spi-mem ops, as suggested
> previously, is the standard way I guess. If you're not willing to do
> so, it must be justified, I guess?

Right, we already have a way of describing flash chips so that should be
used to describe any flash chips.

--+a3x98bDpQ9nV2FW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUAaXIACgkQJNaLcl1U
h9CtlQf/ecZXfTuYSyrp160gqtjUDltFUZ1D+eyXQQzPBrVS5xcbfjG6vAY5AIDf
Mi9qaTxAr9RbQ4EGfFT8TmiYbehg11PgPWhbTRhyJKyUfFVcZ5ntLtlsRlG3PMzS
7xlh/V6Xd0pSkawDpw/ebglHJt2Wt4ubMDkFYd6c9LhAJdcNPsuD8uG8+YSn2+Ze
V0j0cOsj/5kBwn2dcRT3PMbuwQ4OW4cPXlzZ3QYfz4cXdVjkKVe+CArF+/27+lC9
GhYIqznR59b4BIA11gXAfW02slKJ6Ot8oKRdS65ugv1vjF+AtDPS3lBMdTcZ+NzI
kgjSYoJHFM4/OX1br5DKalrItZdLfw==
=lE4O
-----END PGP SIGNATURE-----

--+a3x98bDpQ9nV2FW--
