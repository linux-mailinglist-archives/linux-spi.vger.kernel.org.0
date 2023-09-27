Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56D7B0712
	for <lists+linux-spi@lfdr.de>; Wed, 27 Sep 2023 16:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjI0Ohk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Sep 2023 10:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjI0Ohj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Sep 2023 10:37:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2340F3
        for <linux-spi@vger.kernel.org>; Wed, 27 Sep 2023 07:37:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2F5C433C8;
        Wed, 27 Sep 2023 14:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695825458;
        bh=qWF+NqYelJaQpG877EqA8MHQS8RmOQ1ooBg3CABBt3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ASpyUfAFsBsIzxXjNqewgstlIRbwyJjkIJiEF7OUVKitEcngP9KaeVNwNY5gf5nhj
         tkX8wRjXneezmd7BiMz2YQDOXZ5j2YeQx/E9nkkcwPn3Z1TZWxbj6j/WVkBAhbWOwI
         VsutCdQHi4mbSjrfUxulmvA+/dIbycDiPqQ/sZgC/7qqq4SmfuWYs6wPQ9sLuHgUE1
         AR4tEZm75LEaETW0KTsvKg6ik2z4WX0vK1Lf90MC6SA59zbXee+yKe4F9affzCol9+
         n+4ZvVMMoTkpCMeERjAAzDKg62pIzRBlTzI/y0gTiRQzziqL2co+Ucw9+LfAR648qH
         gHH6z2zXcwWBg==
Date:   Wed, 27 Sep 2023 16:37:35 +0200
From:   Mark Brown <broonie@kernel.org>
To:     "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
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
Message-ID: <ZRQ+LzIoD+J0BzVp@finisterre.sirena.org.uk>
References: <CY5PR11MB63667FBB6AF5B4331419BDAAEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <0d60a78b-0305-4cb3-babe-4eefe5001b29@sirena.org.uk>
 <CY5PR11MB63667AB9958A23970B4B0D3EEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <20230912152102.0dfe7558@xps-13>
 <ee4a85be-aa87-4c40-916c-0a796688ad6f@sirena.org.uk>
 <CY5PR11MB6366427A8DD52D9B8B54F25DEDF9A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <1b93fffe-5aac-42f3-9bbe-a307758673cf@sirena.org.uk>
 <MN2PR11MB40938110726F81D8CE305FB8E5F9A@MN2PR11MB4093.namprd11.prod.outlook.com>
 <0682443d-5219-4aa2-a932-ee3e04c0760e@sirena.org.uk>
 <CY5PR11MB63661B36FFAE9455504DACD6EDC2A@CY5PR11MB6366.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="frZJ4uuKAPwyznhl"
Content-Disposition: inline
In-Reply-To: <CY5PR11MB63661B36FFAE9455504DACD6EDC2A@CY5PR11MB6366.namprd11.prod.outlook.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--frZJ4uuKAPwyznhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 02:11:47PM +0000, Usyskin, Alexander wrote:

> There is a Discreet Graphic device with embedded SPI (controller & flash).
> The embedded SPI is not visible to OS.
> There is another HW in the chip that gates access to the controller and
> exposes registers for:
> region select; read and write (4 and 8 bytes); erase (4K); error register=
;=20

So assuming that's flash region select it sounds like this is a MTD
controller and the fact that there's SPI isn't really relevant at all
=66rom a programming model point of view and it should probably be
described as a MTD controller of some kind.  Does that sound about
right?

--frZJ4uuKAPwyznhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUUPigACgkQJNaLcl1U
h9Dztwf/dI2/2yh2ohlcjPRhimWVWsphQDwpbvDH73EC98Z0A1pqnhMEQNvjGP1z
XD16vP3s84PqWGtNhBdn9NNcK0+smsWDEUwQE+16+MQFhuAHvGl24h2WwsmBZ+8l
NtOcREhYq4nNrg0dQ70xDkb6pCecfEN79R6719yk8ryVOMBGa6LmSr3nKlcGeKCa
POiJS/5kcGr2rgi+2suhkSH56OEUsLbKFjOncZN0NPKCmlnf/kieirZTG9XfajjH
W988zzdRAe++RpgHFYFz2pZqGQ648IaexM2Weje2WGYKPKJslmyYaEf+Ru1hV8sE
VyA1NsixeALMQhIttr1yaAB8xzCTig==
=KXto
-----END PGP SIGNATURE-----

--frZJ4uuKAPwyznhl--
