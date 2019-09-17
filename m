Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDA7B51A5
	for <lists+linux-spi@lfdr.de>; Tue, 17 Sep 2019 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfIQPhC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Sep 2019 11:37:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41098 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbfIQPhB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Sep 2019 11:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Gx+/S3uVOn7Im6f26MF+ICMwWRzY8FKh9jpA0Ozl0s=; b=Vg3Sd5cDC8kRYjFmh6zJu/GK/
        FiozRqiL8a7LEwEkeCy+HrFImEG+SCdURXm7CaEkJZRGQzxdhjnl8TGWjWXgNHpBw664E5IvM8qGH
        1ED1TqnFXFTXZH7JEwbfGaKHydd63bwsQkjddDCJ8GooGl/ma/PBzfJ2fNmuhOF5Jlxh4=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iAFX9-0008L4-Fd; Tue, 17 Sep 2019 15:36:51 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 844AC27428EA; Tue, 17 Sep 2019 16:36:50 +0100 (BST)
Date:   Tue, 17 Sep 2019 16:36:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v1 2/2] spi: cadence-qspi: Add QSPI support for Intel LGM
 SoC
Message-ID: <20190917153650.GF3524@sirena.co.uk>
References: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190916073843.39618-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190916113255.GA4352@sirena.co.uk>
 <466b41c1-3d65-0bf4-6db7-d3b3e06b107b@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Content-Disposition: inline
In-Reply-To: <466b41c1-3d65-0bf4-6db7-d3b3e06b107b@linux.intel.com>
X-Cookie: Know Thy User.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 10:11:28AM +0800, Ramuthevar, Vadivel MuruganX wrot=
e:

> *=A0=A0=A0 spi-cadence.c* in *drivers/spi/*, which supports very old lega=
cy
> cadence-spi based devices(normal)
> *=A0=A0=A0 cadence-quadspi.c(drivers/mtd/spi-nor/)* : specific support to=
 SPI-NOR
> flash with new spi-nor layer.
> =A0=A0=A0 all the API's in this driver purely on spi-nor specific, so cou=
ldn't=A0
> proceed to adapt.

Are these completely separate IPs or are they just different versions of
the same IP?

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2A/ZEACgkQJNaLcl1U
h9CyIgf8CTzBHfnl6ab2KtgUkLdtcsjko33jDsWaIjRogAUFSRsdNX6r7vpmaPBO
qfrx0rskry+jdBRHt5EYiTmvUIsxLeDzXz0WLtSawdjxG/mG1zKdM8sSk50eNdES
8Abj/5z0s6xNx6gpE0Rb7X2Z/peg0msPqIaJDGrVUWEATB+qih7K/vMJUzvQ4snS
zX+/SOl1PTFJl65fLm7H1DNurJTaokNrV1TNdSpzavnIWu2zaMfkPSTc8x+qIMOr
M8ApiHjcmr8Fjdf4UrHA1msXxn98rQvemS9KBYgzWE3TgnTCg0/NfJs65W6WYAor
XZljVmIteJ/4/Pk0nxzlmCgWd6UeoA==
=v5W8
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--
