Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296803513E2
	for <lists+linux-spi@lfdr.de>; Thu,  1 Apr 2021 12:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhDAKqi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Apr 2021 06:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233637AbhDAKqd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Apr 2021 06:46:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B77F60FEF;
        Thu,  1 Apr 2021 10:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617273992;
        bh=9sKFnSc9rtGgqXQ0SUS258LJYfALb9fDVpeMtG6rJeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4Usc08o9FqlxwhfHOD6/pqxw0axGN8ETuAazPivL0XavDyMYa2Q580xMZWrepwLe
         A8U0WXwO5ekvdBoqvULdVrDB5PeRIgCvfBlN5Vf0ReVMFgy8UoqqkcfjXKDzdXgaab
         0Wb3xix3s5XKfmKYO4dshne3aUdVozc/eW4c9Wm62j1MaDKpPI3HBar4Jt0RezXCGl
         /TVtyLIlm17u0LNYSdafulXS7Ren4kPsej/XwGXxCQAE/fDP+aez8jL3vplf6Jmt6B
         MZrDheeFLYGet265zOQMUXilizgK2pUwa71gzSLW3yrAtTKKSjHHXdxlvfa9ArwgZE
         7hCzXSYyew1Mg==
Date:   Thu, 1 Apr 2021 11:46:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] linux/spi: Remove repeated struct declaration
Message-ID: <20210401104619.GA4512@sirena.org.uk>
References: <20210401065904.994121-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20210401065904.994121-1-wanjiabing@vivo.com>
X-Cookie: You will be successful in love.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 01, 2021 at 02:59:04PM +0800, Wan Jiabing wrote:
> struct spi_transfer is declared twice. One is declared at 24th line.
> The blew one is not needed though. Remove the duplicate.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBlpHoACgkQJNaLcl1U
h9A6dwf7BCkbfn2J782vqDfyi3SzKIocf69ce2iuNjxKNMuahUASIg7IfU95F9eA
YiCx7GFQOC+2Eb8Sa6OJdK8vPo8aENlmu49iocCtDmegwpyzdTTfsbkwhGI7ZnKC
7liaoKBZrR+1opkY9nszscG7+MFDOp/UU2ZjZeRwsM6igJb45nMUvRTVXmBmScAS
lzAuNSogX3tAF81tXLyPuY7koJKBeDISU5lHWaQMZpGIw+Wfy/w0GQnDmiH2XndI
n/jVYrN00NClOu/9W9acb+wQ/BZeN5VRgZW22LFowBoJkAb2tmIP6wog7ONrAdM9
b6rU1wCMHzg0rHd758q66pOJ06BiUA==
=HzaJ
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
