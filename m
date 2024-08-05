Return-Path: <linux-spi+bounces-4144-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D16948546
	for <lists+linux-spi@lfdr.de>; Tue,  6 Aug 2024 00:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EC21C21E69
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2024 22:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869381662FA;
	Mon,  5 Aug 2024 22:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5/Y0dpF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE85155351;
	Mon,  5 Aug 2024 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722895556; cv=none; b=c/Do4hRuvj6BX6/XJWNEe7HWK5zTqCI9I1Wo+HwyqWWDbGH+65klcPc6Wf+aPDjlguTocO3PX708vFY7KKfYcvX825vbdym2u6ZoHNnBO3SW4AxqGiJov9q3RqXHOQtofbaZY4PSLeAQ3X+F4ysdNWICKOtZsEhcWcJkjkOTprg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722895556; c=relaxed/simple;
	bh=Zg/Sf5WAfTbi3XGsP+JrB7ppZOFCAOIN59kksswka6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+eDpUiSQ+XB99UWa8Gz7KH+p/JkL93RjB8C2ltJeN8Xs4H9fPPxlVabPr1//hl2IF9Q2Z5ASiagOwRDxblulGqx6Hmrjwp466e/EtwEWmzvSJiyw88V/3BmnNvERudetfKXo+mYdNqCqgj7K6DbPgU1BTuWlYfFAdB8bPS8I54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5/Y0dpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21C2C4AF0E;
	Mon,  5 Aug 2024 22:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722895555;
	bh=Zg/Sf5WAfTbi3XGsP+JrB7ppZOFCAOIN59kksswka6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5/Y0dpF/A8ELMzLz612WjJIyC3IO9waHdn15Zw/EIfAfTk6eGbAsY8w+ZHghJPoQ
	 4jFtBXu8SHfTnk8D13dvY8ZnR/GSdfg3nGLRi4rwH2H0RHNiiKo+C5UT/HeMMke/N9
	 odOoZty1UZjTJIS1ey5M8WrMd0z9pwLf5jONr+VBvKxbAy+jxMSb2/2bFxFOkQBVhn
	 R8FeQOE/RFduv6y7VpPkp/YY0UIK+InGv81V+tYWO1FuVTvZMSRn45OchH9bjYF1xu
	 tQ8L10b0AgGOibzkjwNQzsE21awIRVvs/1bmq3aB902UlO7LamloscO77v2PFBXJEB
	 lGnmxg5tXxKCg==
Date: Mon, 5 Aug 2024 23:05:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, broonie@kernel.org,
	linux-spi@vger.kernel.org, otavio.salvador@ossystems.com.br,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: trivial-devices: Document
 elgin,jg10309-01
Message-ID: <20240805-humid-hurling-90f70757cea6@spud>
References: <20240719111210.1287783-1-festevam@gmail.com>
 <20240719-unquote-query-a76fd9487bf9@spud>
 <28702815.czjnFlTdjD@diego>
 <CAOMZO5AkvxwRrs0BHk5qe_YM_=Up4OYpOrp6ECaLcfd=VhjV0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vE/3m6mdkevVa85B"
Content-Disposition: inline
In-Reply-To: <CAOMZO5AkvxwRrs0BHk5qe_YM_=Up4OYpOrp6ECaLcfd=VhjV0A@mail.gmail.com>


--vE/3m6mdkevVa85B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2024 at 10:18:24AM -0300, Fabio Estevam wrote:
> Hi Heiko,
>=20
> On Fri, Jul 26, 2024 at 6:57=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.=
de> wrote:
>=20
> > with the error Rob's bot reported about the usage of spi-cpol and
> > spi-cpha, it really looks like the bindings needs to be more fleshed ou=
t.
>=20
> I just wanted to let you know that the warning reported by Rob's bot
> is very old.
>=20
> Running "make dtbs_check DT_SCHEMA_FILES=3Dtrivial-devices.yaml" on the
> existing tree:
>=20
>   DTC [C] arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb
> rv1108-elgin-r1.dtb: dac@0: 'spi-cpha', 'spi-cpol' do not match any of
> the regexes: 'pinctrl-[0-9]+'
> from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
>=20
> So we are not making things worse in this aspect.
>=20
> I can work on removing the warnings as an incremental patch, if you agree.

Yeah, I acked it cos the issue would've been there before so it's not
any worse. I think adding a "real" binding can be a follow on.

--vE/3m6mdkevVa85B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrFMvwAKCRB4tDGHoIJi
0lgaAP9yXy59ImkXa25VTWNy01HSFHbOS2UQGa4zDJScrnwrJAEAxMMr82GNs9xJ
L+ouEDI2Hdead+t+upYZGSBzUANigwo=
=ny+V
-----END PGP SIGNATURE-----

--vE/3m6mdkevVa85B--

