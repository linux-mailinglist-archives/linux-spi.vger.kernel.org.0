Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD9112AFE7
	for <lists+linux-spi@lfdr.de>; Fri, 27 Dec 2019 01:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfL0AWr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Dec 2019 19:22:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38700 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfL0AWr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Dec 2019 19:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bc6LEosmx9+Mj/PeBa3ik/jNiTjPpwv/bIYcruuOEhc=; b=DLyqD8tlmKFmsPSUBIbc/bdBJ
        Sn6OY2G1XGtGYawxyaAlhChpvTRyCIyLw9CGFcvrq81NRvEZWiNRL7x61KQBe+nXtqyczFRyjrQ9g
        xlyyLoKdGr5rD4Yd3gTnovJOsv37dFuZ5x4kbuBkKSFEQSWLWNyN9aofXKzuRp5f1EWTs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ikdOq-00044p-H6; Fri, 27 Dec 2019 00:22:40 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 08104D01A24; Fri, 27 Dec 2019 00:22:40 +0000 (GMT)
Date:   Fri, 27 Dec 2019 00:22:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, fengsheng <fengsheng5@huawei.com>
Subject: Re: [PATCH] spi: dw: use "smp_mb()" to avoid sending spi data error
Message-ID: <20191227002239.GH27497@sirena.org.uk>
References: <1577352088-35856-1-git-send-email-kong.kongxinwei@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U3BNvdZEnlJXqmh+"
Content-Disposition: inline
In-Reply-To: <1577352088-35856-1-git-send-email-kong.kongxinwei@hisilicon.com>
X-Cookie: I have many CHARTS and DIAGRAMS..
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2019 at 05:21:28PM +0800, Xinwei Kong wrote:
> this patch will add memory barrier to ensure this "struct dw_spi *dws"
> to complete data setting before enabling this SPI hardware interrupt.
> eg:
> it will fix to this following low possibility error in testing environment
> which using SPI control to connect TPM Modules

> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -288,6 +288,8 @@ static int dw_spi_transfer_one(struct spi_controller =
*master,
>  	dws->rx_end =3D dws->rx + transfer->len;
>  	dws->len =3D transfer->len;
> =20
> +	smp_mb();
> +
>  	spi_enable_chip(dws, 0);

I'd be much more comfortable here if I understood what this was
supposed to be syncing - what exactly gets flushed here and why
is a memory barrier enough to ensure it's synced?  A comment in
the code would be especially good so anyone modifying the code
understands this in future.

--U3BNvdZEnlJXqmh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4FTs8ACgkQJNaLcl1U
h9C/WQf+LWz7dH90awV46vXCMPAFHsxgAk2e4Cef1PIjV2AqD5tpjkaJCKTPaO9r
RZG3L+gFrMzq2VUYQoeENjQqFg1wJsK+yaU/1jPCsdypAX2rb1shLZAClxic0uDG
JjtToZii33DOzReaNdi0pH3yGkGgekgDWwfQkC/QCpUt/jHsSSI0qpEOHYhsOy8h
ig9uUTFMMXqV2zNqwfjwu/JFFieJS0v8oVcx1MdYhPoSvUArIAoGq9VTekrRMzcm
VfSpwRNpVIvK3aiWlesqhkYPd8QGaAwCNBgM+8OO83mkORSQU+PQbvlCE62Tp4ND
ZWFeeiOPOwN9q9DP1SfDItYPTebcQg==
=ZE9Q
-----END PGP SIGNATURE-----

--U3BNvdZEnlJXqmh+--
