Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2CF3B62C9
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2019 14:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfIRMI5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Sep 2019 08:08:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50852 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfIRMI5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Sep 2019 08:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I7ZSOi9ERNuZrChF34ftkmrACUOOUkBVRRUL3bpwH6o=; b=TQP/YZlPrlIkySDwC3drCix1O
        hwRZOzuquGyFRmD9PNjZmRRzuhtuhOg53TcDFEsDarrFSCdkzBMr3clRGAectqgAtXY1gtMsq08ij
        YT+0Ykfrw8x1yTAVr0YRBK8LCVOVz3ME1MjXGshCHaBeIrDoJPzdqmg5g6Qtdo3MUunhQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iAYlM-00054e-LJ; Wed, 18 Sep 2019 12:08:48 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2DAC92742927; Wed, 18 Sep 2019 13:08:48 +0100 (BST)
Date:   Wed, 18 Sep 2019 13:08:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v1 2/2] spi: cadence-qspi: Add QSPI support for Intel LGM
 SoC
Message-ID: <20190918120846.GH2596@sirena.co.uk>
References: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190916073843.39618-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190916113255.GA4352@sirena.co.uk>
 <466b41c1-3d65-0bf4-6db7-d3b3e06b107b@linux.intel.com>
 <20190917153650.GF3524@sirena.co.uk>
 <eeefa79b-0a3b-5d62-3a1b-c1e9dcb03aa7@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
Content-Disposition: inline
In-Reply-To: <eeefa79b-0a3b-5d62-3a1b-c1e9dcb03aa7@linux.intel.com>
X-Cookie: The devil finds work for idle glands.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 01:59:06PM +0800, Ramuthevar, Vadivel MuruganX wrot=
e:
> On 17/9/2019 11:36 PM, Mark Brown wrote:
> > On Tue, Sep 17, 2019 at 10:11:28AM +0800, Ramuthevar, Vadivel MuruganX =
wrote:

> > > *=A0=A0=A0 spi-cadence.c* in *drivers/spi/*, which supports very old =
legacy
> > > cadence-spi based devices(normal)
> > > *=A0=A0=A0 cadence-quadspi.c(drivers/mtd/spi-nor/)* : specific suppor=
t to SPI-NOR
> > > flash with new spi-nor layer.
> > >  =A0=A0=A0 all the API's in this driver purely on spi-nor specific, s=
o couldn't
> > > proceed to adapt.

> > Are these completely separate IPs or are they just different versions of
> > the same IP?

> These are same IPs , but different features Enabled/Disabled depends upon
> the SoC vendors.

> for e.g: Intel LGM SoC uses the same IP, but without DMA and Direct access
> controller.

> also dedicated support to flash devices.

If it's different versions of the same IP then everything should be in
one driver with the optional features enabled depending on what's in a
given system.

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2CHk0ACgkQJNaLcl1U
h9Duggf/UlIeAX6UQNcW0YdFNuwqat0JWT+iz9wojEIWynEPLQj26Zh5zXSa6B4F
tIJd1JvLU9o7A2VFxTUf2H3WZCYoWuHLXKIKWZfutmabb87KoPRI7B8QaOKy1bGe
oJEsKY4AjDv+UnEZo6kNZN7+i7VzpHtBjjg/huoyvLhcVe16a5ScecMKNSA8paQj
JusD7wK1Iub9V+h6Px1n+lb/y+AUc4VXFtzSb/sEgrVAzLBxkoTID5RDFTBRQK0P
K/U30jwLyJjYxD6HBz0Dq8CBdXhg1FYUSURWo/tSSSb+8aSNO3yW2NNZ50BnHVSo
NaPNX7zL7BebDSOMEYBZCGNv8XRFYQ==
=b6Nh
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--
