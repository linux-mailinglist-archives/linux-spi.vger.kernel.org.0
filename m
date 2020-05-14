Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120FB1D330E
	for <lists+linux-spi@lfdr.de>; Thu, 14 May 2020 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgENOfl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 May 2020 10:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbgENOfk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 May 2020 10:35:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D4F7205CB;
        Thu, 14 May 2020 14:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589466940;
        bh=48EwYvSwIgRzFWPGVtkj550AqOLgeUUnyv4LtyKi/pE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnKmJyCk1QIFgro/vw3QB05SDh5+ogBAdK18o1spkVK4RFF+Sxgqduez8FAymwQ4u
         lacbo6x7gFlSmljLNO1A6hq2LFOrXGrDLgKqLV0am5LdghHhP9SFmCdz/fKXbCcNM0
         LopKZfpYuy4FpSQq/UiRFgb1c8s7RhUC3qHkq6OI=
Date:   Thu, 14 May 2020 15:35:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/17] spi: dw: Fix native CS being unset
Message-ID: <20200514143537.GH5127@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-12-Sergey.Semin@baikalelectronics.ru>
 <CACRpkdY=wkgnYPcqSzyzNpS6ckJZs-9kXfTfdwa1E+POzOBQGA@mail.gmail.com>
 <20200513001347.dyt357erev7vzy3l@mobilestation>
 <CACRpkdZTH1DNHvi4r48nLNWp4rqyYDZTzT12hw0eTNcYmgSr3Q@mail.gmail.com>
 <20200514115558.e6cqnuxqyqkysfn7@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KscVNZbUup0vZz0f"
Content-Disposition: inline
In-Reply-To: <20200514115558.e6cqnuxqyqkysfn7@mobilestation>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--KscVNZbUup0vZz0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2020 at 02:55:58PM +0300, Serge Semin wrote:
> On Thu, May 14, 2020 at 10:31:13AM +0200, Linus Walleij wrote:

> > We had some related discussion what to do with this case
> > when a controller can support active high CS if and only if
> > it is using a GPIO instead of the native CS. We didn't really
> > figure it out, I suppose ideally we should use two flags in the
> > master but that exercise is for another day.

> Even though it might be painful, but as I see it the best way to generically fix
> this problem would be to change the controller->set_cs() callback
> semantics. SPI core should pass a CS activation flag to the set_cs()
> callback instead of the CS pin logical level (just propagate the enable argument
> passed to the spi_set_cs() SPI core method). So if an SPI controller supports
> the Active-high native CS, during the set_cs() callback invocation it would
> analyze the spi_device flags state to figure out whether the slave needs the

The idea with set_cs() is to support controllers that allow the chip
select to be directly managed.  If the controller is interpreting or
automatically managing chip select at all then set_cs() is not likely to
be a good fit, if the controller does support unfiltered management then
anything else is going to result in there being a bunch of duplicate
code between drivers.

--KscVNZbUup0vZz0f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl69VzgACgkQJNaLcl1U
h9CkzQf4/uHBSzXTasSY03WgD1z9u+SSfFJAZ5Boxho3Qo6dz4aKF8l8h9suzNWq
1WfAehSkgkhS85JHeNMcuTjr5P4sAjQW/yF7q1n2edDYpj8lbK3+imNpSrnfNp0z
0GUhUfHJLQZ05l7DWFyeQ1S88u7obs7D3/RrRfznYcCFG8CsJczlnlBG8DPFPNtB
ZidIShahKy/TZsdMm8jx+BpdglPnArIwvxd/0wOivwI69077MrigR5cH0GpL6rA9
Pq5EkxK5W9UereSFPv+BsaTW4ou7mHITbCzjS9DDjYo4I5OVEUqKwaFD4yp9CoBc
MTBnB9xxDydUKqJqUNnzksYrFpBO
=ssDU
-----END PGP SIGNATURE-----

--KscVNZbUup0vZz0f--
