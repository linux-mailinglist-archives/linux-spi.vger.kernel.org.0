Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFD45538CE
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 19:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbiFURV7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 13:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiFURV7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 13:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153EB2CDDA
        for <linux-spi@vger.kernel.org>; Tue, 21 Jun 2022 10:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7431615C1
        for <linux-spi@vger.kernel.org>; Tue, 21 Jun 2022 17:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C17CC3411C;
        Tue, 21 Jun 2022 17:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655832117;
        bh=8/Z94xLNTAXq2QJxZzqQeshJjANBZWHqzkX7FOCs6YQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gU4iqGt2XuzphOTnm15lAQVbozhVYrZKrLjJ/TMT24q6OUm0ifM5gAP2Qpt3TWtMM
         2r0dhriPZxM4QtLzOIO5q1xJB8iOX3pfranHoT2RlvlUj7/FKZNQN5k+PXNiSsiZBB
         CPyLGBwEuq6ihus7N6sQgjrswFvZu25oSzj+H20okK3sj4sAoKMaUzfb1mGs1whX90
         aDOJulVlSbOvJi1E8NXNbb8E8nNk2Y/f387AfIZ55O5gPeEn/qk2GjTlsKtdmDF5RB
         AII2jbpIImPzTeuj+3uHScnW8+Lrb7P5LfBTBvAH8v1C3Aa6VojWXrg5P+FYan8WGM
         oGq12WScox33g==
Date:   Tue, 21 Jun 2022 18:21:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 00/11] Optimize spi_sync path
Message-ID: <YrH+MJDJJ4x/CYIQ@sirena.org.uk>
References: <20220621061234.3626638-1-david@protonic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gs5xcBZoWaL7RpDu"
Content-Disposition: inline
In-Reply-To: <20220621061234.3626638-1-david@protonic.nl>
X-Cookie: Edited for television.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--gs5xcBZoWaL7RpDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 21, 2022 at 08:12:23AM +0200, David Jander wrote:
> These patches optimize the spi_sync call for the common case that the
> worker thread is idle and the queue is empty. It also opens the
> possibility to potentially further optimize the async path also, since
> it doesn't need to take into account the direct sync path anymore.

I've pushed this on a branch for testing in KernelCI at

	https://linux.kernelci.org/test/job/broonie-misc/branch/for-kernelci/kernel/v5.19-rc1-50-g71b086bc92064/

It's still running, while it's not going to get great coverage of SPI
it'll get some just through initialising things a boot (and a few
ethernet controllers IIRC which do get heavily used) and it will cover a
wide variety of hardware which is pretty useful even if the coverage is
only light.

--gs5xcBZoWaL7RpDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKx/jAACgkQJNaLcl1U
h9APaAf+IqDXWcsus5b/oufliGoXlFou2xB1EYNAYtDuzyHJaGJjdoT5z39wiL9p
uJQzusiVvGWIfbuJ9qj9Y4z8NnL7pYlt4SzUtvIXydkoGh+hLTU8xwmKJL8BFZy3
E99yNfMjm3OpAa9cRPhb+uElNPi++re6TE7+DUGIlXKlEWVs4tm8D9E0WDGxPugS
5sYsU+l0+/EXgal9Jb0i4GBvGn7ZODcCWQ5cxffslUW2DufSsJyD4WH46rg+H7YV
inoSH+8LPY60oHuuviavMtrRbMjsILClTor2DajcTT/BavneVd55djur83RTrjJ9
QBCAnKWNy5Jm1YiLHSbQISmIXTrZig==
=wVmx
-----END PGP SIGNATURE-----

--gs5xcBZoWaL7RpDu--
