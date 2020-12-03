Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694872CD3B6
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 11:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388965AbgLCKdk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 05:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388608AbgLCKdi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 3 Dec 2020 05:33:38 -0500
Date:   Thu, 3 Dec 2020 10:32:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606991577;
        bh=43yNdax6pGHrO0BTp2xJ0YBAHuZmVV9Ah1L6cygJuMU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNUgwCHMYUgjhrvu5Ze9nx9Prvgbl95hJ+4WEeXVeuh9jqHmetJY9lgIg17dQDyFO
         J3XOiC68vEB9GfEGK8nUzLnbrroIZTiRqc+9tah/cO4DWnXm8wcmaaqjw8kBME2o+V
         PLQV9D0DSnG+3gAY1fBep5BABJ/Xqt1IYdftBO4/NjonpKhNEhZBq+KWyo5VX8XjeK
         9qdV2pHC3AJ3CiQtS9ebm+wMPONbSY1r/QQ0DzMB2yPIeumKROIrguVG/njTNK1AOk
         prOAiZlmlqds7QlSLaj4xO8OhfSB4IidcNklQLwIgmRIbde3e6x0rJKrBQuNKyp6Mc
         vqaDydV5/4g+w==
From:   Mark Brown <broonie@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v2 0/4] Porting ASPEED FMC/SPI memory controller driver
Message-ID: <20201203103227.GC4700@sirena.org.uk>
References: <20201103072202.24705-1-chin-ting_kuo@aspeedtech.com>
 <160683107674.35139.14509237313835347013.b4-ty@kernel.org>
 <CACPK8Xe4TcRVBnZL7vtqGq1PTe5NEx1k4hvk4FDeYgJQ9HALFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
In-Reply-To: <CACPK8Xe4TcRVBnZL7vtqGq1PTe5NEx1k4hvk4FDeYgJQ9HALFg@mail.gmail.com>
X-Cookie: Sacred cows make great hamburgers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2020 at 09:19:47PM +0000, Joel Stanley wrote:
> On Tue, 1 Dec 2020 at 13:58, Mark Brown <broonie@kernel.org> wrote:

> > Applied to
> >
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

> Really? Or is there a bug in one of your scripts :)

Not my scripts, b4!

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/IvrsACgkQJNaLcl1U
h9CS2wf+JYv7MdfNnO9GFIy0AVuTJlRHvbhFYMX35CrKtG3bCDbrHP/9CgwE3NCP
dv5bms58wdNxCvRtu180AHxs2pVBIZKYFIgIIiNayARpwxqupKFr6qMTGHtx76bR
hu4n8ErziSlUzhfnTKsl9eB3DjKoYq5f6hyibKQvElzv72wjyeO21B/ME8x6CBiV
8UGAYjhXnuuu+ovTvKUCp6cTgPrPJ/PVu2rFB//hTj3BxxAhMgUve9Wye6o3TRpC
mQETkDnHgCPtrVHl0zqDK8LusqGDLf9hZ6FEM6DHC1HgMGizKlVaH2GceMJHFfd2
pOFCbLwEik6HfoDBjv3wd8NWY7uhiQ==
=7doF
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
