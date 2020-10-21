Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D2294F75
	for <lists+linux-spi@lfdr.de>; Wed, 21 Oct 2020 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443780AbgJUPDx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Oct 2020 11:03:53 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:38715 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2443567AbgJUPDw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Oct 2020 11:03:52 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D535EB56;
        Wed, 21 Oct 2020 11:03:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 21 Oct 2020 11:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=qxb2dhapqEcV1wlUzpI50HpbL56
        z//q+bmCX0zPuRWk=; b=iuWAIt2XcaEtAHn23qs5m92uT1vkZNTgIK12LRSyAqR
        XoIF76zW0AhIBPocwKxxyGc6912NVKR1TUWLIqsdiGKxOSGW1DUawXkVXosY+UkO
        sNqAhHBd8M/cOYU8UsGWbtT1QVUjNBGkKg2Gn7L2kVc/YbyFrmUFZ9RhW4gtTrBt
        g1fyOIV5+1zHjEqdCDNqkyDwGaoUW7W6e/5K0p2AlMRbKpj1g9pBgr/qHOotCZRK
        tuY74vNKth41EoVZj0VEWWe98Nt2rCJqcKDUaqXIxx2gxDu/elm6BuKSKk9u2xSO
        F3EXmrOgtDGxXrt4jyB/63AED0uI5+r+bnHjjr1Ksrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=qxb2dh
        apqEcV1wlUzpI50HpbL56z//q+bmCX0zPuRWk=; b=iU2dQe7Qx7Wu8kCpHOCyig
        FGNSeeIWoVYLqRsDiq5p3rdSeWvD18xiV2gbm7SCoQHF5eBPp2tc62WgSsevE0pf
        IKiK0DYdkQvZG4YyH2nUmmTLewIZUCrU1d223IFBwq9ZcvBjHpJy5cY7YHt5vN3w
        DCYe9E4I/uvJLK+ptxuVxDH7rVFrrnv4OGJD85XEPH9/r65en9c+dcrZl+tmM7/w
        2+HcbvCC4k/wL7UFJ9F/cGnpQKc4jiPCxcK6ypZm4eUx6E+CQ95tihIT3Dsa7kYP
        YuGMmznmxatXIH3JbiObiR4YzaKKPm2o/siZuK3cIPehVUjfU9Og0lMx0EtKo0Pw
        ==
X-ME-Sender: <xms:1k2QX7P03KAusWuHx7Aw6TxTdtCRN4P-zA6TkawjfBmJ9Of-is_pSA>
    <xme:1k2QX18e5xif-7xmDVXtF2BsGF4NKbw5i7aodd-6D0B3JDZi9Tg2l_gyqAQZcPgsZ
    gVyyETTELbFo-z2pqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeehgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelvefggfevhfdvueejkefguedtleeujeevjeevhfdvvdefgefgffdtgfelgfdt
    hfenucffohhmrghinhepphhinhgvieegrdhorhhgnecukfhppeeltddrkeelrdeikedrje
    einecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgr
    gihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:1k2QX6SgpZiECmRQYw4XcbsZSp2f5IPaTU3OZ1ghF6hflwUsap5UoA>
    <xmx:1k2QX_sp7GAO4HUqGSz3v_V1S7UPkPNDZiaNG5QCK23_c3oLrMk7XA>
    <xmx:1k2QXzcm7Qs_B9MJa7LJSsJoUDtij6C8k1p4w3MXhxE2bUCMGacpWw>
    <xmx:102QX_6LFvDtvFdjW8hy6H45ggFZX1VjddmyK_UUzrftSjX3ED7s4A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 48FE13064610;
        Wed, 21 Oct 2020 11:03:50 -0400 (EDT)
Date:   Wed, 21 Oct 2020 17:03:48 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Alexander Kochetkov <al.kochet@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-sun6i: implement DMA-based transfer mode
Message-ID: <20201021150348.g2anzbqalhrmypdl@gilmour.lan>
References: <20201015154740.20825-1-al.kochet@gmail.com>
 <20201019082129.myxpxla5xwoqwldo@gilmour.lan>
 <4EC91DD5-5611-4B48-B6FC-00690B400584@gmail.com>
 <CAGb2v64ruUf7Lv-cHZTRPs-U-gOboGtTwOB3+qtxZTFyLVFLjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cswefexiyy5rohzg"
Content-Disposition: inline
In-Reply-To: <CAGb2v64ruUf7Lv-cHZTRPs-U-gOboGtTwOB3+qtxZTFyLVFLjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cswefexiyy5rohzg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 11:52:34AM +0800, Chen-Yu Tsai wrote:
> On Tue, Oct 20, 2020 at 1:43 AM Alexander Kochetkov <al.kochet@gmail.com>=
 wrote:
> >
> >
> >
> > > 19 =D0=BE=D0=BA=D1=82. 2020 =D0=B3., =D0=B2 11:21, Maxime Ripard <max=
ime@cerno.tech> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
> > >
> > > Hi!
> > >
> > > On Thu, Oct 15, 2020 at 06:47:40PM +0300, Alexander Kochetkov wrote:
> > >> DMA-based transfer will be enabled if data length is larger than FIF=
O size
> > >> (64 bytes for A64). This greatly reduce number of interrupts for
> > >> transferring data.
> > >>
> > >> For smaller data size PIO mode will be used. In PIO mode whole buffe=
r will
> > >> be loaded into FIFO.
> > >>
> > >> If driver failed to request DMA channels then it fallback for PIO mo=
de.
> > >>
> > >> Tested on SOPINE (https://www.pine64.org/sopine/)
> > >>
> > >> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> > >
> > > Thanks for working on this, it's been a bit overdue
> >
> > Hi, Maxime!
> >
> > We did custom A64 based computation module for our product.
> > Do you mean that A64 is obsolete or EOL product?
> > If so, can you recommend active replacement for A64 from Allwinner same=
 price?
>=20
> I believe what Maxime meant was that DMA transfer for SPI is a long
> sought-after feature, but no one had finished it.

Yeah, that's what I meant :)

Maxime

--cswefexiyy5rohzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5BN1AAKCRDj7w1vZxhR
xeajAQDDQfn/PTTmGCss/aqPhvUim5gLLSaV4p3P4gdxSpylWQEAkHNQa448LP1N
bvAej+dehNCy7akUYd7zXzYe3O5QNwM=
=CuAY
-----END PGP SIGNATURE-----

--cswefexiyy5rohzg--
