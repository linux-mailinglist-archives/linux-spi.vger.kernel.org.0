Return-Path: <linux-spi+bounces-4481-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D42A09668DF
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 20:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634B21F236CC
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 18:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD71BC063;
	Fri, 30 Aug 2024 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpr92px7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6730B1BBBF7;
	Fri, 30 Aug 2024 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725042262; cv=none; b=QzrfzZONy1ZzLLhZ4mFH6wwL2BWBCac+TExB9I0W3/4ysDhUCe2/2AvIJr/PEZU9RfetzxllsmzW6KGupgnVvavUAVZgc4XN8Eq7W+Q7CEBS9sTkloJTldnHYIHhDtEyZi/Is2WoWTmyC0QiqPMzsOafzW65EPpFwlkJChXe6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725042262; c=relaxed/simple;
	bh=u32ftu/mfLpMRTkCyzbPhIrEDF/8+LpV8WcZVnbI2Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoDPAMyEeyA72orGx6WYmi0S4Ij3dSqOpC4OfSVM4FoGzKEA1kiI5BzIAoR6mKoNuQi3xolhJ89BhlRKlhk9NpvQh6ksPtnoJeFHtv7udF9UlDlYAdcF1iU3MHSGMgwIqi20pjxXxcWv60N+51DG+n+uoK1GQEajvisEdy7Lt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpr92px7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F91C4CEC2;
	Fri, 30 Aug 2024 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725042261;
	bh=u32ftu/mfLpMRTkCyzbPhIrEDF/8+LpV8WcZVnbI2Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jpr92px7tsAWyPY/TMMQmZHvM3AxhvQGcnAKnX2cGjDUrF4MqgeQXQeYOiStSQ9Yg
	 aUWtdtrszMNuprAn50W/Tzbm0bXUdaXacOhJWPhBrKemwQTh0jgfsvDFFpNuecRPRV
	 tM7XFpPOCRimeH6xfTlG2zCweOoDMR3VxVPhSD9U/KAnDvsJHbdKi+0MeMJ7NHlDyx
	 WMacXW3rO+x99vBBSoOvYD5l1o4NkrIEH3tGYfN9QQNwyR73XPHeiQsj1tGEuehb51
	 TSA3Gum/Z0ZZ9bQbfbX8OhxGbzjYRTz9Hn4cs8Ef8UlZYpQAsO4YOIV7WlA2kT0J4Q
	 AaovFlrdRd4+Q==
Date: Fri, 30 Aug 2024 19:24:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org,
	linux-spi@vger.kernel.org, otavio.salvador@ossystems.com.br,
	heiko@sntech.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Add a reference to
 spi-peripheral-props.yaml
Message-ID: <20240830-swiftness-clover-24dca1262c32@spud>
References: <20240829201315.3412759-1-festevam@gmail.com>
 <20240829201315.3412759-2-festevam@gmail.com>
 <20240830-anchor-glucose-f8dcc1b0fd16@spud>
 <CAOMZO5AAyjq2M09Ynbu57jd_RyDe_5fN4oaoxMv1CeKjo2aG5Q@mail.gmail.com>
 <20240830-rockfish-shun-da3e42b69f1d@spud>
 <20240830180509.GA565970-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TwRbPJ4+RhCeAFJu"
Content-Disposition: inline
In-Reply-To: <20240830180509.GA565970-robh@kernel.org>


--TwRbPJ4+RhCeAFJu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 01:05:09PM -0500, Rob Herring wrote:
> On Fri, Aug 30, 2024 at 04:17:02PM +0100, Conor Dooley wrote:
> > On Fri, Aug 30, 2024 at 12:05:20PM -0300, Fabio Estevam wrote:
> > > Hi Conor,
> > >=20
> > > On Fri, Aug 30, 2024 at 11:14=E2=80=AFAM Conor Dooley <conor@kernel.o=
rg> wrote:
> > >=20
> > > > Since those don't come from spi-peripheral-props, not really the co=
rrect
> > > > justification (although why they don't, I'm not sure). If you still=
 saw
> > > > dtbs_check complaints after the first patch, I maybe the controller
> > > > schema is missing a reference to spi-controller.yaml?
> > >=20
> > > I changed the first patch as suggested:
> > >=20
> > > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > @@ -29,6 +29,10 @@ properties:
> > >      description:
> > >        Chip select used by the device.
> > >=20
> > > +  spi-cpha: true
> > > +
> > > +  spi-cpol: true
> > > +
> > >    spi-cs-high:
> > >      $ref: /schemas/types.yaml#/definitions/flag
> > >      description:
> > >=20
> > > spi-rockchip.yaml does reference spi-controller.yaml, but I still get
> > > dtbs_check complaints after the first patch.
> > >=20
> > > $ make CHECK_DTBS=3Dy rockchip/rv1108-elgin-r1.dtb -j12
> > >   UPD     include/config/kernel.release
> > >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > >   DTC [C] arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb
> > > /home/fabio/linux-next/arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb:
> > > display@0: 'spi-cpha', 'spi-cpol' do not match any of the regexes:
> > > 'pinctrl-[0-9]+'
> > > from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> > >=20
> > > I would appreciate some suggestions on how to fix this warning.
> >=20
> > Ah, I think I suggested something garbage, because I misread the diff,
> > as my quoted mail evidences. I was really trying to suggest putting
> > spi-cpha: true
> > spi-cpol: true
> > in trivial-devices.yaml, but I didn't notice that the patch was to
> > spi-peripheral-props rather than trivial-devices. These properties are
> > defined (for reasons I don't quite understand) in spi-controller.yaml
> > and applied to children of the controller node by that binding and I
> > wanted to avoid the redefinition.
>=20
> I steered Fabio wrong...
>=20
> I think we originally had these in spi-peripheral-props, but then=20
> decided they are properties of the device, not the controller.

I don't follow, how would them being properties of the "device", make them
unsuitable for spi-peripheral-props? Is the differentiation supposed to
be that the things in spi-peripheral-props are actually there to do
per-"device" tweaks for special controller features and the things
applied by spi-controller to child nodes of SPI buses are the ones that
describe requirements of the device?

Even if that is a rather WTF responsibility distribution between files
(partly that's down to naming), the usage does make sense.
spi-peripheral-props can be unconditionally included by all SPI devices,
since the controller determines what properties are relevant, and spa-cpha
etc only get permitted when explicitly set as "true".

> These=20
> properties should really only be needed if the device supports different=
=20
> modes. If what a device supports is fixed, then that can be implicit.

Right. That's very inconsistently done though, even if it makes sense.
I'd wager there are very few devices that actually support both
configurations but conversely very few drivers for active-high-only
devices that don't rely on the spi-cs-active-high (or w/e it is)
property to function correctly.

I should send a patch for pcf2123 to make it required, because that is
the one I know for sure requires active high off the top of my head.

>=20
> There's one other case I see with "dh,dhcom-board". So I guess add=20
> spi-cpha and spi-cpol directly to trivial-devices.yaml.
>=20
> Rob

--TwRbPJ4+RhCeAFJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtIOUQAKCRB4tDGHoIJi
0qWrAP41MxkRul04+1FJ1Xma4pGBB2xF0ngqVQ1rWd8BTTPAuAEAg2G1V3azTwyv
gyshdN/zngROy4ZEiGcxqtnOv5tI8Ak=
=emxH
-----END PGP SIGNATURE-----

--TwRbPJ4+RhCeAFJu--

