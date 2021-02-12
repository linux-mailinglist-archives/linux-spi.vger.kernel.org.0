Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986F6319F79
	for <lists+linux-spi@lfdr.de>; Fri, 12 Feb 2021 14:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhBLNHP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Feb 2021 08:07:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230301AbhBLNHF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Feb 2021 08:07:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F91564DE3;
        Fri, 12 Feb 2021 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613135184;
        bh=AYZMbP/+Y3TVvujKHed+NO3CyK+JSIz9Z897iZIkEW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVChrVb7uaiO2jD7c60rZ37JnTxmD/GPhMT0KRS4WjzL/PwH7KeLnMoKIvT5xZyCD
         5XsrV24Noc2y8PaaBLuNg6IPeMahr9U5SNi0Qro79sR6CaRv/uucbReUp2V+feyqfE
         FzXqzhbQglaL6yQHMYvSFy/DuPwMiBRRxybv6nLuFcNKZl5LcWKhIr1AIh8ZtBbnnS
         zpr1m6zDwlSaa5ie9DgOg5k7wlvxWf/FTpWI6JLSlbIUtMqneCZ/8B5loaVFUn/SEr
         5YYFrsRnQHXoEB8T7xFMBAeFFHP38UigGqrzjxYfjCBdZSdMUBdmtXX5D4QeGOiVAb
         jDnJnDF3NcxUw==
Date:   Fri, 12 Feb 2021 13:05:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: Skip zero-length transfers in
 spi_transfer_one_message()
Message-ID: <20210212130530.GE6057@sirena.org.uk>
References: <20210211180820.25757-1-nsaenzjulienne@suse.de>
 <20210212123118.GB6057@sirena.org.uk>
 <cd41a204107900c890b0234847fa0b62701f74cc.camel@suse.de>
 <20210212125221.GD6057@sirena.org.uk>
 <CAMuHMdXFt-0vyBQnvwWim8MrijZ-PNN0HsO+dDp9iMzb2153Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXFt-0vyBQnvwWim8MrijZ-PNN0HsO+dDp9iMzb2153Hg@mail.gmail.com>
X-Cookie: One size fits all.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 12, 2021 at 01:57:24PM +0100, Geert Uytterhoeven wrote:
> On Fri, Feb 12, 2021 at 1:55 PM Mark Brown <broonie@kernel.org> wrote:

> > No, I think it's fine - there's probably some sensible use case with
> > drivers reusing a statically allocated transfer/buffer set for multiple
> > operations and just tweaking the length as needed which seems a bit
> > weird but I can't think of a reason not to allow it.  Your patch is
> > currently queued, all being well it'll get tested & pushed out later
> > today.

> Aren't the zero-length transfers also used to do tricks with the CS signal,
> e.g. combined with cs_change?

The issue wasn't that things were using zero length transfers, the issue
was that drivers were doing zero length transfers but also passing data
buffers which isn't an obvious thing to do given that there will be no
data in those buffers.

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAmfRkACgkQJNaLcl1U
h9CTbQf+M0AJe+8RIbyBkQmucMxzMYl1M7W5COpyanLLe/qcEZNQ0yWzuJ13HMCr
9PcrQk+R63wg3Se0VUPAvx083lIbePEcCs2CkzoT+h2Y08zBxT3QBHNYNBq0MZ3D
QqQP9G3BX3xqaFduWeJ/7ZZq5l4dDAC1u9P/7ZJajupQcnKe7H2MoPe01qgKvjS8
T/i5dJaUS2LPhsHxieI5wNBCtvtbJ6ziCyXoc5/QDW5p4GXj9SfUF2jnA0wZEJ93
uq5Qhyf07f7/FAcBfbODsStxhoR9t6PJ3v1ZsJ+bwUoPXKMEre2+Vmbx25q6+MWA
J5MBE8qyVAtSNs4leGb06uNWAwIQ9g==
=14UE
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
