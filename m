Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E862B32661B
	for <lists+linux-spi@lfdr.de>; Fri, 26 Feb 2021 18:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBZRIw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Feb 2021 12:08:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhBZRIv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 26 Feb 2021 12:08:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87A9C64DDA;
        Fri, 26 Feb 2021 17:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614359290;
        bh=O7HQZaD+330mzCO72LvNyaWULgPRvPutDbGS6HTDi4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/Tq2XjC4GHqIBFAvBbQKGSctV/+GN7gQISbg3f7dNKisJWTgKA6o5yx0ysLHZskq
         VMg16aEFaK9F0Os7j+80soT7H4PEo24Mi4dP9ds+1bRc8SR030Lz7xSFOOJPYIZbT3
         QY853T2SI79jO+OcEDYJe/FIN5eUD8V1aBWOI1aVeFxYKej+Pj4kbH8tP1hv2LUThr
         ic98vMloG/nvq4fu/whZz8qNS2pUEBURo5Gl4bdQmO6nsuUm1SHG+zpXmfj+7eMeV6
         3jZYOdp++xNDFtNKJ8SCYRLWhuy/UITR6CWq8T9pWRSe6hqRq/BMNUHo3G3oSRcmp/
         Swa10RkZAsyIQ==
Date:   Fri, 26 Feb 2021 17:07:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mason Zhang <Mason.Zhang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        hanks.chen@mediateka.com, wsd_upstream@mediatek.com
Subject: Re: [PATCH 2/2] dt-binding: mediatek: mt6779: update spi document
Message-ID: <20210226170705.GB4518@sirena.org.uk>
References: <20210226110109.30500-1-Mason.Zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <20210226110109.30500-1-Mason.Zhang@mediatek.com>
X-Cookie: Academicians care, that's who.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 26, 2021 at 07:01:10PM +0800, Mason Zhang wrote:
> this patch update spi document for MT6779 SOC.

I'm missing patch 1/2 here, what's the story with dependencies?

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA5KrkACgkQJNaLcl1U
h9CUygf+Ol0aJAihbCGE4oreYTsWpzbY2iMN3VMLFlwwYf7pwZ4PqvUMUh+VjlSU
kQ1lQGpmLumnZzLXu7ubr37mjzgeKZxEkOOPKr+phghVkj4I47uLh0v86bTJqc+X
XPA0yyFZSc/qgxFe6pqUntdP+Y0lG+AP9yK1TloS+XjA9Mm/GwF3tcJU9w7XPsHv
aoiTM1BT6fL8mS0eap09NtNSS3f8N+4F3ZHsbMgLruO8FdCwYIUrYTdLr5nku9ye
mR/4uyMBPFOD6PjiKcQzkr0Idqk3RTG4LgHXNLkdqubZy5X+gfStD2wI8P/VvgoE
TWm+JacwdHBtb1LfITBgCMs4scS8iQ==
=YVpM
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
