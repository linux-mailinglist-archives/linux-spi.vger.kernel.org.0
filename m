Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E3D6A5B6E
	for <lists+linux-spi@lfdr.de>; Tue, 28 Feb 2023 16:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjB1PLd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Feb 2023 10:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjB1PLb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Feb 2023 10:11:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D188228864;
        Tue, 28 Feb 2023 07:11:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE1A61151;
        Tue, 28 Feb 2023 15:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55002C433EF;
        Tue, 28 Feb 2023 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677597073;
        bh=l6f4S677J1oI+Hevv9J+NgW8xZwXr9Mo8/Hp0wT+LBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1gYlQct9BpzQb6cSoGeN9vByCZ1aj2brN9VPRsrBfc2j5VUFhDfbp6mvEzOz6LZq
         6lZG4Xq/v4+GMQWzXKmsTFhCnmr3TYMvSUxd/9oU63H4NrQfv91f/lL9DZGO81gBRU
         LB8iye1x1sxariTOuqTydRslFx70begLJG37zZVzD+AzmpOAInybXTlO/v/vg6h6Gd
         GvVJuoroLUzRzJfssj23w2FS5Or0mD7u3xb8si8TwY1bWYhmLoMr4lYs17thM8PAbQ
         uj24cHyotg/vd5BZDzWHnXn7vqS0LEsAhvQmkNnMGa3UNLGyE+zyAvqOZ/430V3t7L
         oxRC6MIXnAsjw==
Date:   Tue, 28 Feb 2023 15:11:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     David Jander <david@protonic.nl>, Andrew Lunn <andrew@lunn.ch>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] spi: Replace spi_pcpu_stats_totalize() macro by a C
 function
Message-ID: <Y/4ZjVKXBuOPznUF@sirena.org.uk>
References: <cb7690d9d04c06eec23dbb98fbb5444082125cff.1677594432.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="24Lj3i//jS8PQg3C"
Content-Disposition: inline
In-Reply-To: <cb7690d9d04c06eec23dbb98fbb5444082125cff.1677594432.git.geert+renesas@glider.be>
X-Cookie: For external use only.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--24Lj3i//jS8PQg3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 03:43:08PM +0100, Geert Uytterhoeven wrote:

> Should the address calculation use RELOC_HIDE()? I.e.
>=20
>     field =3D RELOC_HIDE((void *)pcpu_stats, offset);

I have no real idea there, I'd hope per_cpu_ptr() was taking care of any
issue there.

--24Lj3i//jS8PQg3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP+GYwACgkQJNaLcl1U
h9AlTAf8DTkgTlP8Xd1eJWTfRDa+I1Rqnkviw9lqaSrwUbWjCbPFJ9Wptr+bqUEV
20MKAtja9tnWqze6AITBL0ElSMSOlGShoepMlVM0tq7Gk/qTjHmr3IkKlOl2Myok
adSLHJXkh+Ypg5eQQn+8cRTFStQUVfEkACCw1u3jlubHI/wHfwNXYuOjZz+gLRmw
p60pJQU3l8xBGXnrJTZUG/peGaONES2FWOJuLlq+oWwLODuWkBT8cYgy8QmUWGAL
2Y71Al5D5uXEbImevl52NXgE/WjuZI2Cuybv+mnsN7PWIRqAp1Hcm9X5oTjZ+Q25
j1d/WhjO/o03AJII3HnbknDPeVnRoQ==
=4wW5
-----END PGP SIGNATURE-----

--24Lj3i//jS8PQg3C--
