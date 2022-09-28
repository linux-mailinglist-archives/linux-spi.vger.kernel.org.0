Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3915EE11E
	for <lists+linux-spi@lfdr.de>; Wed, 28 Sep 2022 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiI1P7t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Sep 2022 11:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiI1P7V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Sep 2022 11:59:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E101CE171A
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 08:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 24640CE1F06
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 15:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA53C433D6;
        Wed, 28 Sep 2022 15:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380739;
        bh=SXzcGD/X0fOC/5GN0R/6pjCJUEoE0IA8U9B4jvD77vI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+YBszqfMfxMDxjtzaf9CqMgkDe+zSqZyy/2PmwS8NEid+e0KcV53uuoTidsfzRRf
         9+Yqa/muxAqi9V58630n8bho/x9kKHSuoIxTDRseVgLN1jxkJBWXb3q9W+txAqNVLO
         n0XmrPJytG3Hv7k6B3ZyOmnuMnMJaiWVmVWdaLAI1ACAIj7l2MKSgl/5+eayAmz9j2
         OjgjUxqo0FysKltK5BesR7TVBpPSDOf9IbYL403Dz1E92aO2KjAIYk9LwrDdfjd705
         uAAaxbdObF3SbPmi8T44PbJTp/hOO6VY7CzMxR+igSl8LkMLA8N0uF3dnw/zO1quFn
         dBP44U6vZHyJA==
Date:   Wed, 28 Sep 2022 16:58:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
Message-ID: <YzRvP6KcQDMhfnJf@sirena.org.uk>
References: <20220927034525.GA32253@wunner.de>
 <YzLct0v1ZRJVW2Gm@sirena.org.uk>
 <703c43ca-ab47-bfd9-da26-d435aaf236e5@huawei.com>
 <20220927133129.GA29821@wunner.de>
 <YzMsc1IM/73CMEeg@sirena.org.uk>
 <20220927201901.GB24652@wunner.de>
 <YzNbhPjn27cWHwyi@sirena.org.uk>
 <CAMuHMdWb8qeUGbr-zku4-zAM4Zj5MgCLJKR=Xg=Txe39kno8Og@mail.gmail.com>
 <YzQsw8hiMTxdqZuu@sirena.org.uk>
 <20220928151116.GA13418@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pI0bSQoxMT/TvWFh"
Content-Disposition: inline
In-Reply-To: <20220928151116.GA13418@wunner.de>
X-Cookie: You look tired.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--pI0bSQoxMT/TvWFh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 28, 2022 at 05:11:16PM +0200, Lukas Wunner wrote:
> On Wed, Sep 28, 2022 at 12:15:15PM +0100, Mark Brown wrote:

> > It's unfortunately not 100% clear, and our use of controller for the
> > generic thing gets in the way a bit.  There was some stuff from one of
> > the open source hardware groups recently that tried to propose new names
> > but I'm not immediately finding it.  "host" and "target" would probably
> > do the trick?

> Perhaps you mean that one?

> https://www.oshwa.org/a-resolution-to-redefine-spi-signal-names/

> Looks like they're replacing master with controller and
> slave with peripheral.  Pity, we're using controller as
> an umbrella term for either one of them.

> Renaming that will lead to an awful lot of churn. :(

Ah, that's the one - I knew there was some reason I didn't do anything
with it when I saw it.  I'm not sure the churn would be worth it.

--pI0bSQoxMT/TvWFh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM0bz4ACgkQJNaLcl1U
h9CZfgf/VFSNPwlmM3fUqPA+OJ9KkB+9Log+Jzbv1tClcEgYGiKKDfea3RkMCpW+
OWmDsu2JhwJMxEkZ/vntz/UDJl2Se5xqxUD/qaTnIls5eAKDS1raSLX7AWpvnyx/
+ulvx9rVA9KO0KIMqWuAsnwZH2ctL2/u1MeKXJhgRDgCJIoqM3785MiUN2rGK4+g
5ReTyUGdAZhhU7NMa6C2VoCp5AuKHRtlGvGnrbF1fY2dFKns6GbaQb9nshGdJVLp
trQI6h+2AkO3SWrMGG53Oa7QpPLVcm/p7kVhheGMiTTiwgdm57ni2XqIAlBQdiP9
LH9czj6cl0iNMVNbvoX8lsKDchbVHw==
=8rmW
-----END PGP SIGNATURE-----

--pI0bSQoxMT/TvWFh--
