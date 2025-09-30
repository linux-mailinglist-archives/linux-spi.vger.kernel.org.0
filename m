Return-Path: <linux-spi+bounces-10381-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B0FBAE5B9
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 20:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C11A1945492
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 18:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A8626CE37;
	Tue, 30 Sep 2025 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaDSCduO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8E2580E4;
	Tue, 30 Sep 2025 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258318; cv=none; b=ixiRN65kakilfUaubEx1QLU17YPM3Cq7JdENE5/JrFTwlAx2Yee3HuV1I6b7NJajmYWibKoHqx0nggMSLmroGOiBN0Uo7Z74BA0gbYcPJOQswygY+iNqVCP3EXVjfTXjMMcl8QZO9TXdFkiZdWRWLxUD2+vpqvhXgKBHjxOwGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258318; c=relaxed/simple;
	bh=jyBHzsxRS2jxhYbpoIYY4zJABy0+Tr0/8Tj/357Ar9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuuhw8T5RxUR9AQhag8c3kxZUe/7QPNpYvvw56nQHBSJbhO1PpnVIrZukH1JREiSwa+VcvJ8tCtjNrc/K/91o2/AwTK6szYt/izC6GS0ZzCuLRBSn66Zq1JMdn+4SI4aeDDKF6A3e6Cy8GzdvBZhdo0ULijqBBFUuFuFA9lgi8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaDSCduO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF398C4CEF0;
	Tue, 30 Sep 2025 18:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759258317;
	bh=jyBHzsxRS2jxhYbpoIYY4zJABy0+Tr0/8Tj/357Ar9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TaDSCduObxABjop7cQX8B8UhPwkoWFb9DqDzPG2QVBMfWbM936Kp2ypzO0dkZDuOD
	 VwBGOAQq6JEziFjCtXicd/IVG7Yh9NwMdIz0kNHTdZlOhD596ATISkf64SqI8z4e2e
	 R9c9VjR+pJQzXCak7W+W6ZAdES2fnJg45zgznv3c+jjoHy/clX8fRjVtZBrstCcehW
	 qvgrPxWb9GmyvvCdShYS511Eu0nzamkWYRcTVEjhQ+jnlSZ3M7MSbL4s6L4ZKHkc/Z
	 /zhqAR0+IDat+ws1aQH8nyRxVG6BG8iVkgY957HgkjZPc0obTfRISSQeMicXUc/Gqh
	 oV51LZ+3nTSmA==
Date: Tue, 30 Sep 2025 19:51:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Jun Guo <jun.guo@cixtech.com>
Cc: peter.chen@cixtech.com, fugang.duan@cixtech.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
	linux-spi@vger.kernel.org, michal.simek@amd.com,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: spi: spi-cadence: document optional
 fifo-width DT property
Message-ID: <20250930-vocally-closable-136829bc9fed@spud>
References: <20250930075644.1665970-1-jun.guo@cixtech.com>
 <20250930075644.1665970-2-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2UGIE5QG3NgUNc7j"
Content-Disposition: inline
In-Reply-To: <20250930075644.1665970-2-jun.guo@cixtech.com>


--2UGIE5QG3NgUNc7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 03:56:42PM +0800, Jun Guo wrote:
> Add documentation for the optional 'fifo-width' device tree property
> for the Cadence SPI controller.
>=20
> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> ---
>  .../devicetree/bindings/spi/spi-cadence.yaml          | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Doc=
umentation/devicetree/bindings/spi/spi-cadence.yaml
> index 8de96abe9da1..b2e3f217473b 100644
> --- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> @@ -62,6 +62,17 @@ properties:
>      items:
>        - const: spi
> =20
> +  fifo-width:
> +    description: |
> +      This property specifies the FIFO data width (in bits) of the hardw=
are.
> +      It must be configured according to the actual FIFO width set during
> +      the IP design. For instance, if the hardware FIFO is 32 bits wide,
> +      this property should be set to 32.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 8
> +    maximum: 32
> +    default: 8

I assume this differs from fifo-depth because this is the actual width
of the registers rather than the number of elements of that width the
FIFO can contain?

However, this isn't something defined as common in spi-controller.yaml
so you'll need a vendor prefix for the property if the property stays.
This does, however, seem like something that can just be determined by
the compatible and that your omission of a soc-specific one is what's
lead you to introduce this property. Why not just use a sky1-specific
compatible here?

> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.34.1
>=20

--2UGIE5QG3NgUNc7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNwmyAAKCRB4tDGHoIJi
0preAQCGJTXoWL3uSSINEjlopPAGGVgwBWAKQr9EmEat9qGu1wD6Av/DN+YvByfy
v3+e5PUmjSfWH/El5UQ+yc5rLpm7cgw=
=Sl04
-----END PGP SIGNATURE-----

--2UGIE5QG3NgUNc7j--

