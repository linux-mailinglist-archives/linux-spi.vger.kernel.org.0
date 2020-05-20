Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32DF1DB3E5
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 14:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgETMne (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 08:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgETMnd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 08:43:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9FB7207C4;
        Wed, 20 May 2020 12:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589978612;
        bh=Achw6u2biUSzYpt7lckAtUxEhj9ckmJi3eP9xb6WHM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHUEOW2Tvnp1JASks+INQpiCZxdRRlpi7pMkV2c3FlYjsMlLlMU4WAh9mIFLtuZNd
         Ck1KI6uFONv+G7ViQs+cZ9Sv3/Ars8HUbL3YbReqMQWoLEArdvnKjMNB2LFAcNsOfI
         Qu1e2EmwbdB/uz+Dlc+qffoS9PCwskOnBEHYbKKY=
Date:   Wed, 20 May 2020 13:43:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, vigneshr@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v2 1/1] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
Message-ID: <20200520124329.GF4823@sirena.org.uk>
References: <20200520123612.11797-1-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline
In-Reply-To: <20200520123612.11797-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 08:36:12PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel=
=2Ecom>
>=20
> Add dt-bindings documentation for Cadence-QSPI controller to support
> spi based flash memories.
>=20
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@li=
nux.intel.com>
> ---
>  .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 -----------
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 133 +++++++++++++++=
++++++

The changelog says this is adding a new binding but the actual change is
mostly a conversion to YAML.  Please split the additions out into a
separate change, ideally doing that before the conversion since there is
a backlog on review of YAML conversions.

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7FJfEACgkQJNaLcl1U
h9Dl3Qf+LTw6kS7EVKhUNveex8WPCXk8hJiM52SWUTX/njGNYrVCplAyGQd9Hnvk
bTc+7RDW6mAQ7Hum+CIJzNb7DgJQGCV9MEQ4V/f+/lhDAvNI5x0QSPBLZp9DOI1b
RA/tyCJfh4hwm9RtoK1HT4sDhvFGQR3Sb/nMpVlkZPLd1Jpox5zuuDaCOJEJHAKb
Gss5uyXiON9Qk5ee4vwrIykntpBN/snP1b/FBZf8d0xzw01nfm2lsrAHQMk6n4CJ
oxSL8dArY7vq1ZkNUKNE5qkn0Y6VRjohPZzzc8evRtLR3xaQl+FwAsllDH5VMWTP
oa4tOoSbipP93UpzOvMah+tPGuguUA==
=IU1B
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
