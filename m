Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BF2215780
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 14:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgGFMnx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 08:43:53 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48123 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729178AbgGFMnw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 08:43:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CC0605C016D;
        Mon,  6 Jul 2020 08:43:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 06 Jul 2020 08:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=U/3ytRljZPPE41LD806UlJ0fxAR
        DOn7XYpkst93RDjo=; b=cw3R5O1Rbp7GofuFn0PNc+5+UVQymWkVP2VFky1J3Wc
        vztwIJk5jEkaA9Oc9bSwGOLOBVA7fOdeca3i24Gw7oOZlQP/E5Ta+2nHfIV4nywN
        G7bAyqs+jJ1PTRvM0ZagATdc/KUbGE1ib/sSrVhYm0Yk/fpCBrTGfmjng6ASsrQG
        Sbw1JftzY/eSgrX4Nlo7ILh2UEUMd8RAM6VJ7vqbYV4tVSQkwtmfEDfKVPbcspDd
        07ic8U+i7jIpENnl3ex/6V2CrLflRHK1Ja+qjNb/MSpd2uzztxo1oaJQelBVFmwO
        ja7Z2/g+fH5BBi7Qtt7dshvdA86y6IdTNtt38T4+a7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=U/3ytR
        ljZPPE41LD806UlJ0fxARDOn7XYpkst93RDjo=; b=RSWVJxBdbfVPzVR4mhzTmw
        YFwNEUh0rBhE0o9zzKLGfGimXfaNaZXTcZ8QidEgOjdPDshExUv1uqjNwuFOO05i
        CcH5cT39UGbmqWbJsfqc4q73VZu1gyELySYUL2Kc2htXZdp5nWAIeDisVyPUtPlx
        WPTitXDmaswsLWsGASQ0+xyKOJnKQ1DZYPXpBK94FyQHvavbGDNqHdVE1SVhUhMD
        BPB61YuE/uIJd6UoEZHmGPeANjF8opuvmKKSf7WeFU2f0ILCInre4txuAMHOKcT0
        mYqtrlNzQbo41XMN/W8Fm7cEXH9COVoa+TxRLmwC/5adlIwjGoglADbclPVnNgqw
        ==
X-ME-Sender: <xms:hRwDX4HxCJV3nLCPkWFzMV8Ex3Y-rUZEinuks0kqBrQxvUubaMkQ7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:hRwDXxXWqkYUP1dzAPh4WtinZcDFOxhQ1ESmthXwEHlNkkCtiDGepw>
    <xmx:hRwDXyJd0BsLyb3t0Cz-MalABatL_f3_8MAdSaC9U-PjKx-YjBRJ2A>
    <xmx:hRwDX6Gfn6e4kbNTBsDOerJf9tKbQkRAv871sSWenazYM2XsfOdHIQ>
    <xmx:hhwDX7jm7hYGqD2fYBcQUwOfFGEYUQJJcC11byrs2x_vxkYhqPLE-A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7CDD43280064;
        Mon,  6 Jul 2020 08:43:49 -0400 (EDT)
Date:   Mon, 6 Jul 2020 14:43:48 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/9] spi: spi-sun6i: One fix and some improvements
Message-ID: <20200706124348.p6viukufrtdh2qzd@gilmour.lan>
References: <20200706071801.558394-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kfa3nhvj6eozjosa"
Content-Disposition: inline
In-Reply-To: <20200706071801.558394-1-mkl@pengutronix.de>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--kfa3nhvj6eozjosa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2020 at 09:17:52AM +0200, Marc Kleine-Budde wrote:
> Hello,
>=20
> this series first fixes the calculation of the clock rate. The driver will
> round up to the nearest clock rate instead of rounding down. Resulting in=
 SPI
> devices accessed with a too high SPI clock.
>=20
> The remaining patches improve the performance of the driver. The changes =
range
> from micro-optimizations like reducing MMIO writes to the controller to
> reducing the number of needed interrupts in some use cases.

Thanks for that work. Aside from the minor comment over FIELD_GET, the
whole series is

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--kfa3nhvj6eozjosa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXwMcfgAKCRDj7w1vZxhR
xVCbAQC0DpObazCL5NtBvoIct0aL+o/si3yqW5eae4ieElwEbgEAg4apxWTFc1hf
8+l66in2SQvPXcjPdxfOasw3oFMMlgg=
=GnmZ
-----END PGP SIGNATURE-----

--kfa3nhvj6eozjosa--
