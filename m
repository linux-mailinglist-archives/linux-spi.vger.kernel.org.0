Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D8C14FCFB
	for <lists+linux-spi@lfdr.de>; Sun,  2 Feb 2020 13:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgBBMAq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 2 Feb 2020 07:00:46 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57124 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgBBMAq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 2 Feb 2020 07:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a1w13oJxUPKC3CMdf8ErDJElBc0RWvzN5lWluAFbUNY=; b=ugBAHtHBbKW1qIrpyCiB43g8o
        4Rrs5YqdfQKg+FeHmRx2xclTm/6Z19eKuY+Nq5c1BPEjK4Lk568FMjd3P4qU2En3SHF1hzb4B3Mmp
        1hGc84NRhn22btpqX+CyrGXhx5I988QFmfgZ//Fxfbs05t29RlpUQH/RAE/OPcWazN0G8=;
Received: from [151.216.144.116] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iyDvT-0006pn-J5; Sun, 02 Feb 2020 12:00:31 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id B8BFCD01AE4; Sat,  1 Feb 2020 11:34:47 +0000 (GMT)
Date:   Sat, 1 Feb 2020 11:34:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        chenxiang66@hisilicon.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tudor.ambarus@microchip.com, Linuxarm <linuxarm@huawei.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        liusimin4@huawei.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, fengsheng5@huawei.com
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Message-ID: <20200201113447.GU3897@sirena.org.uk>
References: <6dd45da9-9ccf-45f7-ed12-8f1406a0a56b@huawei.com>
 <20200113140627.GJ3897@sirena.org.uk>
 <CAHp75VfepiiVFLLmCwdBS0Z6tmR+XKBaOLg1qPPuz1McLjS=4Q@mail.gmail.com>
 <20200113142754.GL3897@sirena.org.uk>
 <20200113143403.GQ32742@smile.fi.intel.com>
 <0252a76d-7e2b-2c70-8b1b-0d041d972098@huawei.com>
 <CAHp75Ve=ZwJe2XV8Y1UN6sMe1ZHOBwUtRUD=aGqhR4Gc7BNUcg@mail.gmail.com>
 <136bd652-dcb9-3efa-a92f-2263cbf840ad@huawei.com>
 <CAHp75Vd=TY0tPfSHMSLTh1Pgg-E7MCP5Gym1yjpLgH0Tx-2xSg@mail.gmail.com>
 <c5cfb189-797e-11c4-f77a-61ec35395b15@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p+IlF8Xh9KY56wTg"
Content-Disposition: inline
In-Reply-To: <c5cfb189-797e-11c4-f77a-61ec35395b15@huawei.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--p+IlF8Xh9KY56wTg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2020 at 04:26:46PM +0000, John Garry wrote:
> On 31/01/2020 15:46, Andy Shevchenko wrote:

> > So, it seems I stand corrected, the field is in right use, although
> > cases like 0x10 and 0x20 should be carefully checked.

> > We may teach kernel to get something meaningful out of it.

> It seems that someone already had a go at that:
> https://lore.kernel.org/lkml/20170317212143.bogj6efzyvvf24yd@sirena.org.uk/

This is a discussion about supporting DT bindings for
bits-per-word which is a different thing again, that's the size
of a data word which is not connected with the physical wiring.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--p+IlF8Xh9KY56wTg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl41YlYACgkQJNaLcl1U
h9C2AAf+Lpm48M0VNHBo5p+A96lptZIvQ30jMdWzH4CZVehdGXJEwCKwJCK/KkL8
Reo2uQc859QdiYYCMzkwto9l7KvqHDkAeY5r32N30CBTeDKJWSXCrz3nNH/wdt0Z
V0yeI/zFW+8G0NVIyjXppXOeVZ7KJU+b+aDA6uMsqoSawagT+761zcAD57XQ+j4W
J6ZgwafT3ztFYNQAkvkgGp78J4hxIvVmSsig3wKbqS50DsbtqAi3pV9k59QVGIKM
gPKAj6olodQF2e4arzVHCOwoP/3xW6AggOSIJZLCFZrWMOYg9H7NUZz96zG/2b8B
ZjNQNzX4WUF05WtjTxvNQ/nASdbVvg==
=BpGX
-----END PGP SIGNATURE-----

--p+IlF8Xh9KY56wTg--
