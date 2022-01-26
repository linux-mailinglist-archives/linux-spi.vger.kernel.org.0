Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A7F49D10C
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jan 2022 18:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiAZRlj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Jan 2022 12:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiAZRlj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jan 2022 12:41:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54102C06161C
        for <linux-spi@vger.kernel.org>; Wed, 26 Jan 2022 09:41:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9970261B23
        for <linux-spi@vger.kernel.org>; Wed, 26 Jan 2022 17:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD01C340E8;
        Wed, 26 Jan 2022 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643218898;
        bh=UjPtMJvYnQexM6xAUwEDFsPyqZ0hrEpQOLkboh91jc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8u4ijZZnIA8xyh4l/cwZqDQOFH6baIj7xCm9h/39Oo4o4TcqG5JLLM3ljnFo/g7z
         DxvFewX5/SClPR3pl5J3+QW4rxu8rbwNnj4VMxaNeW4pRw81ACfd0W1Cx8iUotCj/I
         Dtla8GAwD0434f9lsVYayORVGHHpPQKcoYXTGfBcrflyqGP7/4x8GCVtWlynhl1g+Y
         4Xb8YqGnRvpCkVC7GrmSNsuPI+jWGrpbQfKdXO8lXRd6dYBYrYYw31WX9878WpQ7pA
         ao5bCHGEirzz/ZzVK1LZOTziF0gbB3r/xwsLSaqJRLxnkeFzCi7Nn90Iws547vr5Vd
         zFHSC5WD4ERbg==
Date:   Wed, 26 Jan 2022 17:41:31 +0000
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
Message-ID: <YfGHy/MsQhaWCeYM@sirena.org.uk>
References: <20220104083631.40776-2-miquel.raynal@bootlin.com>
 <20220126105333.883267-1-miquel.raynal@bootlin.com>
 <YfF4UhhVFu749ZYK@sirena.org.uk>
 <20220126183601.42d38e88@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NGefvqmzzVn6Osek"
Content-Disposition: inline
In-Reply-To: <20220126183601.42d38e88@xps13>
X-Cookie: Use only in a well-ventilated area.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--NGefvqmzzVn6Osek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 26, 2022 at 06:36:01PM +0100, Miquel Raynal wrote:

> > I was hoping to review this stuff?  I think I was expecting it to be
> > rebased after the merge window...

> Sorry for the misunderstanding, I thought you were fine with these
> spi bits so I didn't ping you before applying. Can you review the v9
> then? There is nothing different in the series I applied.

> Depending on the outcome I'll either fix inline if you ack the patches
> or drop the patches from that branch and send a v10 otherwise.

I don't recall seeing anything but I'd dropped them due to the merge
window, like I say I was expecting a repost for -rc1.  I'll try to fish
them out and have a look tomorrow.

--NGefvqmzzVn6Osek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHxh8oACgkQJNaLcl1U
h9AEswgAgLYmvOtovPnDKE5dwp+VAiCx5B+HKUZygwjsf/aVYM8QHpcynETI6/lN
mjWpEYXtiyRH8ndBsB3ZD/duQy9cYWXUu++rLmvamHMoy54NfIahIfobicZhXJBD
9WtJLh3Bgm/jg9DThttEXr2I7QPfOzBF+jfUs8E5XQ7vUQtTXbM464e9Xz/qdjf7
kNG6MtoUu1g+BjafsjZDG0Md7k6zt+MnzgR6JCbcwDUm5onALqYqq8ReKN779W34
DqtC4dhDo+vFqBmCsgK/NqBuNRzwOCaRkXFDOe4VA3Fie5+o0EJJLX7JKpQCx//Z
VKbiUrXh9nc5oqphrCs/yLY6YOIuIA==
=XU6M
-----END PGP SIGNATURE-----

--NGefvqmzzVn6Osek--
