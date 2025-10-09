Return-Path: <linux-spi+bounces-10498-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB75BCA65A
	for <lists+linux-spi@lfdr.de>; Thu, 09 Oct 2025 19:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9CC1898DAF
	for <lists+linux-spi@lfdr.de>; Thu,  9 Oct 2025 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7115D242D83;
	Thu,  9 Oct 2025 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJYeohid"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42172225A38;
	Thu,  9 Oct 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031415; cv=none; b=LhZIgkY32vRFW5pYO/aQ8jQ68KM5SQPZC2k+adgrJuNd8YG6SRMgW68H3M1YV1AYELkSAozAYAvCYRQSrI1pnej52og47auy+t8z56wZTDG+zmv0VoHWYrp6UXshtaRKV2BudlM4HnODeFCEts3Oz5yZkYgIG41zunzOjgTLnVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031415; c=relaxed/simple;
	bh=Vk2FGx8DFJC0TIwUVWudyuX6Y8oPGcqejnBs9stEogs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJnNnfPK0nSnId7kN3yr0FhQjEJsfPW08KTnSvCN9qjAfEIuJKQywTLByHf8Hnwmr2mNhbOE4aWDGe2OLcu30P1qsVaZ7zDGdVSbMkh3MtDujfJXFBIlgn95Y7m85mLOCKmxAuanMchW5tJPlP51ACdotvzakEXRyI82lO708c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJYeohid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D98CC4CEE7;
	Thu,  9 Oct 2025 17:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760031414;
	bh=Vk2FGx8DFJC0TIwUVWudyuX6Y8oPGcqejnBs9stEogs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJYeohidLe+0OxtLpJXE2zBWRw80XWKrpjRHK6LsD55mqkSkvE/d8IVpJ6m7W9GwB
	 ivk/lI+gBNxUDyXI05IJyFnW0WeOpm2uENHOz/pOnYgDQVeCmD5u54H4wfKVISSrsd
	 fGcUwcZZeff8P1Cx7iPUeTkc2uKMo49Wu4AvciWeeorroNuJNHNKrqdvWPE44pt47U
	 RP+bQMHAHqtBN2xGou6PuqxkXpbBmXiI6b63iQchPf4Ygrc7xKHkeO7kf7685IQ0ro
	 B8zHnAfB2ag0W8LiWGsJqCdJmFfOofgC9dO4TvshpOlZuDxFiqFUcWFS6j20BeO5eQ
	 OkN1Z8847U2Fg==
Date: Thu, 9 Oct 2025 18:36:50 +0100
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
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRD?=
 =?utf-8?Q?H_1=2F3=5D_dt-bindings?= =?utf-8?Q?=3A?= spi: spi-cadence:
 document optional fifo-width DT property
Message-ID: <20251009-backstage-tubby-82f903864ba0@spud>
References: <20250930075644.1665970-1-jun.guo@cixtech.com>
 <20250930075644.1665970-2-jun.guo@cixtech.com>
 <20250930-vocally-closable-136829bc9fed@spud>
 <SI6PR06MB7104F6012ADAFDBC7D553F9AFFE6A@SI6PR06MB7104.apcprd06.prod.outlook.com>
 <SI6PR06MB7104AE0345763471E67CD3C0FFE6A@SI6PR06MB7104.apcprd06.prod.outlook.com>
 <20251001-simple-conclude-d9cd153cee3c@spud>
 <SI6PR06MB710489F8394133B846744D4BFFE4A@SI6PR06MB7104.apcprd06.prod.outlook.com>
 <SI6PR06MB710493482465F426F62637F9FFEEA@SI6PR06MB7104.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4/ubkzyLMsxqPB6p"
Content-Disposition: inline
In-Reply-To: <SI6PR06MB710493482465F426F62637F9FFEEA@SI6PR06MB7104.apcprd06.prod.outlook.com>


--4/ubkzyLMsxqPB6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 09, 2025 at 09:51:08AM +0000, Jun Guo wrote:
> On 03/10/25 22:58, Jun Guo wrote:
> > On Tue, Oct 02, 2025 at 02:04:00AM +0000, Conor Dooley wrote:
> >> On Wed, Oct 01, 2025 at 02:36:44PM +0000, Jun Guo wrote:
> >>> On Tue, Oct 01, 2025 at 02:52:00AM +0800, Conor Dooley wrote:
> >>>> On Tue, Sep 30, 2025 at 03:56:42PM +0800, Jun Guo wrote:
> >>>>> Add documentation for the optional 'fifo-width' device tree property
> >>>>> for the Cadence SPI controller.
> >>>>>
> >>>>> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> >>>>> ---
> >>>>>   .../devicetree/bindings/spi/spi-cadence.yaml          | 11 +++++++++++
> >>>>>   1 file changed, 11 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> >>>>> index 8de96abe9da1..b2e3f217473b 100644
> >>>>> --- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> >>>>> @@ -62,6 +62,17 @@ properties:
> >>>>>       items:
> >>>>>         - const: spi
> >>>>>
> >>>>> +  fifo-width:
> >>>>> +    description: |
> >>>>> +      This property specifies the FIFO data width (in bits) of the hardware.
> >>>>> +      It must be configured according to the actual FIFO width set during
> >>>>> +      the IP design. For instance, if the hardware FIFO is 32 bits wide,
> >>>>> +      this property should be set to 32.
> >>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>>> +    minimum: 8
> >>>>> +    maximum: 32
> >>>>> +    default: 8
> >>>>
> >>>> I assume this differs from fifo-depth because this is the actual width
> >>>> of the registers rather than the number of elements of that width the
> >>>> FIFO can contain?
> >>>
> >>> Thank you for your review. You are absolutely correct. The `fifo-width`
> >>> indeed refers to the physical width of the FIFO data registers (e.g., 8,
> >>> 16, or 32 bits), whereas `fifo-depth` describes how many elements of
> >>>   that width the FIFO can store.
> >>>
> >>>> However, this isn't something defined as common in spi-controller.yaml
> >>>> so you'll need a vendor prefix for the property if the property stays.
> >>>> This does, however, seem like something that can just be determined by
> >>>> the compatible and that your omission of a soc-specific one is what's
> >>>> lead you to introduce this property. Why not just use a sky1-specific
> >>>> compatible here?
> >>>
> >>> You raise an excellent point, and I initially had the same thought. However,
> >>> after further consideration, I realized that the IP of Cadence SPI actually
> >>> supports configurable FIFO width as a feature. The choice of using 8-bit,
> >>> 16-bit, or 32-bit FIFO width can be made by the SoC integrator based on
> >>> their specific requirements. This is therefore a feature of the Cadence IP
> >>> itself, rather than a chip vendor-specific design constraint.
> >>>
> >>> For this reason, I believe defining a common `fifo-width` property for
> >>> Cadence SPI controllers is more appropriate, as it allows any SoC using
> >>> this IP with different FIFO width configurations to utilize this property,
> >>> without needing to create a specific compatible string for each SoC variant.
> >
> >> Except, you do need to create a soc-specific compatible string for every
> >> device, the fact that you didn't add one for your sky1 SoC was a mistake
> >> that you should fix. SoC-specific compatibles are a requirement.
> >> The "cnds,spi-r1p6" compatible seems to be used on Xilinx platforms,
> >> including a zynq platform that should probably be using the zynq
> >> soc-specific compatible. r1p6 sounds like some sort of version info, is
> >> that the version you are even using?
> >
> >> Once you have added a compatible for the sky1, this property is not
> >> needed, since the depth can be determined from that. Any other user that
> >> wants to use non-default depths can also use their soc-specific
> >> compatibles for that purpose.
> >
> > After further consideration and reviewing how similar cases were resolved
> > for other IPs, I now believe your approach is correct, We should indeed add
> > a cix,sky1-xxx compatible string to this YAML file to indicate that our SoC
> > supports this IP. However, the "fifo-width" is indeed a configurable property
> > of the IP itself. By using the DTSI and the binding document, one can understand
> > which "fifo-width" the SoC platform supports without needing to delve into the

Who actually is going to read the devicetree to figure out what the
fifo-wdith for the platform is? I don't see how it is relevant outside
of the specific driver implementation, as it just controls how many
bits the loop in cdns_spi_process_fifo() deals with per iteration.

Devicetree is not about publishing information to the world about your
device, it doesn't contain the complete programming model information
etc. It is there to communicate non-discoverable information about the
device to the operating system. The fifo-width can be determined from
the compatible and is therefore not needed to be put in the devicetree
explicitly.

> > code. This implementation is similar to existing binding documentation examples
> > like reg-io-width
> > (Documentation/devicetree/bindings/serial/pl011.yaml)
> > and
> > snps,incr-burst-type-adjustment
> > (Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml).

To be honest, a bunch of what is in this dwc3 binding is crap and should
not have been accepted. There's dozens of properties in that file, and
lots of them should have been inferred from a device-specific compatible.

For pl011, I don't really know why the property is there, the provided
explanations are pretty lacking. Maybe a compatible didn't work because
Xilinx needed it for FPGA fabric implementations where the io width was
not set in stone? If I were reviewing that patch today, I would question
their need for it too.

> Hi Conor. Just a gentle ping. Would you mind sharing your further thoughts on
> this idea when you have a moment? Looking forward to your feedback so we can
> move this patch forward.

I didn't reply to the last mail because I had nothing new to say.

Thanks,
Conor.

--4/ubkzyLMsxqPB6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOfysgAKCRB4tDGHoIJi
0iZeAP41SeEoo+9QkGcNZX8o/HIQBJU+pxbnmTstieCJB/hBPAEAhS/bBpdG3aza
syvHeSiBFISj581LqFUoX177TU/k7wU=
=q9tV
-----END PGP SIGNATURE-----

--4/ubkzyLMsxqPB6p--

