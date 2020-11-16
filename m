Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30F22B508B
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 20:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgKPTHy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 14:07:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgKPTHx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Nov 2020 14:07:53 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 394732225B;
        Mon, 16 Nov 2020 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605553672;
        bh=yosXMLmSKHZhkAgd5D8vJ5A8qZi+NPfl8uhqpTpOj6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqKf9OldNsSdey8/QJeb1luOcd4HwBPSIVYjTLj4rB/CEnWdloMS9AvJgcRqaIgM2
         mgirUWUsENniK2QwP3AomrpBweLg3Y6wSN+dQ54U4OIrdm5kUuW0WVBaLQs4D8sLIU
         13UQXjlpCrGXInaBO3eJFoqP6K57yNj+VU9/tw68=
Date:   Mon, 16 Nov 2020 19:07:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, vigneshr@ti.com, p.yadav@ti.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v7 5/6] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
Message-ID: <20201116190733.GF4739@sirena.org.uk>
References: <20201116031003.19062-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201116031003.19062-6-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline
In-Reply-To: <20201116031003.19062-6-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2020 at 11:10:02AM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel=
=2Ecom>
>=20
> Convert the cadence-quadspi.txt documentation to cadence-quadspi.yaml
> remove the cadence-quadspi.txt from Documentation/devicetree/bindings/spi/

As previously and repeatedly requested please make any conversions to
YAML the *final* thing in serieses so that issues with the conversion do
not hold up other development.

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+yzfUACgkQJNaLcl1U
h9Db5Af7BSeCmDzgNuAKNa2DAq6jwsMGG9DCDDfsoV8mVxxj88/2ctalltiwpuki
WiVDc6AuNbqSQhFOWzh5kI1zqNra9A9s1YP8Z69Uld1B/ZrqL5LDr9a9xgWBvsE7
Co768+PNi5fp1x2hoiFF1MgAUOMsGmKkALVxborYTqB4f3/CC9SJYh94yxYd2dRD
wdtvJQr4gmGKdwhuhjwKcl+m5dyQ9uI9zWZZFmwkCXRzaW27ndw83utGRPd4Z6ht
ExGxovoAX/V+HX/sI4133h+F3emUKGJi0c3jT5GLZPRgFDXVSx/B04FBzfn2qlE+
uleRMfluu5LB/PQJzQrNCFNzeZSYHQ==
=Hmhj
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--
