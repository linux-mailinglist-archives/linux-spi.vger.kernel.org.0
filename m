Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEF422EBEB
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 14:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgG0MST (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 08:18:19 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60781 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727078AbgG0MST (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jul 2020 08:18:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 127EE5C009B;
        Mon, 27 Jul 2020 08:18:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 27 Jul 2020 08:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=mHtep/F/V+/ZTSTOICf7uGBozy9
        AgBu1m/s4r2bq0Eg=; b=ktaRTNZgCdigpkG4O3q2NH6ZsEhG4cscIZ1v3xE5OKt
        qpPvJIFX3qDfiO83dNOiUrUBGm4Zdg9Lj0H7rSNvBKihX5wQdCzFG1Eb1wAsejGG
        kUkwyaw2/jKptMU+PQVA9TLPCzqYxnKx9EFJKJ2AZTspOH8E0ULlYH6JU+1w/9Uz
        +jlepgj+DQIwsX4ZSdZFCzu1HJ4XpvWTh5Tng2cQd2Um+xbIvpT4zaSRWR3259Yw
        PwAag9sJSy2px3IMK2QAwaclMV8JufnZChnxRYk7O31qKRCAo14GwdezCknfygl4
        LCe9BmVp4yZx/djpO4c9GOUGR5rHnHBr9Nf+InWQN9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mHtep/
        F/V+/ZTSTOICf7uGBozy9AgBu1m/s4r2bq0Eg=; b=kltT2+bcmkrCZVrAZMYZEg
        3H9/G0AftWFq3Lofsb3I8Oa84uz9wrcSoGNSO091usatLYggpSZ8dqzqz52IgR8W
        paN9xAMk8EoM3Qy8Z/mmHNzMXO1/ImRAxP1fB0XIm+wsY0iVlFAEaoqJe2w18oHw
        QzXhD0hnfUHbKvZ4QsWJt2ZU1TaWa0PzINSMwPN36y0DVuIBqZATJ3abIyRgYL7g
        8ANZ8HGVcTZvcqAH9iekrzjTowGas+8+H7tDPnN1yRWs/4SKwq7sK/lHhgAGb+NR
        fCNYT1fiqrkzVa6RWzQh63Y4HDZmMnWzRZwW+EZDAkonGJXI4G5LHU1iJOpp+aNg
        ==
X-ME-Sender: <xms:CcYeX7UdMWi9wIo5FtayKf5m4tbSQRkeP7UpVGikiTHsANBAdSzggA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedriedtgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecuggftrfgrthhtvghrnhepleekgeehhfdutdeljefgleejffehff
    fgieejhffgueefhfdtveetgeehieehgedunecukfhppeeltddrkeelrdeikedrjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:CcYeXzlgbB6qRj7Qgu3FI_56Z_QYHjlunYLndhBm8eGhXv4HKaAnvA>
    <xmx:CcYeX3aGhGyGp81Z7HUGHzMRsu1ExyK0X0L6iJkWNCVXl8LkltzNsg>
    <xmx:CcYeX2Ww5tIiD8EtTgTbhSZrAtHptC8h9vfAzHS9Ycg8bMBsCajnWA>
    <xmx:CsYeX4tEKXVYhL94E4a7T5uKL0J7T88yt0oWUOvk0iFOw6OnKLC50w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 11D9E328005E;
        Mon, 27 Jul 2020 08:18:16 -0400 (EDT)
Date:   Mon, 27 Jul 2020 14:18:14 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jonathan Liu <net147@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Olliver Schinagl <oliver@schinagl.nl>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] spi: sun4i: update max transfer size reported
Message-ID: <20200727121814.mibefpenprccgqaq@gilmour.lan>
References: <20200727072328.510798-1-net147@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u36akzhevqsrnfat"
Content-Disposition: inline
In-Reply-To: <20200727072328.510798-1-net147@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--u36akzhevqsrnfat
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 05:23:28PM +1000, Jonathan Liu wrote:
> The spi-sun4i driver already has the ability to do large transfers.
> However, the max transfer size reported is still fifo depth - 1.
>=20
> Update the max transfer size reported to the max value possible.
>=20
> Fixes: 196737912da5 ("spi: sun4i: Allow transfers larger than FIFO size")
> Signed-off-by: Jonathan Liu <net147@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--u36akzhevqsrnfat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXx7GAAAKCRDj7w1vZxhR
xSvfAP9c8u8Tff95lvMwSOvhDaRFeoPnHygE4hraIsJJOestDQEAl/iGmAeXeDWN
j3YGm934Ggfog/Hllk87urkgvVL7mwM=
=kySp
-----END PGP SIGNATURE-----

--u36akzhevqsrnfat--
