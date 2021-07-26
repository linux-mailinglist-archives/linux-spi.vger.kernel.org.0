Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4813D64DF
	for <lists+linux-spi@lfdr.de>; Mon, 26 Jul 2021 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhGZQMu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Jul 2021 12:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235294AbhGZQKq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Jul 2021 12:10:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9C8C6056B;
        Mon, 26 Jul 2021 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627318274;
        bh=rtjZmAIsiO+xusbSMqln3gdu7hyuZHUnli/ersUfVzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvQGd1zdDYrwQQyASqLkoQgjYo7DwYQtN36rY7c8u25N442ry1IFwHXQI7sOcTKZx
         AWk7v0QOPHnT5QI61+CHjVpuDDZBVpYtgvSSG4o5oHXSnnO/ND9qnfNHedYl6/oyF0
         VGWnH7n/rqwBaLW9RL6WasTBF9mqvo5ac5xCSR+nET8GBs/f1uwIbz4PIPzwxqQDqv
         r0Slq7AYDpeh/Br6NsIQsEM13vU9zm3PJN4W3UQ+D1AFWvz5G/cSTn9hx790SaCtcm
         c1r6BohxVbbNgVEqLwwKlAP2NI+3fPPjwPemOeRsviVMAZ/3nMJk3YON3yAEBfYtmn
         h3pyPxDJiVZLg==
Date:   Mon, 26 Jul 2021 17:51:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/8] spi: spi-ep93xx: Prepare clock before using it
Message-ID: <20210726165105.GI4670@sirena.org.uk>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-3-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0XMZdl/q8hSSmFeD"
Content-Disposition: inline
In-Reply-To: <20210726140001.24820-3-nikita.shubin@maquefel.me>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--0XMZdl/q8hSSmFeD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 26, 2021 at 04:59:50PM +0300, Nikita Shubin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>=20
> Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> to Common Clock Framework, otherwise the following is visible:

Acked-by: Mark Brown <broonie@kernel.org>

>=20
> WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
> Enabling unprepared ep93xx-spi.0
> ...
> Hardware name: Cirrus Logic EDB9302 Evaluation Board
> ...
> clk_core_enable
> clk_core_enable_lock
> ep93xx_spi_prepare_hardware

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--0XMZdl/q8hSSmFeD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD+5/gACgkQJNaLcl1U
h9CLkgf+PCrxrgszMSg8zSGETrG5R+2/GTI9H+kiyWWwN/Z5dnK79YEIhNHb/reU
Uk0SBYAxpkyaTAxkLQc2tGjJG/WuMrBw2XrM9ZEzfeqJIJsHLictGL28SEfSx9hz
G3fdg2WUEwq+tN1TX3uPoJB1imJLh56yXKDp5xh/nKLqLSN6LtaQmQo+/EYAAn7V
fFK8De6o5C2Uchn4BCd2QkTSsWlE2CH4GtDXatb/TvUCDcZ13B8WiT3gSZPAO21/
7T+D5C7Lf7Db1WSv/9ZGUpGwDd+g1qG+Y72Ky/7JmUs4am8nw3G8+j0bX08f61dZ
rGvUeRUvJK7xn21RoTNqofUOb9MrJg==
=37Fd
-----END PGP SIGNATURE-----

--0XMZdl/q8hSSmFeD--
