Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B551DD259
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 17:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgEUPvr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 11:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgEUPvq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 11:51:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E5C7206F6;
        Thu, 21 May 2020 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590076306;
        bh=mO0PzgDMdpQ32+Tp34GeQLw4brmQwyU7HhvPc3aXfRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yB9mC01ohdIgpEdwUtfCboqeKzlvDlz3L1WEsOyI/5TSYkGjP5dxxtcvEVObFbTdn
         ciBuprt1AS/qB1bOWmpGsXRwzfnorXUw/X9fOmqrqTFcAQxvK1wWKM7BwqVL70cmjx
         DBxceZD7Ojt4PP+Tlpj7ukfiuraFYVmV/3PM4kxw=
Date:   Thu, 21 May 2020 16:51:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Clement Leger <cleger@kalray.eu>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/16] spi: dw: Discard static DW DMA slave structures
Message-ID: <20200521155143.GE4770@sirena.org.uk>
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
 <20200521012206.14472-4-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VcOX-hZSxHqro_W2X=KzSShg1V=jAsxdz8L5TZpW0kBYA@mail.gmail.com>
 <20200521121228.aqplh6eftylnys3p@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
Content-Disposition: inline
In-Reply-To: <20200521121228.aqplh6eftylnys3p@mobilestation>
X-Cookie: Keep your laws off my body!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2020 at 03:12:28PM +0300, Serge Semin wrote:

> Well, for me both solutions are equal except mine consumes less stack memory.
> The only reason why your solution might be better is that if DW DMA driver or
> the DMA engine subsystem changed the dw_dma_slave structure instance passed to
> the dma_request_channel() method, which non of them do. So I'll leave this for
> Mark to decide. Mark, could you give us your final word about this?

Honestly I'm struggling to care either way.  I guess saving a bit of
stack is potentially useful.

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Go44ACgkQJNaLcl1U
h9ARkgf+MntLj5Do0nvBWAqICSlgK/Xn8rMj1fR5eJDBdfgclFhZsPYUHPbZHr6I
/U2aWUFEslX7Gq/QAu2JNA+uYp3p798aYv1u/h+Ss858qzbkBsRWNVAVFzNph0Dk
qiruZrmFMuDqF0O/ofqHI4yiOqlJnT4KixjR7tKDoHlW4IxXrsHCCR6mAFmunYpY
5XEIolhWrMiP6dN5vmAMwRt6My2zESwY3of8eW2lApg0n6tR2SFnWz5++CR7K04b
TO73tMeXtI1lBogjeYz7iuC0joI16cg5aaDq5Lt6lMdbK6qhH5ZLjAynCRQLKE4C
F/qLatJ9ve0BIC069lF4Tznzsq8NIg==
=1v3o
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--
