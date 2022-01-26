Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2260449CFCC
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jan 2022 17:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243108AbiAZQfi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Jan 2022 11:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiAZQfi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jan 2022 11:35:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F5BC06161C
        for <linux-spi@vger.kernel.org>; Wed, 26 Jan 2022 08:35:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DC5961A1E
        for <linux-spi@vger.kernel.org>; Wed, 26 Jan 2022 16:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB325C340E3;
        Wed, 26 Jan 2022 16:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643214936;
        bh=qdNhUTKmv7dhy+Vliq2xt78RN2xNkzXGQMBAMNKuq48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mMIi8lcbC1GD6C36tGzn/uQ8yxBQa4JnxX6qFg4eq88tfVCYYCt0kksafXyCMKBtz
         e0pjoHlMUdXRRt1FKouuQJMmUN4tnoA10iBkwW4zvndRZO4lWi1XWTzLu+nvDRibIG
         O9S8kmlVuPS+RWSagH3JZSFD3BDBQW6J38yCjJW9fMcYScLVtt7sC9eqe5/X8w2Tyw
         9A5w5DuFR69DsvKS1C1o7THwCotDmMtgGA2ShJQ2SAr1DzcorK+xC8KWLOV3Avr7u0
         gbaFj346JCa+bGUGoUTTxaiGyXgls6Q35fFb+Ceyu4QssW1UDTfrASMuX6uiGkJQa3
         Z1frQtW/vbblg==
Date:   Wed, 26 Jan 2022 16:35:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v9 01/13] spi: spi-mem: Introduce a capability structure
Message-ID: <YfF4UhhVFu749ZYK@sirena.org.uk>
References: <20220104083631.40776-2-miquel.raynal@bootlin.com>
 <20220126105333.883267-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b+o4Gqc76syJes4g"
Content-Disposition: inline
In-Reply-To: <20220126105333.883267-1-miquel.raynal@bootlin.com>
X-Cookie: Use only in a well-ventilated area.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--b+o4Gqc76syJes4g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 26, 2022 at 11:53:33AM +0100, Miquel Raynal wrote:

> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

I was hoping to review this stuff?  I think I was expecting it to be
rebased after the merge window...

--b+o4Gqc76syJes4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHxeFEACgkQJNaLcl1U
h9DTgwf/by9jYrSchPqQd6Xm/Z49F9oWPnphXXukxjYLre0sloaW4eEm8kcEMiU5
+0imedDQtB4ywKl4ZXsQaswco8bThrUUD3oTPleY7muQs8/i4uWSMB1S5bzcoCAH
gAuesxzlHcM5xvogHAT83OmsVHD2X9FdIx41diYTkoLrB5Fz2YFJRmLIvmBLXpjJ
kimxdGxWzkg1o/sKwVNbIJ86buAZ8EIWfJORt/1G0CdJwShCIy0hb4ske652LYq9
9OeTFLj4NfDs3EW9IWaUBbXW81vjwxQPhnOpnY8bBxgyn58Y54RR5TwOwLkCyn0s
WGgO+1pj/euv3RQ6IQhxXa576gzf0Q==
=Wwro
-----END PGP SIGNATURE-----

--b+o4Gqc76syJes4g--
