Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB121DCB7C
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 12:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgEUK4u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 06:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbgEUK4u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 06:56:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F30206F6;
        Thu, 21 May 2020 10:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590058609;
        bh=seW5V778px/AgzonYSOezyKQVmV3Co7HCNgbinTsjyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZbg4vvcLz0BWO3+7f3IRMU9tzhJygn8ioscFP/ZqnGFrF8ie91HV+nRvRe7qZKIL
         S4NZZiLfJgP7Eo4tw1u7++Vd48k3aP42ktKeKc4oOt/epvOoOm3tlg+XEVahGyWWCX
         SCivWjO4FdwbrEKnERNBtyqMub/z9gqjdOyvQsgw=
Date:   Thu, 21 May 2020 11:56:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, vigneshr@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v2 1/1] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
Message-ID: <20200521105646.GA4770@sirena.org.uk>
References: <20200520123612.11797-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200520124329.GF4823@sirena.org.uk>
 <fd086da7-7e18-83bc-d423-56095b0cff96@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <fd086da7-7e18-83bc-d423-56095b0cff96@linux.intel.com>
X-Cookie: Keep your laws off my body!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2020 at 10:18:26AM +0800, Ramuthevar, Vadivel MuruganX wrote:
> On 20/5/2020 8:43 pm, Mark Brown wrote:
> > On Wed, May 20, 2020 at 08:36:12PM +0800, Ramuthevar,Vadivel MuruganX wrote:

> > >   .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 -----------
> > >   .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 133 +++++++++++++++++++++

> > The changelog says this is adding a new binding but the actual change is
> > mostly a conversion to YAML.  Please split the additions out into a
> > separate change, ideally doing that before the conversion since there is
> > a backlog on review of YAML conversions.

> Initially was sending the only YAML file alone, then reviewers suggest to me
> do this way so I did, next by split the patches like below...

> 1. remove the cadence-quadspi.txt (patch1)
> 2. convert txt to YAML (patch2)

That doesn't address either of the issues.  The removal of the old
bindings and addition of the YAML ones needs to be in a single patch
doing that conversion.  What I'm suggesting should be done separately is
whatever changes to the semantics of the bindings you are (according to
your changelog) doing.

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7GXmsACgkQJNaLcl1U
h9BdFwgAgFljcWTcMb6Us4MfVHcgy1YEqUmIwGaqY2UIBzMVQryRSOVEhQ4rpXHl
axvDWQGwewuHB1d0UU8Ec+YKWRJl/MYTCtmTHuE4OYL5ZY1YCM5udJ05u/8FuWB6
Z1Pqt3iJ/QHc76gNqZ+BXnUMGh222ixJSSci5lTKkznlratWhtyz1wJU8IJ2I+M1
zRwl78qMsTvBE8abg7NBXHMlQae0yQVcr0ndYjJkx8z/5C6RvFQ+WGCPjf+xTH7E
IEQxy2zRFVI5EJjofGLCDWitAZSLDULZqh0LObpKRJN6X9aOriK+dQzSVAH2EhvE
ElA/2sH+NZpcz19Wlp6+U+5xNYTNqw==
=Xvew
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
