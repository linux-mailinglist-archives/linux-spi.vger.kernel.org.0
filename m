Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4F852579D
	for <lists+linux-spi@lfdr.de>; Fri, 13 May 2022 00:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359069AbiELWMZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 May 2022 18:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354300AbiELWMX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 May 2022 18:12:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FDD6C0DF
        for <linux-spi@vger.kernel.org>; Thu, 12 May 2022 15:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13D07B827FD
        for <linux-spi@vger.kernel.org>; Thu, 12 May 2022 22:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6E6C385B8;
        Thu, 12 May 2022 22:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652393539;
        bh=OP49iXqDp2Ca5f1+SkDx3fixg7X8jKkqavXxAh9N4A4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CfA1wwaWueFBpIuQW382g5xa0oqo6bZueB8byIQ9gx2zcSDFBX8rlpVcKLpmM18F7
         /pli3b/NINB46LrD3kiqduf/vUv427OlAxR2AJ/bIjuMXPFiW2q4LDXah3i2mFKcCb
         KMuwCUZhz9lMzKvOAj23R00awu5/FOAWAljlAQV8W4ApCSgYxwah/n6WIlDtrHOZuK
         SdCLT+dLjSJXwBagxfG9oKM9/yNjD0egl+UmvQ0dbucwCylpRC6p2gXsFRtLqCD2gc
         /tlxTI/Ek5Q0smK+z/pthWuybRg2izmr31O7odJ4EwebXqoH3ZGnk9GpQAvx7FtTah
         oX4unj/4msc5A==
Date:   Thu, 12 May 2022 23:12:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <ore@pengutronix.de>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <Yn2GSp5aMjKtQ0iC@sirena.org.uk>
References: <20220512163445.6dcca126@erd992>
 <Yn1wE4TLyXCIm9GF@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MDLQEbGXz4eGkqxI"
Content-Disposition: inline
In-Reply-To: <Yn1wE4TLyXCIm9GF@sirena.org.uk>
X-Cookie: <Culus-> libc6 is not essential :|
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--MDLQEbGXz4eGkqxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2022 at 09:37:44PM +0100, Mark Brown wrote:

> I see the problem, what I don't see is why it requires a new externally
> visible API to solve it beyond the suggestion about potentially
> preparing messages for repeated use if that's even something that's
> really registering.

BTW what I mean here is that even if it turns out that it really
is essential to have a completely separate path it's not clear to
me that we can't just have the core decide to do that based on
the characteristics of the message and system rather than having
to change the client drivers.

--MDLQEbGXz4eGkqxI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ9hkYACgkQJNaLcl1U
h9C3Owf8CCMQY/5L4p7xfD3ef11GZLa9Z1g7u0ILeBFmFIMCbxu4qK8ellpRuc+n
VC9LML5gT4oqQXDwuERRYesOWEC2LTdHL6/yiXdeb2e8v/RrKLmiYWh7PutXF1BY
VGRzIFQy49+AHQ+4ovxw3WIm8frIRWeA4NHWTaAokwnf0TnhMjgWmDjRiew4ONBU
mlqS6KqgcrU9ngcRV738fV6HQGeCwAZfX2+K3zUjfmaAhOXD/K36xYRNY5FDAXTt
ItZEIhMR5s5GmFzbHqhBnv7R+M2+qwMW7qzIcrdQdtzNwwhsL0j+tc0GuU+zivRy
SExXUFA8ryrKZW0Fae5OYi0NtozV5Q==
=6Ct1
-----END PGP SIGNATURE-----

--MDLQEbGXz4eGkqxI--
