Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2521022092D
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 11:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbgGOJtu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 05:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730854AbgGOJtu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jul 2020 05:49:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0174206E9;
        Wed, 15 Jul 2020 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594806590;
        bh=9xx+gNtt6oLKxftC59xyOBTx9fu4Ex6Msj/y14JyeWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ymdu1pusQGg3JKkkxYsuWEvNXbUAmj6yZmX3c5nnbA3rs6vQFtoG3QW9cPQ0+LEtn
         Jo+k18VjelP0t6a4o348atJSeCgZBIECuTTxeGuzPwn3lLCUcpT1w1wrMmr/0ppM01
         CaSdBcQqbLFNsAwj/ZOKebcI+o2WFy64YNsNUzbg=
Date:   Wed, 15 Jul 2020 10:49:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: coldfire-qspi: Use clk_prepare_enable and
 clk_disable_unprepare
Message-ID: <20200715094940.GB5431@sirena.org.uk>
References: <1594790807-32319-1-git-send-email-zhangqing@loongson.cn>
 <1594790807-32319-2-git-send-email-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <1594790807-32319-2-git-send-email-zhangqing@loongson.cn>
X-Cookie: 40 isn't old.  If you're a tree.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2020 at 01:26:47PM +0800, Qing Zhang wrote:
> Convert clk_enable() to clk_prepare_enable() and clk_disable() to
> clk_disable_unprepare() respectively in the spi-coldfire-qspi.c.

Like I said on the previous version are you sure that ColdFire uses the
common clock framework and has the prepare calls?

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8O0TQACgkQJNaLcl1U
h9A/dgf/aLQzZJxJjJtHkv0PkrYiFHMKt2j85g9+O2DYaRsaX7NqkYxlg7mdzgaC
m/+BgYLwuUMzGHtkk10454Sdixed6OMIARbGbX6SfzUOIgkeqMOmStuTlVh1ShcL
TLB6EBDXUaVXvozf5NTIfQg2HYoB/4eUILY8jI56JJwhn034883Eu429EGbOQWCs
TO9ndf1B6klLdBJ+u7Arl20jUHmiCYPLIuhPHdaKSzsV8FMMP4TdmeMhi1SX0fVO
uiTbBXXsucV3+d7KUxLzCUR+h4plV0R5ckyucfTZE3luKrg3PYHL5VXUE3S9UVlz
rHHfbNqENQMR5G8iyTkI8IjSiqnF8w==
=How3
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
