Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D362922C8
	for <lists+linux-spi@lfdr.de>; Mon, 19 Oct 2020 09:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgJSHFs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Oct 2020 03:05:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39973 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727223AbgJSHFs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Oct 2020 03:05:48 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5202F5C006B;
        Mon, 19 Oct 2020 03:05:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 19 Oct 2020 03:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=EMlZBo15epeEdVjKu5nXc3zhaks
        PLbuojCDzDSKauhc=; b=Ff1Tz88cw07JCNE4wxm2z6vwZsWuT4T2rTUS33F7n6q
        XHFHexp9DeQs0nK222i5ND3s7PA3kVEMZq8HNrYIYKWoPRRVdzleJBZlzPIJgynx
        9lQlNeNp4bV2ND9OOkMcsoN9C2ZKLjUYOOMC8XBTErt8ofG3/DQG9ZClExOy2jRG
        PcVoIDAvSeHCWqsHCRdGp6d7bPvSmMTqhjWsGnqqR0E8N/J1Zx7y617FPLUImR6h
        vt293NCnps/TY4gMxNuR4d6j4IE2c9LWPjuhpjA8s136sa+i+e0+f4YyGAWrXGty
        qp7Tx7ovldoxBGZTiEN+kVlYbb/A66nMuPJKsBN9K4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=EMlZBo
        15epeEdVjKu5nXc3zhaksPLbuojCDzDSKauhc=; b=S0aG4V4Ttx2iboTB84z+Qk
        rPBcyuX74KZPKeB8akRNaQbKeSUcKrPmZt1JI+IY4r6Wee7ttUVvmhljdzBFTag3
        +Nc/BnamdgFPvmg5ICJAWOpWEZ9bNWC8BMWtV4eqamRDEv8Sgyx56Pu7OPPdy5l6
        aCtzktK9FiH67N2sblZ/19CHSWcK972pf291mznvK02sOUELJ3XD9U4IeMhsfBT2
        HX/KHn/whI34h9pg4EIpYOB7MvX5UQ2YfmXdcU8+aWf7AzYhfzjWi9+ssR9/VS6u
        vd/ZHAob/vR9KX17xkdZ+xq1cpNJGyVQbZXgyrCmzqTGwpeXUhU2MVLAxjFS4PBA
        ==
X-ME-Sender: <xms:yTqNX-cqtwIHTbGfPUFl7TEkveLK8FXQBKfa-mePJHiMKg3dMpJmBw>
    <xme:yTqNX4Pqct-PJ6r-mDFWPZWopx3H1ztG64VazfANd_CDLEs71Mqtz4s052vCY26BU
    tI9LTg9rIDUCcIfOu8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedtgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:yTqNX_jjwyTB9cmAPjm6YYEHWRjgVLf1f5tioFUgBObHpyCpm4G90Q>
    <xmx:yTqNX79MvCNBtrT4ybXiYm4B-ahC07KmJRsdRMO0iJaHWgzVw19_VA>
    <xmx:yTqNX6sLeAKjJZOOSie0enk7n8ruV7nu4K936cte2dSZ9ZKkKXLjuQ>
    <xmx:yjqNX-LelQ6K03fZPfyQjFspX5PBVBSEXqWhhWTj5UASO6x_lJN_Ng>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 287113280059;
        Mon, 19 Oct 2020 03:05:45 -0400 (EDT)
Date:   Mon, 19 Oct 2020 09:05:41 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Alexander Kochetkov <al.kochet@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-sun6i: enable autosuspend feature
Message-ID: <20201019070541.qy3v2r3sg5itdhds@gilmour.lan>
References: <20201016083826.31427-1-al.kochet@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zqg3emlloxikctnv"
Content-Disposition: inline
In-Reply-To: <20201016083826.31427-1-al.kochet@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--zqg3emlloxikctnv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 16, 2020 at 11:38:26AM +0300, Alexander Kochetkov wrote:
> If SPI is used for periodic polling any sensor, significant delays
> sometimes appear. Switching on module clocks during resume lead to delays.
> Enabling autosuspend mode causes the controller to not suspend between
> SPI transfers and the delays disappear.
>=20
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  drivers/spi/spi-sun6i.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 38e5b8af7da6..4cc0280e934c 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -22,6 +22,8 @@
> =20
>  #include <linux/spi/spi.h>
> =20
> +#define SUN6I_AUTOSUSPEND_TIMEOUT	2000
> +
>  #define SUN6I_FIFO_DEPTH		128
>  #define SUN8I_FIFO_DEPTH		64
> =20
> @@ -639,9 +641,10 @@ static int sun6i_spi_probe(struct platform_device *p=
dev)
>  		goto err_free_dma_rx;
>  	}
> =20
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, SUN6I_AUTOSUSPEND_TIMEOUT);
> +	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_idle(&pdev->dev);

You should also mention why pm_runtime_idle isn't useful anymore in your
commit log.

Thanks!
Maxime

--zqg3emlloxikctnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX406jQAKCRDj7w1vZxhR
xQZMAP9MvzwkJ7KYvidr8Tqy6Uun4yiI03CcELJ3laGSQezVEwD/diF7Gju+JH4x
NZedwB1YqwnhUGqHXmb8Mf8hYxkjMgY=
=bZcy
-----END PGP SIGNATURE-----

--zqg3emlloxikctnv--
