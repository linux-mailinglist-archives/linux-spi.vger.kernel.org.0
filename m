Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF91E3FB0
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 13:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbgE0LSf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 07:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387619AbgE0LSe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 May 2020 07:18:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9302A207CB;
        Wed, 27 May 2020 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590578314;
        bh=Eb5W1Mu4UnXinW4nhuzmv6KKdI/oP0r3mQb3N4LC+sU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XtBpaS+v/lpJ9RrOyaPoiNOws0yskW0gCFJwnq5/cqlLekMU3baEbiWM2aeapJ8di
         CklyM05gEwvP4Kf2SWN9Va00wb2otRuEMe7bisF3ZeRBm8TTQ0bikOri9+9fyDnkXP
         E7vBo27aAiaM9AkQWfLi96qnlVRBQMOK2vWz9Xfs=
Date:   Wed, 27 May 2020 12:18:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     dillon min <dillon.minfei@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, p.zabel@pengutronix.de,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        thierry.reding@gmail.com, Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Hua Dillon <dillonhua@gmail.com>
Subject: Re: [PATCH v6 8/9] spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX'
 support for stm32f4
Message-ID: <20200527111831.GC5308@sirena.org.uk>
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
 <1590564453-24499-9-git-send-email-dillon.minfei@gmail.com>
 <20200527095109.GA5308@sirena.org.uk>
 <CAL9mu0JA=XRTj_HONQGtj74X05TAV0__dW2At0AAeymwNvJhEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <CAL9mu0JA=XRTj_HONQGtj74X05TAV0__dW2At0AAeymwNvJhEw@mail.gmail.com>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2020 at 06:45:53PM +0800, dillon min wrote:

> sorry, forget to remove these two patch from this submits, will not
> include it in later submits
> which ack other's review result.

Ah, OK - no problem.

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7OTIcACgkQJNaLcl1U
h9CjnAf9EH3yOA2f087uyr/KGCDeTZDdKdksfcJ4a9wlCQWW1Cur92auEEnoA3Rt
OaZkMT9iqrDJqCSZ80c9Be1Ql4zXnjxCHU+qExkLFmDJcR448ywgqaYh9gluj6D3
xQnn0fxJcjgY+eixxAPqszazPIQm3iHZL0TsQo5DNBU7uDO/p+HytpUoYEntT7AT
bjn2mYE+1drgcxELR/TkQdRnV0jUiAtcpkGnI2tPO70MBQ6jcAwIAX4cBSnjwdhO
L9bXUB58NNMcuUWSj9+c8WyJn0zssre7UWLaYiX9g92/yJEPJNzGN2SFXiM1Jsks
PQH9axxSmBjKf8StOS7727u+sJ8H8Q==
=Ibfd
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
