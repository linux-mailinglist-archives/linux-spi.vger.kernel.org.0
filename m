Return-Path: <linux-spi+bounces-4474-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52269966521
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 17:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9361F2407E
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444721AF4E4;
	Fri, 30 Aug 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIyvcV8x"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A21016DED8;
	Fri, 30 Aug 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031027; cv=none; b=ax43xChvcCE38mRx4S9iIrGrFdQikUJ4tX7dkrbc59BLzr2271P+UFwCsdlfWd+AedgDqGvyGOkqz69FM5xB86UQJN4/fBNXA6MzokdmJrh3LAkIT3XPOMbfQv+zPlzuaYGjMnsVuljK4MHZmQwUEf7Wyb+2mn+WEnuZFcaygw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031027; c=relaxed/simple;
	bh=INyY8kzYL6NFQlWqGfro8S2POcahnLhYvWoyR/3H+6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSOwfSYnAhLOw2HWQ387YoHoBEicdkj89AgVcwIm1gvXV8y8/bqA5vKNwuDyOONJr4napE6DYRg9ZUEfl0a2kwRr5y3eWNzisIogEyKWu+wdE71Ulthay+mWW8rFHWZBspEgyEcK+7c1k2BMnOOVnNPYZ2upCHO5nEamqF77AAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIyvcV8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6703C4CEC2;
	Fri, 30 Aug 2024 15:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725031026;
	bh=INyY8kzYL6NFQlWqGfro8S2POcahnLhYvWoyR/3H+6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIyvcV8xvK++jbnFO50FJzssMBGVHaa051mEeKlsU8GQ9Il3ChMM0vxHnRu5+fgTb
	 64P0xsn4l4eh6G5wvCJxyeZoNkoR0cvOM2sl9QqVrB7gGG5QZNKG2C+1n27yD0+wk9
	 rXj43F/Gotz8adRGsTBl7hfswZdTHCpdMprSjJ/5/BKAun8BQ5WeB/iAU6GqpsZVAv
	 STT2IDkHo2hEcC1QVCOy83V1BQJtXbEkdslyAHqltV8Mly1v4mr+CQgijquaZ2E5p9
	 1dRPtctGRApKWYTljSJQBUC92rd+yWeoxZmy6UPdSAhjM58vU9wYsoxeqb6mj1Vxsk
	 K1OTbnk4RtTWg==
Date: Fri, 30 Aug 2024 16:17:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	otavio.salvador@ossystems.com.br, heiko@sntech.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Add a reference to
 spi-peripheral-props.yaml
Message-ID: <20240830-rockfish-shun-da3e42b69f1d@spud>
References: <20240829201315.3412759-1-festevam@gmail.com>
 <20240829201315.3412759-2-festevam@gmail.com>
 <20240830-anchor-glucose-f8dcc1b0fd16@spud>
 <CAOMZO5AAyjq2M09Ynbu57jd_RyDe_5fN4oaoxMv1CeKjo2aG5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dq5SpshxUndbzuAM"
Content-Disposition: inline
In-Reply-To: <CAOMZO5AAyjq2M09Ynbu57jd_RyDe_5fN4oaoxMv1CeKjo2aG5Q@mail.gmail.com>


--Dq5SpshxUndbzuAM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 12:05:20PM -0300, Fabio Estevam wrote:
> Hi Conor,
>=20
> On Fri, Aug 30, 2024 at 11:14=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
>=20
> > Since those don't come from spi-peripheral-props, not really the correct
> > justification (although why they don't, I'm not sure). If you still saw
> > dtbs_check complaints after the first patch, I maybe the controller
> > schema is missing a reference to spi-controller.yaml?
>=20
> I changed the first patch as suggested:
>=20
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -29,6 +29,10 @@ properties:
>      description:
>        Chip select used by the device.
>=20
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
>    spi-cs-high:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
>=20
> spi-rockchip.yaml does reference spi-controller.yaml, but I still get
> dtbs_check complaints after the first patch.
>=20
> $ make CHECK_DTBS=3Dy rockchip/rv1108-elgin-r1.dtb -j12
>   UPD     include/config/kernel.release
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC [C] arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb
> /home/fabio/linux-next/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb:
> display@0: 'spi-cpha', 'spi-cpol' do not match any of the regexes:
> 'pinctrl-[0-9]+'
> from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>=20
> I would appreciate some suggestions on how to fix this warning.

Ah, I think I suggested something garbage, because I misread the diff,
as my quoted mail evidences. I was really trying to suggest putting
spi-cpha: true
spi-cpol: true
in trivial-devices.yaml, but I didn't notice that the patch was to
spi-peripheral-props rather than trivial-devices. These properties are
defined (for reasons I don't quite understand) in spi-controller.yaml
and applied to children of the controller node by that binding and I
wanted to avoid the redefinition.

--Dq5SpshxUndbzuAM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtHibgAKCRB4tDGHoIJi
0mUqAQCneNd0cvKzjfOEhaMynX4R/HOTN6dY6quVuiDHkr+T5wEA8fi611+D43Oo
DzGp1GUrFCByDvVmbdIRmMSHQ1QO8AA=
=R3u1
-----END PGP SIGNATURE-----

--Dq5SpshxUndbzuAM--

