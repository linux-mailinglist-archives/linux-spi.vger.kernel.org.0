Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AE11FAC79
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 11:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFPJeI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 05:34:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgFPJeH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 05:34:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA22820707;
        Tue, 16 Jun 2020 09:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592300047;
        bh=S1TLVtKQtS3UGT6JhpwcpbYM8/Aj8mPZtPlyY4qh8xI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdwWWQLblJC3ItTTUFJi93pBVXZOnHYvI4yag53wS231WLSa283Mic8bzXOv60Hb4
         FfiXX/m8x9TikDdq/jvBFdY+Qr31GE19DINQVzFfau4ow0pOfeJlkmNmucCXKdHA8e
         STkOaf0WiWO+Xl/CbxLrnKPk/ywGX2PKEOr8nFHg=
Date:   Tue, 16 Jun 2020 10:34:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-spi@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-renesas-soc@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4] spi: add Renesas RPC-IF driver
Message-ID: <20200616093404.GH4447@sirena.org.uk>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1ece0e6c-71af-f0f1-709e-571f4b0b4853@cogentembedded.com>
 <159226448570.27735.17453498854310254061.b4-ty@kernel.org>
 <6fd4533e-c548-5d14-2d21-96efa0c58a0b@cogentembedded.com>
 <20200616083856.GF4447@sirena.org.uk>
 <6730033e-c966-d465-9273-75137e7ccbcd@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QuX0r7ZseMwydPce"
Content-Disposition: inline
In-Reply-To: <6730033e-c966-d465-9273-75137e7ccbcd@cogentembedded.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--QuX0r7ZseMwydPce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2020 at 11:48:36AM +0300, Sergei Shtylyov wrote:
> On 16.06.2020 11:38, Mark Brown wrote:
> > On Tue, Jun 16, 2020 at 11:24:55AM +0300, Sergei Shtylyov wrote:

> > >     You realize that the SPI driver won't build alone, w/o the
> > > drivers/memory/ core driver merged, right?

> > Those aren't merged yet?  There was no mention of any dependencies in

>    No. I thought we had an agreement about this (core) driver going in thru
> the SPI tree (because there's no repo for drivers/memory/ anyway). Looking
> at the DT patchwork:

> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/4becbd3b-c9b9-070a-5771-48cade6651e5@cogentembedded.com/

Nobody appears to have ever actually sent me these to me so they're not
getting applied...

> the DT bindings still need to be reviewed -- but by whom? The "Checks"
> section indicates that they did pass the DT checks this time around).
> Rob?

There's a backlog on YAML binding reviews, I'm sure Rob will get to it
in time.

> > the patch, no feedback for months on the patch and I've not seen any
> > ongoing discussion.

>    Everybody seems to be in a silent agreement. :-)

Or lost track of things given how long this has been going on :(

--QuX0r7ZseMwydPce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7okgsACgkQJNaLcl1U
h9DlQwf+NkEG5lOuiYhRArbfrTxFcwcBodWu75aYab/A8omCxX19MBBYPoZofN0k
YUQBhQgcNv6GcVzWrR9RhAY7ogHq6BmtreTK3ip3rTRuPiuVJ4MOBvEs2aqLnYya
XFXOg6ZeUmvyCVaXlMcMCSaNWv1Hx2mwsdMLyD2GNjHanrjnIQMVfJC8Ulkt3Cpa
2Da3gYqVSV1Qca2QPhBWM18Oft/M+WOWXfpIjcmoqzfmZYAFqVpYa7QWuC/afCow
r77P2rzqH2NuBPDz+bjghMTCQNYrCLdof1rtEd0TzZMg5bYmzoIpwQCAV/7uB5DU
/bo7uPqzFnCRKtzWM0IUFaXBOUoGVA==
=M5ef
-----END PGP SIGNATURE-----

--QuX0r7ZseMwydPce--
