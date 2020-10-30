Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326512A06A4
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 14:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgJ3Nmi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 09:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3Nmh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 30 Oct 2020 09:42:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8C00206CB;
        Fri, 30 Oct 2020 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604065357;
        bh=gcZRJlf2vRw+dqbq1y4yCYsNH63imKJ3BSp0HkZ2ZC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MINvTug0WTBf/n6Fo+7iut6Mqjv2PP3F3Vck/6HiSPumwTBmesOYEGHQOAVck39L8
         Z10U8LiniP+QbNZoRYzD6J++wJErlDVRh897NnqxFBB9RLGge3BJoZICXVk2k69nun
         1F1PkYhIhbwX2ZMRlf9pN0sK4UgsjhPzvAxcnLs8=
Date:   Fri, 30 Oct 2020 13:42:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Bangzheng Liu <bangzheng.liu@unisoc.com>
Subject: Re: [PATCH] spi: sprd: add runtime pm for transfer message
Message-ID: <20201030134227.GC4405@sirena.org.uk>
References: <20201030072444.22122-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <20201030072444.22122-1-zhang.lyra@gmail.com>
X-Cookie: Blow it out your ear.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 03:24:44PM +0800, Chunyan Zhang wrote:
> From: Bangzheng Liu <bangzheng.liu@unisoc.com>
>=20
> Before transfer one message, spi core would set chipselect, sprd spi
> device should be resumed from runtime suspend, otherwise kernel would
> crash once access spi registers. The sprd spi device can be suspended
> until clearing chipselect which would be executed after transfer.

The core should be handling runtime PM for normal transfers, if it's not
managing to do that then we should fix the core so it's fixed for all
drivers not just this one.

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+cGEIACgkQJNaLcl1U
h9B4Pgf+IvIiwEDkZQaxyvEVcgYx1vNEX4NM/KNwpFoJfYbEERBxkcJ7YZaL5Y5W
dRAoqjGdbvgXk4jXfzqjCXoodXEknonwAI7rU0KeWZeg4NUzSHbA4GOtNSDP1sBz
5m2rv79+/B1u1Dp2iRAY4tSt+lnlvR6MjNZuyL4NrXrQDGs8Oma7uaOa1LYcGEx/
91KdS71KXko68rLVJsDkjmzWuQigmQ+swHfIH8URGKAOpma68rbeVaB1SydUbkou
kODB+bA/j8CfABKaddjmfVL2D00lk7Z0MvQ9ZJiw8dWQi+5JXG2cnbBJahx8jwMd
zdjzNr+VcJpRlf6LvBaVRvRQl9ehbw==
=Tpkr
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
