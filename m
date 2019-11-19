Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5879D102B9A
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2019 19:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfKSSTd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Nov 2019 13:19:33 -0500
Received: from foss.arm.com ([217.140.110.172]:56552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfKSSTd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 19 Nov 2019 13:19:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8C891FB;
        Tue, 19 Nov 2019 10:19:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3585B3F703;
        Tue, 19 Nov 2019 10:19:32 -0800 (PST)
Date:   Tue, 19 Nov 2019 18:19:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Luhua Xu <luhua.xu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Leilk Liu <leilk.liu@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: mediatek: add cs timing configuration support
Message-ID: <20191119181930.GF3634@sirena.org.uk>
Mail-Followup-To: Luhua Xu <luhua.xu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Leilk Liu <leilk.liu@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1574053037-26721-1-git-send-email-luhua.xu@mediatek.com>
 <1574053037-26721-3-git-send-email-luhua.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Content-Disposition: inline
In-Reply-To: <1574053037-26721-3-git-send-email-luhua.xu@mediatek.com>
X-Cookie: Beam me up, Scotty!  It ate my phaser!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 18, 2019 at 12:57:17PM +0800, Luhua Xu wrote:
> Add configure SPI CS setup/hold/idle delays in terms
> of clk count support, and use one period of current
> spi speed as default if setup/hold/idle not indicated.

We have added a generic way to specify delays like this via the
set_cs_timing() operation and related fields in the spi_device struct
which operate in terms of spi_delay - Alexandru Ardelean added them
recently.  This supports both times and clock cycles as units so should
fit with what your hardware can do, the interface is new though so there
may be soem rough edges to worry about.

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3UMjEACgkQJNaLcl1U
h9DuYQf/Sh6DLOmgyjnIubrb27dh7rENm3ubM+wQws2RYtpLpn81Y+QeCeuFmG+5
qab+os+aGjg82VyLmLMU07NqDkCLfu4JVFUudK3M5ZLCZcQQ0VPhQ2CUSya+gSkr
cDrncou8L/Q7E1HlRwY+b3/S1qLxrMGYA5JkaivmCTC/RRhtUDb+6JORzIpVER15
XrgH6cJM79jkEfUWoz5AQITORtrebZnKDsYDxWzbcjLE0SleAK8AJ55zPf1QNzMz
qX3dpdyEDPfMWEiCitAOHRNzwpVdBKwOCN5vXJdbPXRJN7DhkDwWigDSaz+9uL0m
f8lMvtoliW5cyEX0Q/O+WEvR9vdvjA==
=vdlB
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
