Return-Path: <linux-spi+bounces-2412-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7178A871E
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 17:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBC9281083
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B72146D41;
	Wed, 17 Apr 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWFqdRSb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF6B146A99;
	Wed, 17 Apr 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366689; cv=none; b=o5IJd09OYNvkMy/hgNOy66JdqwhBHASvnX36RVVgxr5Kwert4z6090rhtXUGS15KuS1jmNe3g6pfSgOvWRSRkqHuv8VtkWnRG+VkS7tdbNC9R8z38qgv6Kheh8zaLW+NfblK7zUc5vrWUDYjO/P8H19dw9j1bb5pgwiI4bn5GGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366689; c=relaxed/simple;
	bh=vs8zeQ3uu0Gvfz+X8EO/BsEowJtDXKz4XbgC6f/o/SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKrkFj4yMdYK9q//EHVq9XNdgObqukpQ+74osANl0RtVpyBI+xb7fX/0/uwHnsH3MLF+OvIv81vCER2MjUs9hkRdbWC6UEmenooK8uXxLdXfCaBUSrPrn14e1G5bUYrG3SQoYfVGUFY02TOB6DfFmbnXngD0lUTWZGJEr60wmeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWFqdRSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B6DC072AA;
	Wed, 17 Apr 2024 15:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713366688;
	bh=vs8zeQ3uu0Gvfz+X8EO/BsEowJtDXKz4XbgC6f/o/SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VWFqdRSbZoOJT0Fwjy+fjTNZs8n6UlMbdYCjPCc04lsr7ax1KghRj+WmmKwKZn/+X
	 FaLkCp1n3z5I3Qy37yfiHl13ccDsQwEdzviPI4R4f/tMYYv2w85PY0eGlJSV8Cm10e
	 bNFQkVEJiUNNzVKStqU6kVKMMNCg9WzzJaAI8HDK4/hZGpsxqUhnCaReVZxuIAjZO+
	 Yi6WjKTmXWDVdyU5qdiTdKd1VfBIBI55mp5TK94F16vhZD3H1E6A07dBG90Om4u68I
	 jBobF55LORhAIsuM2QsdeaOExWnaYdU82rkEAHbSSesOMWZCpl1m0TP6ZSmiGhbI0n
	 TvbUAVned+qMA==
Date: Wed, 17 Apr 2024 16:11:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-spi@vger.kernel.org, broonie@kernel.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, nbd@nbd.name,
	john@phrozen.org, dd@embedd.com, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: airoha: Add YAML schema for
 SNFI controller
Message-ID: <20240417-unmanned-wildland-e7cbd2d3845f@spud>
References: <cover.1713335916.git.lorenzo@kernel.org>
 <361a447b86eb71951af206d4081c2e7985811a57.1713335916.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aNj7dxjvwqiyJzzz"
Content-Disposition: inline
In-Reply-To: <361a447b86eb71951af206d4081c2e7985811a57.1713335916.git.lorenzo@kernel.org>


--aNj7dxjvwqiyJzzz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 08:45:50AM +0200, Lorenzo Bianconi wrote:
> Introduce Airoha EN7581 SPI NAND controller binding
>=20
> Tested-by: Rajeev Kumar <Rajeev.Kumar@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor

--aNj7dxjvwqiyJzzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh/mmwAKCRB4tDGHoIJi
0kbRAP9tRY8YCT7dwetxNBX0Ui4C+gJb6yv3bIQUZ2+B16xs/gEArzWt31UiufP5
nkBB2zcB/NlavOB+Wt/izaf2GPfLPgQ=
=j4da
-----END PGP SIGNATURE-----

--aNj7dxjvwqiyJzzz--

