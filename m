Return-Path: <linux-spi+bounces-4965-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F8F98610D
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 16:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62817B31723
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D05D19C55F;
	Wed, 25 Sep 2024 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/rDeOHr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67BE19C555;
	Wed, 25 Sep 2024 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268405; cv=none; b=UWVSPQN/YMP02DJutI+f6q8+HMhgkekHOpG1npRzYPAFJWz8XBuGnsdhm9Zt4U8EKBCDZZ/G+Fkrg09gizHmTQY3GxuVHfZy2Aol/RX7i2rY6DgO/jncA/6wpKScRd3I8PaCvhwgI62UthxwMW+KLf0viFgCn+uPrdDEvhaQOTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268405; c=relaxed/simple;
	bh=kcSA1j/3f0Eze9yRRZ4pyTUpEjl/LYeoC7gl0Z8q/BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cj7oV6ZiXc8TJ22lPn+osPItaZNXtfsaY3avF5F+KlAgsrgn5QsD4mf4Gc+TR/wPLLrkSEeQtWe94AeQwL30Cfhfe3A6IBMfFtAsSEszQSUV3fdYRKvnO6Q8yvv2Z7Ba/9H0b1ejHvs4E715IAe+VRTfgG9RauKKf2PiNlE0KxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/rDeOHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23301C4CEC3;
	Wed, 25 Sep 2024 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727268404;
	bh=kcSA1j/3f0Eze9yRRZ4pyTUpEjl/LYeoC7gl0Z8q/BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/rDeOHrlwt6bi35l3WrRKtwZ/Hf7vHYS9qemOk3SIU+UIyEZmgNFddrsGW3cR/d+
	 MvzsyAojMqYy5NaCHneDSiHJCtZ7XkelcfAyCRyNgV/4lagm4JGo9HVVKSAgUa716D
	 PD5pUQWUIcDHNbCLIfVUljDNd2/YJCm/kvCzXwUH1FnUlo8Rci/lltRXmU16AeAmBu
	 Jbv+3/ENU5je2/AS2BkIcJjIOzXmV8NDuuB2LAw0oiuKV0jQdfALqnbGbwlSoV6lsQ
	 tujWUyEwICK6r91V7BGKV04xg0VQi9Z/cGKWJCW5ASNQf4gwHs/7wRCZ9mEtTy0hqk
	 fI1PMf0GIHZsw==
Date: Wed, 25 Sep 2024 13:46:40 +0100
From: Conor Dooley <conor@kernel.org>
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names
 properties
Message-ID: <20240925-trapdoor-stunt-33516665fdc5@spud>
References: <20240923123242.2101562-1-amit.kumar-mahapatra@amd.com>
 <20240924-impaired-starving-eef91b339f67@spud>
 <IA0PR12MB76998D7BC3429606508E6202DC692@IA0PR12MB7699.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HaqQMrQQU5awWjZC"
Content-Disposition: inline
In-Reply-To: <IA0PR12MB76998D7BC3429606508E6202DC692@IA0PR12MB7699.namprd12.prod.outlook.com>


--HaqQMrQQU5awWjZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 11:35:56AM +0000, Mahapatra, Amit Kumar wrote:
> Hello Conor,
>=20
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Tuesday, September 24, 2024 10:07 PM
> > To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
> > Cc: broonie@kernel.org; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>; linux-
> > spi@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git (AMD-Xili=
nx)
> > <git@amd.com>; amitrkcian2002@gmail.com
> > Subject: Re: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names=
 properties
> >=20
> > On Mon, Sep 23, 2024 at 06:02:42PM +0530, Amit Kumar Mahapatra wrote:
> > > Include the 'clocks' and 'clock-names' properties in the AXI Quad-SPI
> > > bindings. When the AXI4-Lite interface is enabled, the core operates
> > > in legacy mode, maintaining backward compatibility with version 1.00,
> > > and uses 's_axi_aclk' and 'ext_spi_clk'. For the AXI interface, it
> > > uses 's_axi4_aclk' and 'ext_spi_clk'.
> > >
> > > Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> > > ---
> > > BRANCH: for-next
> > > ---
> > >  .../devicetree/bindings/spi/spi-xilinx.yaml   | 29 +++++++++++++++++=
++
> > >  1 file changed, 29 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> > > b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> > > index 4beb3af0416d..9dfec195ecd4 100644
> > > --- a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> > > @@ -12,6 +12,25 @@ maintainers:
> > >  allOf:
> > >    - $ref: spi-controller.yaml#
> >=20
> > Please move the allOf block down to the end of the binding, after the p=
roperty
> > definitions.
> =20
> Sure, I'll take care of it in the next series
> >=20
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: xlnx,axi-quad-spi-1.00.a
> > > +    then:
> > > +      properties:
> > > +        clock-names:
> > > +          items:
> > > +            - const: s_axi_aclk
> > > +            - const: ext_spi_clk
> >=20
> > These are all clocks, there should be no need to have "clk" in the name=
s.
>=20
> These are the names exported by the IP and used by the DTG.

So? This is a binding, not a verilog file.

> > > +
> > > +    else:
> > > +      properties:
> > > +        clock-names:
> > > +          items:
> > > +            - const: s_axi4_aclk
> > > +            - const: ext_spi_clk
> > > +
> > >  properties:
> > >    compatible:
> > >      enum:
> > > @@ -25,6 +44,12 @@ properties:
> > >    interrupts:
> > >      maxItems: 1
> > >
> > > +  clocks:
> > > +    maxItems: 2
> > > +
> > > +  clock-names:
> > > +    maxItems: 2
> > > +
> > >    xlnx,num-ss-bits:
> > >      description: Number of chip selects used.
> > >      minimum: 1
> > > @@ -39,6 +64,8 @@ required:
> > >    - compatible
> > >    - reg
> > >    - interrupts
> > > +  - clocks
> > > +  - clock-names
> >=20
> > New required properties are an ABI break, where is the driver patch tha=
t makes use
> > of these clocks?
>=20
> Alright, I will remove these from the required properties to avoid=20
> breaking the ABI. We're working on the driver patch and will send it once=
=20
> it's ready.

What changed to make the clocks needed now? It's possible that making
them required is the correct thing to do, so breaking the ABI would be
justified (provided the driver can still handle there being no clocks).

--HaqQMrQQU5awWjZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvQGLAAKCRB4tDGHoIJi
0scRAQCAKuG3tQ1/pvYQPWfQVDEub9Z82uFOrgLkwy9OhlSd1wD+LQsM2swJTMq1
Uz+Je+2R40Vej/gra4Rc5OrYmXslfwY=
=8acX
-----END PGP SIGNATURE-----

--HaqQMrQQU5awWjZC--

