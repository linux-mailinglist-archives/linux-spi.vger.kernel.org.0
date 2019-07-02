Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 596775CE79
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2019 13:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfGBLfc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jul 2019 07:35:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59404 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfGBLfc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jul 2019 07:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hYs9B6SOA+/TMNFNDcAK5dC3+A8RDOkifXgUA1qtYJo=; b=RJsGc4YTbgQjY/N7WoHlpwKdg
        d3aFcNSpvmM7QiQh4LkKTRfsq+TgBcSY6tdKgG1baBWIv7WGpSNGR+KdafrJNTsocvtMcN8xUSj88
        02fO5XWYsxGCUVJ89D9comCpJ9u8kvYLm7FMrVwl6WusLJT7TyAEH3UCuMAiVrBWK1wk4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hiH4M-00029b-3p; Tue, 02 Jul 2019 11:35:30 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 464CA440046; Tue,  2 Jul 2019 12:35:28 +0100 (BST)
Date:   Tue, 2 Jul 2019 12:35:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] Revert "spi: gpio: Don't request CS GPIO in DT use-case"
Message-ID: <20190702113528.GG2793@sirena.org.uk>
References: <20190701172517.31641-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O8XZ+2Hy8Kj8wLPZ"
Content-Disposition: inline
In-Reply-To: <20190701172517.31641-1-linus.walleij@linaro.org>
X-Cookie: This sentence no verb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--O8XZ+2Hy8Kj8wLPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2019 at 07:25:17PM +0200, Linus Walleij wrote:
> This reverts commit 249e2632dcd0509b8f8f296f5aabf4d48dfd6da8.
>=20
> After this commit drivers/net/dsa/vitesse-vsc73xx.c stopped

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--O8XZ+2Hy8Kj8wLPZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0bQX0ACgkQJNaLcl1U
h9AiMQf9Ek3h7F15W3ANvi7fZPoxtzSQJrFQma0fHhEHq68GzUGQc2fPI6trv21S
aOOCEHMN5wJLuY40OPWMW5t/C595s2EFH5mV8saSghIhqA9n6uKNZbSYvzxLTDJn
s3W08mi+NU5dnn0sQsYcXN11q3EEri2w/lynUOZYJWChMdJn7J8RgKSyvvtoTz48
Qw+SU1T4dLUKZBN/S+YTgev7KVJac/dKLtw6NuVjL0Kxnre9btWOBBB7ZZnE9wqA
MQo4mgq8RaMIdH+M+fwCLEC79Fi2uwcVcwPba2onSwpCpDx2qW1EsXB2tINaaNVP
H8TREo1czzMM7z9oC0wa1U1EvMpLHA==
=Llsm
-----END PGP SIGNATURE-----

--O8XZ+2Hy8Kj8wLPZ--
