Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EE87A8900
	for <lists+linux-spi@lfdr.de>; Wed, 20 Sep 2023 17:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjITPyh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Sep 2023 11:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjITPyh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Sep 2023 11:54:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD1BCA
        for <linux-spi@vger.kernel.org>; Wed, 20 Sep 2023 08:54:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820D5C433CA;
        Wed, 20 Sep 2023 15:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695225271;
        bh=Un0FVDI+pR+zb834Z9EX7gYghzxvVrZStdbLa2Osbuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ys46WLJBGUnm/y7RAH9tLK6IpJC5KOCHm1tvYoV6rWypLiUX6gtwYL+/kRoD03t2X
         G3IyDR/q8lYQshWtf2gcClk2EgKeiEzZnOIHoy5HIqtYH8htf/k8gXutXxytxZOPwO
         qPevV3+UKU+i2zho1lohdpsqCnbvdm2ObKf8FKdrLgm37UAZQ0/5FbNgBpBRWAhru0
         taCY5RfN0e/52pNRjaIhFRws5dGDYo1fTW14hmyTD2OMS8oG9995hVuDucCj70sSgM
         H/MNKB6XoIgb1u8cAgxOWzKIIZCJFE2NU4DWPLwhok0+NdoKInS/84J+YhZRwkv/H2
         AR/YFUb6vFitg==
Date:   Wed, 20 Sep 2023 16:54:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
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
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>
Subject: Re: [PATCH 00/10] drm/i915/spi: spi access for discrete graphics
Message-ID: <1b93fffe-5aac-42f3-9bbe-a307758673cf@sirena.org.uk>
References: <20230910123949.1251964-1-alexander.usyskin@intel.com>
 <20230911094233.326fd936@xps-13>
 <CY5PR11MB63667FBB6AF5B4331419BDAAEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <0d60a78b-0305-4cb3-babe-4eefe5001b29@sirena.org.uk>
 <CY5PR11MB63667AB9958A23970B4B0D3EEDF1A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <20230912152102.0dfe7558@xps-13>
 <ee4a85be-aa87-4c40-916c-0a796688ad6f@sirena.org.uk>
 <CY5PR11MB6366427A8DD52D9B8B54F25DEDF9A@CY5PR11MB6366.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S5LRfe/7bXumGJ72"
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6366427A8DD52D9B8B54F25DEDF9A@CY5PR11MB6366.namprd11.prod.outlook.com>
X-Cookie: Even a hawk is an eagle among crows.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--S5LRfe/7bXumGJ72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 20, 2023 at 01:52:07PM +0000, Usyskin, Alexander wrote:

> I've tried to register spi controller with a spi-mem ops, but I can't find a way to connect to mtd subsystem.
> I took spi-intel as example, which connects to spi-nor but it relies on JDEC ID of flash to configure itself.

You should use the normal SPI device registration interfaces to register
whatever devices are connected to the SPI controller.  What in concrete
terms have you tried to do here and in what way did it not work?

> We have predefined set of operations unrelated to flash behind the controller.

This sounds like there's some sort of MFD rather than or as well as a
flash chip, or possibly multiple SPI devices?

--S5LRfe/7bXumGJ72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmULFa8ACgkQJNaLcl1U
h9Ajuwf9FgmMqJxORVwccT0TdWZIXUkQ+yPI1Nk3vA22gKIqtlEa6vj6YaVuGUTR
LLFmvUSM3R/t/chkXl4i1uZu3bj9Vz6Pdvbxs4PKsR60F1UnDaqVduo86pygsV/0
rDpApJLpQM6GjRUUcX1EtYinSfIKp0GquXFPiPQA/hk4+zxCqSLsvkHECeYVwLon
QSKRy++dCliGQnNOKtSWwNk5LBCe7izGHMvcvjXhgbUGKRyFNgMWBEt3NDEQSN5b
QIVDTUvwiii1Ld1k7RS/XW2JtsOOyur+D7zEp15aSpNLfFu/KDWtWyNfML0/RNDg
cwuyRhv2LYsvj4MPCQWsExVCT1sO5w==
=j5mK
-----END PGP SIGNATURE-----

--S5LRfe/7bXumGJ72--
