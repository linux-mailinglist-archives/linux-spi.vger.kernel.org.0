Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3AF211E2E6
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2019 12:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfLMLll (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Dec 2019 06:41:41 -0500
Received: from foss.arm.com ([217.140.110.172]:56068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfLMLll (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Dec 2019 06:41:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA0301045;
        Fri, 13 Dec 2019 03:41:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2911E3F718;
        Fri, 13 Dec 2019 03:41:40 -0800 (PST)
Date:   Fri, 13 Dec 2019 11:41:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-spi@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: bcm2835: don't print error on clk_get() DEFER
Message-ID: <20191213114138.GB4644@sirena.org.uk>
References: <20191212231213.29061-1-jquinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20191212231213.29061-1-jquinlan@broadcom.com>
X-Cookie: Life exists for no known purpose.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2019 at 06:12:13PM -0500, Jim Quinlan wrote:
> Otherwise one may get multiple error messages for normal
> operation of a clock provider.

>  	if (IS_ERR(bs->clk)) {
>  		err = PTR_ERR(bs->clk);
> -		dev_err(&pdev->dev, "could not get clk: %d\n", err);
> +		if (err != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "could not get clk: %d\n", err);

On the other hand if the clock isn't there and never appears then there
won't be anything saying why the driver isn't loading which won't be
helpful when trying to figure out what's going on.

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3zePEACgkQJNaLcl1U
h9BHDQf+Kf+RYd7moLj8bCbIPnaZZ7Nsho3jFNQaB96HmWNc0rO3oRC2CHPcW7Az
EAw9GHh64sKQ+iLsXXIj5WhkBFfx0XsQ4uRSMCHwvpfnYaWw9a4ntAYr8Q6D7T5Y
RZQgixN7JobxgbUrL50FdhBJFz/Jjcc0a5N6xYrD8xNQDFlmnMtmqVpN9PBQlzp5
hdDU5eDqz0ncgiyJMsMUoEyoUtdjXJKWFcJtuEJ51bi/ken7MVU/m3CO806jkW9O
jk+OV2OMytB67pvLZyenL7pXLmkpP45Vpcb+elTkBBFiTDOsNsWkBxEhrQ1qxowF
Db335irZY42aFsjJkwvOx+C8Nc+qIA==
=EGVJ
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
