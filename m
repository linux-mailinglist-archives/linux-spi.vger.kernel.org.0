Return-Path: <linux-spi+bounces-2328-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FFB8A2D03
	for <lists+linux-spi@lfdr.de>; Fri, 12 Apr 2024 13:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239DF1F220E4
	for <lists+linux-spi@lfdr.de>; Fri, 12 Apr 2024 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F1CDDC5;
	Fri, 12 Apr 2024 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJerQq9y"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC38250A6C;
	Fri, 12 Apr 2024 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919730; cv=none; b=J7rCcn4fOuHaaOEarmbqPHvWfKiK6ZJBtvCs8oTEyqgci+i2ZffgfXYJ7mJsc7IrWqsn1nCcLOtV15ggji4x1sFMB9ROlQgYH60BhNBvl4yCtCFhEJpI6ilxqAm2if7U2qUL64pmPCDnN8WdOQcQGcS0wuJkPDyjQZlxwzSep/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919730; c=relaxed/simple;
	bh=pg37VYQhVBOP/ZWLsG5FBf76Ky5PRnHG/vG2w8kdFjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRGPWSQ5t4PHwA0Vm+NFFLADFhONEb7XjDH8JbRWXZ6h81iqu/DjIf/HJW73Lyi8z37TJdnH+mXNgPeffemiPuuLx/HSFbevHpzye5DOhDUZY/ezCzPOcqGzQnWmD90mtDqny6Xb1p8HMng6a+FzMOTFB3F793Fx/id/awmtQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJerQq9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3793C113CD;
	Fri, 12 Apr 2024 11:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712919729;
	bh=pg37VYQhVBOP/ZWLsG5FBf76Ky5PRnHG/vG2w8kdFjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJerQq9yCM+8cWMu6PoRUlau9659v6ggFsegxC4YOuFI/PLK+TevvT0hil+1G68NT
	 wfGCw7AXHRVJugQR+kuGU4dWr1EZPPLJS6RzD3Hj/U/8pscE2ohjm1kmRLvTjgdIrX
	 PGxJasXGzIb29CfRAJJE4Kw32baJL54vWGbkOrtTLx2fcTxoAnXs0mzunxDzqlDL7R
	 6By2RlmEVjeN3cgpqXO8mKb8IEGizSR6VcrGbmBvEsXBSPOK933qJnAJN9xRcAAhst
	 j/9AlVrdGstAykkzPW53XtoNW2eVh0CBUQJVA3vaweZY/UgyizKEEKC7IKftnQQ7MI
	 GVsUDC0hK7PUA==
Date: Fri, 12 Apr 2024 13:02:05 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-spi@vger.kernel.org, broonie@kernel.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, nbd@nbd.name,
	john@phrozen.org, dd@embedd.com, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH 1/3] dt-bindings: spi: airoha: Add YAML schema for SNFI
 controller
Message-ID: <ZhkUrU5pmbvUY27P@lore-desk>
References: <cover.1712833493.git.lorenzo@kernel.org>
 <bbc03f8d33c538b36e366e289861b90adbe64a37.1712833493.git.lorenzo@kernel.org>
 <19977d0e-ef31-42c0-aa4b-acd7e773c603@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yK/Y7uL0aO9iUQOp"
Content-Disposition: inline
In-Reply-To: <19977d0e-ef31-42c0-aa4b-acd7e773c603@linaro.org>


--yK/Y7uL0aO9iUQOp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 11/04/2024 13:08, Lorenzo Bianconi wrote:
> > Introduce Airoha EN7581 SPI NAND controller binding
> >=20
> > Tested-by: Rajeev Kumar <Rajeev.Kumar@airoha.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../bindings/spi/airoha,spi-airoha-snfi.yaml  | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/airoha,spi-ai=
roha-snfi.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/spi/airoha,spi-airoha-sn=
fi.yaml b/Documentation/devicetree/bindings/spi/airoha,spi-airoha-snfi.yaml
> > new file mode 100644
> > index 000000000000..0244f242eff1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/airoha,spi-airoha-snfi.yaml
>=20
> Use compatible as filename.

ack, I will fix it.

>=20
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/airoha,spi-airoha-snfi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SPI-NAND flash controller for Airoha ARM SoCs
> > +
> > +maintainers:
> > +  - Lorenzo Bianconi <lorenzo@kernel.org>
> > +
> > +allOf:
> > +  - $ref: spi-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: airoha,en7581-snand
> > +
> > +  reg:
> > +    maxItems: 2
>=20
> Instead list and describe items.

ack, I will fix it.

>=20
> > +
> > +  interrupts:
> > +    maxItems: 1
>=20
> This looks incomplete. No clocks? No other resources?

actually spi-snand relies on a fixed-rate clock. I will fix it.

Regards,
Lorenzo

>=20
> Best regards,
> Krzysztof
>=20

--yK/Y7uL0aO9iUQOp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZhkUrQAKCRA6cBh0uS2t
rA6PAPwPjK+mL49w2V49EIM1p5+n5VL46H/O7L9LSzO9FIc91AD/X+q/N08igp8V
pFowxI+9/PwAhqvntQ9M5MPXo0NTogg=
=V33S
-----END PGP SIGNATURE-----

--yK/Y7uL0aO9iUQOp--

