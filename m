Return-Path: <linux-spi+bounces-6402-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A239A154C7
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 17:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D58D3AB626
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866F019F121;
	Fri, 17 Jan 2025 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFUvNsrq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61119924D;
	Fri, 17 Jan 2025 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132545; cv=none; b=CnjHgAQvJmwpT11VjIW1z2T5xKqgLHulFgVWX1NHdGntqir5Nc25S2Z2kX3H64d5p6FVyhtRdT1k5Gc2RiQ1o22x9Fst6CToC+q/L7FyDlPeUWJFnsO2+u5GvzPHgarntKkc9A/DBJU4h5M0RLj0FdE8zV0IYgtI78Xf64KLC70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132545; c=relaxed/simple;
	bh=ND8V5fOcJsROr77aqViHLb97gtgIazDKB9/duPzSvNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1IQCKVWDZqdFyOF6fd5XypiWe4gr3TYqHYdtLfu/x5YrShTATJufpTLrCiU57h4NGFCSfnCwXsz6l0qronwryUVSYUjcnqsMXHW2XZrFU/QJ2f3ZGwMxJoCs8BJyzJrOwNepOxmsUsNFWEAUNAGg7NsVO7AlPO+wLLL+iibbdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFUvNsrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F3FC4CEE0;
	Fri, 17 Jan 2025 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737132544;
	bh=ND8V5fOcJsROr77aqViHLb97gtgIazDKB9/duPzSvNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFUvNsrq871Pwk1ddwhuI3sQiWssnu/pg+7uXsKl020HGHAIH+Io/4fVnH6TSBBni
	 Bkzh8TFYgNuW3+RTeiublp10K1LlVzWNjJbLZGwHagEJorBZRl19sq/tPlrcfWIDUc
	 slu1U5KoqUZBSjPxxsJkQxMadh389I3tI6y3IUQCf4v+3OEgJrUDwNAQPqNMOkIf0p
	 I13+bWbXlWnCyLj0xfwtYyvW/4reTTBgDHlBwFQjBPr8+TxeJWnXuXOFZhQjm3NAFi
	 PAaqYJs8xTiXZetb657AtoxFW6deaNQ3rhq/0boMO7VGeh+C32N114ZmJ14SR2S9D2
	 5qjYSW5s7bkDg==
Date: Fri, 17 Jan 2025 16:48:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] spi: zynqmp-gqspi: Improve error recovery by
 resetting
Message-ID: <f694cd3e-f2be-48e0-8d84-038579cfca7d@sirena.org.uk>
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
 <5942e111-24ba-4d1b-bd4f-6b81dcc6c5dc@sirena.org.uk>
 <3a38cc06-d052-420d-812e-7f3c0c6ef24c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="StRUInDXb5Xbsn+o"
Content-Disposition: inline
In-Reply-To: <3a38cc06-d052-420d-812e-7f3c0c6ef24c@linux.dev>
X-Cookie: Q:	Are we not men?


--StRUInDXb5Xbsn+o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 17, 2025 at 11:17:35AM -0500, Sean Anderson wrote:
> On 1/17/25 08:21, Mark Brown wrote:

> > If you're hitting a timeout that tends to indicate there's already a
> > serious stability problem...

> This was mostly hit when I was hacking on the driver. But of course
> there are probably still bugs lurking in this driver, so I think it is
> good to handle the exceptional conditions in a more-robust way.

I'm not saying it's a bad idea, but your changelog is written in a way
that makes it sound like timeouts are normal.

--StRUInDXb5Xbsn+o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeKifoACgkQJNaLcl1U
h9Bi5Qf/aOOONht9nF1QgH5eqogTXxnhXR3+6g2ErVy6+JnHfwpmvvYzi+ftFvmd
Mszb2jO07Ux7vvtyNqQlkcZSIwodZL2AQ3lBfo9g416HatBLak0CRnII0GKhRAmK
2rtW0mSJ0Y3KnzYfK7iHI6lIwDYVYZ3QybmIk5SSPiUZLedsmyE0WIg3VU4LLvyj
xV9eAV60zPp1sUVVIzCZ3IpYdPzmNsWRT0fXRYQQKtdYKZZ8UHFA2RkB8XPeQMFO
yYNZOPXwpoFEirKTPcfRUrjnEFe1YL463HAu9OxDoBoyvkMquTsXp2p0ZpoQ1siK
HUi4GvhqOdv5TBICd7alAaS9Q3YthA==
=X8IG
-----END PGP SIGNATURE-----

--StRUInDXb5Xbsn+o--

