Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCDF5EDB89
	for <lists+linux-spi@lfdr.de>; Wed, 28 Sep 2022 13:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiI1LQB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Sep 2022 07:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiI1LPl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Sep 2022 07:15:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643339AFE9
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 04:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2DD1B82036
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 11:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AF7C4314B;
        Wed, 28 Sep 2022 11:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664363719;
        bh=3KddA+PjS64Tt/76Xdhjim5dDK+w5KsgxTjQlROMcLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SwvpPUqR6VLC7Xct8099BxvjiE61+PK6xv5/DO/05YNW3+TVkWa6ffB9IknNl1Zh+
         ZJ6zVlTKXdI9mg3gaV2zt00SdPEqZBClDzKMcuPTf3PTX6VMzHyPhZM4UYsDJddVt/
         M7sIAybTGSHHfbONfI8ZR4of62r3PB+6qJ42o5xr4/EuEaLqoIxKbGozcmbfUW8EVw
         2t+5XaVkX43+GrbwIhthladaYKlecbzeNy7O4udYa2WUhKGu1WqHw7NPkK+H8oP0dG
         5rc5rI8/66BK25HxFZa7TGMeWYfswZBz236G9lAt5DNcpbw7FJfCupBdJ1I6sEZ8TT
         6U2IS5TpbgqnQ==
Date:   Wed, 28 Sep 2022 12:15:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
Message-ID: <YzQsw8hiMTxdqZuu@sirena.org.uk>
References: <20220926142933.2299460-1-yangyingliang@huawei.com>
 <20220927034525.GA32253@wunner.de>
 <YzLct0v1ZRJVW2Gm@sirena.org.uk>
 <703c43ca-ab47-bfd9-da26-d435aaf236e5@huawei.com>
 <20220927133129.GA29821@wunner.de>
 <YzMsc1IM/73CMEeg@sirena.org.uk>
 <20220927201901.GB24652@wunner.de>
 <YzNbhPjn27cWHwyi@sirena.org.uk>
 <CAMuHMdWb8qeUGbr-zku4-zAM4Zj5MgCLJKR=Xg=Txe39kno8Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dMRElBJRhNNlxPEx"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWb8qeUGbr-zku4-zAM4Zj5MgCLJKR=Xg=Txe39kno8Og@mail.gmail.com>
X-Cookie: You look tired.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dMRElBJRhNNlxPEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 27, 2022 at 10:43:08PM +0200, Geert Uytterhoeven wrote:
> On Tue, Sep 27, 2022 at 10:24 PM Mark Brown <broonie@kernel.org> wrote:

> > Sure, but since the current wrappers use the legacy names this means
> > that we need new wrappers with more modern names hence there is
> > something to improve here.

> So what are the more modern names?

It's unfortunately not 100% clear, and our use of controller for the
generic thing gets in the way a bit.  There was some stuff from one of
the open source hardware groups recently that tried to propose new names
but I'm not immediately finding it.  "host" and "target" would probably
do the trick?

--dMRElBJRhNNlxPEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM0LMIACgkQJNaLcl1U
h9D6ugf+L0dEbcYOPJDwpTYytzgxT5or13V3tp14w5kn9E5uxrZEUDhhTXqNEnBu
qt8cjeagzdDfl8IFm/Ee0H+drYUKx6yFi4plp6eotWm5u3sOxvTfYY9lPJqpmiN7
gpeNXpmBmfjU005ychH/E0Fx20I0VH2GWVao2XwNPOQMpsbgxE3GfJ3XWgZIZdyg
SzYxMulCdBcrjollAIY0bH4rAxav8xnLCIcdFZif+h/X+V2uXLRqFa+92yDeDjsJ
/JX5zt+5/c8Xp6JURixHVVmR8LvgV8XTqTkyu5h3LyJZLE1OptBB9RRCwcMWKjGa
3pV7BNn4mZZJZMfSCfL/6Y5YdUkyJA==
=L3lO
-----END PGP SIGNATURE-----

--dMRElBJRhNNlxPEx--
