Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C367D36B747
	for <lists+linux-spi@lfdr.de>; Mon, 26 Apr 2021 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhDZQzK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Apr 2021 12:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZQzJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Apr 2021 12:55:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D3D761076;
        Mon, 26 Apr 2021 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619456068;
        bh=Givos2wPFTgIoBx6YKC8nj3Pbgm9ei6Z3Wxmrayz8aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mi1T/fbA112QQ9XjZpq+gfVb8GpNrkpYbelLEM4qxtVfjeSS5xj5qETS4h15vCZaQ
         SusAJJIIGeg4d/X7AtRkN+l7eUcTPDwUJwkQHHwl+9mdIAb90zWQDvqfdK9xYJbhtj
         O4LaB8ZnboQQBLNywMVtp7NofdQvW+DkiVo6657vztl4eiEEfrMUs5ZToR1lLY7pQZ
         aUKM54yBx7CWPD3kqwyCKQEdNiIRxoXPlFrJhq/ylaNFKz65vRJAN/u5UTA+RGQpEF
         whfEa5r9J0mXYrwVFQU5O0KrqpyfBgibTpsEw/WSZFy3WLnrD0MZCCpV7bGJZQWBbs
         hZwL+rU4Zy0uA==
Date:   Mon, 26 Apr 2021 17:53:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zhengxun Li <zhengxunli@mxic.com.tw>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        jaimeliao@mxic.com.tw
Subject: Re: [PATCH v3 3/3] spi: mxic: patch for octal DTR mode support
Message-ID: <20210426165358.GI4590@sirena.org.uk>
References: <1618900179-14546-1-git-send-email-zhengxunli@mxic.com.tw>
 <1618900179-14546-4-git-send-email-zhengxunli@mxic.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Content-Disposition: inline
In-Reply-To: <1618900179-14546-4-git-send-email-zhengxunli@mxic.com.tw>
X-Cookie: Zeus gave Leda the bird.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 20, 2021 at 02:29:39PM +0800, Zhengxun Li wrote:

> -	return spi_mem_default_supports_op(mem, op);
> +	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
> +		    !op->data.dtr;
> +
> +	if (all_false)

This feels like we might want a spi_mem_op_is_dtr() helper?  I can see
other controllers wanting a similar check.

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCG8CUACgkQJNaLcl1U
h9DABwf/T8rQdl/NOEIQUm1TecsYXmR8RsSAvPbEH1oYP+nG22bMVSqWP3PUkoaP
XDYz2jP9Ptfkgh/SbiH8b5zT/c4Z5qYJO0jPNb2/+98XJKao65VDRIpr7P3CXgQj
lzNqJmLteJn2dMcWRwZoIkGV/eniS0VjzDGR/dLguMbuPtCuGL/dCxtEI8412SK2
BrPjHJrzsOOHO/tINDMOH/NLTchiaxX8suduPaish3Nr0aK1kv7YVSa1KgvDpaiK
Hqkps1sdmC1Q/1M2NNCKgTfKhYdZAjIpuAffvO62DnVQaq/O/AeWNPgYXluHK7BX
9s0XSphKweIUGpdrCA3CX7cSzChGEg==
=JjQy
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--
