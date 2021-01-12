Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358F72F2F56
	for <lists+linux-spi@lfdr.de>; Tue, 12 Jan 2021 13:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbhALMsz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Jan 2021 07:48:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbhALMsz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 12 Jan 2021 07:48:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A25C422B37;
        Tue, 12 Jan 2021 12:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610455694;
        bh=BToyKO6I53LJkegMwyfNmTPFV988ajxYziM4AKqOwIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=skAThuuyG7aJJm2LZP+GaFrLtZNqe5KY2vUpfYs0fpcsr0vRPQf24aEvrVJ2UJzl/
         sJITnCgGacGbhOqpLUyVGMSpmgLso+WgTXf9P3XLzitPoifROvcyirr9362rxKBMIX
         jsoKD75tvfoTa3J1CCd01oi6+lAxtN7VzIumla/TKNk3lQ60jf5EBxRymwqqENEpz4
         HDQenyHCCL5x4tEMWrWsjb6UZp7GAZWXI3TvlUyr2woXUDvtqw0QznUzoac6rdo+tB
         I7jJrw5mll1jxWc9mh+V6ilVi+f13m/6O/sax62bdbZd5yBAUh7XRxOuqmpTSYynuo
         xsLE8sAj9WaNg==
Date:   Tue, 12 Jan 2021 12:47:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 0/1] spi: cadence-quadspi: Fix a compilation warning for
 64-bit platform
Message-ID: <20210112124741.GA4646@sirena.org.uk>
References: <20210112100637.747-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20210112100637.747-1-thunder.leizhen@huawei.com>
X-Cookie: Stay away from hurricanes for a while.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2021 at 06:06:36PM +0800, Zhen Lei wrote:
> This patch is based on the latest linux-next. So the Fixes commit-id
> maybe changed when it merged int v5.12-rc1. For details about the problem
> analysis, see the patch description. The auxiliary information is listed =
here.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/9mmwACgkQJNaLcl1U
h9C96Af/ZisxzCk9VAYqmV67HrqaXT7axsKplWisQLjyLG/AT6ZkllXAxQ1LZjON
NSVX0Aex/EhVHHrW5i1FLhkco1Tg6YgtgwB0KsQe7HQr2Ly5p+KoBoqyZaeInF6q
6cT+lSemwoPcKrrBMMBpvg1c9O5xa3938EiMmXq0lFw4XqQbU6kX8HApvVaPbSNV
q1nQ9JIjwqAA7Cq0TMKoYriYdvsz5JT2C6H+Puy7xHqXjo7px5z0SN7r85WPyvwH
7FvLqak/pJSjNZurCWDzyINpd/ipY9CVh7QrfaVkbskPxSI4xOwvjxPf9i6CYXbL
/E0fPrMdl535c83C6VvuauMzgFZRAQ==
=WKIK
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
