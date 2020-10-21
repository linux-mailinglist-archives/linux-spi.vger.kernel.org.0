Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F977294F71
	for <lists+linux-spi@lfdr.de>; Wed, 21 Oct 2020 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443914AbgJUPDD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Oct 2020 11:03:03 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:50647 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2443913AbgJUPDD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Oct 2020 11:03:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B5DFDC55;
        Wed, 21 Oct 2020 11:03:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 21 Oct 2020 11:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=eFu2bMtKLMG2xcNKdFGhIE+PQM9
        o3Uc5LUJogHhz2Gs=; b=Wj7UfHKNvs6ZE2gpNUHen4UfQD2mJouXSI7fpBabzf6
        o8O/L3bSwm/SS9dMUEXFPgDNzVnasdHEnrWcjeZXwhzdlPx8L5glX5sdAZ3ykZv8
        jE9pRJCxQ0gyOeGeXWXh7ZwGoNqI4W1D62F2/o0CuqqKN4Tc8eIe3KjglHmolcpx
        ekdOWrojCmdLKCyfpBNhoBrFSIxrCNAurdyLB318QUSp2mUypTfeojAN5imh/SDi
        nxFSlWGDrYolJ58T3EGXBlxar8QQ+EEPXJbVFHelC+p+JhWsrvvQi6ZdVtTcrnyd
        hh5kc2wjZq2Ppa3wH1DBmgCJrblgFLTBdW728+1tUKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=eFu2bM
        tKLMG2xcNKdFGhIE+PQM9o3Uc5LUJogHhz2Gs=; b=VfsL+q72UXF29qV3PdEnn/
        hkuQaqJr1h6+7075pWMCpPF9ttEd2hND4RmuLWqCCafmRcp0fdaXN5h+358MH0tV
        JqysWvMX3wnSffEAZ9NdQOAYnbqHCge2wMTiMuHut29q4O9dCyZn1DcTM2+mTxuv
        fKZji5ka4TgU/AeG+xOOABTMuhQNuGkz1pVzSMrjJ183J43TXZBvw2fb8fhRO5Wb
        YTus+N/LcSqLWKrv/T+HzNJMMzN5AOP1DEtiLGmxJ9aer20znDnf1/r5TaDEFQ/L
        7NEt+FxNuhVye7KW7fux3YbBJDx5C+JjMqkgIlxno2QeXotyqIkrkxJyp4jAOliA
        ==
X-ME-Sender: <xms:pE2QX9k_OPJndof2SPWVOsC7Mg65fKuJU2_HvxYkAhGqTShfB3UfGA>
    <xme:pE2QX41BUv0E_fYqmkap84jHRXh5j-B36vmU_AYylPfp1sYyCHMJRFmOoHE9fazwM
    NiGeemNW7eYfR8rzfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeehgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:pE2QXzrvRm6L3WhWHc7n4bJ-QcCDHdgjkc2XuT-qwLz3itjJdV0bGQ>
    <xmx:pE2QX9ljfcnK1En9aVNlwyX5edvIKu4xmN45DXZqkfaQMJV2rTGSlQ>
    <xmx:pE2QX709aOjP5KmGFbxAFc7mqO21mwDkuUA0UUWbfUUgWWO9Z_zPPQ>
    <xmx:pU2QX8ynPXceos8qOYAlzlCbLxaZjUaTGiW9kOBdfsfjyWqGo6Vt1A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 53F693280059;
        Wed, 21 Oct 2020 11:03:00 -0400 (EDT)
Date:   Wed, 21 Oct 2020 17:02:58 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Alexander Kochetkov <al.kochet@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: spi-sun6i: enable autosuspend feature
Message-ID: <20201021150258.mwis3ez5b6emqoci@gilmour.lan>
References: <20201019150343.2520-1-akochetkov@lintech.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d2rnhfszvqavfh5e"
Content-Disposition: inline
In-Reply-To: <20201019150343.2520-1-akochetkov@lintech.ru>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--d2rnhfszvqavfh5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 06:03:43PM +0300, Alexander Kochetkov wrote:
> From: Alexander Kochetkov <al.kochet@gmail.com>
>=20
> If SPI is used for periodic polling any sensor, significant delays
> sometimes appear. Switching on module clocks during resume lead to delays.
> Enabling autosuspend mode causes the controller to not suspend between
> SPI transfers and the delays disappear.
>=20
> The commit also remove unnecessary call to pm_runtime_idle() used
> to explicit put device to suspended state. Without pm_runtime_idle() PM
> core will put device in the suspended state just after probe() returns.
>=20
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--d2rnhfszvqavfh5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5BNogAKCRDj7w1vZxhR
xSudAQCh8jxQhmFsw2AHAgbds1TcgyA1wyq6U0aRuMfs0OJbaQEAlxiWpoFxPZpA
GHh9Nazv5DJzszLvscpQJXY2ZnNxsQA=
=amT9
-----END PGP SIGNATURE-----

--d2rnhfszvqavfh5e--
