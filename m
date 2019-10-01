Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE5DAC32FF
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 13:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfJALlZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 07:41:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41432 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387681AbfJALlT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 07:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y1E3R8dLROwbz+u7OaMfdoIIhxQX9FooeMJGxRhUgSc=; b=xwRDywKyS94HRdedy8s646tUp
        27khmRCQ2coohEPGb5rQxVNMszzyodgQm8jAM01Z7xkR1ljJVRJ3hNnHnP/INxE7b3OiGvMpH2ZnK
        O/oEznclYQx5CkNUgSfBSXElIZxFphEfBZ6eyiLPl9DW/NENZnQfGAw0nHL9XhDuqf+ac=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWi-0004Zb-UE; Tue, 01 Oct 2019 11:41:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 62C2E2742A31; Tue,  1 Oct 2019 12:41:08 +0100 (BST)
Date:   Tue, 1 Oct 2019 12:41:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lukasz Majewski <lukma@denx.de>,
        Colin Ian King <colin.king@canonical.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] spi: Avoid calling spi_slave_abort() with kfreed spidev
Message-ID: <20191001114108.GA4786@sirena.co.uk>
References: <20191001090657.25721-1-lukma@denx.de>
 <CAMuHMdWHTaPkzTdzz-j1rFeT=aAEG+J46fgKiPYrXoAR_DTvtQ@mail.gmail.com>
 <20191001113420.032dbfef@jawa>
 <CAMuHMdWh7xPZqp4J1qG22dXk_g=Q1WtQ9Xu-r3wiFOL3kW+WBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWh7xPZqp4J1qG22dXk_g=Q1WtQ9Xu-r3wiFOL3kW+WBg@mail.gmail.com>
X-Cookie: Keep refrigerated.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2019 at 12:00:07PM +0200, Geert Uytterhoeven wrote:
> On Tue, Oct 1, 2019 at 11:34 AM Lukasz Majewski <lukma@denx.de> wrote:
> > > On Tue, Oct 1, 2019 at 11:07 AM Lukasz Majewski <lukma@denx.de> wrote:

> > The if (!dofree) prevents from calling spi_slave_abort() when
> > spidev->spi == NULL and spidev is kfree'd.

> If spidev->users != 0, the block checking spidev->spi == NULL is never
> executed, and spi_slave_abort() will be called.

> I'm wondering if spidev->spi can be NULL if spidev->users is still positive.

It *shouldn't* be.  I think we have other problems if it is.

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2TO1MACgkQJNaLcl1U
h9Co+gf9EMfuNyB92VOoFo9okqWdMzDPwyTkYJyk6HSgVicME9grYfHDe81a7GjJ
9Dph4fdIVAcDkIFL/MbVPi3hsJCKFy+8QV1htiKYl32T9J3fKWROCKUD67c+PDwb
6LV+0EZCb5He4bdw3/CbrMsLhDTMedQL0/smyCNVcfj9WNeRBX64tv+48sE6lCaZ
bIGvhUppBJfIjDUU9hmKBweOp7XdMvGQE8SZmhruhgVEl/XICBkL73hYrHyW0QnJ
6FTJmaYLaW8nTDsk9XEiCM/AV8yC+hGdQhlEg4VxiGJ+1sm3QfXvyqYVQo7umAkV
hNXIGjDoZ61XFt7E/0SnzKLru/taCg==
=mQ+T
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
