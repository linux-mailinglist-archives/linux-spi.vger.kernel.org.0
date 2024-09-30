Return-Path: <linux-spi+bounces-5055-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FA298A9FC
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 18:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BDD1F2289F
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF04193079;
	Mon, 30 Sep 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F30tD1Xw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FD218F2D4;
	Mon, 30 Sep 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714420; cv=none; b=ktdWYjuot+alKMVDAsN5HagHogEZ91hDPD8PGW/WYk3VClmGwbv0HvjAq3fVdV4Y0+NFyPEViaaPRe5ot7DDDh194N+Yg4JJep7p+IIid/ojdeaLFiz1v1EDWDlWvzCgbBPoSxXz4vRpVXD7q5EdcHbkXIxzAz8Eubo/TyuKUKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714420; c=relaxed/simple;
	bh=5PwBaEank1tzixFn/XIcqswYPlebnWChFxZ6KhinVnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyIKLHdMDECi7VnL4sB05Lb7uEoib1NNE+OXle6a1rJp/uI6exM5Rv7DylbCxcKvf0fLP2QOb1tynmU2GAbA0NvGYs159Y9U+RFKu/UYBBw+xdSu9iv2l8sA2Zke/G3BzJWm06G1HeFi0FPqoorMMFQZY7ULwWjH6PPU8gHiv8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F30tD1Xw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E10C4CEC7;
	Mon, 30 Sep 2024 16:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727714420;
	bh=5PwBaEank1tzixFn/XIcqswYPlebnWChFxZ6KhinVnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F30tD1XwY4JQ2BUlBwbHHueL2mm7vjokzsvhTckIpEbgoYaUGaIwD7ruQoUdx4adz
	 L1sFf7t+a9eqG3n89NwiT59cQurTRxBYrXxTfzDYX02R9mgNMWuEwX0cm8oHE7A7CF
	 Qhb3P6hMc5+dBSk9/uJcDDGpjNNDZzrnp6tHXMv//dmwxMOUUa0sWb4QaOCwwgK9i0
	 Y5Mu9jwlePV5eiLWFzZvI0MKRWMPrf+I6xfpnv/lDPo82LOb1fTDc0d8Rh/kg74IiF
	 HMUKka7blvxp5LtkHawWYunZYRCHvqHmClsXQGiqPD7kDa3vUCnSj9lidpU1teX0pQ
	 ZD+f/7DjbEfCg==
Date: Mon, 30 Sep 2024 17:40:15 +0100
From: Conor Dooley <conor@kernel.org>
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
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
Message-ID: <20240930-unbalance-wake-e1a6f07ea79d@spud>
References: <20240923123242.2101562-1-amit.kumar-mahapatra@amd.com>
 <20240924-impaired-starving-eef91b339f67@spud>
 <IA0PR12MB76998D7BC3429606508E6202DC692@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20240925-trapdoor-stunt-33516665fdc5@spud>
 <IA0PR12MB76999B696A9BA0834644AC71DC6B2@IA0PR12MB7699.namprd12.prod.outlook.com>
 <03a1c7e7-c516-41ab-a668-7c6785ab1c4f@kernel.org>
 <20240928-postcard-lively-c0c9bbe74d04@spud>
 <IA0PR12MB7699EDFA3753D25C8126D901DC762@IA0PR12MB7699.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tqjyBib7Ey0JSbiX"
Content-Disposition: inline
In-Reply-To: <IA0PR12MB7699EDFA3753D25C8126D901DC762@IA0PR12MB7699.namprd12.prod.outlook.com>


--tqjyBib7Ey0JSbiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 03:44:47PM +0000, Mahapatra, Amit Kumar wrote:
> Hello Conor,
>=20
> > > >>>> Subject: Re: [PATCH] dt-bindings: spi: xilinx: Add clocks &
> > > >>>> clock-names properties
> > > >>>>
> > > >>>> On Mon, Sep 23, 2024 at 06:02:42PM +0530, Amit Kumar Mahapatra w=
rote:
> > > >>>>> Include the 'clocks' and 'clock-names' properties in the AXI
> > > >>>>> Quad-SPI bindings. When the AXI4-Lite interface is enabled, the
> > > >>>>> core operates in legacy mode, maintaining backward compatibility
> > > >>>>> with version 1.00, and uses 's_axi_aclk' and 'ext_spi_clk'. For
> > > >>>>> the AXI interface, it uses 's_axi4_aclk' and 'ext_spi_clk'.
> >=20
> > > >>>>> +      properties:
> > > >>>>> +        clock-names:
> > > >>>>> +          items:
> > > >>>>> +            - const: s_axi_aclk
> > > >>>>> +            - const: ext_spi_clk
> > > >>>>
> > > >>>> These are all clocks, there should be no need to have "clk" in t=
he names.
> > > >>>
> > > >>> These are the names exported by the IP and used by the DTG.
> > > >>
> > > >> So? This is a binding, not a verilog file.
> > > >
> > > > Axi Quad SPI is an FPGA-based IP, and the clock names are derived
> > > > from the IP signal names as specified in the IP documentation [1].
> > > > We chose these names to ensure alignment with the I/O signal names
> > > > listed in Table 2-2 on page 19 of [1].
> > > >
> > > > [1]
> > > > chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://www.amd.
> > > > com/content/dam/xilinx/support/documents/ip_documentation/axi_quad_s
> > > > pi/v3_2/pg153-axi-quad-spi.pdf
> > >
> > > So if hardware engineers call them "pink_pony_clk_aclk_really_clk" we
> > > should follow...
> > >
> > >  - bus or axi
> > >  - ext_spi or spi
> > >
> > > You have descriptions of each item to reference real signals. Conor's
> > > comment is valid - do no make it verilog file.
> > >
> > > >
> > > >>
> > > >>>>> +
> > > >>>>> +    else:
> > > >>>>> +      properties:
> > > >>>>> +        clock-names:
> > > >>>>> +          items:
> > > >>>>> +            - const: s_axi4_aclk
> > > >>>>> +            - const: ext_spi_clk
> > >
> > > Nah, these are the same.
> >=20
> > They may be different, depending on whether or not the driver has to ha=
ndle "axi4-
> > lite" versus "axi" differently. That said, I find the commit message ki=
nda odd in that it
> > states that axi4-lite goes with the s_axi_aclk clock and axi goes with =
s_axi4_aclk.
>=20
> Apologies for the typo. When the AXI4 interface is enabled, it uses s_axi=
4_aclk, and=20
> when the AXI4-Lite interface is enabled, it uses s_axi_aclk.
>=20
> In my next series I will update my commit message & change the clock-name=
s=20
> 's_axi4_aclk', 's_axi_aclk' & 'ext_spi_clk' to 'axi4', 'axi' & 'ref' resp=
ectively

There's no driver here, so it is hard to know (why isn't there?) - are you
using the axi v axi4 to do some sort of differentiation in the driver?

--tqjyBib7Ey0JSbiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvrUbwAKCRB4tDGHoIJi
0j/hAQCwvuqSKF8S9+PLpZoLbGbTmHGaUHXP4tl+HnV4U2PNIQEA+Fgo9g347OhL
YYaxJ68oDkcMvD6mw6ZvyG1oVY+OUAA=
=IkR5
-----END PGP SIGNATURE-----

--tqjyBib7Ey0JSbiX--

