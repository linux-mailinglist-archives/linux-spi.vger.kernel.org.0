Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133D05EE137
	for <lists+linux-spi@lfdr.de>; Wed, 28 Sep 2022 18:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiI1QJJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Sep 2022 12:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiI1QJG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Sep 2022 12:09:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E181EA3D37
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 09:09:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B274B8201E
        for <linux-spi@vger.kernel.org>; Wed, 28 Sep 2022 16:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECC1C433C1;
        Wed, 28 Sep 2022 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664381343;
        bh=3bb28MU+X5mTkUGkFVgN5Yr5NvrkkLJf3/9OcpCBIOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gbjNFoWAu9Qx8DhTeWuU2i8qz1tM781o6oRrD83iQVQD2EZQChDxXAitddL7AaWGq
         FvqTHcvKGWFrKECvhQDyGtTdjI1NrP+mYrT09INZFMf59h9/ZnrXUwq7T2MP3mN1Ns
         qDBcOOGGfNzlfi52Yq91JYMLr+yWLOYCXTuz2w7xsfYctrmCkzFd+DSdF0h+IgEnf3
         momet6bOMDCYQhhCzDj/nmoH6xP6inr9T8KPmHqcTw2kpW6sfU/t5uqqpIE8EG+eY1
         zPEPsVaxDAVrGmEuSpeknHnpCn2gvL87sbHTSDrgTGOfeRFwe8ItplJk5+nOVq9PtG
         hpMDmD043t9QQ==
Date:   Wed, 28 Sep 2022 17:08:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lukas Wunner <lukas@wunner.de>, linux-spi@vger.kernel.org
Subject: Re: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
Message-ID: <YzRxl+dZPhklC/08@sirena.org.uk>
References: <20220927034525.GA32253@wunner.de>
 <YzLct0v1ZRJVW2Gm@sirena.org.uk>
 <703c43ca-ab47-bfd9-da26-d435aaf236e5@huawei.com>
 <20220927133129.GA29821@wunner.de>
 <YzMsc1IM/73CMEeg@sirena.org.uk>
 <20220927201901.GB24652@wunner.de>
 <YzNbhPjn27cWHwyi@sirena.org.uk>
 <CAMuHMdWb8qeUGbr-zku4-zAM4Zj5MgCLJKR=Xg=Txe39kno8Og@mail.gmail.com>
 <YzQsw8hiMTxdqZuu@sirena.org.uk>
 <bc97b9e1-fbd1-be29-beb4-e7a1e4037f3f@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gj2Zit2ThYVgOVR0"
Content-Disposition: inline
In-Reply-To: <bc97b9e1-fbd1-be29-beb4-e7a1e4037f3f@huawei.com>
X-Cookie: You look tired.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--gj2Zit2ThYVgOVR0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 28, 2022 at 11:01:00PM +0800, Yang Yingliang wrote:
> On 2022/9/28 19:15, Mark Brown wrote:

> > It's unfortunately not 100% clear, and our use of controller for the
> > generic thing gets in the way a bit.  There was some stuff from one of
> > the open source hardware groups recently that tried to propose new names
> > but I'm not immediately finding it.  "host" and "target" would probably
> > do the trick?

> So shall we use host/target to do wrappers.

Yes, let's try that and see how it looks.

--gj2Zit2ThYVgOVR0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM0cZcACgkQJNaLcl1U
h9BMfwf/UVdQUZnKxo5ZIHTK1GMf2STxWCuFpzq+qbXWKdE6he8O3s1xQS3bhUpK
BTs3bRaqRqWZXc1zGiulzOW9kUIHpDaXIYvxng8IEWKXvi/jp0NxuonD1alXsqYu
8lwN4tTs+VurQ6sGKhL+GHFFPhmvLPk8d0kBTEvGI8V1pATvk5uzmPEwD/686Pke
X8vPLWs+OYnokxpoqGvGKSHZP5y+pZpOqmXb35FcFftGEe9lF7kq3/4pAg1BlSQn
dDBeU1FsQ7KQ5otGhdxPf0OI4GF2Lg0z6YY0C94bbjnIsyk/l9ElFIUA44XgC8q2
tqPBt+PsNlULjL+Xm4PWuBsG5nVSlA==
=E5uB
-----END PGP SIGNATURE-----

--gj2Zit2ThYVgOVR0--
