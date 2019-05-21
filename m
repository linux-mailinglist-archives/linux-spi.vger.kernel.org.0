Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0DB259AE
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 23:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfEUVIr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 17:08:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42096 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfEUVIq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 May 2019 17:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y7ibEasnNlMrg0Cg0u1uA8kjMpvwkTqXDxhIGJ97fKY=; b=fHihLTsTBRj8VjaQKfcECHqjH
        7QaAYGF0BGdUc3CQdB5hmMpvxPaU8ozn9e1eWwM9GVrWUlF8NH5Sr26Hwo0fxYOQ+nebRdpf2VUrZ
        x8CMS1QorssZj9YtUqQHVVsNebaHWlNgE0Eh8o87e4P89Jw5JOfi3mPbtF1Doevl4hAPQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTC03-0002FI-Um; Tue, 21 May 2019 21:08:43 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 643A11126D13; Tue, 21 May 2019 22:08:43 +0100 (BST)
Date:   Tue, 21 May 2019 22:08:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] spi: zynqmp: Fix build break
Message-ID: <20190521210843.GC1580@sirena.org.uk>
References: <2bb66114-c976-9c44-6db3-33a5dd12edde@monstr.eu>
 <20190429162246.6061-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <20190429162246.6061-1-olof@lixom.net>
X-Cookie: Klatu barada nikto.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 09:22:46AM -0700, Olof Johansson wrote:
> Missing include:
> drivers/spi/spi-zynqmp-gqspi.c:1025:13: error: implicit declaration of
>   function 'zynqmp_pm_get_eemi_ops'; did you mean
>   'zynqmp_process_dma_irq'? [-Werror=3Dimplicit-function-declaration]
>=20
> Fixes: 3d0313786470a ('drivers: Defer probe if firmware is not ready')

Please copy maintainers on patches so they aren't surprised when they
get mails saying they accepted patches they never heard of before!

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzkaNoACgkQJNaLcl1U
h9CBfwgAgbLrAnQDkYTUpP7MdSDSiv8ppwZ4R/EN9OCgQb6Cjms4xG6hrxkbloPA
+oUebvqpcjb2wzduZU8tdCKx2CSU/uGlqTxG55BLy+pyrGHmFDY3MBpWr0aAj8hi
XZGbyLoZWQYWTWorcXeC50RTLzX+fRTPx0A5KJzjXU8pjUmjnA+hjDeruCcW2JNN
Suy2LE8ivUVCFUAOHVhM0bVXIbteUPRu08p3XGd3aTsfzJRn35GWepyfhnzAKX1g
OwIBgEZFHVzQ0AZh4jm4c4YdkrF/vpawZdC+48BCVtfsdreTlVzBZ8OvKfC9j4jX
q0QdP42x5IWG+4mrek1zsa3JoYmsJA==
=tUfm
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
