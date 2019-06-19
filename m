Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E59504B7C5
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 14:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfFSMOp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 08:14:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51448 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfFSMOo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jun 2019 08:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k3P3++6GQiP2ImSaOTC4gPs5tYB1KrKrlADh55M4Y7c=; b=GLoxLkGT3DKYUTbegAR4dtLvl
        JAcOZ35M+taNnvlktiRr/9cbCSk4qpR/PmFqAoCqDXh//hiD5SZ/ynCIud2p0Hd/FMTUNsYa+qiIS
        NKWiVYV6bxLxxM2DoLQCNcZfdjWSFUQK/qNwEbUZxmd1Y41Khiv3C6QLu3DgXsKGS/4zU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdZUA-0007EJ-9X; Wed, 19 Jun 2019 12:14:42 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id D7BDC440046; Wed, 19 Jun 2019 13:14:41 +0100 (BST)
Date:   Wed, 19 Jun 2019 13:14:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/3] include: linux: spi: more helpers for declaring spi
 drivers
Message-ID: <20190619121441.GS5316@sirena.org.uk>
Mail-Followup-To: "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <1560796840-18207-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6s/G0Ait2f6IH9MX"
Content-Disposition: inline
In-Reply-To: <1560796840-18207-1-git-send-email-info@metux.net>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6s/G0Ait2f6IH9MX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2019 at 08:40:38PM +0200, Enrico Weigelt, metux IT consult wrote:

> +/* subsys_spi_driver() - Helper macro for drivers that don't do
> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces subsys_initcall() and module_exit()
> + */
> +#define subsys_spi_driver(__spi_driver) \

I'm not convinced we want to be encouraging anyone to be using
subsys_initcall() for SPI drivers in the first place - my guess would be
that with deferred probing none of that is needed anyway and the driver
could just use module_spi_driver().  Certainly if the drivers do
actually need subsys_initcall() I'd like to understand why before going
forward with something like this, and ideally we'd be able to remove the
need.

--6s/G0Ait2f6IH9MX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0KJzAACgkQJNaLcl1U
h9DeUQf+PgOAkyo4pT4LasAHcsQL8bXxE3hqloJcMpaFpRgnSp4/I5Pc/Jg04XCu
CI2k7QnDLDIcUq1FlrI+eVvb0SKhzeEkIfJyaL8dX1kRPea2n9WbP0ZF5GcnQQ2d
ZidAKFQNB7eSWEhgPUIvkNHIvGm7TUNST35PbhZCd+j4ACcErdrKhGpZPm2hmHRN
7T7nUtkLFL5YvCH8QqdPLUzg2Co6BFik3jiseCAIi1PH4+zIA9QPi3g47VDPQ6aF
nTUg51S5Y4aduklIOTW8G+D47tUTsjFiKb3g2ZqUz1wbgmJlyd6q48h4lR55gSj8
xJYmx5diMemXIks5Ksr1Ny2mhGsXqg==
=szr+
-----END PGP SIGNATURE-----

--6s/G0Ait2f6IH9MX--
