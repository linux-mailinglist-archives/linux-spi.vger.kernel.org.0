Return-Path: <linux-spi+bounces-5319-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22109AD11E
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 18:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E82E283166
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 16:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646201CB326;
	Wed, 23 Oct 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0CH/hkM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E51CACEF;
	Wed, 23 Oct 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701454; cv=none; b=H9dynSQ7rzyIZdo3YNxAB2Gm6EcZkC6L1cqseMOnYAroyXAMEbx9BeqUtJ3rF+OtNUdHx4omRjnER7DvtVChvnQeDnUnD52zU1KdzGJ912Fik3sIZAouuLdNy7FKtDQGnSOA9QhDchtJoAICBiHLlOBE20PRvVaohquJQ+FULEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701454; c=relaxed/simple;
	bh=lRi0/nbBx0EcnpJdJrSER6XlVEOeT8jhZsfMLgBKoX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKCo/zuDlj3zRo/HRUC3Tzj367qeazIe7FynY+xuqOlmu91ee/AXmNkkxNsBP0Lo7RLZXcvxhjFFjytA9blGlldqlCJ4J84wU3wQwAiyNN2p4gGehW4mUB4B7V0QMJ3TU/in8sbERPrWL8m4SAErGmHI1aDmftEMBvMKZoibwJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0CH/hkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618D3C4CEC6;
	Wed, 23 Oct 2024 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729701453;
	bh=lRi0/nbBx0EcnpJdJrSER6XlVEOeT8jhZsfMLgBKoX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0CH/hkMKYH48v8Sr/RQU1IatBjbfb1A2DzaiWFAfPxQLOoJqIJCyH2iKwnPeN4o9
	 EGJEQciElHcqiqTgwnehDwu0qeuzqrLa42ll5c5uSb/TZ5BN7KboxwHvuNoELmyRBm
	 E8l1BhxHboj54ZV5pK6wVQAgJxwRjppK4+RdXfVeMJvusitRCvhRKu5ponfvQFH44/
	 Clr8rAEKVaXAMjdaimhTRk6xe4++CIhSkAG/kiETSLmQuXQWck+pLMger85R0gzGMN
	 Uu/zsO6f40+7UWC37GEYwVr8ubJ7A16iqEVo82sVHBPlnRflBpCHdv1jWs0FaffKru
	 tSljbav7LldqQ==
Date: Wed, 23 Oct 2024 17:37:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, broonie@kernel.org,
	linux-spi@vger.kernel.org, shawnguo@kernel.org,
	linux-arm-kernel@lists.infradead.org, lukma@denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/3] dt-bindings: misc: lwn,bk4-spi: Add binding
Message-ID: <20241023-irritate-veal-0423be9e4c45@spud>
References: <20241023120015.1049008-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CjG6ETQKo6RDEUwd"
Content-Disposition: inline
In-Reply-To: <20241023120015.1049008-1-festevam@gmail.com>


--CjG6ETQKo6RDEUwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 09:00:13AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> Add a lwn,bk4-spi.yaml binding for Liebherr's BK4 external SPI controller.
>=20
> Currently, the compatible string used for this device is "lwn,bk4",
> which is the same as the board compatible string documented at fsl.yaml.
>=20
> This causes several dt-schema warnings:
>=20
> make dtbs_check DT_SCHEMA_FILES=3Dfsl.yaml
> ...
>=20
> ['lwn,bk4'] is too short
> 'lwn,bk4' is not one of ['tq,imx8dxp-tqma8xdp-mba8xx']
> 'lwn,bk4' is not one of ['tq,imx8qxp-tqma8xqp-mba8xx']
> 'lwn,bk4' is not one of ['armadeus,imx1-apf9328', 'fsl,imx1ads']
> ...
>=20
> Use a more specific "lwn,bk4-spi" compatible string for this
> device.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  .../devicetree/bindings/misc/lwn,bk4-spi.yaml | 54 +++++++++++++++++++
>  .../devicetree/bindings/misc/lwn-bk4.txt      | 26 ---------
>  2 files changed, 54 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/misc/lwn,bk4-spi.ya=
ml
>  delete mode 100644 Documentation/devicetree/bindings/misc/lwn-bk4.txt
>=20
> diff --git a/Documentation/devicetree/bindings/misc/lwn,bk4-spi.yaml b/Do=
cumentation/devicetree/bindings/misc/lwn,bk4-spi.yaml
> new file mode 100644
> index 000000000000..7fb86e6abade
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/lwn,bk4-spi.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/lwn,bk4-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Liebherr's BK4 external SPI controller
> +
> +maintainers:
> +  - Lukasz Majewski <lukma@denx.de>
> +
> +description: |
> +  Liebherr's BK4 external SPI controller is a device which handles data
> +  acquisition from compatible industrial peripherals.
> +  The SPI is used for data and management purposes in both master and
> +  slave modes.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: lwn,bk4-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 30000000
> +
> +  fsl,spi-cs-sck-delay: true
> +
> +  fsl,spi-sck-cs-delay: true

Why does this have fsl properties? I figure they're taken from the dts,
but spidev doesn't use them, right?

> +
> +required:
> +  - compatible
> +  - spi-max-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        spidev@0 {
           ^^^^^^
This should really be the type of device that this is. The way you word
the description etc doesn't really make much sense to me but it sounds
like this is a daisy chained spi controller? Or is it a data acquisition
device that is a spi "slave"?

> +            compatible =3D "lwn,bk4-spi";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <30000000>;
> +            fsl,spi-cs-sck-delay =3D <200>;
> +            fsl,spi-sck-cs-delay =3D <400>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/misc/lwn-bk4.txt b/Documen=
tation/devicetree/bindings/misc/lwn-bk4.txt
> deleted file mode 100644
> index d6a8c188c087..000000000000
> --- a/Documentation/devicetree/bindings/misc/lwn-bk4.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -* Liebherr's BK4 controller external SPI
> -
> -A device which handles data acquisition from compatible industrial
> -peripherals.
> -The SPI is used for data and management purposes in both master and
> -slave modes.
> -
> -Required properties:
> -
> -- compatible : Should be "lwn,bk4"
> -
> -Required SPI properties:
> -
> -- reg : Should be address of the device chip select within
> -  the controller.
> -
> -- spi-max-frequency : Maximum SPI clocking speed of device in Hz, should=
 be
> -  30MHz at most for the Liebherr's BK4 external bus.
> -
> -Example:
> -
> -spidev0: spi@0 {
> -	compatible =3D "lwn,bk4";
> -	spi-max-frequency =3D <30000000>;
> -	reg =3D <0>;
> -};
> --=20
> 2.34.1
>=20

--CjG6ETQKo6RDEUwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxkmSQAKCRB4tDGHoIJi
0vmXAP4xi+mBjk3u9ojzHfEMphla5LEqQXpnG1Pd8VUmTXz7eQEAzhJEl+8likjP
4CHifmI+fvA19ArkRRuWrqJ9MBetNQM=
=weg+
-----END PGP SIGNATURE-----

--CjG6ETQKo6RDEUwd--

