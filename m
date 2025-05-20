Return-Path: <linux-spi+bounces-8221-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AC6ABDF6B
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 17:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A43A47B286D
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 15:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35125DB14;
	Tue, 20 May 2025 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Elr5GmgN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E14F24E4C4;
	Tue, 20 May 2025 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755923; cv=none; b=PrVAUxEz5U/TxCGfoYv4JlN1reM0sFoFVLxWmukLfVELq0xHrEhIFtU3fcF5g0rlvw+WpK/XUgnC8qi4aQUZ34TDWj+h3dLmvUjVNAmsHnFiREYvbDyD14m6IW3dKPY4Oefx/SnugGqBGl23hzeOYtJF0/sLU612DNJcelzyDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755923; c=relaxed/simple;
	bh=QZwMAMHXJadVhVw8rt/Vxp0DnIWTSyCOm/9s7Dh/5ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sotpM3kG06ROdSULoaPmvHWspcYTZC0iHM9Wq1sVXZh9e/NrjOOeNNsPAwHB3MPjboqlCr4NErUZ3SRdTXXImG2//WtTpCmLl9gDLcAS+14lED82/Bjn42nroElXoqyhcnWoPrR/ElJOLUJXUb2PDbMYop0m7DhrNmtiG7gj/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Elr5GmgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE88C4CEE9;
	Tue, 20 May 2025 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747755922;
	bh=QZwMAMHXJadVhVw8rt/Vxp0DnIWTSyCOm/9s7Dh/5ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Elr5GmgNc0bnO/D8dP3JhuMcFuYUtNJYb/rzzI2WfYx5tqf7SA2MAdFN7YMAYXGxP
	 pivBuyfPYAXFhdZqx8M3E3KyBR2MHQ9x1FR9VvYw8xnYvB10+J1b+diHcW7jglP8sF
	 HQcwJOv4KQwaZaNem9JD1R9TqoA9/0J/YqMNZnMQU9LjHLKKa1Lb3tciG26m2czvmr
	 MBoV/Kod0NSu8cHBvot15yRaGPwdhgExvpqfZ02uWndqhWOZabXHdZkqAZBf3I+XNl
	 2I/CrV4RPe4gJW7Cf+pFKuYNM8QV/Oc+GaqaX3eHLqIJNWsuVd8O9GcCZ40det8nj6
	 XkghhF4IXfz3Q==
Date: Tue, 20 May 2025 16:45:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>, Yao Zi <ziyao@disroot.org>,
	Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: Add rk3528-spi compatible
Message-ID: <20250520-safely-taekwondo-c9daf6ee76c2@spud>
References: <20250520100102.1226725-1-amadeus@jmu.edu.cn>
 <20250520100102.1226725-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g+s0XxxpsHPxzUUk"
Content-Disposition: inline
In-Reply-To: <20250520100102.1226725-2-amadeus@jmu.edu.cn>


--g+s0XxxpsHPxzUUk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 06:01:01PM +0800, Chukun Pan wrote:
> This adds a compatible string for the SPI controller on RK3528.
>=20
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--g+s0XxxpsHPxzUUk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCyjjQAKCRB4tDGHoIJi
0ndWAP40ZWHqwSwJvdKd3NHs8XCjLGX9F2LFsU7/nG3hlT8jKQEAhR+Ap19CEIou
UEYSvVw8j3bzPZ+4rhf6pNr0X3HJ6QQ=
=xOeR
-----END PGP SIGNATURE-----

--g+s0XxxpsHPxzUUk--

