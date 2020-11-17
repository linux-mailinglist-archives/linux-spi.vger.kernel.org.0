Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE932B5F29
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 13:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgKQMcw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Nov 2020 07:32:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgKQMcw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Nov 2020 07:32:52 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F892222A;
        Tue, 17 Nov 2020 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605616371;
        bh=izxyFjKIFW3pt9KHyWgEE42Domo8XJ3vnnCgfHrj7Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDhrcGkvx9tuADQ/u0cjcW7U3r4ZKfOIlJ5pjB2fOl/A8vyimz+ip9m0Fs7r/SME5
         hJsuGLGrRLgUupkXWUfWP9y8UFT3GeKcMwrlpxyWhId2GU09tJzItBGD7DwnhIzS3Y
         C6HWj2BNYvfa+XFGySPlSMrFYVZcUwyfAIhKPtxk=
Date:   Tue, 17 Nov 2020 12:32:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH for-5.10] spi: spi-mtk-nor: Don't leak SPI master in
 probe error path
Message-ID: <20201117123231.GB5142@sirena.org.uk>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <a203c24658b7d70ddb27bf1f9898fe6f896fead5.1605512876.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <a203c24658b7d70ddb27bf1f9898fe6f896fead5.1605512876.git.lukas@wunner.de>
X-Cookie: Pause for storage relocation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2020 at 09:23:08AM +0100, Lukas Wunner wrote:
> If the call to devm_spi_register_controller() fails on probe of the
> MediaTek SPI NOR driver, the spi_controller struct is erroneously not
> freed.

Please don't thread things that aren't threads, this breaks tooling that
attempts to understand what you're doing - for example b4 thinks every
patch in this series is a new revision of a single patch.  Just send
separate patches with no interdependencies seperately. =20

Please also try to avoid noise like the for-5.10 in the subject line.

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+zwt8ACgkQJNaLcl1U
h9DWLQf+M5rfFeQpGNxzyBzjh0nj2tjLBAh/+tqyvhWARaHZFBckTU4/sr1YxQTm
Kh/gx6otNnB7ITsdviNvHiBs/w2wCmwqnStxDza0aeH0Yi4Ejs8SF41Tb3AGjIte
SzPg5pLBQMUj5AUKJWhqMkzxYZ1bo+sdKJHq3OzxU3X7rrImSCLqPXEQdTtG/azH
gJbBKH8ClF5qHenX+iN9mQNXkaMHdcHP7Aj70ndBORKuv7Z0/sdLpy9vAcIF93Aq
0Gv08j7zNDWHT1C//FoQOlfi7Lk4WtpEyzCoUBWBpq2Me6f2YdowV+3aDn2MvU9+
qRPbNtGA2Ag70AbcrvpK+k/EVRqdkg==
=8iZC
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
