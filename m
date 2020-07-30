Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8827C233075
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jul 2020 12:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgG3Kia (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jul 2020 06:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgG3Ki3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Jul 2020 06:38:29 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79B022070B;
        Thu, 30 Jul 2020 10:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596105509;
        bh=dXQ9ihMdkHvfu1PcJITpnX9vykBOmHZSayNp1ynNHy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUTR/WwRNu73BB65XaKIYDkZwwKLfAlKiDG/VH4zYUF9VGpUXWOWjHun77Sazfop5
         yz0lbRmYJ6SBNOwWVcf6jg/Va8Ki9mwpqRPThBSq78bKS7DPXD806UaeMCEq1PvGNz
         hfUqrkyO1MX4HAsmbP03JVB8V8UoBH8WEQR3CsjQ=
Date:   Thu, 30 Jul 2020 11:38:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Anatolij Gustschin <agust@denx.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] spi: mpc512x-psc: Use the framework .set_cs()
Message-ID: <20200730103807.GA5055@sirena.org.uk>
References: <20200729214817.478834-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20200729214817.478834-1-linus.walleij@linaro.org>
X-Cookie: Alex Haley was adopted!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 29, 2020 at 11:48:16PM +0200, Linus Walleij wrote:
> The mpc512x-psc is rolling its own chip select control code,
> but the SPI master framework can handle this. It was also
> evaluating the CS status for each transfer but the CS change
> should be per-message not per-transfer.

No, CS change is per transfer.

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8iow4ACgkQJNaLcl1U
h9DWuAgAgd2C5DIzzn3dKPPJcOg9K9pwXeaptO1AIIevbzXGKMVrDgKzRBr+FbpF
yFI9yqIHRNP4COuGPz5Q9ICROPtwGulExgXQqQfaJ0q9VTQO6FTQTSafk7DI99hw
/45tALRrBPr2+vvdJr3XZi9MH7g6r3clwTuLC5ial7WqMAz8VfCYOqPKvTvLX/G+
1ydtp4FORQnYWRNQqdbnLAgVTLYOUbAFVnujDQQSm6yt1Gbttdrt8v1gJezYFLfJ
ORSJmj3G3P8BLwazI3UsZlpjX7Z85UtQLkDnaTHB7jIR/ibITXZfJR9uADE6QtzN
G5Pz9AmMWnmkf85o7GbLYtGiIeFiuw==
=ZiR0
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
