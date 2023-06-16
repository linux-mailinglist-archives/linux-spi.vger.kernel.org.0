Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C830733793
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jun 2023 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjFPRn6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jun 2023 13:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFPRn6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jun 2023 13:43:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C5626B6
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 10:43:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF26A61550
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 17:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2EEC433C8;
        Fri, 16 Jun 2023 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686937436;
        bh=vAEKhf2r05WTIZqQ6FQkLGicVZAFh7Fqr2woQmGeXWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jaxtLQD2cmSvTGFZWjH3Sw8Lu9JVef3aG2sIwK63QNG6EQMtlRJgtMN4NXzgyxKW0
         sHMrpKlEKV44St81zH6GQlLAlHYbzPgCwHUUXsfxdzEB4plAHKvSm6sMqUeDqXJBT7
         wrfksEXVhP5y+4DrLp302jxRxtKEVYWzYwmFJM2+24DonAjCyCoHNMeDCf/yqTRDxY
         pJeIzPqpbOjbxmaXoQ8pcprF0trFkXuLAGOdRjVmRp7IcrDc8LvcHZCkEJogTZ/wbR
         xIptmGI10uGiMmZT/MKRv2pGZ0MnrmwVvk8pacFJRIX8MIM3wiejc/zYS2P6JOUgrL
         37i3+6mgqKlaA==
Date:   Fri, 16 Jun 2023 18:43:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        linux-spi@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: atmel: Prevent false timeouts on long transfers
Message-ID: <71245a47-5c7e-4ff4-80c3-3b2b4d3642db@sirena.org.uk>
References: <20230616141225.2790073-1-miquel.raynal@bootlin.com>
 <89439569-4fc3-4f5e-9392-4ed92ecb62e5@sirena.org.uk>
 <20230616181535.032bf9de@xps-13>
 <4054360c-b942-4761-a03f-e4d50a328ec0@sirena.org.uk>
 <20230616185906.04c4a869@xps-13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hDchQLG4zZdATydV"
Content-Disposition: inline
In-Reply-To: <20230616185906.04c4a869@xps-13>
X-Cookie: P-K4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--hDchQLG4zZdATydV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 06:59:06PM +0200, Miquel Raynal wrote:
> broonie@kernel.org wrote on Fri, 16 Jun 2023 17:43:06 +0100:
> > On Fri, Jun 16, 2023 at 06:15:35PM +0200, Miquel Raynal wrote:
> > > broonie@kernel.org wrote on Fri, 16 Jun 2023 15:20:27 +0100: =20

> > Like I say we should know the transfer speed so we can do better than
> > 4ms/10k - we know how long it takes to clock out each byte, we can just
> > multiply that by the size of the transfer then add some fudge factor for
> > setup/teardown overhead.  1s feels pretty generous too.  The sun6i
> > driver for example does=20

> >    max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U)

> > and just doubles the length based timeout with a minimum of 100ms which
> > seems reasonable.

> I already had issues with ~0.1s timeouts on NAND controllers, just
> because the machine was heavily loaded. I believe we should avoid too
> small timeouts, it does not make sense and make things worse under load.

Well, we can raise that minimum if it's causing issues - 500ms say?  1s
does feel a bit extreme for short transfers (and note that we'll use
more than 100ms for long enough transfers).

--hDchQLG4zZdATydV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSMn1YACgkQJNaLcl1U
h9DsHgf/Z4QLzgALwjUkSpnmuQzCx3pzvY34jLKGHZhk+54WYiIsEy5nOYvbQ0MJ
T5L701I4uHmaEx5/zRJlVMfECi1MPO22JsaMCb2WXmh0c2NdYyuE7fno4uRrCKyT
I+hF6cfayOHdl8mbpBwoqfEM11j4EAt75qGItdxd9Py29G71STXEz1FI+P1QXOXI
3E2hqMHLsqr97MBSWrBi1aBYJVChsPEYcXj6BgzcC9JIV3ROSFm8iTu/5Tuk+08L
USWpxJBaOSkbW1IbkI/q1xjzN9BxPuIv94HysrVuSEe36h6rnHqxswL7mXJ/WCG4
P+TmTLUny5vZrN4bcTjGVAjbkuXVoA==
=Urdu
-----END PGP SIGNATURE-----

--hDchQLG4zZdATydV--
