Return-Path: <linux-spi+bounces-6419-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2EAA1819B
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 17:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD4918838BD
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEBC186E46;
	Tue, 21 Jan 2025 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuPgY0cI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940851C36;
	Tue, 21 Jan 2025 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737475275; cv=none; b=ImOkyNr2ILv86Z69Xwx/XVaJL65l4zeIbozrg9xlkxMg+vIYfgD/kSHYjV4clVELljZtOwFa2vyeQ9BCxaXeBQ+nHoGtK5k8r0vTJaN3o6kPp6QraXKUZAfqhsZhA33wtIVPDTYrSSBVMdx1Hps32fIhrRw9G8Zs1GrVdKvUlrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737475275; c=relaxed/simple;
	bh=iQcpKD+KJDuVJj3F4wa6P8a/bpfKsiibTn0ATqZgmkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lm1w0vPBgyJDmzm0Oy0+7eIinC1IkkdyePeSRgjyV2M7S5OepOr5/Hh0KyQm3OWP2WvqaZk9ywzzPcCkemQLOmUdgImW/u3RJtWUkBmO2F6W8uNon8HkD++gSNUbS7BGn2xAi+pqsMRYbbjp7v72smDRMa6gISFLsWIxQsoTM+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuPgY0cI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6055C4CEDF;
	Tue, 21 Jan 2025 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737475274;
	bh=iQcpKD+KJDuVJj3F4wa6P8a/bpfKsiibTn0ATqZgmkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NuPgY0cIhJi6iFxI0ERs2b1yTwsg8I00IC/5PCfqCljGQClTB0lQ7tNHds7xDkTb+
	 mslZAaucrQQWJgLuPHbGoGyjjgklTTSZ5Qmh9nQMyOt/pPadM7JJBpB/3nMpmsbVDz
	 5VZ45hTOBVvLs1racWwsfTYYPjKLYRMu/SEsiLwq6HcMaX5NziLsj8GGOwunZcpWNP
	 C4QYl1l4evg3o+XHegXAojiPxHSUx4cy4ZbtFFwPfXASG6wYOu6cDRCcR01UIFhWpf
	 zIujOTg0YHFI/xbxKuCTVMFfB4vCcSXjl0zdOSMsZrLSIqGHhh2NHktw27ahWZis96
	 4ZN0DJhVnvpCA==
Date: Tue, 21 Jan 2025 16:01:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH 5/7] spi: zynqmp-gqspi: Split the bus
Message-ID: <f1310bb6-48ef-4bdf-a359-f34b0d849a4d@sirena.org.uk>
References: <20250116232118.2694169-1-sean.anderson@linux.dev>
 <20250116232118.2694169-6-sean.anderson@linux.dev>
 <DM4PR12MB76932590B9A6BB1CC17AD67FDCE62@DM4PR12MB7693.namprd12.prod.outlook.com>
 <1f7cb52d-31a4-458c-9b81-b46bf56fd8a8@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SkwomuF90JxgE8Ws"
Content-Disposition: inline
In-Reply-To: <1f7cb52d-31a4-458c-9b81-b46bf56fd8a8@linux.dev>
X-Cookie: <Manoj> I *like* the chicken


--SkwomuF90JxgE8Ws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 10:53:53AM -0500, Sean Anderson wrote:
> On 1/21/25 08:19, Mahapatra, Amit Kumar wrote:

> > IMHO, restricting users to fixed names is not ideal. A better approach =
would be to=20
> > introduce a Device Tree (DT) property for the bus number and select the=
 bus=20
> > accordingly.

> Why? It's not an artificial restriction; it reflects the hardware. And th=
is is how
> SPI busses are typically represented. If you have two SPI busses, there s=
hould be
> two devicetree nodes.

Perhaps the thing is more that the buses are named instead of numbered?

--SkwomuF90JxgE8Ws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmePxMQACgkQJNaLcl1U
h9DOhQf/YOzVrfNHnRJnwGRbPbNkofZBmWsqC+oClntJtsfCIOd+yZ9XffNE+XTW
d3wV2ZC9xSBHQxmlnNT+FKuujIDWCsPmhuOgoxAgs349j3eot+CXTgbAxbZXGnm2
F/wdLFQZ5kL+CN7J6z3KmHMoP2rEjl0EBVhnsRWL9JdayOiq6TNGQFpHm+QN15rq
6TXvF4UAYiBi6q+quTy+gMjBMPJKMHOO1/O3sf64+TO+t38e0vxUziV9a2IoCqcL
2OaKjv4UxFuufz5KmxVkxaOknpSQITnTdBdu8XSApSM0DfFmEWzVluFh+XgD8hnH
0L02vm82OcjZRvMrs4TZ2pTYlc71KA==
=Zc1a
-----END PGP SIGNATURE-----

--SkwomuF90JxgE8Ws--

