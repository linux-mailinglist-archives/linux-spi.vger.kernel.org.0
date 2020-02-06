Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25CFE15431A
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 12:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgBFLcC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 06:32:02 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57854 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgBFLcC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Feb 2020 06:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hrTSSwMgoFoMei/rf3tc5ugittY+LPAKG0LZTWUMR7g=; b=pd56uw8NC6/BFBMhBtaEJvydQ
        5Bio+S9nX8+kpyRLN2wNDHgl7u3HPW+9R/5Jf1cdAg6BJbvBpniTX+ea9eBx6+GZ3/Gk3MlDYkGmL
        D7HODD27TVSW6Hdt/3L3KkAq9zv/XW78yNcwqzlQubh/K3Xj+n/UgKQAKZOs2rq8knJWQ=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1izfO2-0001Um-CW; Thu, 06 Feb 2020 11:31:58 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 138DDD01D7F; Thu,  6 Feb 2020 11:31:58 +0000 (GMT)
Date:   Thu, 6 Feb 2020 11:31:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH resend 1/2] spi: add driver for ar934x spi controller
Message-ID: <20200206113158.GK3897@sirena.org.uk>
References: <20200206084443.209719-1-gch981213@gmail.com>
 <20200206084443.209719-2-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZuCi2HMIMuKavysU"
Content-Disposition: inline
In-Reply-To: <20200206084443.209719-2-gch981213@gmail.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ZuCi2HMIMuKavysU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2020 at 04:44:42PM +0800, Chuanhong Guo wrote:

This looks good, just a couple of comments below:

> --- /dev/null
> +++ b/drivers/spi/spi-ar934x.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SPI controller driver for Qualcomm Atheros AR934x/QCA95xx SoCs

Please make the entire comment block a C++ one so things look
more intentional.

> +static int ar934x_spi_transfer_one(struct spi_controller *master,
> +				   struct spi_message *m)
> +{
> +	struct ar934x_spi *sp = spi_controller_get_devdata(master);
> +	struct spi_transfer *t = NULL;

...

> +
> +	m->actual_length = 0;
> +	list_for_each_entry(t, &m->transfers, transfer_list) {

It looks like this could just be a transfer_one() operation
instead of transfer_one_message() (which is what this is in spite
of the name)?  There's nothing custom outside this loop that I
can see.

--ZuCi2HMIMuKavysU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl47+S0ACgkQJNaLcl1U
h9A2fQf/ZhyF5Pv32BHd7AWFpCiVV/G4v29FwEuOkbTrG3BmW2HxkCyTST0d68BN
8n/GcOWe+yTfE9lJdSUo1yWNsqX2vT0ELdqTZOsu2Jwor6fKUVbHEqmS7hxIBdyM
LtvvOQZQtCr1j4pIeW0iHEfpdhtsZOuZB9BeHG2BwDBnmfeWDWMyQ3JH9yY1YAry
Iuza2QcHqVU+1Y6beD5OCv0YAtUqNuqmKRYBpFFCbmh88/469Fg2lMwCThrtLq17
XvmVQm2nA36vLtBsix4ioL4WJTw+KMne9/G8U6tRaWh3AUwdnZM5N4XezHagYWx/
0oAHkWZVNxNokjlNLImALrBWyfphfQ==
=9gDh
-----END PGP SIGNATURE-----

--ZuCi2HMIMuKavysU--
