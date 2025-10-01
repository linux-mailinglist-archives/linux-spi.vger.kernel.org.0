Return-Path: <linux-spi+bounces-10402-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B537ABB1714
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 20:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32DD61920746
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99D92C21F6;
	Wed,  1 Oct 2025 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+40gXSB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53118A6CF;
	Wed,  1 Oct 2025 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759341862; cv=none; b=JHhUnFcN+qnwsunF3F3czz1nkdIOsAq4tg+W1xpl+urrfj+Z8hdU1Y5qF5K5s6e8xmtv0mIuFQpnQK6PhxfnZxMBcTQnyJ9TMOvtdajZZAPACIXzruQLHRfIPr0uOruR0dIDqJjxfwduWgwfcwiQvQQ8JZ2x9aB+3yG+7Crgikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759341862; c=relaxed/simple;
	bh=UditdOJ+p+ZmjZaYpgQPQ5OHHZIaPFJQ9pa7o91UQJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4Fh7B+QxicnlNrr8BVHvDcZ5aF3nQ6syvKII2W9Hs+aljRTniihxTMReLrjYlEnydTM09HdULeS28b8fewMKd5TOcUTf/YrZEtJt7JbEwTfeayZBwaMykLzuMLah7KevfJGuTrfQIHeUuSLtAcOtK4oRPDQwZKKToChLop/eVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+40gXSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1BAC4CEF1;
	Wed,  1 Oct 2025 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759341862;
	bh=UditdOJ+p+ZmjZaYpgQPQ5OHHZIaPFJQ9pa7o91UQJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I+40gXSBTvtBXh/2NOKHWoA/7qZULTZ+RhI4N6PGNzJoIn3hoa8/CwzVGKD7VnsS0
	 JRf8A4DpdWbTxU5Mk4XKKZ4HbBQ6InUNvk/vhsuhiNvVgHWKk2DxgxbNEKso4P3FkL
	 ZnBXnpXhssSZnKvDf1bjbhzEcCYahS9Re1nTPJhCDWFlbUJJtSkrzy417Ki0RpJbmC
	 31g5ibkSBKpg9CTg3sHrRu0cawGsmOqAiSsuUoDFg8W7aZcbotFRi7N82gjpD4d5y1
	 tayZZi9l8frhGlh0bFp4DkWGWm0+DUyvQw4wNy+fvpo8oAk8Pb23ojyRH4xQ+L2115
	 bTWrJ1/sMDnjA==
Date: Wed, 1 Oct 2025 19:04:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Jun Guo <Jun.Guo@cixtech.com>
Cc: Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMS8zXSBk?= =?utf-8?Q?t-bindings?=
 =?utf-8?Q?=3A?= spi: spi-cadence: document optional fifo-width DT property
Message-ID: <20251001-simple-conclude-d9cd153cee3c@spud>
References: <20250930075644.1665970-1-jun.guo@cixtech.com>
 <20250930075644.1665970-2-jun.guo@cixtech.com>
 <20250930-vocally-closable-136829bc9fed@spud>
 <SI6PR06MB7104F6012ADAFDBC7D553F9AFFE6A@SI6PR06MB7104.apcprd06.prod.outlook.com>
 <SI6PR06MB7104AE0345763471E67CD3C0FFE6A@SI6PR06MB7104.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RZlrBQmtaAPuQAyZ"
Content-Disposition: inline
In-Reply-To: <SI6PR06MB7104AE0345763471E67CD3C0FFE6A@SI6PR06MB7104.apcprd06.prod.outlook.com>


--RZlrBQmtaAPuQAyZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 02:36:44PM +0000, Jun Guo wrote:
> On Tue, Oct 01, 2025 at 02:52:00AM +0800, Conor Dooley wrote:
> > On Tue, Sep 30, 2025 at 03:56:42PM +0800, Jun Guo wrote:
> > > Add documentation for the optional 'fifo-width' device tree property
> > > for the Cadence SPI controller.
> > >
> > > Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> > > ---
> > >  .../devicetree/bindings/spi/spi-cadence.yaml          | 11 +++++++++=
++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b=
/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> > > index 8de96abe9da1..b2e3f217473b 100644
> > > --- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> > > @@ -62,6 +62,17 @@ properties:
> > >      items:
> > >        - const: spi
> > >
> > > +  fifo-width:
> > > +    description: |
> > > +      This property specifies the FIFO data width (in bits) of the h=
ardware.
> > > +      It must be configured according to the actual FIFO width set d=
uring
> > > +      the IP design. For instance, if the hardware FIFO is 32 bits w=
ide,
> > > +      this property should be set to 32.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 8
> > > +    maximum: 32
> > > +    default: 8
> >
> > I assume this differs from fifo-depth because this is the actual width
> > of the registers rather than the number of elements of that width the
> > FIFO can contain?
>=20
> Thank you for your review. You are absolutely correct. The `fifo-width`
> indeed refers to the physical width of the FIFO data registers (e.g., 8,
> 16, or 32 bits), whereas `fifo-depth` describes how many elements of
>  that width the FIFO can store.
>=20
> > However, this isn't something defined as common in spi-controller.yaml
> > so you'll need a vendor prefix for the property if the property stays.
> > This does, however, seem like something that can just be determined by
> > the compatible and that your omission of a soc-specific one is what's
> > lead you to introduce this property. Why not just use a sky1-specific
> > compatible here?
>=20
> You raise an excellent point, and I initially had the same thought. Howev=
er,
> after further consideration, I realized that the IP of Cadence SPI actual=
ly
> supports configurable FIFO width as a feature. The choice of using 8-bit,
> 16-bit, or 32-bit FIFO width can be made by the SoC integrator based on
> their specific requirements. This is therefore a feature of the Cadence IP
> itself, rather than a chip vendor-specific design constraint.
>=20
> For this reason, I believe defining a common `fifo-width` property for
> Cadence SPI controllers is more appropriate, as it allows any SoC using
> this IP with different FIFO width configurations to utilize this property,
> without needing to create a specific compatible string for each SoC varia=
nt.

Except, you do need to create a soc-specific compatible string for every
device, the fact that you didn't add one for your sky1 SoC was a mistake
that you should fix. SoC-specific compatibles are a requirement.
The "cnds,spi-r1p6" compatible seems to be used on Xilinx platforms,
including a zynq platform that should probably be using the zynq
soc-specific compatible. r1p6 sounds like some sort of version info, is
that the version you are even using?

Once you have added a compatible for the sky1, this property is not
needed, since the depth can be determined from that. Any other user that
wants to use non-default depths can also use their soc-specific
compatibles for that purpose.

>=20
> Thank you for your valuable time and insightful suggestions. I look forwa=
rd to
> your further feedback on this approach.


--RZlrBQmtaAPuQAyZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaN1tIQAKCRB4tDGHoIJi
0oMjAP4zsaaPAMU0SQSKmTQbp1DBvtpZf4mNFIjsMrVhWzKr3gD/Rsy8ig2pCubA
Bo1QWNZbE3AbmsqSutDk71YJ13rf9QI=
=XRtH
-----END PGP SIGNATURE-----

--RZlrBQmtaAPuQAyZ--

