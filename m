Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B896F789CF
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2019 12:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbfG2Kvh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jul 2019 06:51:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42456 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbfG2Kvh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Jul 2019 06:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fp98NvsVQHW4OteUr6DoqjsManneTqzSgEmj4Sv6NWQ=; b=TlrwPKA0cPSJXmi/CZ25ALugV
        fwE4t4puANsJwlT545pg2qTFU4B+9F6GQ/3Vul5hbHisbMVARhBjcbRa24Zv2oXN2VB6YsUcDLK7Y
        dOD+aHReKKAGSf3i1gXHw5qn1blH1XnwlHIny424vFxgYHzeNuB35PUh3wafro2dQtaC8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hs3FW-00048A-Dm; Mon, 29 Jul 2019 10:51:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 641832742B59; Mon, 29 Jul 2019 11:51:25 +0100 (BST)
Date:   Mon, 29 Jul 2019 11:51:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-spi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] spi: tle620x: remove stale driver
Message-ID: <20190729105125.GA4787@sirena.org.uk>
References: <20190728161304.32022-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20190728161304.32022-1-yamada.masahiro@socionext.com>
X-Cookie: A man's house is his hassle.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2019 at 01:13:04AM +0900, Masahiro Yamada wrote:
> This driver seems obsolte because this driver needs platform data
> but no one in upstream passes it.

I've not noticed this driver getting in the way of anything?

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0+z6wACgkQJNaLcl1U
h9A8iQf/WUaWbus2/y56hSB5wgIdbmnLdlQKFIbOiLlLCvTHg1+B16u4ggqtmNNy
i/LxhIXJHljhPSB5UqNvqGbUUfJPqlC6EjP/VH9Se25srhYgCzNetng4TSJgUhf6
mPx38/UCRMss9iggUIlCcZlwum4olpdkChGQCKbRpJYiJEmAT4/iiNdRbOhNVGor
w75RTowSMbKKwzSw/vcrpZiyH+XV2xoRGiDRAR2yltKK84yEEvRd8LsiZnYtKm/f
oEVeTbr2aM5P0EmyoTUN6waKMEHyUKDfiYI8fPqh+YIqEUM1cGor0tRyQUFah9G/
+M/W7SX1YG7bE4+hsWQjfNpfkAxf4Q==
=+NF+
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
