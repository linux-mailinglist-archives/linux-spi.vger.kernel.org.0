Return-Path: <linux-spi+bounces-5023-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0547989147
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 22:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9628F285C4E
	for <lists+linux-spi@lfdr.de>; Sat, 28 Sep 2024 20:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D00315C139;
	Sat, 28 Sep 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JI/efwwF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0281718633;
	Sat, 28 Sep 2024 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727554344; cv=none; b=I+iMDTT9N31cld64Jyt9BW4o9gq/Uf9Ek+4bGNO1LYCSMFJmYxs3DXupiQxV89G41WdaOHkfxwxGNGsPHIgB/Ig4isIPd9N+vJ+/lNCP27pXr6vRKrmiI3PgjKKkhM5Qn5Mz6vOmQ7DMwz8F/53USTyFoOmxNqFZ5wCNfG3Km4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727554344; c=relaxed/simple;
	bh=I26IhX4NPnUeeWPTVvJaD0+ucaQP/7Z8uFoi3S8v0Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoavZZ6NjMOM2FQ6xAqJY2DB5kulrHB95ntVdJAGEFTUepMBvYMQL61Wy031ytZPm0WSpORdnDzXALn/z4cnBo9CleHwLzHS6xbUTc8Yor0WlR253dOOTEy+Hud2S+tbgZM0HVQa9TBfMTXP91fFtIFFLa+ocqlZFHx554/IjpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JI/efwwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EE4C4CEC3;
	Sat, 28 Sep 2024 20:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727554343;
	bh=I26IhX4NPnUeeWPTVvJaD0+ucaQP/7Z8uFoi3S8v0Bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JI/efwwFtDmd+Nkm6Hsk/gt9t5XEcQqUqD6b0o9RIUI+KDDCIgO8mlFeVr8Jyyy9j
	 5A0ZX0W7fAwebJwawO3dh13IX0OT/81s5+95Rj/ux3eS4cdNz3UixGYMloVSl32d5/
	 ldHHuC+BLQm2X+9+Hho5fu5cEKRSyxsJGxt+OLHm8tG4L1ylu3UJTs5Bd0Nv5hwqEL
	 p7EKwU2ON28oYc49PQI9ovO6XdjWtI3gYJc/qN/7DLSkJTkFaVEWOzbVw3IfclOmve
	 F5pLNYURtBGOEfxu6fg3shNJroczcjQx+mkla31XkuDYkXlvV7GwMwm2SSKuXMHp6R
	 EvTZ0wgbrpeLA==
Date: Sat, 28 Sep 2024 21:12:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
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
Message-ID: <20240928-postcard-lively-c0c9bbe74d04@spud>
References: <20240923123242.2101562-1-amit.kumar-mahapatra@amd.com>
 <20240924-impaired-starving-eef91b339f67@spud>
 <IA0PR12MB76998D7BC3429606508E6202DC692@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20240925-trapdoor-stunt-33516665fdc5@spud>
 <IA0PR12MB76999B696A9BA0834644AC71DC6B2@IA0PR12MB7699.namprd12.prod.outlook.com>
 <03a1c7e7-c516-41ab-a668-7c6785ab1c4f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1NX/bfG8PX15XlnI"
Content-Disposition: inline
In-Reply-To: <03a1c7e7-c516-41ab-a668-7c6785ab1c4f@kernel.org>


--1NX/bfG8PX15XlnI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 10:19:01AM +0200, Krzysztof Kozlowski wrote:
> On 27/09/2024 11:30, Mahapatra, Amit Kumar wrote:
> > Hello Conor,
> >=20
> >=20
> >>>> Subject: Re: [PATCH] dt-bindings: spi: xilinx: Add clocks &
> >>>> clock-names properties
> >>>>
> >>>> On Mon, Sep 23, 2024 at 06:02:42PM +0530, Amit Kumar Mahapatra wrote:
> >>>>> Include the 'clocks' and 'clock-names' properties in the AXI
> >>>>> Quad-SPI bindings. When the AXI4-Lite interface is enabled, the
> >>>>> core operates in legacy mode, maintaining backward compatibility
> >>>>> with version 1.00, and uses 's_axi_aclk' and 'ext_spi_clk'. For
> >>>>> the AXI interface, it uses 's_axi4_aclk' and 'ext_spi_clk'.

> >>>>> +      properties:
> >>>>> +        clock-names:
> >>>>> +          items:
> >>>>> +            - const: s_axi_aclk
> >>>>> +            - const: ext_spi_clk
> >>>>
> >>>> These are all clocks, there should be no need to have "clk" in the n=
ames.
> >>>
> >>> These are the names exported by the IP and used by the DTG.
> >>
> >> So? This is a binding, not a verilog file.
> >=20
> > Axi Quad SPI is an FPGA-based IP, and the clock names are derived from =
the=20
> > IP signal names as specified in the IP documentation [1].=20
> > We chose these names to ensure alignment with the I/O signal names list=
ed=20
> > in Table 2-2 on page 19 of [1].
> >=20
> > [1] chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://www.amd=
=2Ecom/content/dam/xilinx/support/documents/ip_documentation/axi_quad_spi/v=
3_2/pg153-axi-quad-spi.pdf
>=20
> So if hardware engineers call them "pink_pony_clk_aclk_really_clk" we
> should follow...
>=20
>  - bus or axi
>  - ext_spi or spi
>=20
> You have descriptions of each item to reference real signals. Conor's
> comment is valid - do no make it verilog file.
>=20
> >=20
> >>
> >>>>> +
> >>>>> +    else:
> >>>>> +      properties:
> >>>>> +        clock-names:
> >>>>> +          items:
> >>>>> +            - const: s_axi4_aclk
> >>>>> +            - const: ext_spi_clk
>=20
> Nah, these are the same.

They may be different, depending on whether or not the driver has to
handle "axi4-lite" versus "axi" differently. That said, I find the
commit message kinda odd in that it states that axi4-lite goes with
the s_axi_aclk clock and axi goes with s_axi4_aclk. Seems backwards..

--1NX/bfG8PX15XlnI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvhjIgAKCRB4tDGHoIJi
0hFsAP9qhLfMvQnzh6cmsRecT9CTopCWp6KmwX/VcslN+ktYaAEAi5sAx2oVJBfy
K00tigLYMqwYoZS6Oac4xOrzlxuOaAs=
=lz2t
-----END PGP SIGNATURE-----

--1NX/bfG8PX15XlnI--

