Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB3417443
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 10:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfEHIy6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 04:54:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33426 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfEHIy6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 04:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vGicS9ee7VFI1RMg56juBK5dAe3X/Jb33WVAH1KqMHo=; b=LA3vZV4u2NvdKxD0xAev/4o+w
        wFOFlOoX628tNmGsdo1eJS7fCB7QtMASSea7glsUB3GZjFP7u8yIMeDa4Mw+At/v5C7hs9yCrR7vM
        YAdJ0f68Jp1DJJjT5QLuYWtelIw0Kj3cqB4LOLeLWcPdrbAy5jkDvF/6QoMGYlA7+lrPI=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOILm-0007cN-Is; Wed, 08 May 2019 08:54:55 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id E307644000C; Wed,  8 May 2019 09:54:47 +0100 (BST)
Date:   Wed, 8 May 2019 17:54:47 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 2/2] spi: fsl: Convert to use CS GPIO descriptors
Message-ID: <20190508085447.GA16289@sirena.org.uk>
References: <20190420111404.6225-1-linus.walleij@linaro.org>
 <20190420111404.6225-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20190420111404.6225-2-linus.walleij@linaro.org>
X-Cookie: May I ask a question?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 20, 2019 at 01:14:04PM +0200, Linus Walleij wrote:
> This converts the Freescale SPI master driver to use GPIO
> descriptors for chip select handling.

This doesn't apply against current code, please check and resend.

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSmVcACgkQJNaLcl1U
h9Dp1gf9ExPU4QvvF3QLRyGyTa+cc6xJmV+JwH29Yhc6XXBEP8xUGNX8T+m9E/J+
7+7wo9gurseCS4q28fEQMcOT2+XCUPAa+lQOp4i1WkbBj0fuCLSHDNcGOvH1+U70
aV5H612NvqoTEK+kaBMyualUcYstEqjW58hDl0VMHmdqnpVWau0mkFuxpCmSTJ38
An/qzi14RSceCH/pQBQw9bQMUUarpGnt8oKWRSlooS/t1XD1Zm9ymx8etHOHcEZS
7iSDCSs03UrfTokCkATGSOBfJbsgrprJ/neJZupl5PqOSLytMhyuXJXNtEnDfwR7
rM4hlweh9nzSfIZe5Jo5uEiix/nd+Q==
=+rBZ
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
