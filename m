Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B2031C327
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 21:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhBOUpA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 15:45:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhBOUpA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Feb 2021 15:45:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F085864DF0;
        Mon, 15 Feb 2021 20:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613421859;
        bh=BnsvQV2bdkDvPdcHnrU1YlHZ7QeSAQIz9cXX9Wf+6OU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uswIQDVlkY/w75GG80UZj2JtwPdKb2VECCVNrPA/m+2aror+NBBM2s+V3BAbk9pfW
         W+e861uqfGj0odvw799QiQ65mIg05UXWHc92/1crEiDrUZmraYIhaJV9l8bPqhFWjj
         pMTQAJXx0blpwixXtg2fr7zR4vCvRiS7Uk+pJz32OMG+iZmhG3EyxwGn6f9T6zJT3c
         NL18y/RY6jjDYYmvaCvHiZrGCV6Vmh82T0ET3xVOGx1mmI+AKv+vHa3qKNST/ftEV7
         AQq9uO3rEGICZdfSEf5+vJgblQuh71nfFOuqBBoPtyR+rNWpqI5hzIwYBar95icX53
         PC7pQMtYPTHJw==
Date:   Mon, 15 Feb 2021 20:43:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] spi: butterfly: Switch to use
 module_parport_driver()
Message-ID: <20210215204322.GA4378@sirena.org.uk>
References: <20210215202353.18515-1-andriy.shevchenko@linux.intel.com>
 <20210215202353.18515-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20210215202353.18515-2-andriy.shevchenko@linux.intel.com>
X-Cookie: Serenity through viciousness.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 15, 2021 at 10:23:52PM +0200, Andy Shevchenko wrote:
> Switch to use module_parport_driver() to reduce boilerplate code.
> Note, device_initcall() is a default for module_init().

Acked-by: Mark Brown <broonie@kernel.org>

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAq3OkACgkQJNaLcl1U
h9DOPQf9FqpvmTWWFBe/gn7sh4aD9oHcrR7VkbKN8rkDd0r+NgRPppOaOokKdyoQ
e24StEgGbWaIgSRk+2/c9W+wmk30IfbZoNjoz/aM5My6k/NEIaFl+5Wa/72JUFqc
vJARGCJ42SQRlX9eAug/Giq0/taClEqoXiu0KfKZfRGylFD7kCtCZjDAlXTjoTqX
G9aGeyjIHnJDCQROQ/FxEma0ZmqtbrvNP+5I33BXpAiGP2MdMqSO3kGo9P/Mp9UM
NKUYbC8xjS+nYYrumFjDjpCryLkVTs0fDqknrN+Ls3MfvayXRxwNxfdHtXNnl39w
Zbs11EtkbrSAoCClTj2aJKoBI52zSQ==
=+ZwN
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
