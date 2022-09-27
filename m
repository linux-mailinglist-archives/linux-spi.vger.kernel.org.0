Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0DC5ECE57
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 22:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiI0UWh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 16:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiI0UWg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 16:22:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F195C10F73C
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 13:22:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A75DB81D63
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 20:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDA3C433D6;
        Tue, 27 Sep 2022 20:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664310152;
        bh=yilu4sev3PUYECjXbIaZ42S/MoctSrFwtbMvugB0lls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Og51g5uhpwHvqoSSxj70orTyGfkgA+IP7grocoXF8UZrCR2ENp5et/7sg8zuDzOeG
         XEYJD6K7Doj94amQWiJ3TA/cUM36JrGiNcoln3mHa9u9iFUCmh/cv9wixtEI3PCr7r
         ikLf3uN3bnHlbgpKCR+xfp/qLGQG+gW7PZIhffC6OmQZTT7SAqqg9q8jthQ/y+GOIG
         +Ci9Np1bYZmLDRe9FKCpUTZbPBWHeYIAtQM9ThMePDEvT1PNL45OQbLK2f5m2Id51+
         tGbdXQ4IiFbfQSJQh0ouPkTVWNVrONgCAKD2jqjLpOin+GBL3AbzBSwPWUGjJaUBlm
         BE8AzpQ6H3fIQ==
Date:   Tue, 27 Sep 2022 21:22:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
Message-ID: <YzNbhPjn27cWHwyi@sirena.org.uk>
References: <20220926142933.2299460-1-yangyingliang@huawei.com>
 <20220927034525.GA32253@wunner.de>
 <YzLct0v1ZRJVW2Gm@sirena.org.uk>
 <703c43ca-ab47-bfd9-da26-d435aaf236e5@huawei.com>
 <20220927133129.GA29821@wunner.de>
 <YzMsc1IM/73CMEeg@sirena.org.uk>
 <20220927201901.GB24652@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I6ZwMwJl5JMGBCmd"
Content-Disposition: inline
In-Reply-To: <20220927201901.GB24652@wunner.de>
X-Cookie: Vote anarchist.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--I6ZwMwJl5JMGBCmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 27, 2022 at 10:19:01PM +0200, Lukas Wunner wrote:
> On Tue, Sep 27, 2022 at 06:01:39PM +0100, Mark Brown wrote:
> > On Tue, Sep 27, 2022 at 03:31:29PM +0200, Lukas Wunner wrote:
> > > On Tue, Sep 27, 2022 at 07:57:05PM +0800, Yang Yingliang wrote:

> > > > Do you mean to introduce two more proper wrappers to instead of
> > > > devm_spi_alloc_master/slave() ?

> > > Honestly I don't think there's room for (or a need for) improvement here.

> > The issue here is that we're trying to get rid of the master/slave
> > terminology.

> Converting drivers to use spi_controller everywhere in lieu of
> spi_master is fine, but drivers need to specify whether the
> spi_controller is a master or a slave and Geert's design is
> to specify that on allocation.  Which makes sense because
> that's the moment the spi_controller comes to life, there's
> no earlier moment where one could specify the type.

Sure, but since the current wrappers use the legacy names this means
that we need new wrappers with more modern names hence there is
something to improve here.

--I6ZwMwJl5JMGBCmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMzW4MACgkQJNaLcl1U
h9Cvdwf/YPQhcebzqC8Zs0LUtrENX943hVTgMTAT1jVe8sAeiNf2OlTGuy5Xvxwg
Fyc8aPYWP6xS5HpPlCXLK9KTHT062Dy0zfyaKq0xeILGK/1U83vRehWse4ARDeUf
Ui2orUUOEkP+FjVvDnRW1DGE88aiqM209FYvtQPmPY4txhxrj+DjAGTCPiU+bPiw
ajii9WCACTwC5KnJKZbpoh3bpOdmtsE+Iq2Oo6B2MHC5fJdwY8MzT0/00LwVJk4P
fLx0yaQ5ArHszpInvRyFyl8mB1klpc/DgLEj8Puu/BO1Vy/JKDYfc9fr4Q85ClEL
2DkTHtr2+bQua1UUoTi6inIa0E7hoA==
=oGyX
-----END PGP SIGNATURE-----

--I6ZwMwJl5JMGBCmd--
