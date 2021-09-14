Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F3640ABC5
	for <lists+linux-spi@lfdr.de>; Tue, 14 Sep 2021 12:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhINKeP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Sep 2021 06:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231774AbhINKeJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Sep 2021 06:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12EF560F21;
        Tue, 14 Sep 2021 10:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631615572;
        bh=l2tHl1GYMK0OnFn5+OkiiJz5Ebqa6wLvnbCBc9xbL1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bx6ZmlMHw/PzhyvI95fbwSUEDRQxGuqfAmaWyMi3niFZT7Rw/N8RkthdW2JlRe933
         mFxJm5TipxZFMijdO9k2EUgKJml6/BjpE1TesCuGeFd3mG/yAAj6Z7PRai23zScwax
         jhZQlazZiP3K1++YVO7S9ntsbHvS54+qGrwzt5gyFjFZ3dczg0iM/ERE2sw7/jPjS8
         ly3wYIMdDYsLXXFFhexvj6lBqUh8vjsLrYLVByrW4MRaey7k7nIv/fp/f3+dEA2Udf
         tLiTEe/rOuRpUqtabXa4Z8ZJDYh3VavKI+0Ez2UNpVnPujMwt4g7uCYNVd4sfP+Slm
         4/3wR1UCePzWA==
Date:   Tue, 14 Sep 2021 11:32:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/8] spi: spi-ep93xx: Prepare clock before using it
Message-ID: <20210914103212.GB4434@sirena.org.uk>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-3-nikita.shubin@maquefel.me>
 <20210726165105.GI4670@sirena.org.uk>
 <b8ddca2452bddaa89875a66e658c882f4d0641ae.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <b8ddca2452bddaa89875a66e658c882f4d0641ae.camel@gmail.com>
X-Cookie: This space intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 13, 2021 at 11:36:30PM +0200, Alexander Sverdlin wrote:
> On Mon, 2021-07-26 at 17:51 +0100, Mark Brown wrote:

> > > Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> > > to Common Clock Framework, otherwise the following is visible:

> > Acked-by: Mark Brown <broonie@kernel.org>

> would you take the patch to a tree of yours, please?

What's the story with the dependencies?

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFAeisACgkQJNaLcl1U
h9DMxgf+KPL8iTvOv+yHqCe299GLMTbMsyYoPHPC4CuSAKiN043k33knHmA19wtm
XmzT2N8jPIuvQ+vYhgcRv/b8/okSA8jzWUKIWo9dpuPo+7yAbJv21ZKSne2CY8EG
fDI58F+MgkJFU9j6uZRZip/qmVaVGAJdbBP4A47UDYox66VFFy4eL0efidjzciWA
7a4G4DXyewSKLeVKomL2nYp8mXcRzv/vOy6HXlWmH1zBYjdOG5+/NvcbXs9nhrXd
8cUkucyW06fYKK5wAzONgLVnmfD9S9JpKq4AHyIJdCtcJjBiwrSDkvPiq6gwf+cl
uKTUn+8W3vs/9pnsOv/Uwtb9vYip5w==
=IpQG
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
