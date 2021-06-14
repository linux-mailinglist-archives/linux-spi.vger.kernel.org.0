Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D8A3A611F
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jun 2021 12:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhFNKnY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Jun 2021 06:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233077AbhFNKlX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Jun 2021 06:41:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E061061426;
        Mon, 14 Jun 2021 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623666905;
        bh=IujGyGFkUh6c095wpaUHFnrO0iE38+6f/5PehxIR33I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3Hfj5KIOzRs7RfSvIXqZ4p5SPswqlDHwwGhTBQLZLdUUbskwUkncAJ4YgSAnXvz7
         H1I0ZDylPWbKJLGG9wDhF3oJEdgj7bgNuZAemWnpduBSUFYTSt7Dnyb6nsaBQ19LnA
         9hvOFNEatx122zL3A6h6eLs9duGyEI8yqMtpylDRWYNQbMOGcSYtYzf6L/0FhYYh1Q
         iOMZ3qcZvcjONMEBB9qEHIPDw6dEMb/fDCNvl7rLaKfWIn/wFmuuT3XoXntsRMnQns
         AleFF3hoOtQfQ+4TQUmlDKcoUwcIk5gN6G00A9YBSvZjGv5RVtaV9ehoLtg9mrqxjk
         oYEyMbTs3YASA==
Date:   Mon, 14 Jun 2021 11:34:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] spi: spi-ep93xx: Prepare clock before using it
Message-ID: <20210614103446.GC5646@sirena.org.uk>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
 <20210613233041.128961-3-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <20210613233041.128961-3-alexander.sverdlin@gmail.com>
X-Cookie: Some restrictions may apply.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 14, 2021 at 01:30:36AM +0200, Alexander Sverdlin wrote:
> Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> to Common Clock Framework, otherwise the following is visible:
>=20
> WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
> Enabling unprepared ep93xx-spi.0
> CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.13.0-rc5-... #1
> Hardware name: Cirrus Logic EDB9302 Evaluation Board
> [<c000d5b0>] (unwind_backtrace) from [<c000c590>] (show_stack+0x10/0x18)
> [<c000c590>] (show_stack) from [<c03a5f38>] (dump_stack+0x20/0x2c)
> [<c03a5f38>] (dump_stack) from [<c03a2098>] (__warn+0x98/0xc0)
> [<c03a2098>] (__warn) from [<c03a2150>] (warn_slowpath_fmt+0x90/0xc0)
> [<c03a2150>] (warn_slowpath_fmt) from [<c01d8358>] (clk_core_enable+0x9c/=
0xbc)
> [<c01d8358>] (clk_core_enable) from [<c01d8698>] (clk_core_enable_lock+0x=
18/0x30)
> [<c01d8698>] (clk_core_enable_lock) from [<c023eeb4>] (ep93xx_spi_prepare=
_hardware+0x10/0x30)

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDHMMUACgkQJNaLcl1U
h9DaVgf/WRx61EZX++GV5SmP8RyZsQsu8RLHH/fRsJLP77/QncSMK6AjFAx3Arjm
TKayaB2d06wkAPDXaXVPGu/ltYZRDcHo+vdBwG586kQgdzfagMSq/y4f4Q8V9r8w
NuVoVRvxjXAOPUUxsLJqhtlczeheW4fCIGRmbQyBnryipf/NgCRU0MSoAsTk5O8C
ILihHzbynhk3CZ9OZt8awIAIeq+/FesV7W+RcosHFeKNIPzWgTgrDcdelR/E4f06
7qbqZ3G4EXNyggvdusfKVTGINSOBKa5qk5HPuJu0766LiJi6o7wqA4Ay3bstjGmV
+PONN4/TXKsZEPDoc1644OZ6JeP82Q==
=IFes
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
