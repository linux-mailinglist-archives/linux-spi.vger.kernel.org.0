Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B6C220925
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbgGOJsq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 05:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730612AbgGOJsp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jul 2020 05:48:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F62E2067D;
        Wed, 15 Jul 2020 09:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594806525;
        bh=VBT6+2mD0180rMLiWxQbczbunVnOQjEkxWFs+kJVOJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M7Dols/lmEAItBI/aNpifHi/0ulkO5sSsQJBzTRw2efPRkv5qsNP4jSgS4NyRhOsO
         Bj1goInvkxBVHKKlySq9kiTiRh4HlMs3/ApRGlFD6g3PdK8B/de9Kv03hTTNiQZzlA
         /qj2Ls6Zqvs+yBziCnKDdswiK4Pgn8trrEWKFsIc=
Date:   Wed, 15 Jul 2020 10:48:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     axboe@kernel.dk, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: lantiq-ssc: Fix warning by using WQ_MEM_RECLAIM
Message-ID: <20200715094836.GA5431@sirena.org.uk>
References: <20200714230234.3145-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20200714230234.3145-1-hauke@hauke-m.de>
X-Cookie: 40 isn't old.  If you're a tree.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2020 at 01:02:34AM +0200, Hauke Mehrtens wrote:

> This fixes the following warning:
> [    2.972635] ------------[ cut here ]------------
> [    2.975956] WARNING: CPU: 1 PID: 17 at kernel/workqueue.c:2614 check_flush_dependency+0x168/0x184
> [    2.984752] workqueue: WQ_MEM_RECLAIM kblockd:blk_mq_run_work_fn is flushing !WQ_MEM_RECLAIM 1e100800.spi:0x0
> [    2.984759] Modules linked in:

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8O0PAACgkQJNaLcl1U
h9ArdAf/cgVAmzu4DULwUn/o432OJsHNP5gWrUCOOmzy30wpisDayixFuLQF9Pkh
IQyH2Jdushh0x6zjy28MxaY1uE7d3CWW6P+hm+uaN01U7U1DYsYI5BW47gjP72ov
nlqK/gEph5SrEsL9R74Yx+P+k0stWNCYoNl56zE5o7Bx98ul5OcOGWXWPVFcJZhn
Ls5DH7EzzmRfUJFxTMnZZYn4h8xvBAPCyil84rPV68BywrO/Tm3nH3l3BbLQQPKL
WTTAbqIxqhQNdt2QJxJBDivcPcEk4/7LEEaciceQHCXRyEE25Vm62YHsGxfeQvnS
DOsd3IPNwf5Wa0VL/6afUICLWWG+bQ==
=oe7M
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
