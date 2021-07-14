Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50503C838A
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 13:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbhGNLSV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 07:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239078AbhGNLSV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 14 Jul 2021 07:18:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A72A8613B2;
        Wed, 14 Jul 2021 11:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626261330;
        bh=gln4o9RYzRUbHOmzZqjlvV9yan+8+ZdEpUYMAg5gL/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKMWmnZStjX2CGk2zjgDWd8X8ttujb7VrM/P4zovZfZH35IfrCIvb91yoG84Wx2aW
         MgKYD8aBlwy0J/5fxgNEQqLUSC/McZ265/AOgb64FzufAe1o6PeeawnZFcI+cIVzyY
         saubQqi4nY2uFzaCX3mrKcbrFYYMOKIkYFkORC+hvXhmHhf/FvpqAHNlB60tBsjat5
         8KpvKz8V/B0TAUPxFDcg667k9h5U5EZO6OOtOUxiqSr4iCjJO6SkKO1EWfVu7EO9Q0
         hRj2eie/pM4Zc28xgIlhj6Fda21Dep2ZcCfRv4xCjdPsL/cojUselnyrXbXK7eC5UT
         KDG1DMBkciKOQ==
Date:   Wed, 14 Jul 2021 12:14:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        linux-hwmon@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Move fixed string 'patternProperties' to
 'properties'
Message-ID: <20210714111453.GA4719@sirena.org.uk>
References: <20210713193514.690894-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20210713193514.690894-1-robh@kernel.org>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 13, 2021 at 01:35:14PM -0600, Rob Herring wrote:
> There's no need for fixed strings to be under 'patternProperties', so move
> them under 'properties' instead.

Acked-by: Mark Brown <broonie@kernel.org>

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDuxywACgkQJNaLcl1U
h9Bc7wf/VFIPyyWWMsNINwBGSVPcM1hXRLA6fZcXy+7sLbycWy8SufjBoG59RLn/
C4HNt7T8YDEdRgHUu7T0wfXxdfObm8W2RleX8FPEZ7IjD1e7/tY1+cNBBOQNdTdT
T4s9TLh4c0aVjTXwB6TGAANL9kk7kS/bNwpxtnpb1P1rHAvcGyk/vkYNPs9m97MO
KKkpVAzJoJpX9nQxUq+u/xdXkLawzGwA4lv+2Y2XPC0DwWLVGNB6al6tiU/sPlry
pJ+ndFbDfT0lFWG8ZQbnpNW7aDy+ez12Lz6Fksi6s1eEKTCkmNd8FElGbJyAwiIR
m6LUlCuJM3gflOnm28ExPSQjRXv9Qg==
=583K
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
