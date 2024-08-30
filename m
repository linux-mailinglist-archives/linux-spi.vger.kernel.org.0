Return-Path: <linux-spi+bounces-4468-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ACE9663EC
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 16:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF361F21088
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 14:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460F0170826;
	Fri, 30 Aug 2024 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B98t+uoI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAE316D4E5;
	Fri, 30 Aug 2024 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027277; cv=none; b=qPlnB9OS6H/VCqAfboBEadOyDRI22PuvLNdUtTsXbO5v9Juy/HraZU1RjFKL8dmV3h6TYj/vtLy50WOnprtJNzRLnIwxArL3lq//z+ijsaQa+C/Y2G3rg5QRkrOquh5Rb9zDosNiQt0upYaz0Xa9TrfRKq3PA+R1BmgsM9uBBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027277; c=relaxed/simple;
	bh=5j7HFB56Qes7cUqNRYyxZbdUq7SCpbJ5SR/AqrEbXS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK2Diapi74YSC8E3m8+lsPZYUaKZ6e2XNxJpwtCBXvKoKhK0Ocb7LISGprhK/V7D7IQPVTtQZKZbKIAsM2KemnpEpSC/wcMuR3pYOw6xtjMXavjLvTM0SgrN6LJIoyYGWfm1BBLLYr5c3g1YANylj1DGKHO4osWk7eOGVgSs4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B98t+uoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84557C4CEC2;
	Fri, 30 Aug 2024 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725027275;
	bh=5j7HFB56Qes7cUqNRYyxZbdUq7SCpbJ5SR/AqrEbXS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B98t+uoISTwZgIdwFFb49Q+0WxtjN/hAxtwIAIOVvQ82isK25mwJH+WO9rMO6TYsR
	 /ITgdeMdg9nxXdNuWBbUvcqrZdq3QVp3uBM1BrvMIiu4lXwKFTKkwWKosLI2YRduf8
	 WAEEEsUGzEBiTRbphnLDwS9+WPaP12bVRDiU0xhaGpPlhum5xgV08KtKKqnDs1xvRf
	 bUNPbaMl99KDwVc4kVnyClI4qEMWd9Ft8bV4lYw85Zq8fjr3sUZsoYYZrlOjakodsb
	 16MWn4CXLbmAluDqAaaBXeBVN1k3NmUC12AGxHw++d00mpLrWWvxYYtW3kFNfh/4vJ
	 SKwSLZau0m+rw==
Date: Fri, 30 Aug 2024 15:14:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	otavio.salvador@ossystems.com.br, heiko@sntech.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Add a reference to
 spi-peripheral-props.yaml
Message-ID: <20240830-anchor-glucose-f8dcc1b0fd16@spud>
References: <20240829201315.3412759-1-festevam@gmail.com>
 <20240829201315.3412759-2-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="69Vy0EJSs26on1AY"
Content-Disposition: inline
In-Reply-To: <20240829201315.3412759-2-festevam@gmail.com>


--69Vy0EJSs26on1AY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 05:13:15PM -0300, Fabio Estevam wrote:
> There may be cases where a trivial-device needs to describe
> the SPI clock polarity and phase via spi-cpol and spi-cpha
> properties.

Since those don't come from spi-peripheral-props, not really the correct
justification (although why they don't, I'm not sure). If you still saw
dtbs_check complaints after the first patch, I maybe the controller
schema is missing a reference to spi-controller.yaml?
That said, I think the reference is useful for other the properties,
like spi-max-frequency, so the diff here is sound.

Thanks,
Conor.
>=20
> Add a reference to spi-peripheral-props.yaml to allow that.
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 75a5fad08c44..356b89ade6a8 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -424,6 +424,9 @@ required:
>    - compatible
>    - reg
> =20
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> =20
>  ...
> --=20
> 2.34.1
>=20

--69Vy0EJSs26on1AY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtHTxwAKCRB4tDGHoIJi
0sOAAP9yK04bIiTPD5Sfk5DzJgGryfVA1de8A9yAys6RNugj/gEAmGmC8Bu5HGX4
LlQSfsQxgaa4DtMSr15pHxP+4HRGUAk=
=qdxo
-----END PGP SIGNATURE-----

--69Vy0EJSs26on1AY--

