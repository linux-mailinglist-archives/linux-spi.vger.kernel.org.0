Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC9C3E59CC
	for <lists+linux-spi@lfdr.de>; Tue, 10 Aug 2021 14:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhHJMVp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Aug 2021 08:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbhHJMVp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Aug 2021 08:21:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAD096023F;
        Tue, 10 Aug 2021 12:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628598083;
        bh=1hsadZeitXB5CUW3Q6gu9kYoCo9loKWmN9H4lu/tj3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oenuHDYn9Q/7zZPKhqtn+sZPEPlrIqFnpCVEIaUbt+ZGg8cMJSHdxtzsAtreqTppA
         PC71E3OWU4SeoeO0t9XvhsyXkd/hUcP/pgBbTUKk2Nlh0KKVRIDIN5SoakXupw75eG
         NaIS9IvW6aQrvAZE/95RQNhuj+oK3/KW4zmuGMQrH2H7D+ttWzX3utVcK8Z4ze2IWt
         tx7DJYuzngg7JcVPg9zl81O+D1VriSU0RkEnnnfJ1LmvIkd8nj6VNiCMGCUhN+sZKn
         C+SODvaEY05e52n9AUSMGzPJ44fsGpIKJFxsWqC3AMiQP+7Q18CQN8NZC5NkK8OYW3
         PGgcE1N2dWHxw==
Date:   Tue, 10 Aug 2021 13:21:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zhengxun Li <zhengxunli@mxic.com.tw>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH v8] spi: mxic: patch for octal DTR mode support
Message-ID: <20210810122104.GB4704@sirena.org.uk>
References: <1628584186-9266-1-git-send-email-zhengxunli@mxic.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <1628584186-9266-1-git-send-email-zhengxunli@mxic.com.tw>
X-Cookie: Who is John Galt?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 10, 2021 at 04:29:46PM +0800, Zhengxun Li wrote:
> Driver patch for octal DTR mode support.
>=20
> Owing to the spi_mem_default_supports_op() is not support dtr
> operation. Based on commit <539cf68cd51b> (spi: spi-mem: add
> spi_mem_dtr_supports_op()) add spi_mem_dtr_supports_op()
> to support dtr and keep checking the buswidth and command bytes.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmESbzAACgkQJNaLcl1U
h9BoqQf/WiQHKK+Gskgt3bHhPJDlRl5BfajCrjP5PM/bKYSPy6YQ2kfS/Cte+gr4
5sS9DYt/jDZgg5IH77AquwHduoJJeDP3DwpmepW/HHhyR4I8y8zY5os1FAIgwekf
xpj48kCQ6X0dvnCBabtw7XWLcXTEUpRJEJooMUKIPq3cvf8xx8pjSw3mmR+2FMk7
P3nrpb/qe1EpmTcmIPqfPzqULT0ubtdVuGbQiHl0dl71VWPJyuSEBxddruLbZndi
goyR9ji5TOzZk63MeP3MTVHLcPhZucAxv/vDDe/TwEk2lXMjZrL8VP2/JzGU/u9T
e4Bw3bY4x/9aUVcp6NA9OFl+OKsDDQ==
=1vMU
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
