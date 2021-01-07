Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E267B2ED134
	for <lists+linux-spi@lfdr.de>; Thu,  7 Jan 2021 14:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbhAGNyp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 08:54:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbhAGNyp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 Jan 2021 08:54:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 118F523142;
        Thu,  7 Jan 2021 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610027644;
        bh=JC8B6lBRxho+1ODflmPrVl9UKrYdblTNvt6nNyneuxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzY/Hon3PQidJf6ttYVo7P0dBz+O0ES93bOHvW7sdP8xDcV+kf6/Hg12+zfkIsVl+
         R39e1pUUExT0RCBvoYoPelnr440VI6RqulM2tUbx4I2ndIXOWrMB1MuqliiSo3c26r
         1RNpWcHKuL+QrnBKIOZhnfi/Wcpo/Taf3eUJv5raaINDBxyAiKncI6wEUJxuvLsvPW
         554ylAWP7R9552vUXpNap7CurvbD2G4VfpcuyEKlKEnQovPGPpXfyVMheT/BUebYcW
         CWVnWN3bRHYakcQ0tJ3YSDxinHbgyx+47RYlRJIFBSNmvAHqMG2OLif85i4IJolRvJ
         dx9hjhpIxKmdQ==
Date:   Thu, 7 Jan 2021 13:53:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, linux-spi@vger.kernel.org,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yanteng Si <siyanteng@gmail.com>
Subject: Re: [PATCH] SPI: Fix distinct pointer types warning for ARCH=MIPS
Message-ID: <20210107135335.GA4726@sirena.org.uk>
References: <20210107115704.3835282-1-siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20210107115704.3835282-1-siyanteng@loongson.cn>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 07, 2021 at 07:57:04PM +0800, Yanteng Si wrote:

> Fix a new warning report by build for make ARCH=MIPS allmodconfig:

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/3El4ACgkQJNaLcl1U
h9BADgf/Yoc1itNJtl6V/Ir8SypswnoNyiqPdzCbJmgWSrA7IGIhUgbtHVA6GLBf
uiR2+ddAB6j076SnwKxIBZ5FSyiqec5dutgC8rtczQj8vg7zLUgtXNEGLF9tO4li
tIGW675EwpAklAXYVjPI3XCSJijxdj6Xt45YBlBLFhYnKtXa5ylY+nPEhnpHisnj
SEL9KOS39Fq8vr9BBDPN99BA/sKq0oXym39U87/fml67mrAM5peeRqalUGacEhRg
uCEI+qmlLucboRtoAMwBilDr6Ur9236KCy0e5l2aFQ1M0bnlnS5Zzm1nfRXqicrm
tj4z5Sn8Sfi2p2QpZIxQpSP6V1vIPw==
=U1it
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
