Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9CE6AF741
	for <lists+linux-spi@lfdr.de>; Tue,  7 Mar 2023 22:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjCGVKj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Mar 2023 16:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjCGVKi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Mar 2023 16:10:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE75A100B
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 13:10:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1A8EB8117B
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 21:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8457C433EF;
        Tue,  7 Mar 2023 21:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678223434;
        bh=B4Dh4KncAE2aEGeTAf+L2fVPNFrYC/F98Asp9eM3RR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxux7lRJw8NTWvfV+zEA1rHbM9C9Af+fFa9YbW6rpFSqViay7ZPM0vGCjCDGpnJmU
         +6uxBZngFZkfau1TwuTcDFT1/GyBlNSDYnQFG3dnXGqvrpHChj8YSN170IJcKM31au
         gCDvEUGe2v2jl0EgoIAGMqRuFrfBDmzN0gQ0wS9YYEPRNELAL3fzB7bQC/C3TAVADA
         Wp65AmMQLZcN2Zl3uycRYw0jdeVOOMMDXAe8cnDTzHSe/GHysdo+bMDzW10nJvyWXX
         Md3+7yoLiKaiXt32KzkElNLyYTVoehY2pnEnWxrFmaJAWRhYLS0+E4IDzzoFb0Hnru
         qQl05x/jsC34g==
Date:   Tue, 7 Mar 2023 21:10:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Message-ID: <e6c44ee3-fd31-4341-96d6-bf542ecd6111@sirena.org.uk>
References: <764971c9-fe57-160c-d073-a519934da767@csgroup.eu>
 <8fd7715b-1dba-4cdd-916d-8c9dce004031@sirena.org.uk>
 <e21b9465-664e-bdf8-71ec-b7818c04c171@csgroup.eu>
 <84d3426c-47fe-44e9-ad04-be120fbbcd03@sirena.org.uk>
 <f9593ae5-a3e4-9bce-faa1-4761d76238ca@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9AJuvD2ehKpuOFSJ"
Content-Disposition: inline
In-Reply-To: <f9593ae5-a3e4-9bce-faa1-4761d76238ca@csgroup.eu>
X-Cookie: A rolling stone gathers momentum.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--9AJuvD2ehKpuOFSJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2023 at 07:43:42PM +0000, Christophe Leroy wrote:
> Le 07/03/2023 =E0 20:19, Mark Brown a =E9crit=A0:

> > Oh, so the issue is that your controller is *not* swapping data?  In
> > that case if 16 bit transfers are more efficient and a buffer formatted
> > for 8 bit transfers is already in the correct format then why not just
> > tell the controller to use 16 bit words where possible?  Nothing outside

=2E..

> No no, 8 bits mode is slower, or should I say it consumes more CPU for=20
> the same clock rate, which means we have to use slower rate in order to=
=20
> not saturate the RISC controller of the Communication Processor.

Please read what I wrote above.

> Well I not sure what you mean by swapping / not swapping data. Powerpc=20
> 8xx is natively a big endian processor like all PPC32. But its=20
> Communication Processor (CPM) is apparently fetching data as little=20
> endian when told to perform transfer of 16 bits word on SPI.

The default wire format for SPI is big endian (MSB first), as covered in
spi.h:

 * In-memory data values are always in native CPU byte order, translated
 * from the wire byte order (big-endian except with SPI_LSB_FIRST).  So
 * for example when bits_per_word is sixteen, buffers are 2N bytes long
 * (@len =3D 2N) and hold N sixteen bit words in CPU byte order.

LSB_FIRST has only one in tree user other than spidev so I'd question
how often it's correctly implemented.

> So, my problem really is the GPIO MAX7301 driver which requests 16 bits=
=20
> transfers, because then the SPI controller sends the 2 bytes in reversed=
=20
> order. Do I understand correctly that from your point of view, that=20
> driver shouldn't request a 16 bits tranfer ? It is done here, in the=20
> max7301_probe() function,=20
> https://elixir.bootlin.com/linux/v6.3-rc1/source/drivers/gpio/gpio-max730=
1.c#L50

It would certainly improve interoperability with controllers to request
8 bit, but so long as the driver is reading and writing data in the
expected format it should work perfectly well.  Looking at the lack of
any endianness handling in the driver that doesn't seem to be the case
though, it's just handling data in CPU endian format which isn't
portable.

> Because if I clamp the CPM SPI driver to 8 bits transfers, then I cannot=
=20
> anymore perform 16 bits transfer for loading my FPGA, then it means I=20
> must reduce data rate then loading the FPGA takes ages.

Why?

--9AJuvD2ehKpuOFSJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQHqEUACgkQJNaLcl1U
h9C9Jgf/SOCPBy7vcM8uyd+1Fw8/Ud+OrK7Y1BKYMpkZgFUOujTvk59zS60FweJf
QYb7HpOtQKRKqEqXHGZuR6cY3TOQytwISoCpamLHtDym2KMCIaqrM5eE9Ptn1o3R
b1c6/jFlOVifAkB22K3n60H6ruSHZfmFrUUZHorWyx/I5/D249GRYytUTQcGgko9
/VZYtlm/J3dm+kp97fssI/OqvmUUTShb8Zl4t9Pl0OH9GwIs/rea52hzlnmuWtbE
/2zlv+rjGfk2h0fVhGdxmhfcrpnCD8BflZbc8xnzreArWj34TGsfyh+lCaoW3AU5
zSK8o1rOH8j4ebhB16nzoi08xEOXBg==
=daDw
-----END PGP SIGNATURE-----

--9AJuvD2ehKpuOFSJ--
