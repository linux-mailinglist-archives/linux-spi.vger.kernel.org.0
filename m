Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDB56B9F30
	for <lists+linux-spi@lfdr.de>; Tue, 14 Mar 2023 19:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCNS6W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Mar 2023 14:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCNS6V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Mar 2023 14:58:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A564A11678
        for <linux-spi@vger.kernel.org>; Tue, 14 Mar 2023 11:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 400E2618C4
        for <linux-spi@vger.kernel.org>; Tue, 14 Mar 2023 18:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2300C433D2;
        Tue, 14 Mar 2023 18:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678820299;
        bh=TELwoUppgWwsbK+QA3FECszEK9h/kol+OmJkC/gIUvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pkk4LFWuA96cWSDZA4RIIKmv/y+lO+vwCDXIb58JfyswUBWzQaWJYu+93Wy7duXAT
         gNdNKP26oqIs0WqsSTVww+n7o1/LDDwaVINGogulI0u1QGmy6KWVNG4s76UDFMKTil
         HjgcyPVsWlttu9uQM0ZQdMZr9Ubc321GwfufKugfTetpq++bIGfG7fSXShC47tZFK+
         T+IxaDwfn1Drfb4S3hk6aHIOqqTFWJiwArHQ9/3hpEiEku8JFHkTVN/0oQj1oXOwNb
         aZQBIfDrCcwY9beooTbkrcU6N20QCrkBthLX9YL2/0RDj0jsyg+9Htn49QtIM7TCEC
         g88hrjWxK0cXw==
Date:   Tue, 14 Mar 2023 18:58:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Message-ID: <4ee54bf5-e984-4c91-bdbf-6794cf4be305@sirena.org.uk>
References: <764971c9-fe57-160c-d073-a519934da767@csgroup.eu>
 <8fd7715b-1dba-4cdd-916d-8c9dce004031@sirena.org.uk>
 <e21b9465-664e-bdf8-71ec-b7818c04c171@csgroup.eu>
 <84d3426c-47fe-44e9-ad04-be120fbbcd03@sirena.org.uk>
 <f9593ae5-a3e4-9bce-faa1-4761d76238ca@csgroup.eu>
 <e6c44ee3-fd31-4341-96d6-bf542ecd6111@sirena.org.uk>
 <247b27c9-7753-cf8a-6983-157e6def7301@csgroup.eu>
 <4c46ffe5-6793-4149-998d-d76c37fca7aa@sirena.org.uk>
 <85e02cb8-935d-b715-0e40-9cdcfca1abda@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xy0THG92OjQVxOb9"
Content-Disposition: inline
In-Reply-To: <85e02cb8-935d-b715-0e40-9cdcfca1abda@csgroup.eu>
X-Cookie: For office use only.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Xy0THG92OjQVxOb9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2023 at 09:55:25AM +0000, Christophe Leroy wrote:
> Le 07/03/2023 =E0 23:16, Mark Brown a =E9crit=A0:

> > So the CPU is big endian, memory has a big endian word in it and the
> > controller is then sending as little endian?  That would mean that the
> > driver for the controller is implementing SPI_LSB_FIRST mode without
> > being asked (IIRC there is an option to run these systems LE, I don't
> > know if the controller is just always little endian or always byte
> > swapping).  That seems like a bug in the driver for the controller.

> What does SPI_LSB_FIRST stands for ? From what you say, shall I=20
> understand that it means Least Significant _Byte_ first ?

> I'm asking because as far as I can see, for the controller SPI_LSB_FIRST=
=20
> means Least Significant _bit_ first. Is that wrong ?

Ah, you're right - it's bit rather than byte.

--Xy0THG92OjQVxOb9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQQw8YACgkQJNaLcl1U
h9B6zwf/ec3TvWBcQwK4zA3SA8ReOSeDWj6uXQk3FjJHU7LuHBMTJmuYsjQX2iu5
icFho2lz/w2gNWEft1hcfh7bD2m4MJwxHusX2hY6bZpO/JpCBuXIPzqzBIzUjsQd
JZdZvU3k1d1tszO8eh3Cfz+jpCllu7pgNbwWQP6pyM1J5AzyASwJZ5JqxvtuKhSO
kX2D9yfH7NtNKI6LDE+tpV/GEWig2hvIZM51/ykCHDQAKnMdsfjX7r5fbqe3WlM6
wh5NfZEeHScpnvVyCBFZQer+qhqG37zxqleRRk5U5n9MOo25ZzBza3dAVEWZYx3e
9ZCegFx3+1v9NV70KI5tWYEStc+1/A==
=2b+Z
-----END PGP SIGNATURE-----

--Xy0THG92OjQVxOb9--
