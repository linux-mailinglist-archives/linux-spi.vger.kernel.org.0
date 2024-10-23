Return-Path: <linux-spi+bounces-5317-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ABD9ACE87
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 17:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D86B2A428
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 15:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3931A08C2;
	Wed, 23 Oct 2024 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="sYVNrfG5"
X-Original-To: linux-spi@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867C19DF53;
	Wed, 23 Oct 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696664; cv=none; b=ght2XoQjDGX10hr3ZbYKSJ44JGYPUiw1xaCuDuZBi6DHOwfxrTiGaMXcglA3lju+wqeUvqkqDSvrY3a4RDDOqdk/tnxSdbWzFzYfd6ytbDDXVKHEoNOH1C6yhYBe/wxo1SfWSEIeqgQWnjCppFYekWaBKcN8cVuXR9GAQkTHTxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696664; c=relaxed/simple;
	bh=4hnHAIaEe4ze1ZxKC3Y2qOStpSS+H15iF4uLDOF5Fuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzPMR6tk3YD6zt3EImlHXec31lORlxSGpx2IrykPMaobF5wMKw+gW79vcWce0/gzr7Rui6pA5K3rak9GTzBRzhePpgzKBxe7UjtHwhjR8emqelZm4oUyFaVKICg7W+r86g5OvMbqcQvTkxzItfafItJO1kOydHkG3uTTRk9lwrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=sYVNrfG5; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AC9DA891A3;
	Wed, 23 Oct 2024 17:17:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729696661;
	bh=mGNPZ7L2+BANTdVwGnl+FyDwUhdNjCqHTPZtrrx98vE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sYVNrfG5It5j42lroGwiscpQM1HAuIS/QdVO9YJ8HaIZyQh/dxCHxRnSvanFFc0RB
	 /XFouyNKsHh8IaqvMYdGocRO5QmCb6IgV2YRLoIpBfso+JPBFviVEIucykdLCrp6rq
	 limZl21TOiekCVm+qoeL4FxH47tmU5rMFxIjc1iKig0x3e4uGkpTNgeonHlo+HwSfl
	 d7bhaKDe43GxQjhyxyDqNhliOXHWemqZM++r+44vvzmEDNijbuYY/Ew1RnCU+jurse
	 G22qMsk1Z6r+p4oJmE5PwF79G8ywCQaJ1XkHYQC9FReKEOunztUPu0bN1Op0efXnZ3
	 cyxHgwISbA8/Q==
Date: Wed, 23 Oct 2024 17:17:39 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, broonie@kernel.org, linux-spi@vger.kernel.org,
 shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam
 <festevam@denx.de>
Subject: Re: [PATCH 1/3] dt-bindings: misc: lwn,bk4-spi: Add binding
Message-ID: <20241023171739.475a2bb7@wsk>
In-Reply-To: <20241023120015.1049008-1-festevam@gmail.com>
References: <20241023120015.1049008-1-festevam@gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EXs69__H/ReNKkpgChycJ7c";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/EXs69__H/ReNKkpgChycJ7c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> From: Fabio Estevam <festevam@denx.de>
>=20
> Add a lwn,bk4-spi.yaml binding for Liebherr's BK4 external SPI
> controller.
>=20
> Currently, the compatible string used for this device is "lwn,bk4",
> which is the same as the board compatible string documented at
> fsl.yaml.
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

Thanks for updating this.

BK4 is another example of to be long-time supported device... :-)

> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  .../devicetree/bindings/misc/lwn,bk4-spi.yaml | 54
> +++++++++++++++++++ .../devicetree/bindings/misc/lwn-bk4.txt      |
> 26 --------- 2 files changed, 54 insertions(+), 26 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/misc/lwn,bk4-spi.yaml delete mode
> 100644 Documentation/devicetree/bindings/misc/lwn-bk4.txt
>=20
> diff --git a/Documentation/devicetree/bindings/misc/lwn,bk4-spi.yaml
> b/Documentation/devicetree/bindings/misc/lwn,bk4-spi.yaml new file
> mode 100644 index 000000000000..7fb86e6abade
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
> +  Liebherr's BK4 external SPI controller is a device which handles
> data
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
> +            compatible =3D "lwn,bk4-spi";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <30000000>;
> +            fsl,spi-cs-sck-delay =3D <200>;
> +            fsl,spi-sck-cs-delay =3D <400>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/misc/lwn-bk4.txt
> b/Documentation/devicetree/bindings/misc/lwn-bk4.txt deleted file
> mode 100644 index d6a8c188c087..000000000000
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
> -- spi-max-frequency : Maximum SPI clocking speed of device in Hz,
> should be
> -  30MHz at most for the Liebherr's BK4 external bus.
> -
> -Example:
> -
> -spidev0: spi@0 {
> -	compatible =3D "lwn,bk4";
> -	spi-max-frequency =3D <30000000>;
> -	reg =3D <0>;
> -};




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/EXs69__H/ReNKkpgChycJ7c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmcZE5MACgkQAR8vZIA0
zr2JBgf9H8mKx1+O2rZSlkSQDdOlfnIg8XuozSSDbe6QLKtQYYnxuAEBbjooqYsY
kYYTOSSlLCNrb8sWtuZFf6zWWmWbPiri4J92hFv/ZC2h6bWIKgaO3fO2nCaar36+
ANiTgWo83oD1Vd6VfWRIvESzCh+attaDCueKbseaC+BB3uvcu/I+wYmYdv2Cno6C
Vu9yCAW4v50zPxu98/YtC0fHGmoowqrtXiXkoiPpmkTtzFuAmnKMq/HHMExMgR02
xp4IgKKS57UdyyEP7K/YA1slem9Hs2UVDQ1r1LnfqUu0T8tGjn2AXmsPGNsfctv6
AUsEjOKDz1+u8ma39DrHFlLCqtrt/g==
=OYo+
-----END PGP SIGNATURE-----

--Sig_/EXs69__H/ReNKkpgChycJ7c--

