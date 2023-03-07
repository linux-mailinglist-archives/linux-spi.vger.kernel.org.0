Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CD86AF85C
	for <lists+linux-spi@lfdr.de>; Tue,  7 Mar 2023 23:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCGWQd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Mar 2023 17:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCGWQc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Mar 2023 17:16:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF70AA72A
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 14:16:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DE904CE1C5D
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 22:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8F8C433D2;
        Tue,  7 Mar 2023 22:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678227386;
        bh=gRZ44UJ6sY/xLS4Utf60zrsGIy8eHjc9vceVuTXDd8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iDaOPRbVDUVV5Ft8647Uo8byKUY/g2jvIsnM4izmX+uWz14LhHpjHCafC7MHI03vC
         azUlXXAff/QkRX51kU8LbVf4vI7x7J2/vtN8/AzIhbf9LT009vdq/518r2SEerIpN8
         ApIPB84ZquKTyt1i4GACRNc5Q09eimUpzHYNt5hA2fTfN7zzTL3ETBh0daFew12ozk
         aLqcBm2VUbJtr8gT90BqAEApVes2vcYLoZKcsQPTbsqOL6qYdxtv26Y5lPMBf/z9t8
         mIRPQi2tap2qoT9RBiElu0f3485TUMj60C1XywmuEkL2nPXUPEIeEkzKIfATtUM83w
         wmE1etnnGayZw==
Date:   Tue, 7 Mar 2023 22:16:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Message-ID: <4c46ffe5-6793-4149-998d-d76c37fca7aa@sirena.org.uk>
References: <764971c9-fe57-160c-d073-a519934da767@csgroup.eu>
 <8fd7715b-1dba-4cdd-916d-8c9dce004031@sirena.org.uk>
 <e21b9465-664e-bdf8-71ec-b7818c04c171@csgroup.eu>
 <84d3426c-47fe-44e9-ad04-be120fbbcd03@sirena.org.uk>
 <f9593ae5-a3e4-9bce-faa1-4761d76238ca@csgroup.eu>
 <e6c44ee3-fd31-4341-96d6-bf542ecd6111@sirena.org.uk>
 <247b27c9-7753-cf8a-6983-157e6def7301@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A9FH3/Ot7MTs0Mwu"
Content-Disposition: inline
In-Reply-To: <247b27c9-7753-cf8a-6983-157e6def7301@csgroup.eu>
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


--A9FH3/Ot7MTs0Mwu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2023 at 09:40:09PM +0000, Christophe Leroy wrote:
> Le 07/03/2023 =E0 22:10, Mark Brown a =E9crit=A0:
> > On Tue, Mar 07, 2023 at 07:43:42PM +0000, Christophe Leroy wrote:
> >> Le 07/03/2023 =E0 20:19, Mark Brown a =E9crit=A0:

> So yes, the problem is that the controller *is* swapping data: if I=20
> format the buffer to have 0x12 0x34 and tells the controller to send it=
=20
> as a 16 bits word, it will send 0x3412 whereas if I tell it to send as 8=
=20
> bits words, it will send 0x12 then 0x34.

> So a driver like MAX7301 which wants to send 0x1234 as a 16-bits word=20
> will write 0x1234 into the buffer. The powerpc 8xx being big endian, I=20
> get 0x12 0x34 into the buffer then the controller sends word 0x3412.

So the CPU is big endian, memory has a big endian word in it and the
controller is then sending as little endian?  That would mean that the
driver for the controller is implementing SPI_LSB_FIRST mode without
being asked (IIRC there is an option to run these systems LE, I don't
know if the controller is just always little endian or always byte
swapping).  That seems like a bug in the driver for the controller.

> >> Well I not sure what you mean by swapping / not swapping data. Powerpc
> >> 8xx is natively a big endian processor like all PPC32. But its
> >> Communication Processor (CPM) is apparently fetching data as little
> >> endian when told to perform transfer of 16 bits word on SPI.

> > The default wire format for SPI is big endian (MSB first), as covered in
> > spi.h:

> >   * In-memory data values are always in native CPU byte order, translat=
ed
> >   * from the wire byte order (big-endian except with SPI_LSB_FIRST).  So
> >   * for example when bits_per_word is sixteen, buffers are 2N bytes long
> >   * (@len =3D 2N) and hold N sixteen bit words in CPU byte order.

> > LSB_FIRST has only one in tree user other than spidev so I'd question
> > how often it's correctly implemented.

> Well, ok, I have no problem with the wire byte order, only with how the=
=20
> controller fetches the data from the DMA buffer. I'm not sure what I=20
> write is clear, is it ?

You have a problem with the wire byte order not being what was
requested - the data should always be big endian unless otherwise
specified.

> >> So, my problem really is the GPIO MAX7301 driver which requests 16 bits
> >> transfers, because then the SPI controller sends the 2 bytes in revers=
ed
> >> order. Do I understand correctly that from your point of view, that
> >> driver shouldn't request a 16 bits tranfer ? It is done here, in the
> >> max7301_probe() function,
> >> https://elixir.bootlin.com/linux/v6.3-rc1/source/drivers/gpio/gpio-max=
7301.c#L50

> > It would certainly improve interoperability with controllers to request
> > 8 bit, but so long as the driver is reading and writing data in the
> > expected format it should work perfectly well.  Looking at the lack of
> > any endianness handling in the driver that doesn't seem to be the case
> > though, it's just handling data in CPU endian format which isn't
> > portable.

> I agree, it should work but it doesn't.
> When I change max7301_probe() to set bits_per_word to 8 instead of 16 it=
=20
> works.

So the driver should also work on a little endian system configured for
16 bit words - looking at the code I would only expect it to work on
one endianness of system.

> >> Because if I clamp the CPM SPI driver to 8 bits transfers, then I cann=
ot
> >> anymore perform 16 bits transfer for loading my FPGA, then it means I
> >> must reduce data rate then loading the FPGA takes ages.

> > Why?

> Maybe what I wrote here isn't clear. What I mean is that if I modify CPM=
=20
> SPI controller driver to always use 8 bits mode (as done for the QE SPI=
=20
> controller via function mspi_apply_qe_mode_quirks() ), then it will work=
=20
> but I will not be able to use the same speed as in 16 bits transfer mode.

Why would we tell the controller to run in 8 bit mode when you don't
need to?  What the driver tells the controller just needs to produce the
correct results given the request from the client driver, it doesn't
need to be what the client driver asked for.

> So, to sum up, the solutions I see:
> A/ Force CPM SPI controller to always use 8 bits mode.

SPI controller driver should do whatever is the most efficient thing
for the transfers it was asked to perform.

> B/ Implement a flag to allow a SPI consumer to say "please perform=20
> tranfer with your bogus but performant 16 bits mode, I have worked=20
> around the data order for you"

SPI_LSB_FIRST already exists, however unless a device really is
operating with words I'd really suggest not using this since it just
adds confusion and portability problems.=20

> C/ Implement a byte-swapping in the CPM SPI controller when a consumer=20
> asks for a 16-bits data transfer

If the device doesn't request SPI_LSB_FIRST.

> D/ Modify MAX7301 GPIO driver to use 8 bits words instead of 16 bits word=
s.

That seems like it's needed anyway AFAICT, the driver is assuming a
particular endianness.  It could also be modified to format data in a
way that'll work with either endianness but that seems more confusing.

If your FPGA image is just a byte stream then I'd expect the driver for
it to be using 8 bit mode.  It is unclear to me if something has pre
swapped the image to contort it through whatever set of endianness
assumptions are going on here, you seem to want it to be byte swapped
but that seems like a surprising format for a FPGA image to be generated
in which makes me think something swapped the image earlier on?  AFAICT
what you're describing is a FPGA image which is a sequence of little
endian 16 bit words which need to be sent to the FPGA as a sequence of
big endian 16 bit words.

> Solution A will degrade performance by forcing transfer rate reduction.
> Solution B looks like a "home made" solution.
> Solution C means copy-and-swap into a newly allocated DMA buffer.
> Solution D is .... the best one ?

> Any other idea ?

> Which solution would you prefer ?

It seems like it'd be a lot clearer if the FPGA driver worked with a
byte stream, then the controller driver can work out the most efficient
way to actually perform that transfer.  At the minute I'm not clear what
it's actually doing here.

--A9FH3/Ot7MTs0Mwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQHt7UACgkQJNaLcl1U
h9C8wQf9GOtd1r8IKAEn1FrAQT6Cs1o8sEINC6slBMJ1tTrRKCqcEGPetyy5whQi
/HKfBaK39xCk5ACiWR6Xtyw+37fhIeNORR70EPwXRVHj4m4Q2DPD0WAUguc/iCkz
0jDKWIJFkzYnDzzYw64qgrRcvfynMjMgBjZQIsjQmn95mY5wYm1lhLpi6XhEVlVj
8ydtk8CxFoFj5xHBm31dD6mRCSoJviSumb8seXYS03RwVcNCRbopiWv+KogNvWO7
y2cVoxmBt53fTv8cjxMEZny/kXz/KhWa64vu34ejafYEtvfjsXnkIzvmviWexy8Q
OBCIwXesonKLV4Vlfd8inLiCj+PwRg==
=pUYt
-----END PGP SIGNATURE-----

--A9FH3/Ot7MTs0Mwu--
