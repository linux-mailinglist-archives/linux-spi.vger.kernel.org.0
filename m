Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12893C8953
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 19:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhGNRJa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 13:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhGNRJa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Jul 2021 13:09:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 091C760698;
        Wed, 14 Jul 2021 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626282398;
        bh=jNlgPMgZN4EpeXdbNIPWr2KBnHm3nge8Gn/GKjF3UcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ILSC5K0tDOrDr4SlSUXGH6bqhvwLgftnZt5TJjGqh2as10U6G16uGvu7X/IsbyXpz
         tlmngxBsxhiLjdEjrgqvGNC8lgMNrIT6J+B3EizyztvYsVj/3s+RiGnL7Zf3GabA5L
         k7uhx6G6WxD5HkgrFX6ZQcZuSkiw3yav0ww78VaondYtDEXQQGN35lI06p+785kN2X
         IYwwdQTF/d5ijNVY5FsUm6WCYtvAavJ0NvsGYErZU2zXEiNq5wT5SgMAnsC/obX+F/
         CJwbDpN2GfkYJOpvS+si33nSTNIYe6+pZ/1fD6nbrgUJ8JTVDN56jDLZluXx7YZ8q4
         rW7/LCxlqcW+A==
Date:   Wed, 14 Jul 2021 18:06:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 01/13] spi: spi-mem: Add DTR templates for cmd, address,
 dummy and data phase
Message-ID: <20210714170601.GH4719@sirena.org.uk>
References: <20210713130538.646-1-a-nandan@ti.com>
 <20210713130538.646-2-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MP5ln1Rcf9Bvi+ZW"
Content-Disposition: inline
In-Reply-To: <20210713130538.646-2-a-nandan@ti.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--MP5ln1Rcf9Bvi+ZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 13, 2021 at 01:05:26PM +0000, Apurva Nandan wrote:
> Setting dtr field of spi_mem_op is useful when creating templates
> for DTR ops in spinand.h. Also, 2 bytes cmd phases are required when
> operating in Octal DTR SPI mode.

Acked-by: Mark Brown <broonie@kernel.org>

--MP5ln1Rcf9Bvi+ZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDvGXgACgkQJNaLcl1U
h9CuOgf+OZwzBjuqfvGXu9HhhtOFIDOriNVdP8bqqDTVfmTIZw5qLXv2KsASJQbR
67Y0bQeUvlIfaOboTjdE5OWWKavRE+3VASCjAShLl4QrYigm6RKXfK8YEAWIg2Ia
sJhBSQGr+wCNcRyT1OF8p1QNW5rQanlqTS54Vuyy9PISDO2YCmMnngOLe/0LrKaB
AATXpiINw2//4wZQz5PFSZYNRp4BarGHps9ZpcV1SSApVTD9sOpCPd1lkTXRWP/4
72P+tfVCerB3REvELGRMbVs7Gg21xfwWC2S67QzprmQ/1jYSRGd7DV25i74tZIEw
A189cTmusslEmBTPQnZVvNaakXWlzg==
=RuqX
-----END PGP SIGNATURE-----

--MP5ln1Rcf9Bvi+ZW--
