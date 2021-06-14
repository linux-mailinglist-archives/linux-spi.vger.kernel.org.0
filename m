Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D033A601B
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jun 2021 12:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhFNKbi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Jun 2021 06:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232908AbhFNKbW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Jun 2021 06:31:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9DE5611CA;
        Mon, 14 Jun 2021 10:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623666560;
        bh=lSeXCd4lcJ0tTuMRN1HC4nFi6fATD6bu2jRIYot55WM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ko+f3laW2JB91Bc8p/Oxg7X5WOwVgspcCNOv3A/lGSGEFNFS0RZvmjPLuYLC37Zcy
         FF9Dek5SERjFhw7J0R/SYulTkkNhuB7AHoVw8oRuFfOJ0s+PaQQxGisqrDS7gpFPCR
         QvF8Bnzkm1llBwn7Wbiv9RAO9utRIAeIzYZKupieuN3qykkxjbQpnJjoh+0Yf3Dhw0
         oPNCkTTmURuV3paBgSq0WXDOYnyO6zJw4pbcZv1nbBQobOKVXsq+iwcV4kTxpobuJr
         P6oy/IKGBLvjmeECmOOFzOTa+jUm0VQFR6flZtRyTXMmmfxYQia41zd08i/CPRLS4W
         LB+/BYqXHoPBQ==
Date:   Mon, 14 Jun 2021 11:29:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mason Zhang <mason.zhang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        hanks.chen@mediatek.com, linux-kernel@vger.kernel.org,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-binding: mediatek: mt6779: update spi document
Message-ID: <20210614102902.GA5646@sirena.org.uk>
References: <1623413625.22727.10.camel@mbjsdccf07>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <1623413625.22727.10.camel@mbjsdccf07>
X-Cookie: Some restrictions may apply.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 11, 2021 at 08:13:45PM +0800, Mason Zhang wrote:

> 	I'm sorry to disturb you, this patch is stay here for a long time, Do
> you have any suggestions about this patch?=20
> 	We hope this patch will be merged as soon as possible,If you have any
> concern, I will fix it in time.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDHL20ACgkQJNaLcl1U
h9CsAQf+Nn4HRlnSP3tQV0DnMF2cdXi1Iq99YwPbLlaUcaR573n/pt3ERW1fG+RQ
Buc3s5ft40NrHag2fnlP1plJY3hlhBvcjyyPvK+JhJanfYd0YmiOAuMAssVASA0E
QDPO76npJtv1EJ+Y5ZmNec2Xyt9kpbbHVZrk/kQ1Uv01p/a/wXRLNN55ZYmeQ2kQ
xFObSTgbJEEZtl/WXK5A7EDT7kfUSQO2kQIwHDI2AmiCOtE0WbqEYALgdd0ijAx9
IAvq6Cte2W8E5S6bWtyJ/0wL7VFdyI+e8fIuhoaNK56cttomrsfDy/maEDQIRukA
Vj8gFPHEmIY2r4tRjLbrBcwg1baueQ==
=nGK1
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
