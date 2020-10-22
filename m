Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0517F2961D3
	for <lists+linux-spi@lfdr.de>; Thu, 22 Oct 2020 17:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508479AbgJVPni (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Oct 2020 11:43:38 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44415 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2508315AbgJVPni (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Oct 2020 11:43:38 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2387D5C00C9;
        Thu, 22 Oct 2020 11:43:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 22 Oct 2020 11:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=qQcssX4y6y38K9RgQ4janqr2ZQA
        j8lZs3yvwrRKlDUo=; b=gjLvTVm3R2ZB47yKS5mM/X73sRUGmxyXVjcoUsZaas/
        /qi2TrMEbOOYcG42P5qLYfTnlRMjMbm0ok9XrFl54XUzqoaQNJxGwHGEaGCgJdMS
        ItWVqAhcQbWeOBdpF7YU9rPdjy1NWgUEt8PT2TxUeSKMa3jDWnFSIQgVH9Av/XpX
        Y305HV64yMzbwL01mCwc0U/16+tNu175/O+totUYqBEPZjWPD7KW2IRTy8Ms30eh
        caYccnKn0dihYPDufgEt9TvCCw4d4YbBMCweWEpZnhAsscP11bfEAELvpWhNthWq
        GcN1BSoQP4Iys53bBPHotoWaKR49zp5iIs5rt+udb/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=qQcssX
        4y6y38K9RgQ4janqr2ZQAj8lZs3yvwrRKlDUo=; b=XKQe4eaTOA6vq0wFrUOae1
        9DHPqJT41PnPCZ9Tz9Cfkr7hJRhNG5MDa3ikpkR7OfNKXDNEZXx0NMoOGsqVwTbW
        dn4uLC7zYb2HM9ggB8dDM8q+0voI/rkkum+chqr+82kNmoexxFYU3qAmEb55v+fz
        d99pD0sHDaXH9rBv4YgoqXV4z9b86Ipyevpm6k1qpoPl32jN/DLBVydBIbu3mAAZ
        TYh6mA5osD5tSJUE13PFtc2RU3iaAowLOrZS5ziQecxfK1LvTY1wccH/iO6wPVGd
        uzn99IvvmcqnVWkmXO+tjTJIXDsQTdBclJeuj9lNP7ciMXNZsWyqR5hjWhFHBRWQ
        ==
X-ME-Sender: <xms:p6iRX-NiFx5u6px0KrD1oSKkY5_Mbvs2LRTDwQS0-VLUYuC1RFaPdg>
    <xme:p6iRX88oBx4b1KQwwSh0TTwmG2CVZILt6WTA2_c3M-PgAU_ofZmmAhP-kkNVKYZG6
    qpSHSGj05vJ3pxc63k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeekgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeffuedugfdvjeeihedvgefhieeikeelteehteekffetudeiueeggfduueevffet
    geenucffohhmrghinhepphhinhgvieegrdhorhhgnecukfhppeeltddrkeelrdeikedrje
    einecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgr
    gihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:p6iRX1Sy6k89lk-6nqQl3srn-xIgTwpAa7U0ImOKCEYuw_keHKv9Dg>
    <xmx:p6iRX-vReGUBiDFEq0w8I_nVY8CHROzX6Lq0dNA9_OsYIxS8aP9EVQ>
    <xmx:p6iRX2dH8kss364liqw0h65dLz_isDPQ3WRv_xVLOAq22m-QV7mEuA>
    <xmx:qaiRX26LM7xFWLdGjx9uMSkus5U0QC-l484zr3birAf5-pTmiH1BwA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 64ED53064684;
        Thu, 22 Oct 2020 11:43:35 -0400 (EDT)
Date:   Thu, 22 Oct 2020 17:43:34 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Alexander Kochetkov <al.kochet@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] spi: spi-sun6i: implement DMA-based transfer mode
Message-ID: <20201022154334.qqkoihzjxzdfhvce@gilmour.lan>
References: <20201022075221.23332-1-akochetkov@lintech.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="24oxrxwiyl7dicsw"
Content-Disposition: inline
In-Reply-To: <20201022075221.23332-1-akochetkov@lintech.ru>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--24oxrxwiyl7dicsw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2020 at 10:52:21AM +0300, Alexander Kochetkov wrote:
> From: Alexander Kochetkov <al.kochet@gmail.com>
>=20
> DMA-based transfer will be enabled if data length is larger than FIFO size
> (64 bytes for A64). This greatly reduce number of interrupts for
> transferring data.
>=20
> For smaller data size PIO mode will be used. In PIO mode whole buffer will
> be loaded into FIFO.
>=20
> If driver failed to request DMA channels then it fallback for PIO mode.
>=20
> Tested on SOPINE (https://www.pine64.org/sopine/)
>=20
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--24oxrxwiyl7dicsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5GopgAKCRDj7w1vZxhR
xR6mAP9cQRYGW5IK0TdSiOXRAXSI4XovnETyUkuY1fx/Re6dCAD8CkftTek57e84
yyPrPE3Cy9Cn+zK4d2OnSjIZIfDv+QY=
=6+uq
-----END PGP SIGNATURE-----

--24oxrxwiyl7dicsw--
