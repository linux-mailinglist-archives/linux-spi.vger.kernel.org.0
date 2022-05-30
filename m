Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DED537A59
	for <lists+linux-spi@lfdr.de>; Mon, 30 May 2022 14:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbiE3MGM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 May 2022 08:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiE3MGM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 May 2022 08:06:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B3155207
        for <linux-spi@vger.kernel.org>; Mon, 30 May 2022 05:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77D79B80D7A
        for <linux-spi@vger.kernel.org>; Mon, 30 May 2022 12:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD86DC385B8;
        Mon, 30 May 2022 12:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653912369;
        bh=NT3b4UniTwZjM3Am7ldS7pvUS70BR3cLBOs4qsTq4mA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knZzaaiMfeik8Ug1n299qN7i0K433MCRwbrMh9i5oR+q2/PshnwqLYM2lBODRorai
         cUBJmO5NWdKPUmkJEKbh7/qzE7wuDRu7GoW7ZSG2vFGjOIrtZUaeAar2wZAanbLa7o
         cL07b0dZ8K+xNtM+WeFhbPZshK94hiRyVyMiddg0HFw92tJyqiyYyzMSxWJj0AJLLa
         dgsqHcXya0AkwoY7YZwNii1uznrRanzSf16aGftUZKX80XEyvqJGL2RGMXr/JfwlrE
         FW0H+xId8goJAkOI4uwBwBRS9EZWtOZH/MGv1avRju378dJfgYp0/At5tK7yJNK3eI
         /RRpeLlUozM4w==
Date:   Mon, 30 May 2022 14:06:09 +0200
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] [PATCH 0/3] Optimize spi_sync path
Message-ID: <YpR6QyuuA1+833Uv@sirena.org.uk>
References: <20220525142928.2335378-1-david@protonic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GMi7NQtmLqt38miI"
Content-Disposition: inline
In-Reply-To: <20220525142928.2335378-1-david@protonic.nl>
X-Cookie: May your camel be as swift as the wind.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GMi7NQtmLqt38miI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 25, 2022 at 04:29:25PM +0200, David Jander wrote:

> Unfortunately though, this optimization requires a small and hopefully
> innocuous API change. This change is contained in the first patch, and
> it replaces the function spi_finalize_current_message() with
> spi_finalize_message(), which takes the message instead of its
> controller as argument. Without this change, it is not possible to avoid
> touching the controller message queue, which is what this is all about.

You're right it needs at least a bit of thought here -
unfortunately I'm out of the office this week so I'm not sure
I'll have bandwidth to review this properly until next week.

--GMi7NQtmLqt38miI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKUsy0ACgkQJNaLcl1U
h9AIQAf+JZhhzhuR994IONO/9ylqy1RyKZ/m/SWM/mg/GaKxrzmoUFuAWVcp2JM9
ks5wh0T3C2v9uh15yJYThJd10oxEBzUFJ1mB7NFnk9L96dRyjt0zea1Nigp+gf7Y
qIAr707jWGIArS94RTU8iq0qVtoCJURvLqe8l54RZYdPXxzqkI4kbi9eEwPwtSv9
zssQx0yUGZJbkdx+v0tGGXsyz6vWMif/Jfd4EHwl/W9UKtByaul3wG/KC32CRPBn
J0ijnXDIf9YIIY0vb5Zf/9/xKYQwIOcRNtJdPQHFgRt4QvyAAM2lYkcamyttJI2j
76Jlo1qZ46v1wqHXXXDDIzvMmAw4nA==
=3TZl
-----END PGP SIGNATURE-----

--GMi7NQtmLqt38miI--
