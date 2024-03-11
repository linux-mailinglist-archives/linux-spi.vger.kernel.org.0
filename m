Return-Path: <linux-spi+bounces-1759-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EF68780DB
	for <lists+linux-spi@lfdr.de>; Mon, 11 Mar 2024 14:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39752826ED
	for <lists+linux-spi@lfdr.de>; Mon, 11 Mar 2024 13:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1383D980;
	Mon, 11 Mar 2024 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdimayHO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2193D97A
	for <linux-spi@vger.kernel.org>; Mon, 11 Mar 2024 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164853; cv=none; b=O3Wzoa8TWyq0+oatWfzftCXGZ/JjlfJtwZg5Awv/8eQqTWk9O6DamS+L1/yJ/1Ru+IKEZIFR5XEtyfMM86uhXb/U5QIyULKXRkYa0AmHKTL3lYcNF/9UaDjZ8D1xW018ABvtmsW7QzsVxPTOCfLo/d65z5a+Yj+2+7a5Yk9kcgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164853; c=relaxed/simple;
	bh=FlEkVc5sG6fQspOFkLRPdLildaiUit7MrKdPK5ZKFCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEs3MzJZmoLLmjrWnrHuFYbrWIsK4J37OGYRe5AyK3dPb/mn9eAfjVIHRumvxRAua5ju+qbbzaz7rJhTvHnGtHKsBOwGhW1+cijQs3Y7iD8/S65JBRtPIjvZzNFk/zEDD1u54rlo/L695KfXwb13leXPlQnOCU2Wmx9Vvl34se0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdimayHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44587C433F1;
	Mon, 11 Mar 2024 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710164852;
	bh=FlEkVc5sG6fQspOFkLRPdLildaiUit7MrKdPK5ZKFCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HdimayHObsh0uqBo9hLNuqwCwVCkd742kcZussKq+NowMFACKG/tCFYfqRw1EErYg
	 KGhMICuP9UyKpVoeqocYm7l1giwC2EzelWjmJKlvmd4dwcyYpfg+fw3EZ8FLd77OC0
	 Kd0sZ+QMP282bSwAvbsTyLo0Ntal1uVJiXJayx4ykNG3vpVdeSGmx8XZEczMaAtJ0u
	 HphKkup31Gn3mNu9GppKavabVFbdEVmC0g+ugdd9TZgZ0nnG5w+BXVftkiyu6ZKdKd
	 iLghcxf2o7mMVNRKffOVux4neAfTfVIHMVYJ/5iupXHyfDqtLmDXEiaw1VUXDj/zit
	 u30cN/j4sjcHA==
Date: Mon, 11 Mar 2024 13:47:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Jesse T <mr.bossman075@gmail.com>
Cc: linux-spi@vger.kernel.org
Subject: Re: Questions about userspace SPI async IO support
Message-ID: <bb4808ed-c2b2-4741-b66b-0133fbb18f5e@sirena.org.uk>
References: <CAJFTR8TbFFHSxX0hUbiACcY4uy2-QppfT0CgBMjico=Cr1DWZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SXwviT4+GvhJtRyr"
Content-Disposition: inline
In-Reply-To: <CAJFTR8TbFFHSxX0hUbiACcY4uy2-QppfT0CgBMjico=Cr1DWZg@mail.gmail.com>
X-Cookie: Sorry.  Nice try.


--SXwviT4+GvhJtRyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 09, 2024 at 12:41:56AM -0500, Jesse T wrote:

> I would like to add support for userspace SPI async IO.
> Why hasn't it been added?

Nobody proposed anything.

> Is it not as simple as adding the async equivalent of SPI_IOC_MESSAGE
> to ioctl, or is that not a valid way to accomplish this?

There's the completion part of things - you need a way to know that at
least some of the messages have actually been handled, especially on the
read side where you're going to look at the data.  You also have to
worry about management of the storage used for everything.

TBH with modern systems it's unclear if async offers useful benefits
outside of an interrupt context - the cost of synchronisation between
CPUs gets very expensive very quickly.

--SXwviT4+GvhJtRyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXvC3AACgkQJNaLcl1U
h9CxWgf8C+u3n9WNksZro3gsub2xNEcOExW8vVD0B8h4idaDd1KllRRlTjvEEms6
Q2gfJgOVufK8NvWBohLvxmTPWf2PiJsAXwriXuTVcXQS+7O7EUM6zZ+u7W0S3Zzt
f5Pzl3BBy0CccmFY35preyW8zuxssMkQw0bR4nhXZQgDPNXuQ+1PF6Vus2/UwQUU
TPAZkobPYaMDnW7IGqZw5AZ1jsc/bREh956xBh8i8XCAc293ha/MvP5YC8E9xvub
YVIzclfX06r3MWyZZ2ni7pao5Q9qIPuOXSWoZ0Xt1xy/2AqWQ6DKENgr3Fni14LM
zk8+X564/d3U5alvOs/lBIZrDLh4RA==
=z0/5
-----END PGP SIGNATURE-----

--SXwviT4+GvhJtRyr--

