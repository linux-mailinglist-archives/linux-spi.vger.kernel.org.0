Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E41DCD0A
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 14:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgEUMhi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 08:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgEUMhi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 08:37:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 547DD2070A;
        Thu, 21 May 2020 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590064657;
        bh=XzY9Vu3vZDIMRqhC2Uec8ljVnAJkU8kHTGL8ax+6XUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Hh7R91MXepY8cJaTBq4r9BBHcCknRHA4kdtVwWZGAoahyEhDYtZUpVhR2+huC2ip
         hR/cvCRBcGfdmuFUvqWfmOB6yYDafJQcIKkuSdnmwxQEdI7Lc6ZJ8WOZVPHkTiFu+6
         zXB74atNrHZCB3MQ5YyiYn7J01c7AwODVBRHTw8M=
Date:   Thu, 21 May 2020 13:37:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, vigneshr@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v2 1/1] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
Message-ID: <20200521123735.GC4770@sirena.org.uk>
References: <20200520123612.11797-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200520124329.GF4823@sirena.org.uk>
 <fd086da7-7e18-83bc-d423-56095b0cff96@linux.intel.com>
 <20200521105646.GA4770@sirena.org.uk>
 <24b0297c-5c33-f690-9514-68b76fc2c9ea@linux.intel.com>
 <20200521122035.GB4770@sirena.org.uk>
 <463b24a4-0a6a-9fcf-7eb9-8fde602c0c13@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline
In-Reply-To: <463b24a4-0a6a-9fcf-7eb9-8fde602c0c13@linux.intel.com>
X-Cookie: Keep your laws off my body!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2020 at 08:34:43PM +0800, Ramuthevar, Vadivel MuruganX wrote:
> On 21/5/2020 8:20 pm, Mark Brown wrote:

> > I mean that any changes to the bindings ought to be split out into
> > separate patches, if there's multiple changes it may make sense for
> > there to be multiple patches.

> Got it, we do not have multiple changes since it is new YAML file.
> in case if we feel anything to be added , we add as separate patches.

If this is just a conversion to YAML then your changelog is wildly
inaccurate and needs to be improved, your changelog says you are adding
new things.

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Gdg4ACgkQJNaLcl1U
h9CEowf/QMYDfB1WRpIHtE540R46+Mt+m6ieiujeMi72a0tdEVaExwPeBNHvHAfr
JeVWeL+H6//8H2NcR5NwR6kVDFYNlx7h1JSNKhOpMedxsT72sJxj62hadMgF18Nm
laUg+q/bz+kPN6qOpAb6iY9ocf6vo9qWcYcKK00DDrrEfkLVF2KbLdft9dGzs75O
VApz+3bfiMY4ROV3Kc08V7xEGyJbXRWnAtiA21+9XrWjiuqYtfuLue+2qeFiE9Hu
3eacgVdd0pGiBjrEi/WbwRUoAnbQBFpRisqkNz/OGtt3d/8mvjF2prNW9QwsPH+g
zugQEeTYSCDR4Nm36ZHyuqzau9hAvA==
=zxZ7
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
