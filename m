Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFAF2DD246
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 14:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgLQNjg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 08:39:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbgLQNjg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Dec 2020 08:39:36 -0500
Date:   Thu, 17 Dec 2020 13:38:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608212335;
        bh=pSfMUZ96kSdawYMRTaMaGuAJ5GpskXL1E0UCMQOK8eY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWQK1cvGKyWD5Z7PXA0/bnQUgLx6w0w0ZxAJgfoHVD7/VC1VCG9rQ/bjr10LxRr2F
         Cp4qYyOGzGbd1aZGdX0gUct7SzG/LfNNeRRaHKg0RI/IgdWvZ7IjpgtVerbICDH9SK
         yv+mMaMHsocRS55vAkza+7jMoPVAeOYzuIQ9GTYband3LdriK3kj4o85QxtLMaxkMP
         yyfBAwPzUeu3Ceh/hZJdODc9YobUX3pqegl5M5YM83uXG+Dm9Xjps7E2OV3nx20c1Y
         GvSJMqJymilfacQqw9rbSujd/9EFza78tl9MUY/8ch3pIjLxLnuinukOxrdCShN0rs
         FlqHK5XdZs8Dw==
From:   Mark Brown <broonie@kernel.org>
To:     kostap@marvell.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mw@semihalf.com, jaz@semihalf.com,
        nadavh@marvell.com, bpeled@marvell.com, stefanc@marvell.com
Subject: Re: [PATCH 3/3] dt-bindings: spi: add support for spi-1byte-cs
Message-ID: <20201217133842.GD4708@sirena.org.uk>
References: <20201217112708.3473-1-kostap@marvell.com>
 <20201217112708.3473-4-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline
In-Reply-To: <20201217112708.3473-4-kostap@marvell.com>
X-Cookie: I'll eat ANYTHING that's BRIGHT BLUE!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 17, 2020 at 01:27:08PM +0200, kostap@marvell.com wrote:

> +      spi-1byte-cs:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          The device requires toggling the CS for every 1 byte of data

This is absolutely not something that should be in the DT, if the device
requires this we know that simply from the compatible string.

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/bX2IACgkQJNaLcl1U
h9DNKQf+NLSmczuDdHbf5AyFtKeh5uMnvdwsKOHihSFyhh8tMGMofvRk1VRj+yK1
VREd6nshBRt84Pdgl0olHQwfc4l7h85WBDlKdFoSXIW2gmvgmfq1ZBZGuSUOAzwd
lJ42gWxQpvC/vEabBFnZZ/9/ar2T7gNacCoRpnONORH8oWQ6d+tr3f4Gm/+O66ws
sb3Tz5gWjIR8oyEifvGnEbNZNCLbAySFATOo2PZJsJ4a/OrcpT0w/ARC3jwrHzQr
a/CAbsIsRxqRn8UuTz8CREGQgYTEH8VjLadOv0m4VmuUnk2uvhsYG1TnqoP6/37N
z0kBQILFyN0fs0fmgbN1yoEF1c014Q==
=2L8S
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
