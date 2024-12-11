Return-Path: <linux-spi+bounces-6013-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 629CA9ED2E3
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 17:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE29280FA1
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7381DE2A0;
	Wed, 11 Dec 2024 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMBgc627"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9E1D63CA;
	Wed, 11 Dec 2024 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936277; cv=none; b=AX8SKqcFigUzy5z16tdMnDA+tW3yThFr4hfCyJdiF7pR4VW/amL/nKOm4eXtqt1KEbMF1uHpzCObGaMwbaGXMIOcVGA5BMNgTb4DcNj8+PBMojDlUxDULTR0uPNEu+A69fyTKZp8Zy7YjDe3cPGfCCXhxXKf82QCtDp35p58Zi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936277; c=relaxed/simple;
	bh=1yIWus27OtZE7bJMyA2cso+dtL6NIpeS6Aafk4CnEz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4DmRmA3Is7S2ES5riwX8G5UGm+FoJt2Wz/8Be1ypI7HcR5Cu9VSNPehpDCQX9Y+4nhqHm+d3YtKlL7L/0JkBrOIV8Afme2UfWd19nFx6CtpR7uYtgHc4j+yXLl+KZL11gshenZC/H+BSaQR8cjsPD+5MtkOd9hFOcykRr+xQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMBgc627; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A8EC4CED2;
	Wed, 11 Dec 2024 16:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733936277;
	bh=1yIWus27OtZE7bJMyA2cso+dtL6NIpeS6Aafk4CnEz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMBgc6278Cqxq3Ef8j4RI7sPxNL8KGlOEXqFR3ncDfyNJDh9fo8ioFSlxytsavnyG
	 a4m6KQfUIdeEFhGyDrR4kmgHzdQVBeC5oFo0Hmw4nKuKNnMFHSQNsbpUXk2YxOzLg1
	 pisPX6uTpX/zXb4N7LlQjeGrHwpXJdDM/XPT3f6L4K7FoJ64W21fsUZVhyadHxhAH/
	 EZ1R/mGt+sJKUunuzbXpDbhCL4XrEezcb8VnzRxvbtO1snWWibwpllKRL4uadE6MwL
	 w9zEIh2EzcF9U5dd4nQQ+209lVUFtjtn6WUeW3bD8QsDtT3wnrwYRRtu2AIYyYdnx7
	 mbMrXiPGoi7vw==
Date: Wed, 11 Dec 2024 16:57:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, javierm@redhat.com
Subject: Re: [PATCH v2] dt-bindings: devicetree: explain how to get CS
 active-high
Message-ID: <aac3c2a2-6034-4cd1-b03e-3582f03f18c8@sirena.org.uk>
References: <20241211165054.254164-1-ikerpedrosam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YWrt2eyDDIld0rVQ"
Content-Disposition: inline
In-Reply-To: <20241211165054.254164-1-ikerpedrosam@gmail.com>
X-Cookie: Every path has its puddle.


--YWrt2eyDDIld0rVQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 11, 2024 at 05:50:50PM +0100, Iker Pedrosa wrote:
> The current documentation does not clearly explain how to invert the SPI
> CS signal to make it active-high. This makes it very difficult to
> understand.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--YWrt2eyDDIld0rVQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdZxI8ACgkQJNaLcl1U
h9ADhwf5AZKYVSZtRXMACXd+PAZ6HtnJLoJD1+C2KMjRWsG1q63iBYuQqTkIxCLo
6eUtg8lbmWMbhY5PJa9/W086T3h5tafwpRuIcBblkws723aVnHoawIR2/085Kupp
lTCvhnTXRjxu5S2j0vCt2eCL/dQGizPfrYwndYP4c6UTLCcEqBFA0w7njr3YIsBq
AKzrc3gKIq+HMXBZ4sCecZB0HUawH0OB896lBn5LOmcsRR8azK6KBO3f6uTIjYZ3
OMoSaZIGUORwJnDuk5av5XouZOEXW35BFaGxdoFV9XAebJ7EO/ebIJSvuL85YoPi
T2VAoZrOgGRaTYowIChhVGPflxpYkA==
=1xoi
-----END PGP SIGNATURE-----

--YWrt2eyDDIld0rVQ--

