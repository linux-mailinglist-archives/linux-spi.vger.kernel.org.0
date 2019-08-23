Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B55A69ADB2
	for <lists+linux-spi@lfdr.de>; Fri, 23 Aug 2019 12:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbfHWK4w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Aug 2019 06:56:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46980 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731756AbfHWK4w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Aug 2019 06:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=koiWObzq5rTKtpZczJCbXwdbVcOOLP/YJmcfb1IFvJg=; b=G/YbZ2CAkQ86wEx4LmYJ+yV3W
        XyHFenI917EjqhYjceApNe4nnZfkQWCd28y1DCC6+HCc7JkibNaHrxNW8X6Ri8bn3o137XoVq92kt
        JrWsEVTXUpTQpjx8gjBjZIRgwAvnl4i0iUprflZsVmcYlOKkTvxFdYGaKW+ssAQcsSyKw=;
Received: from [92.54.175.117] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i17FS-0002vG-5l; Fri, 23 Aug 2019 10:56:50 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id CEF79D02BF1; Fri, 23 Aug 2019 11:56:49 +0100 (BST)
Date:   Fri, 23 Aug 2019 11:56:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix shared IRQ behavior in spi-fsl-dspi
Message-ID: <20190823105649.GP23391@sirena.co.uk>
References: <20190822212450.21420-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OGLMwEELQbPC02lM"
Content-Disposition: inline
In-Reply-To: <20190822212450.21420-1-olteanv@gmail.com>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--OGLMwEELQbPC02lM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2019 at 12:24:49AM +0300, Vladimir Oltean wrote:
> This patch is taken out of the "Poll mode for NXP DSPI driver" series
> and respun against the "for-4.20" branch.
> $(git describe --tags 13aed2392741) shows:
> v4.20-rc1-18-g13aed2392741

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--OGLMwEELQbPC02lM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1fxnEACgkQJNaLcl1U
h9ASIQf/SKt+WpRN4Gf/NlepPXBNfqGFEvuWS2se0FwyKunIaQlk4lzGfX1kEI/4
N+RMdtnCKkjtIcByafumflx4xoBo3AXOh1PV5eVN2wdsBHu1sep+dgNKh5UYVFTs
x9W6ghQaxtkFSecDC1bmvY+m8q2hWnDC3Q0AjbLlqaM7yPh70sXh7SR2fRnekKCE
stJavztU7SumHzpVenm+8zOw+6SPLe6wjUk7KK6tGzMHGLrtwWJnGMtCuBnwfhQU
W9NigLpkbj+DgajGbqz7uG8cqIHmVN8/UECeHXmMdsm2LN+oq138TGLQLGBRFTkD
91hT+SbfV96ycUSDNHYPi4BrH+JHlg==
=XdkG
-----END PGP SIGNATURE-----

--OGLMwEELQbPC02lM--
