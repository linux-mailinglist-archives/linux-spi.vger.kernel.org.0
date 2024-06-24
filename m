Return-Path: <linux-spi+bounces-3547-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BB391525A
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 17:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F6E2862DD
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 15:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC0019D061;
	Mon, 24 Jun 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/sPsdyw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDEB19CCFD;
	Mon, 24 Jun 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242947; cv=none; b=nNq5aVJpAuhW36/xxWxEOMWe7w887CMAZySv8rlf/uvTjejqB3EEg6ieysRXxKQ2YKvOfWCEh7jXuMF4VdUvSHSzWYtcAe737MVGbfGM9dmHvdnBS1F2YFYJuSZZLBKNZgLtvizzxAj71iGO7JHki3zLgfaMvJZrodAENSOp0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242947; c=relaxed/simple;
	bh=mDhyjVgs56aJ5xriQm7r9/x5TQOebX4CDwLO2N9ee4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITxriNjeG+fpcFMk4g7qortQ5aCYyLER0stazlhODr9xEPvvqJ5rBJskAPcUitP5HqS37RLiZT2xox4hcKM1x0eo4cD3PzzRuCDXlrJqqyuPq1PcR5A89eLGc++rRnGTmBJ6nC5MI+4t4jifXPG0FMZUL8YP+JEVZ3AP/02cmzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/sPsdyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B2CC2BBFC;
	Mon, 24 Jun 2024 15:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719242947;
	bh=mDhyjVgs56aJ5xriQm7r9/x5TQOebX4CDwLO2N9ee4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/sPsdyw8rC+jnFpgHCz6r0ktKKDUJ5yyPfzrpfPr6zaNTzsD0xemkvrmGj9uv6W8
	 YohybZrMkR4yPFJX5UHHxSqHn0L9/f9b5R9FOYzz3qvXJ21X46mf5c4C3HHyR0+kqH
	 74cROPNUPCrmaJix6QWOE0cvP/l7RW9rkRNSaw0h5i7TGMa8EvzbcMLkTJK9TPE8gR
	 fkFYx7Qq7HqsCgXkJQAb4i8LNznjYGlPFUvivj902hIekw4rHoaOoJ+/1fnrCN3s+T
	 v0bZZ/+3mxLODflpRdnjrXoKXf8dhQcP+aMfX9mQohwpdulvvynFkUUB7OH3NbkY20
	 DRPr0H30supDg==
Date: Mon, 24 Jun 2024 16:29:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Witold Sadowski <wsadowski@marvell.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com
Subject: Re: [PATCH v9 6/9] spi: cadence: Add Marvell xfer operation support
Message-ID: <408b4046-12bc-40d0-aaf4-adced4033946@sirena.org.uk>
References: <20240619141716.1785467-1-wsadowski@marvell.com>
 <20240619141716.1785467-7-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DZMx+64Iaq6u+Ao/"
Content-Disposition: inline
In-Reply-To: <20240619141716.1785467-7-wsadowski@marvell.com>
X-Cookie: Allow 6 to 8 weeks for delivery.


--DZMx+64Iaq6u+Ao/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 07:17:12AM -0700, Witold Sadowski wrote:

> +		while (t->len) {
> +
> +			current_cycle_count = t->len > max_len ? max_len : t->len;

cycle_count seems like a weird name?

In general please try to avoid overusing the ternery operator, it
doesn't help legibility.  Just write normal conditional statements, or
in this case use max().

> +				cdns_xspi->current_xfer_qword += current_cycle_count /
> +								 MRVL_XFER_QWORD_BYTECOUNT;
> +				if (current_cycle_count % MRVL_XFER_QWORD_BYTECOUNT)
> +					cdns_xspi->current_xfer_qword++;
> +
> +				cdns_xspi->current_xfer_qword %= MRVL_XFER_QWORD_COUNT;
> +			}
> +			cs_change = t->cs_change;
> +			t->len -= current_cycle_count;
> +		}
> +	}

This loop doesn't implement any of the delay stuff, ideally it either
would or would reject transfers that request transfers.

--DZMx+64Iaq6u+Ao/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ5kL0ACgkQJNaLcl1U
h9ARnQf7B96HrXr7vrndu3rt8BCFbQ4SbyBbQXfq9GI0eZ4mUSnwuu76WjbYyjqE
pYjsJaUFPMQe9Qv9aYh1cvvFbkH9Xn7qASaXMvtKJUY8ByQgF7+Q9PtuHkK5NJm4
BLmhfOhCjBad6cBu0ft/AEy1lTOuzETFBi6pk2UXKYhHNCIzBdqa8/fEjb4ayrl5
9jpr6M4YsRaPKGhngCOlr4izUoSEf6KdVUg7TVUZIWcoHG+9n9WPJPZXXFrxRV8G
C98W2mJoS5PPak3yO5KnN2Cz9gi7tsxB4IjZ4vAdytKlctJaF+QoGl8k4O8WFw4G
1bbvJwcp3olWJYy4x1Lu5b8qm1Jl+A==
=2ZzG
-----END PGP SIGNATURE-----

--DZMx+64Iaq6u+Ao/--

