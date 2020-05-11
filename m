Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57291CDA56
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 14:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbgEKMmx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 08:42:53 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45625 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729666AbgEKMmw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 May 2020 08:42:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E8055C0081;
        Mon, 11 May 2020 08:42:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 11 May 2020 08:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=LwUS7EdzKn64SedzwWMrtH0cjWc
        iOHlJCMLvGeb+ziQ=; b=D9+5etmDfCEqjeK2DeQ0h1Wa55xH8Wjgi8Z87jnpAbQ
        37sP/nZ4qcfMdoLpm68pZUWq7lxhl5TtbrwVIdznCD/V/krOPVH9CJZy378PVsji
        x9Sj7t9xZiSsqD9xWOxI4MLB4cTaEk+eQntZwWhf/XMEfbPG3Dcso7rbC08Fe2T1
        /GyjqAPjKSJZA9cFANBbQKA7UMwa2ZuqGnHsHUT1c2aFl+bPGuSRgqT0xsMIe8Sv
        fBfF70LucSdvEoYj3wYpfEWO120O85YymQFCuF3v3RQjiHDfYck66WTBI3gZDpwo
        75SsnapyxboZGwmMhHndR7ycE5AU4IKP09HeauaBStA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LwUS7E
        dzKn64SedzwWMrtH0cjWciOHlJCMLvGeb+ziQ=; b=IKaKXAWa/e9hbi4Bh3pPbn
        yRfCY3KU8IoUHVek7FpkmKuqghXQldCXDATc8DtaXVp20R9NjVRS1v4t3coaIvj1
        LRm+bkXsc/Mm2JbuRJY6eZ8fUlTuHN8p0YkLLy175AodhakV4V2IufBHCOqMTw+0
        SpxNhGj7S0esFTLqJOe/1S9HVQT2mtYTTiKRFQGKa0DrXhBsdERMeKz4cxZketr9
        d+MbPG3VkVveSGgQecQ3SwSY+jlUuKBnuV6EPig/d5YWU/H9kggh9m0D76y+1cys
        Lzba7jFTWfVnsEYtz1/NyW400T6eJshk1q8bEXq3O14TZ7f1Ue+9d4BF67XwWetg
        ==
X-ME-Sender: <xms:R0i5XuqL3_3hug-BGHFSpGtmruFvd_-v-Z_n_n8pV7zX_dM7MYYOgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrledtgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:R0i5XoX4xbW0ustp5-hauH7UThD1uM2wW4TGAqy9wKDqH_puj-Az0g>
    <xmx:R0i5Xi_lUHGj7LX8zr1QCFf0eztpGB44CqJUWF7fo3-QMQZzOJTXuQ>
    <xmx:R0i5XhHPUz_JK-FaapuzfMJ_weQqdLU9TscWupNOUcnhQkHIldtC_Q>
    <xmx:S0i5XrSYMBwe5o9XlEFZBnva7-nIj4z5oO8HHkWs09qtqFzG_-zdEQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9AE853280060;
        Mon, 11 May 2020 08:42:47 -0400 (EDT)
Date:   Mon, 11 May 2020 14:42:45 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>,
        linux-kernel@vger.kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, alistair23@gmail.com
Subject: Re: [PATCH v2] spi: sun6i: Add support for GPIO chip select lines
Message-ID: <20200511124245.j5pdnpsuhixzvs32@gilmour.lan>
References: <20200511045330.690507-1-alistair@alistair23.me>
 <158919630591.8372.404655401498379497.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pan7d2v2d5d6woy5"
Content-Disposition: inline
In-Reply-To: <158919630591.8372.404655401498379497.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--pan7d2v2d5d6woy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark

On Mon, May 11, 2020 at 12:25:35PM +0100, Mark Brown wrote:
> On Sun, 10 May 2020 21:53:30 -0700, Alistair Francis wrote:
> > Set use_gpio_descriptors as true to support using generic GPIO
> > lines for the chip select.
>=20
> Applied to
>=20
>    local tree asoc/for-5.7

Are you sure this is the proper tree?

Maxime

--pan7d2v2d5d6woy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXrlIRQAKCRDj7w1vZxhR
xdG7AQCDOq4jweV0JSLjkAtdWOcG+q5K0eA3YJ6cDKXKDjvoZgEAiCXDDT4BkV28
Fcl4Hx8EELgjn1vtcI7hLwSEnzTABQ0=
=P7p2
-----END PGP SIGNATURE-----

--pan7d2v2d5d6woy5--
