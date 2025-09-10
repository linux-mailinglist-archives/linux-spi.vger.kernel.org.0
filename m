Return-Path: <linux-spi+bounces-9973-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10352B523F0
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 23:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C287D560BE5
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 21:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5118E3112D8;
	Wed, 10 Sep 2025 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4Xu4S9R"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068324C068;
	Wed, 10 Sep 2025 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757541562; cv=none; b=taV/2sCPMW5Z3bkKcUxxXb5PX63ZG+CezIPiqdCUygQMWL7LKUAF/nhkDlVkaoNx5GheKqZx/lIl9Lw0JkL8b3XYQZyknSIU9V7VGi0vrJE37aUH/2CM4XcBJC+ADEWDcCXytzqHCypzePdsQwjn+ClnNpTRPqzXhQmfcJcFz1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757541562; c=relaxed/simple;
	bh=jnJrw4KvMaS+1IPKppeQ27NtdlHsDVhqXF9fQR8RGgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuNWT1QFS4Smy0zHIKJGIG/gpWo57K+7TqUl5SjDyrx03n9J3iCDnEACivGDuOPTQEhrihfaJLwwJk+5lRB29AxdkczAYRqBtjruSmsngNs6ZpSzi6H2gnIWfcv4Xjqoni6tQ7XvMlYjo918AXLCsWZw+UvkhkmU20eH2+oGHBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4Xu4S9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D91C4CEEB;
	Wed, 10 Sep 2025 21:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757541561;
	bh=jnJrw4KvMaS+1IPKppeQ27NtdlHsDVhqXF9fQR8RGgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4Xu4S9Rx2yS1fg0DyEmfsdAATj6pBjYSTrWyIO+bkMb7V9O9rrNnImNLLBLz9S5X
	 WiJm40QSMq2rrTfu8zhLmQ8O5lvjpMz7mGYoFJJ7smLkUnD6fx84/X1tEom3Fp3fGx
	 xqI+PQN9c0XYGvYmJHu5QWE/pgfcKrjny1rJ5ssLyi7EQFSeQnfaBXA9KN8MVkFhck
	 q6x9t/fE+muCSwNHgf/Bgc0FZMrjZfyCurERST7CAEtZLGK1ZzT6IxXg2N7OzXWwye
	 NGHYqMBxENG75DZ8SafyMzOYWhwVzMg3rGZ8zYyfJvLBFBmDv/Vh1z+ItGJk4D3FXV
	 33C07vnV5U5Gw==
Date: Wed, 10 Sep 2025 22:59:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: ldewangan@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr
Subject: Re: [PATCH] spi: Replace lock/unlock patterns to guard
Message-ID: <ddb8f91b-3110-4d17-afcb-fa9199e128ac@sirena.org.uk>
References: <20250910213537.553673-1-karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g4o6fT5DfXvnE0Lv"
Content-Disposition: inline
In-Reply-To: <20250910213537.553673-1-karanja99erick@gmail.com>
X-Cookie: I think my career is ruined!


--g4o6fT5DfXvnE0Lv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 11, 2025 at 12:35:37AM +0300, Erick Karanja wrote:
> Replace lock/unlock pattern with guard cleanup macro.
> This simplifies the code flow path by replacing the conditional
> jump with an early return.

Seriously, please fix your subject lines to follow the style for the
subsystem and distinguish between the patches.

--g4o6fT5DfXvnE0Lv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjB9LQACgkQJNaLcl1U
h9A+4wf/ehY93JmhJYn6SG0Nl6s/Hcg+5EtbWr6R2/2du+TYhzuWW0AUYqMrpvQH
eFc6rauyPxfpqBgaKaGEot5JftJdgjts6rR6gWFMYvTgp9fXnYu8FFvzq0waKTrf
U5jb6d0A4qqF6B1HBtNg51TtCd2lyS4I7InrYiurYiWCAy+x2a2Cun12AVfu58sX
ZRTtz31xzJgC5tv7jaPYJczW2rqJ8dzfeni4tu71WIIA+uujMtAB6XsFQ5zY9OO/
YX45VL+mfqs6gzzSgvgwe0tNI6Pu8BCHvEHC3NxCR8iEL8IyDFPiEiNiQnxBiQwJ
rqgqPdZOsLayTPIUjigHH6s6l31u1Q==
=m26Q
-----END PGP SIGNATURE-----

--g4o6fT5DfXvnE0Lv--

