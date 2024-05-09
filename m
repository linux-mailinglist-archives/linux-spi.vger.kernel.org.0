Return-Path: <linux-spi+bounces-2803-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1358C13F3
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 19:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2723E1C21083
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2024 17:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17A3101DE;
	Thu,  9 May 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmLlGVur"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322FDDAA;
	Thu,  9 May 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275339; cv=none; b=tJ6TD082W/YOy+99kQ2wZRD2r9n1MayFcsLPS5g5OLV3Nkbup2qkv+nRnecqOugNo3dcsi7tnfrWwnTJNet7k/7ubefGlXD5vm96tFc2uopsZiUs4/gtZAe1Nd1WkPzQGimruWZhp5RsUfm4H6x+qq3yLuZWhe/B1nF1R1GSz3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275339; c=relaxed/simple;
	bh=XwNk5V9R0QPzNcNh99wAkQowo9Pa2mx7s88SZ+TAMDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV5ffuVNlywPDSsLWXburd7tR7F3xguCyVsSOfIjXHUc6qBUJrKpOnefiDRS+Q7/bD9V0yiL4qZ4Nv9BoFKPzW+UNGOQEQXdhEy2jesZYz/uK2fgTUfLtWpBWhtL6JmX4ZjfK/65kIcbUK2iWGxZRmYMCbojjSYpqEphTYoyBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmLlGVur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACE7C116B1;
	Thu,  9 May 2024 17:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715275339;
	bh=XwNk5V9R0QPzNcNh99wAkQowo9Pa2mx7s88SZ+TAMDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmLlGVurc5Bzn2z4QgNAt8uPrwv3geS9SsHaBNCzsw9vL+xBzz5ZJEtyIm2LBIt81
	 ka5stnEFm6GIN9odgm2n+XjrDB6+L8agro9SPTMAetuiFy7PWgPwGg86RzUxib9Z6X
	 pHOmi8qCqqzkf5hsqnBfK9PW++J4VTPqWWDYIIm9aO8LwrsJqEFC20SAIthM65SrC2
	 EiEoeEoA0GSlshYEMBdD3LqDgVatA2WMZaExJf/RzhDFdDeqVBqBaEbutoYP+IHnUm
	 vWW9bmHDxD+2WYUZghfM/Et+CYKbIuZ+RI6BujaONxTri5Z9vjV3xjtV1uZA4Ukjsq
	 8P/X1XMnuyGYg==
Date: Thu, 9 May 2024 18:22:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, broonie@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com
Subject: Re: [PATCH v4 2/5] dt-bindings: spi: cadence: Add MRVL overlay
 bindings documentation for Cadence XSPI
Message-ID: <20240509-hurried-canned-3ceac439b93d@spud>
References: <20240509010523.3152264-1-wsadowski@marvell.com>
 <20240509010523.3152264-3-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WpdYn/ptb22WafW8"
Content-Disposition: inline
In-Reply-To: <20240509010523.3152264-3-wsadowski@marvell.com>


--WpdYn/ptb22WafW8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Witold,

On Wed, May 08, 2024 at 06:05:20PM -0700, Witold Sadowski wrote:

>  allOf:
>    - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: marvell,cn10-xspi-nor
> +    then:
> +      properties:
> +        reg-names:
> +          items:
> +            - const: io
> +            - const: sdma
> +            - const: aux
> +            - const: xferbase
> +        reg:
> +          items:
> +            - description: address and length of the controller register set
> +            - description: address and length of the Slave DMA data port
> +            - description: address and length of the auxiliary registers
> +            - description: address and length of the xfer registers
> +    else:
> +      properties:
> +        reg-names:
> +          items:
> +            - const: io
> +            - const: sdma
> +            - const: aux
> +        reg:
> +          items:
> +            - description: address and length of the controller register set
> +            - description: address and length of the Slave DMA data port
> +            - description: address and length of the auxiliary registers

The usual approach here is to define the loosest possible constraints
at the top level, so unconditionally define the xfer register region,
and then constrain things based on compatible. In this case, you can set
minItems to 3 unconditionally and then do (in psuedocode):
if:
  marvell
then:
  reg:
    minitems: 4
else
  reg:
    maxItems: 3

Additionally, when the allOf: is more then just references to other
documents, it should be moved below the required list.

Thanks,
Conor.

--WpdYn/ptb22WafW8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj0GRgAKCRB4tDGHoIJi
0qAUAQDDkek5uuZo8fhS+5+n+/KC5jbgv3VqBlRRX6dNq4+aMQEA3ieUk8uBqv3x
G0rgnFNQrGoFLnff0xt+ojPwilKoWwg=
=aE1J
-----END PGP SIGNATURE-----

--WpdYn/ptb22WafW8--

