Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE26AF1C6
	for <lists+linux-spi@lfdr.de>; Tue,  7 Mar 2023 19:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjCGSrN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Mar 2023 13:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjCGSqx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Mar 2023 13:46:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE51BAD20
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 10:36:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 692AB61539
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 18:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290A7C4339B;
        Tue,  7 Mar 2023 18:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678214134;
        bh=Umpo78ZkSFrzhGCkoDqCezgE59l+Bvu7l3aISe25DVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8B3yz7s/r3LkU66LVQeCJJfB2RExKbxXUpG7uhmi3F+k3/XUEQ3eyAFM4jl6Np5a
         B+nOzPEWMzDvTfYPwWHrQrhgK48MQYnjUm9Ht4Nl49p1Npt7OQes2VdGqsujiw3bOr
         af1LSS1uxg6VLhm9cxcJcYoEYzUOsJV0y/vJfmUx1Eqowd/89nvWWalxonrLtBpuuS
         DO/JqSjiWi9rKDRC40P/1xZR7ny+O1cPIQCwkh1N+wt0uiRRqXI7G32pt4jpv8IeIk
         xhYA6FwL4XGbBk3gsCvQ6zbkBRdRrEzF0cBmc0ZuagqD7mFoKnuPOgxn6iAeWQpHmg
         NB0CL4+Cd1Tlg==
Date:   Tue, 7 Mar 2023 18:35:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Message-ID: <8fd7715b-1dba-4cdd-916d-8c9dce004031@sirena.org.uk>
References: <764971c9-fe57-160c-d073-a519934da767@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ffw4ANYlxH3Rw3qA"
Content-Disposition: inline
In-Reply-To: <764971c9-fe57-160c-d073-a519934da767@csgroup.eu>
X-Cookie: A rolling stone gathers momentum.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ffw4ANYlxH3Rw3qA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2023 at 06:21:36PM +0000, Christophe Leroy wrote:
>=20
> On powerpc CPM soc, SPI handles words in reversed byte order. Therefore=
=20
> when some drivers like the GPIO max7301 driver request 16 bits data,=20
> data is sent in wrong byte order.

Clearly if the device is byte swapping the data incorrectly then you'll
need to do an extra swap in the CPU before sending to the device, or get
the DMA controller to do it if that's a feature it has, when using the
16 bit mode.

> We could do as in spi-fsl-spi.c SPI driver for the QE soc and force 8=20
> bits transfer at all time:

Right, that's the simplest thing.

> What could be the best solution to force 8 bits transfer on generic=20
> drivers like GPIO max7301 while still allowing aware drivers like my=20
> FPGA loader to use 16 bits mode by reversing words by itself ?

If your FPGA loader is already reversing words you may as well just move
it into the controller driver.

--ffw4ANYlxH3Rw3qA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQHg/IACgkQJNaLcl1U
h9C/0wf+LsekkpBtQwe2EleP+ht9OXZqWsXu2UcG9B0qRW6kPENlHfeS0gO7IM4j
6sYGzG/vF9szeXrYbuAPuf/J7RF5u1o0Y0HVXvMKozErw/RsWv4yLi+pynWuzL+D
gZEuDFwRK4NW1Dum2KVDuwmsXlwQluNMYYgQJSzxpvU4416DjPozf+eyajIBUzHk
hKesmb4ltmd3TfCtYhtZ54oV6id+GkkLbMOwjrBbo71L7Nz29FwJQmKWAapkX3Z5
9MSNtKQ1mPGFNLG9CWllUDjrmWcC0c+BmC0xSFTbnXpOUjkQzbb0koBd5q6tJgEy
746P7hNDMznKVXNILbciXxecqApDDQ==
=0eCH
-----END PGP SIGNATURE-----

--ffw4ANYlxH3Rw3qA--
