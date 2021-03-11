Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF35A337856
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 16:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhCKPoC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 10:44:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234320AbhCKPne (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Mar 2021 10:43:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9624564F99;
        Thu, 11 Mar 2021 15:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615477414;
        bh=yDXgS0inYi0WFo3hlPHqtgtfl3ofv2QGTiheosYbsgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DO49/VF0hYvfoh02CmVLYgeKyW2I0WgBl4pqoV7NoIjGE8P3vdgTcOkDXf5UiiA9u
         gL3TYXdLM0LZfLALCKkfJCVdSfhev2lCaGbA1eQTSc2h2Lp4eunIPJNPS1G+4NoZNW
         5Vq+0wnoRsS//E9ZE4ppX0UMiait1K5F73Fky3EF8DPlmQcVbdm5mX9OQStUwl4g/Q
         Y5DchnhM9RXxbMWmIOzg90L7pZBS26ubra2cZL05JMVrtTel3Q1wBlduRbWyICp8HS
         RKv3KOcap/RHHeCA9IJHGNfvoBTiHsvfB4udKqFDcStB9vf4Zsf6rcW/y95dsaJ+RG
         jV3zj+n2jRT+Q==
Date:   Thu, 11 Mar 2021 15:42:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Li, Meng" <Meng.Li@windriver.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "vadivel.muruganx.ramuthevar@linux.intel.com" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] drivers: spi: cadence: set cqspi to the driver_data
 field of struct device
Message-ID: <20210311154221.GE4962@sirena.org.uk>
References: <20210311091220.3615-1-Meng.Li@windriver.com>
 <20210311132629.GD4962@sirena.org.uk>
 <PH0PR11MB51912BDD33645BDAB88B0139F1909@PH0PR11MB5191.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline
In-Reply-To: <PH0PR11MB51912BDD33645BDAB88B0139F1909@PH0PR11MB5191.namprd11.prod.outlook.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 11, 2021 at 02:05:18PM +0000, Li, Meng wrote:
> Thanks for reminding me these issues, and I will pay attention that when I submit patch next time.
> Do I need to submit v2 patch to fix this issue?

No.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBKOlwACgkQJNaLcl1U
h9D9Twf+J3ItvaZ+wzdHvKPgLVDyBgX7VaD03gaKv46qk4cJuO9Ca5KwXYXccoG8
IRgDyQLeVs+vTlFU/U88V/eBrGFO8LIj30RBLKmwzMQ0ZcWbDm2sLv9jzXgPLD1j
B+avcFvw3RZZHRhJp/6/4RzF/epwrNTBB5CFH7A8kYGZ9M1+GQkn0pVbguuDDuYq
F7nCI0p+wvsiELcHL4VXZjXEtSC02POR4MpG1o4lAMDv4Z9a04FSzCBCqIP++rVb
PkdDqpGC5zvPoMs9CH3JuI0sZ8BuVZ6ZIDQzXuXKpEGnq3wO1sE+DY0Wem+U1Hnq
02FCLKw7Vy+MAFpC/Y8TAOSXxvzVsQ==
=MM7O
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
