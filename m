Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2693D3406CA
	for <lists+linux-spi@lfdr.de>; Thu, 18 Mar 2021 14:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCRNX6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Mar 2021 09:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhCRNX1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Mar 2021 09:23:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08EEB64F01;
        Thu, 18 Mar 2021 13:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616073807;
        bh=azu47gE8dnLQPum0mcL1O3W7dBz1Y3txbYwdvva8Cws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Is+8Ae7xagv3lP1HQAZHmvPszDS8ClHjJFVBtKew3rEJ4Y3g32dx3zifqvtL9jBQz
         lUUfP2WxjLqwzPeBFdIVpAZ2T9vr8zchOkfOOJPkhkOb6IbCqeVABrpR6r32vZr9mk
         b8ZZaUZLIwYiaA0VfZofTELMrcFKj6ZixsKLTC3zZIV/1CN4GtmgCe0Tfol5a4sQto
         06afu/sl25D5l7J8R6h0nRPtZzlfzTeJgnAWk5nFoUIhopfplc19klm+/47nBg4HFa
         KnPQaGalUGYtk3HLkXvZVJDdQNKGOK9J4oIjLiNdE+FhMqUId5iAZ9DetMoIRCXgel
         sHG6baj9KmXSA==
Date:   Thu, 18 Mar 2021 13:23:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        Karen Dombroski <karen.dombroski@marsbioimaging.com>
Subject: Re: [PATCH 2/2] spi: spi-zynq-qspi: Fix stack violation bug
Message-ID: <20210318132323.GG5469@sirena.org.uk>
References: <20210318102446.25142-1-amit.kumar-mahapatra@xilinx.com>
 <20210318102446.25142-3-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Content-Disposition: inline
In-Reply-To: <20210318102446.25142-3-amit.kumar-mahapatra@xilinx.com>
X-Cookie: You are false data.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 18, 2021 at 04:24:46AM -0600, Amit Kumar Mahapatra wrote:

> When the number of bytes for the op is greater than one, the read could
> run off the end of the function stack and cause a crash.

> This patch restores the behaviour of safely reading out of the original
> opcode location.

> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted
>  in: zynq_qspi_exec_mem_op+0x1c0/0x2e0
> CPU1: stopping

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBTVEsACgkQJNaLcl1U
h9DsCQf+KMrGalD617RM69Vb+1jNxBl1jynG6zS3+cO+oFdQaB1t5rxVY8V/7ayp
+7n+laRNMY2C/OJke3NY0P85le77SKQaai1Tjksl6tg0JH+VKdyoRE89gKmbYT93
DT2m88UXzYNVt28ZcnkKIbrHdKvNYkHBLP9P5hyk5LtTkipv1a1+OqYStbYfKzAk
BDn+lvv31mcQh2QySqwFqyhixTPNmQSfj1RR5D1v7KNExk3wTZ3oj0Shj4Biw+UO
XELRrtm+rmcz2i7L1BS6mQCTPtIsJJQk6gpJ+BJ7+ZFI7D6b6+oFr9luQf+fp2ts
yClnG6i75D3p5NPnyV6bcKFN+mLUVw==
=XPjD
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--
