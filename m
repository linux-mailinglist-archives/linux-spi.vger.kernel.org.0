Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3DDFE3198
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 13:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409247AbfJXL5d (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 07:57:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52912 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfJXL5d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 07:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kr/f673Mx2Vmgq5uo7UsU+3VpfM6pi0n/reFDWnN8wE=; b=k/DxNRglph0oPYk/ZLphi1qgQ
        PM9tTq+iwhUBYYerogIFjXcP/hJk2lHoIx4iMjAoeb+yjpp6/xIzA9ia/CQ/rs1ehJLHMl4QnxVKC
        q8AJmwSR3gdCU4Fh3BfdHWB+q9lXLd4SnvIrc97TSLdJJV1PZ/rXIfHb055QHiHTOl8lU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNbkB-0003RP-6r; Thu, 24 Oct 2019 11:57:31 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 62930274293C; Thu, 24 Oct 2019 12:57:30 +0100 (BST)
Date:   Thu, 24 Oct 2019 12:57:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] spi: xilinx: add description of new property
 xlnx,num-transfer-bits
Message-ID: <20191024115730.GD46373@sirena.co.uk>
References: <20191024110757.25820-1-alvaro.gamez@hazent.com>
 <20191024110757.25820-2-alvaro.gamez@hazent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
In-Reply-To: <20191024110757.25820-2-alvaro.gamez@hazent.com>
X-Cookie: Filmed before a live audience.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 01:07:55PM +0200, Alvaro Gamez Machado wrote:
> This property is used to set the number of bits per transfer (bits_per_wo=
rd).
>=20
> Xilinx' IP core allows either 8, 16 or 32, and is non changeable on runti=
me,
> only when instantiating the core.

When sending a patch series you should number the patches within the
series - if you use git format-patch to generate the series it'll do
that for you.  Instead of [PATCH] it should say [PATCH x/y].

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2xkakACgkQJNaLcl1U
h9C3mwf/X2Y/6MG6Ys70X6/iuqHqjQxiTEWQ4lSNMUySWRanZOh0rsMiVwP6UgvG
QZ8Bw6SiLxRjSmmUShqLq40H/tU3i3NI+KWk9gTS7FJOSMcyoPIUME3UzH7mmAPT
bUsmyEjsNxPQPJwqsg9PEzzvuseJ0hmzJNJ4UnaE6//aAif1gf4Fedh2jxRUKv8Z
f1VxD8XCCDynapU7mh8eiR6xD3ZBoP8WrM4hC1oDVPzqGMax31jPg7sZi2EhDbsj
KnqpETSlXWxrB/5ndItUC/R4xcPB40B87sZy7apRXcJNPrEZUNoKhT+CuE9JzvO8
2Fkmo7hULG6kNcK9DQgA82ZXT46ewA==
=ecyw
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
