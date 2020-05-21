Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C6E1DD40A
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 19:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgEURNk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 13:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbgEURNk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 21 May 2020 13:13:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82FE920759;
        Thu, 21 May 2020 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590081220;
        bh=nLt/i15MjrNqsvOy9V+a9DQMHa6geg3s34SazJ34AHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q6tZlNf+RLWG225hD6Aw5iF3BpM/yh2Z7VInb6ke+UEVhW2PWK10GYrwFpmlLYW3r
         fgo+1m6zLsuxqE5m9eDeWuPneOMyC38E/a07Y5Q9DGhN6Qs4kRPX6KBcexADrxD4bB
         /pxKnzD9iqwZgfr27IAHNiaO85az9soxX/7mWooY=
Date:   Thu, 21 May 2020 18:13:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: snps,dw-apb-ssi: add optional reset
 property
Message-ID: <20200521171337.GI4770@sirena.org.uk>
References: <20200521170359.20430-1-dinguyen@kernel.org>
 <20200521170359.20430-2-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Az4VpBrmI9+OyhK/"
Content-Disposition: inline
In-Reply-To: <20200521170359.20430-2-dinguyen@kernel.org>
X-Cookie: Keep your laws off my body!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Az4VpBrmI9+OyhK/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 12:03:59PM -0500, Dinh Nguyen wrote:
> Add optional reset property.
>=20
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/=
Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> index 3ed08ee9feba..e01c557a9876 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> @@ -37,5 +37,7 @@ Example:
>  		num-cs =3D <2>;
>  		cs-gpios =3D <&gpio0 13 0>,
>  			   <&gpio0 14 0>;
> +		resets =3D <&rst SPIM0_RST>;
> +		reset-names =3D "spi";

This only adds the example, it doesn't add anything to the actual
binding documentation.

--Az4VpBrmI9+OyhK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7GtsAACgkQJNaLcl1U
h9AnSQf9HejrmAdErVY3ochU0FJ0BN0NFP/F4rzGy344mciEsopTU3UIpdvfyBQj
AbbZ+UOt1IAaJAKRse7bPAMKDGigZQW+g+9zYAYSidLn85rHwao8UVHmFvTRIECk
/uWiuDT2YQVHWJgbrlSlt5n1MTffhOL7UrvDgsPIOMo4j0H17LUiDxUNMY59CJ/z
h1Z4GtBLInhcyopo7gNns/ZYUTmFNyDBuat5pyzbaQJ8bifG2vbxbkmstNw0FO5y
Jb0jmO/RP45iCWb2mKdu99q7LtpFV7Fkis14c0/PeNTN8ZXH00RqK1xU4KCEJg1P
8h1KkFl3OBA5PSaefEcvZLk13CRv+Q==
=VJF0
-----END PGP SIGNATURE-----

--Az4VpBrmI9+OyhK/--
