Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8471735DDD4
	for <lists+linux-spi@lfdr.de>; Tue, 13 Apr 2021 13:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbhDMLf7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Apr 2021 07:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238804AbhDMLf7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Apr 2021 07:35:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 648646101B;
        Tue, 13 Apr 2021 11:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618313739;
        bh=t4QjZI893/9aurkfXP0tNq7kLKT/EvV0OUE8OmGr6Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9aI5kqtecMhj0rzEuhqw0Sqr5BZPxi0b3/lTYf4WlJYB2AozkmpHAnxbMuko9rXt
         c65cDqPtKZdPVOdEFti5QWSSCU3U5ABPROIQP1kvzQp4EhhyMxCzACJrLVvAqzhSF8
         G8yrG7XqEvebF+yfVSix2DH5r8NGejMdYeBgnCz3L3hezRgrXV+C5Q7FPVNRr4pI+W
         DQmS8mKiw2L47uCIzfjnCVXZNwiNLRRyqlrfTeOA7zxuG5YBVIylxO9UlGqGZx62S/
         61+LjTsPkgC0vwVsEedZdX4tVnYF4QaRCqJDadq7AJBjTZPGkqL28l1IyYOJ3EBkJ5
         B3UEE0v8iTrXQ==
Date:   Tue, 13 Apr 2021 12:35:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Quanyang Wang <quanyang.wang@windriver.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: spi-zynqmp-gqspi: unlock on error path in exec_op
Message-ID: <20210413113518.GA13244@sirena.org.uk>
References: <YHV3gkc3RFcBZVAK@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <YHV3gkc3RFcBZVAK@mwanda>
X-Cookie: Fortune favors the lucky.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 13, 2021 at 01:50:42PM +0300, Dan Carpenter wrote:
> If the allocation fails then we need to drop the &xqspi->op_lock mutex
> before returning.

This doesn't apply against current code, please check and resend.

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB1gfUACgkQJNaLcl1U
h9CQoQf9FVTSNgQ4bpxFlqgm5UogrDsTJaE2SZ3JJ9EaR4bYLsnHrKBLzP8kMQcz
reXBXGcJUznS6Kc2yEbOeKJ+mY1POAw0KjX/8g+XoU1Rh4D9eZ1Q3/UAVKt3M1oE
z0K/H+Xq1KPQz7Tpd5yg4tQRZGVpB6l/dQYD/oFZafBROU8bQmd8gyQ/KWN+stoP
HF3pIs2WrnD8LTFmpLlWT6gQkoMmPTitquduAisf74hMhwjMs4j2x+sR+77SR/iP
o+OgTAiKvC2uHIbIUgKc+zMmzrnGyeDW3lZNg7n1w7L167rA+5o8I5SJuaUMfajs
lpBBnTq8J0nte6p3SAlQPeaEIn0O5Q==
=rgh1
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
