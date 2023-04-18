Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD27E6E64E1
	for <lists+linux-spi@lfdr.de>; Tue, 18 Apr 2023 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjDRMxX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Apr 2023 08:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjDRMxU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Apr 2023 08:53:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15F516F8D
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 05:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9095663440
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 12:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FE8C433A0;
        Tue, 18 Apr 2023 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681822381;
        bh=zRxpqzn78YA54iQsLrcw0c4B56S5uPHBZyUSwYzLdo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ffbrdyx1+wvLlXGCDskYu4cbR51kEf1PlZtrhQOPWxS+Xnrmn5RD8bT9uCKozML5k
         Tjif4ZeewMBUTM93Me31yCrgnusOIMytzRV1m1tyX+zLBx60+DF8pHVrV8hFh4KKTj
         xDYXb+pOklTQlp0KL2aVr2eEvaktBM+VS6GXq+uZKAQ4mMR49Pg2y3vVPlbo6geYi4
         D8oU2ShuOcDpw2LxzKtl94NqrAr57Mg2aUubim6W09Unaxw6AUsnB/grD2YaCMlo4y
         zY/YUGBJvOnl5YM/peFbnk7QMtLPe5p3lYZ+RJzZ8JttMYrjS6iDVlwy3F7CMAZFHr
         1MTgHDdujx9LA==
Date:   Tue, 18 Apr 2023 13:52:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Vaishnav Achath <vaishnav.a@ti.com>, Vignesh <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: cadence-quadspi: use macro SIMPLE_DEV_PM_OPS
Message-ID: <e65683c1-9f1b-4cfb-8e14-087ef7d69595@sirena.org.uk>
References: <20230417091027.966146-1-d-gole@ti.com>
 <20230417091027.966146-2-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Jpn4zXoXVD9eoGmq"
Content-Disposition: inline
In-Reply-To: <20230417091027.966146-2-d-gole@ti.com>
X-Cookie: Just to have it is enough.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Jpn4zXoXVD9eoGmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2023 at 02:40:26PM +0530, Dhruva Gole wrote:

> -static const struct dev_pm_ops cqspi__dev_pm_ops =3D {
> -	.suspend =3D cqspi_suspend,
> -	.resume =3D cqspi_resume,
> -};
> +static SIMPLE_DEV_PM_OPS(cqspi__dev_pm_ops, cqspi_suspend, cqspi_resume);
> =20
>  #define CQSPI_DEV_PM_OPS	(&cqspi__dev_pm_ops)
>  #else

These days you should use DEFINE_SIMPLE_DEV_PM_OPS() instead.

--Jpn4zXoXVD9eoGmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ+kqcACgkQJNaLcl1U
h9Aevwf/SNTlC+wg2l0qkwwYLIIVG/rC5ec/cRZWZ7tjPOvKoMaWsodeHPiyMeJG
rp7GvNh62DFGykGlchj48AVQkIu8YXrwjdIaK6cnlXtGZ6EQIwIYgCB3HzKP94GG
GwAl4b5lHou2sG/6rpv1UvN+vJ9fenBPix25bQmUdzsfn4YlLa6U+lPW0Y8mKyJ5
vilN7cyBeLwsOC1VsbZeUnNEJwZL0hzpLQwIYbnZuWHKlUIRarfZH9MYve9aSlVP
Qy4k0Yi1J723o+hGb5q808ddp2MNfMVjzv+YQZ3QLcfKmwk2h8b5PzC3fvqq+Ia+
2c2jdrJZL5Fm6E+QOMiOvMdAUuyL8g==
=/8O6
-----END PGP SIGNATURE-----

--Jpn4zXoXVD9eoGmq--
