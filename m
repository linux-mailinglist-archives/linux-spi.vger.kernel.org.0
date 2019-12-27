Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF44912B008
	for <lists+linux-spi@lfdr.de>; Fri, 27 Dec 2019 01:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfL0AuX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Dec 2019 19:50:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56818 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfL0AuW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Dec 2019 19:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CWy9VCP1vErua8bPZgko+C970Y+v4sZZxp7RAdofIY4=; b=TVYBNHWsEnQadbfZ4JBXCr6je
        kCKhOeUZsGbKao/e26sbcLUZd/RKoiVlBftlvncXQmWip2Iw7V6ExZ3NshW3wBmlL+GNZH+ZR3x1H
        wpCNs1ZjN7g0Fkjfabk854iSHb3JnriTvlsJuVPPzxfQwC3uIEaYCpImoC2ULVIKO/hdc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ikdpc-00048D-Fh; Fri, 27 Dec 2019 00:50:20 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id C62B4D01A24; Fri, 27 Dec 2019 00:50:19 +0000 (GMT)
Date:   Fri, 27 Dec 2019 00:50:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "wuxu.wu" <wuxu.wu@huawei.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com
Subject: Re: [PATCH]    spi: spi-dw: Add lock protect dw_spi rx/tx to
 prevent concurrent calls
Message-ID: <20191227005019.GI27497@sirena.org.uk>
References: <1576900099-40754-1-git-send-email-wuxu.wu@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ev7mvGV+3JQuI2Eo"
Content-Disposition: inline
In-Reply-To: <1576900099-40754-1-git-send-email-wuxu.wu@huawei.com>
X-Cookie: I have many CHARTS and DIAGRAMS..
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2019 at 11:48:19AM +0800, wuxu.wu wrote:
> 	dw_spi_irq()nd dw_spi_transfer_one concurrent calls.
>=20
> 	I find a panic in dw_writer(): txw =3D *(u8 *)(dws->tx);

Please fix the indentation of your commit log, it's indented by a
tab - look at other patches people are posting for examples...

> 	[ 1025.321302] Call trace:
> 	[ 1025.321309]  machine_kexec+0x58/0x3e8
> 	[ 1025.321319]  __crash_kexec+0x98/0x148

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

> 	[ 1025.321365]  dw_spi_irq+0x48/0x70
> 	[ 1025.321377]  __handle_irq_event_percpu+0x74/0x278
>=20
> Signed-off-by: wuxu.wu <wuxu.wu@huawei.com>
> ---

The Signed-off-by here has the right indenttion for the
changelog.

>  static void dw_writer(struct dw_spi *dws)
>  {
> -	u32 max =3D tx_max(dws);
> +	u32 max
>  	u16 txw =3D 0;
> +	unsigned long flags;
> =20
> +	spin_lock_irqsave(&dws->buf_lock, flags);

We shouldn't use spin_lock_irqsave() here since this is called
=66rom interrupt context by interrupt_transfer() - we should use
plain old spin_lock() here.  Otherwise the code change looks
good, well spotted!

--ev7mvGV+3JQuI2Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4FVUoACgkQJNaLcl1U
h9CceQf9GaikZTXYD0rg68bF6w6UrTSEJ1u5MP/k9IMNIFuqUSlQ3ioVg8kBobkq
Jo30DM3KNwXISBvtCS/KZxBvWjRjcI9A7Q1iLMmPNdGlF9/EumeuFFp0BJr/P1cF
X7ICunNMD+/Qg4hKNnu2hn9+cZZsddmhnlfu407nYSJnxjbAYtIIXmtis+k34ZF+
VKZiKqqq6BK3QwfZaf1FjvIl36m2r1FEGab8p3oKU+MdY0i/dXLeyPe7tMSGvo50
Yln0Tv3oxHQQLKnwn717sDdL9gvC/nw41zJefziOTg9JXiFpZqWSvCey75ysEhjL
wKXR1p488/0AmcNHuWw6kLbwpcksEA==
=YLiK
-----END PGP SIGNATURE-----

--ev7mvGV+3JQuI2Eo--
