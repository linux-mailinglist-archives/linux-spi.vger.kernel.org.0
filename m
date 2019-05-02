Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B57111B4
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2019 04:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEBCmM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 May 2019 22:42:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39154 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfEBCmM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 May 2019 22:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RQycgOI7TQiHnn6G3te99vU3cYPvSzTcJudMZ61IXZQ=; b=AjViRcaLcDZVQ6cSw1edgQTn/
        FF+nDFbWw710FRhA/9bNhVT9R3YcO5X0YwlcB7XLn6/1JggawODHic4p/Auje1pRcRjaqhkCAW78a
        /3ednAJWpIiCIiyhi2/vgshjWGdPNv4kUsoE1CnamIjv+H+PqUQOBNk8uwfXq71IrJzIA=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1fi-00060m-1x; Thu, 02 May 2019 02:42:06 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id F3EE4441D3C; Thu,  2 May 2019 03:42:01 +0100 (BST)
Date:   Thu, 2 May 2019 11:42:01 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Timo Alho <talho@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Subject: Re: Applied "spi: tegra114: fix PIO transfer" to the spi tree
Message-ID: <20190502024201.GU14916@sirena.org.uk>
References: <1555363834-32155-2-git-send-email-skomatineni@nvidia.com>
 <20190416163257.956F211281C6@debutante.sirena.org.uk>
 <BYAPR12MB33989027C79790E4B3CC827CC2390@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jllsgs4PL/sXFNaa"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB33989027C79790E4B3CC827CC2390@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--jllsgs4PL/sXFNaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 09:42:39PM +0000, Sowjanya Komatineni wrote:
> Hi Mark,
>=20
> I don't see below patches that I see as applied in latest linux-next.
> Can you please confirm if they are applied?
>=20
> Applied "spi: tegra114: fix PIO transfer" to the spi tree
> Applied "spi: expand mode support" to the spi tree

Check again, they should be restored now.

--jllsgs4PL/sXFNaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzKWPkACgkQJNaLcl1U
h9DYAwf+MNXdI7RM9oCnExD93pc31GFmhhpwuxn0wXF2H8qg9jWwV87Qk4S6bQad
84+WJDZYteWg3gwEh5Gx37njs6wpVd8SAss0WLwEbWqdNf69U28K2jSMEcPWmAIG
QeQeukw5cm3dyHUOpqaQnl+idg0RxIUjSU7FXFJLz4B9pOqbH71Vozf+ZKH/v1kg
Pzc5Kwla5P2aO4V55R4JLM/M0wrbk7rUMw1rww8kfIm8FwmdxN5G9812yburnI3b
q3k0PDCYT1QnxFKC/ZrzdLy+etMUHinOaHLBKy/b8UWWewZ7zNBs3m+yctbmXZMz
3MCsM8VordXwiEmuKeN1AyQGoHbrtw==
=evNI
-----END PGP SIGNATURE-----

--jllsgs4PL/sXFNaa--
