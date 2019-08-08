Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C5C86D24
	for <lists+linux-spi@lfdr.de>; Fri,  9 Aug 2019 00:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404619AbfHHWYU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Aug 2019 18:24:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47000 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404609AbfHHWYU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Aug 2019 18:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CiEMLkgHGajJ+S7I72ZRbI8J7SWrJ8WWjs7jCf+7ejA=; b=XzTgQRKOpMPcNVm19/fjK2NKn
        gbcyvI50SCZkj9gpPdA03kw37BV1nyEBViCYHxfIGU80E5dScLRBJhBD2923bZplbjZW/LQnGt9ij
        bi01zdTjgmerrxLHVQhidSyL8PwUt0HTOlKhS0q73QYazG9iS9IlGlVgt+iCFNGYMf4QU=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvqpN-0004Dp-F3; Thu, 08 Aug 2019 22:24:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8BD112742BDD; Thu,  8 Aug 2019 23:24:08 +0100 (BST)
Date:   Thu, 8 Aug 2019 23:24:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 07/22] ARM: omap1: move perseus spi pinconf to board file
Message-ID: <20190808222408.GS3795@sirena.co.uk>
References: <20190808212234.2213262-1-arnd@arndb.de>
 <20190808212234.2213262-8-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kVhvBuyIzNBvw9vr"
Content-Disposition: inline
In-Reply-To: <20190808212234.2213262-8-arnd@arndb.de>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--kVhvBuyIzNBvw9vr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 11:22:16PM +0200, Arnd Bergmann wrote:
> The driver has always had a FIXME about this, and it seems
> like this trivial code move avoids a mach header inclusion,
> so just do it.

This appears to be part of a series but I've no cover letter or anything
else from it.  What's the story for dependencies and merging?

--kVhvBuyIzNBvw9vr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1MoQcACgkQJNaLcl1U
h9BTcwf+PZNQyv2QwRk6+uATv2Z/5jBqf59MD6hu+nPG7ZvewRhifHBZ0Wn0oGIy
LKuN77ve2quiHJEaXWc+6uMdkTKzHf0dq7PXzkSHvdGpKY8oXpfv+JxIP1fbvLU2
LjgoKVq4QXXKOwQKuPuBt6G5MFmPXLsTLnxo0C2CA8bBYHUhY1YNpslOiDbmN7kY
si0Og/am+P+msK+XEDu2s2waVhOEA9JhUJzNBSLvqdZnVrbKflMnJ1f+lqGPtJuf
G249qyMoeuoQoq7XX2OmvHk6MPxgjyFnANG88Pmz7kITgyC7M8cQbeMDsox6X5Wf
yZd+9ZI1XiupoEyUNs+MRVRuLA77Dg==
=Q0wr
-----END PGP SIGNATURE-----

--kVhvBuyIzNBvw9vr--
