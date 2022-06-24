Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69D55A2A2
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jun 2022 22:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiFXUb0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Jun 2022 16:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFXUb0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Jun 2022 16:31:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C74A6F791
        for <linux-spi@vger.kernel.org>; Fri, 24 Jun 2022 13:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26E76B82994
        for <linux-spi@vger.kernel.org>; Fri, 24 Jun 2022 20:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DC5C34114;
        Fri, 24 Jun 2022 20:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656102682;
        bh=Kitz44+gTdhs7R91m5ZLvZ4b0SokkRRbiM5SW/OhZwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OINcwm6U8Jdkr/gffBvsyYBvchWQXStn2OGOVH03aqNxcFu+IQjxvRm3z/vuXQJye
         1LLGwFzJ6iBMUi+GIAYdOm1BMk1Js3d7JBE7ZM7eNnbmAnOxJRpfDJo/5W3hoOxqNq
         gKJO78Oq4R7sDHREeEOYy7tgdezWealFwWC4Xld0+sA2M4viJgRI3fwYrNedUXuppA
         HK+AHbKq3KNMBfGFX49bjXNn5jJxnSEs2XkUv3waOPr+DJrvBk8O5zlhnOPhRe/zjR
         Fhr6KsQsRcLwyV66a0Hkg+QXsr7ua0g37twsLyRedqYwqUVAhp+SX4BgbGHntbkdrO
         VzfAS2VK5UqaQ==
Date:   Fri, 24 Jun 2022 21:31:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 00/11] Optimize spi_sync path
Message-ID: <YrYfFiiYuvazKBtu@sirena.org.uk>
References: <20220621061234.3626638-1-david@protonic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nxV27VCFTPOJRpj5"
Content-Disposition: inline
In-Reply-To: <20220621061234.3626638-1-david@protonic.nl>
X-Cookie: Love America -- or give it back.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--nxV27VCFTPOJRpj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 21, 2022 at 08:12:23AM +0200, David Jander wrote:
> These patches optimize the spi_sync call for the common case that the
> worker thread is idle and the queue is empty. It also opens the
> possibility to potentially further optimize the async path also, since
> it doesn't need to take into account the direct sync path anymore.
>=20
> As an example for the performance gain, on an i.MX8MM SoC with a SPI CAN
> controller attached (MCP2518FD), the time the interrupt line stays
> active (which corresponds roughly with the time it takes to send 3
> relatively short consecutive spi_sync messages) is reduced from 98us to
> only 72us by this patch.

This seems to be testing fine so far so I'm thinking it's probably a
good idea to get it into -next which will hopefully trigger wider
testing, unless someone shouts I'll look into that early next week.  The
only feedback I've seen was Andy's review which is broadly stylistic so
can safely be addressed incrementally (like the improvement in patch 4
already does for example), I didn't see any comments there which went to
correctness.

--nxV27VCFTPOJRpj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK2HxMACgkQJNaLcl1U
h9BzeQf4hmqV/v8iZsiZFzW3pob0oY3kGn3mo5H3tvfcho4HeU7p/GG3uuRGIfP2
0oKlY2snI4v73kenQSyR7OH/HrMfCUpeUCqnQlCAh0E7Prp+L0FhocpN8FIUEezt
qujxD3lLYeRXIKO7aPYxOghPy5BeCcCDBhCQx1T2GvimFREwSYrMmpMiGTxnS6Xo
Lt0+BNnPXcl2022zQ6f5pL0n0LP3NOw5L7xMbGS6P7sHujHNVk1mpbc7DQXksvZO
tPdWvc0b/aoLmGQ5CI4YLygZsnqx52nJpxlpMwaZ1CcFrJQp8KIbI8F3irtKWE/i
tZEXu46fEbTj7Tmf32MjT6tAmN3a
=hCJC
-----END PGP SIGNATURE-----

--nxV27VCFTPOJRpj5--
