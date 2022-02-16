Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882824B8DFE
	for <lists+linux-spi@lfdr.de>; Wed, 16 Feb 2022 17:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiBPQ3J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Feb 2022 11:29:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiBPQ3I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Feb 2022 11:29:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7CF2AE71A
        for <linux-spi@vger.kernel.org>; Wed, 16 Feb 2022 08:28:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBBB161B3C
        for <linux-spi@vger.kernel.org>; Wed, 16 Feb 2022 16:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02126C004E1;
        Wed, 16 Feb 2022 16:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645028935;
        bh=7aw8KHoi72vmlWzUJUruEe6Fj6OtL4yDvPz9349QW2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFSOH+IPOh18cLuHmUQlTinUAX+n/J/95/BSCh7FRREZLeHzQr2A8h6qAcVSySR43
         4zfjley5EOy+qTRB/0tCiD/Dbe5H//EtJQwsrB9BN/00pK7QJz/X6xKnl65EYgSfdo
         iJd4XuJ/IaW6481lTUVq8fsoFCcatTKqhk16fXyNYr8wMY0qlNV4Bb5kwTrgv/jH4F
         UxR3j6+fKdY3vVyXVN1HJLX4f2/i3Nx9tQBVU9iDlO30y1a6NG+UNRDIlqNoqlkI6c
         EAEBXK7p8ODOPhunYsD05AhG567E90BETftf1e+9IzGDJZAdqMy+Zx7lWguhjTaqOy
         a1xZaPnXbBnbg==
Date:   Wed, 16 Feb 2022 16:28:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tudor.Ambarus@microchip.com
Cc:     mika.westerberg@linux.intel.com, lee.jones@linaro.org,
        p.yadav@ti.com, andriy.shevchenko@linux.intel.com,
        linux-mtd@lists.infradead.org, michael@walle.cc,
        mauro.lima@eclypsium.com, hans-gert.dahmen@immu.ne,
        boris.brezillon@collabora.com, miquel.raynal@bootlin.com,
        richard@nod.at, linux-spi@vger.kernel.org, vigneshr@ti.com,
        alexander.sverdlin@nokia.com, corbet@lwn.net
Subject: Re: [PATCH v6 0/3] mtd: spi-nor / spi / MFD: Convert intel-spi to
 SPI MEM
Message-ID: <Yg0mQF+oqmZlFi20@sirena.org.uk>
References: <20220209122706.42439-1-mika.westerberg@linux.intel.com>
 <164492969770.14011.5135767095761454169.b4-ty@kernel.org>
 <ec42e96a-0240-9cb8-2f27-746fbbeef56f@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="in6RCF0ZULD1Vaij"
Content-Disposition: inline
In-Reply-To: <ec42e96a-0240-9cb8-2f27-746fbbeef56f@microchip.com>
X-Cookie: Fremen add life to spice!
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--in6RCF0ZULD1Vaij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 15, 2022 at 01:46:13PM +0000, Tudor.Ambarus@microchip.com wrote:

> Have you synced with Lee Jones? I remember he asked for an immutable branch
> when the patch set will be applied. There's no need to sync with MTD.

I think I sent out a pull request?  Or perhaps I didn't if you
explicitly said you didn't want one.  I don't remember at this point.

--in6RCF0ZULD1Vaij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmINJkAACgkQJNaLcl1U
h9C/5Qf7B1f8A7MLmxH6RyENE59QGI8i9Bhv9F+aG0T19lqQJLEvXWirod6mlW7f
YU9lfvwc+ibzEAjK7uY7a+qgGHxRKxor9YqKIk9JuRoU6ZDdtQd785qx3U+Bpg4Y
SElhfmfoB4KIrT8VyJCoHO/bqMMNh3LZnFWNuzuNg23Ct74fY9WuPGLv7e5FXVgu
M0vaGvRxqGb7MTHJ9Fx/eJbV0TfbWEN61vB0ScTlgw31DQEKviDEkXnq36ddE0jS
akZIZ5l6RdCO//6Gp8RnfLxLHmAkww/DcHChL07Fb9TjFlsSIsv0J1egJdJTceO9
GxL2qjPZiXepUV1BFR6xsywWOt5U1Q==
=qpNT
-----END PGP SIGNATURE-----

--in6RCF0ZULD1Vaij--
