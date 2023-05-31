Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989FE717DE8
	for <lists+linux-spi@lfdr.de>; Wed, 31 May 2023 13:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjEaLVo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 May 2023 07:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEaLVo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 31 May 2023 07:21:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611D29F
        for <linux-spi@vger.kernel.org>; Wed, 31 May 2023 04:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9805639BB
        for <linux-spi@vger.kernel.org>; Wed, 31 May 2023 11:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5E1C433D2;
        Wed, 31 May 2023 11:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685532102;
        bh=jIig24LqBUXOw9BhBCAwXCBLMwCM4ifvBRMmw72UaOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nt0oSV0QDocpdyfvBKaPSHDr0zI+OhWu4OH33Ty5Dp9sz1EF4NkHqnEA6gvhHPe/o
         c7438JvOuKlLSZwgss1ki3wDl6YUwDNwa+WMmERT5sOwhAMS49XNEDALAQDgOfh29z
         DcINBzaWAKO0FLTV8eIgoc4rd8ApfGhPIpmpjZ67YeTrO4LK7vZc3Idvw8zWZnW9IB
         DCIKJ/aB/3kETuxW9XI28bxX6oXeD4c5tKT+ZuSgbHZWbnE8b9vzJ+6A67A7Ha46ov
         zHkvaRkVaxuDeR1+0U/GQTvJD2q75tg6LoRNqZjdFn3UJLlr9wIATLqqyKarVKBT8i
         dOvnQ0nVfQZOw==
Date:   Wed, 31 May 2023 12:21:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] spi: spi-imx: Use dev_err_probe for failed DMA
 channel requests
Message-ID: <d28247c1-2885-4510-a769-27d354f1cc53@sirena.org.uk>
References: <20230418083505.466198-1-alexander.stein@ew.tq-group.com>
 <3243730.44csPzL39Z@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8ZBUfBBgc7OsdhGG"
Content-Disposition: inline
In-Reply-To: <3243730.44csPzL39Z@steina-w>
X-Cookie: Will Rogers never met you.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--8ZBUfBBgc7OsdhGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 09:26:42AM +0200, Alexander Stein wrote:
> Hi,
>=20
> gentle ping.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--8ZBUfBBgc7OsdhGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR3LcAACgkQJNaLcl1U
h9B6/gf/YB8/K7Vwm3MAzfAieq2m7YlStGiCz+BIw/a/KU8wqFnjdX4O3Vh1TdGH
0ZDsfHOtfNW2GBdT0eBujriwiSqHcYFiG88ciDu0r8Q/okiPh0Uwu8TRz0Bg39zp
lEGuldlVlEeL8zRonCtG29FIjxkVS4nrQ8PGBG5KSKJATebTcSgEoZYXmzDTZhQc
b8aSpxd6WYjUd+JxK5DnrDIXieyVxTVsm2LKjVClK7n/36IO+TiaMipQtrdchJew
A3W/YaMN2fwHK0pCynqwyosrs+LoeiK805F3is3a+RFhYdlLjmaO2Avz+IIyj3CR
pJ0BzGzV+Oq3Twz/qD0KpGwqZbRziw==
=UVES
-----END PGP SIGNATURE-----

--8ZBUfBBgc7OsdhGG--
