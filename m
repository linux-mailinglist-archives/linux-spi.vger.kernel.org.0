Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23E1F5965
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jun 2020 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgFJQtc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 12:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgFJQtb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jun 2020 12:49:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB2C206F4;
        Wed, 10 Jun 2020 16:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591807770;
        bh=uL84iTpjcJrG49BW1qpvg+ceYzvNWcuI+EjpSNUrXtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8xkfdIgBPkyqakPBMHpmV4MHBmZijBh0k0Idbd2dWb0oW+bJ0Z4h3uPY8S7Tgxaf
         E/80A/fJ4lmfVN43LkuA+h4k/4DiYQg6MlKgskOCiooP9v0myHwMpWRyFAx5+x2ha6
         N55T17siJuAHSdEbNMRu/CAG+t9I2DC/f5vAYQsk=
Date:   Wed, 10 Jun 2020 17:49:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: renesas,sh-msiof: Add r8a7742
 support
Message-ID: <20200610164928.GJ5005@sirena.org.uk>
References: <1591736054-568-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1591736054-568-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200610110810.GD5005@sirena.org.uk>
 <CAMuHMdWCHeSB9mjpdSX_-qxwo33kMb1_1R93CjBtVBPFPKkEOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qD3brAgIG4LbUq6d"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWCHeSB9mjpdSX_-qxwo33kMb1_1R93CjBtVBPFPKkEOg@mail.gmail.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qD3brAgIG4LbUq6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2020 at 01:59:24PM +0200, Geert Uytterhoeven wrote:
> On Wed, Jun 10, 2020 at 1:08 PM Mark Brown <broonie@kernel.org> wrote:

> > To repeat my previous feedback I'd expect a driver update as well.

> No driver update is needed.

> Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml says:

I'm much more comfortable explicitly listing the new compatible so that
even if someone makes a DT that doesn't bother listing the fallbacks
things will work.

--qD3brAgIG4LbUq6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7hDxcACgkQJNaLcl1U
h9DqzQf+L8N8+1ylxe1pYlV1c//i1CYnyH3GkElfL95nGobYBGb9VLgA4MOcj/0b
TqbGACtoQm8BL+EE8XzQ3Mj+ohmTisI9JKRHsYoi78Tm8L+dl3pLiPt9Wc30li+K
nrKA8BHndOoVpRK2SMNgUE+rcU+sImZLTLjfEnZUUGGx7sDJmfFXRHdP2pZb/BEh
CCN3m+F74/XdRlf8USEa6B4cAN3sfhitr4Tx/hbQ3e8BS7FAhEjp+fP8x+Eji1WW
xLFk3/DweH05qA6nU0Tm6aHfUyzRaCLbn0LQAgJRBISTdAEc2NGiRXuCZckMFsWJ
Qguh+qafyIRn22PAoLP8jFAiYNlHbA==
=02N9
-----END PGP SIGNATURE-----

--qD3brAgIG4LbUq6d--
