Return-Path: <linux-spi+bounces-1769-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89956879548
	for <lists+linux-spi@lfdr.de>; Tue, 12 Mar 2024 14:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3741F23791
	for <lists+linux-spi@lfdr.de>; Tue, 12 Mar 2024 13:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A547A14E;
	Tue, 12 Mar 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko40XMGg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BFC5B1E1
	for <linux-spi@vger.kernel.org>; Tue, 12 Mar 2024 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710251175; cv=none; b=bpnouurXxql/P8sgYE9TVt93vLoukdvM62+2tV5B59We4CiE4wpEiCoLrgccr3zQX37HxmlQt1LZmeYp1gpbrvZRvR+pr6hW1R9friXIUgeVaf2qga1+tU35ls4j1k7GctAVN36s154/QFZYJxi9Kpc8IfhRe5eKPHK7XJP9/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710251175; c=relaxed/simple;
	bh=t4Ky92yXtmowrpiNptUuJpd9c7KWMOGhhqbjfrCEuik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bodlYDhEboqnxDFdDxJhExXe4S58u0FyIipE1Vdfeu2vu4SnicZvdY7Li2b9lTyGBcvSfbraiDpAASt5P+IS1foJO1hqSX4KWF9q2tqJBpO9HzMlmCMEKc5IrIrd/uTUvE8VPpXPrXv6c0bZAZh9ltFjj88FMgjixMdnwR18dXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko40XMGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD01C433C7;
	Tue, 12 Mar 2024 13:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710251172;
	bh=t4Ky92yXtmowrpiNptUuJpd9c7KWMOGhhqbjfrCEuik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ko40XMGgtleEmsZ4Dy9CdtnJnkcjtiUFlx+8seMOeyWvWp9GW0/MyeAUtAZbuewN8
	 BNdRAAWXBXc/8O/1ISgxw84kXLsVaDOGqkc0lbRVV2Sn0TNL2SHIrt1gtzN2r/mL/B
	 pJchnEKMSn0C5jg5LdOKJ3fM6dydNhX16BTk6fJmsm6B/k/TKB+sip4rQzQYDDpbmy
	 nO3k6UkXjzlbb3N1o0qhBvKK5HOXBoFk3TIKOj+XVQot4O9VjGpoCAyEo95LlBjodU
	 qSAJQhweHX/Z8RoAbryFYb2bkwvrcv7caiM6srj+UQCAjwk/vCECvLXXmSAxx+zmGb
	 OvtJR9xF6Rqxw==
Date: Tue, 12 Mar 2024 13:46:08 +0000
From: Mark Brown <broonie@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-spi@vger.kernel.org, Fugang Duan <B38611@freescale.com>,
	Gao Pan <pandy.gao@nxp.com>
Subject: Re: [PATCH] spi: lpspi: Avoid potential use-after-free in probe()
Message-ID: <87c1553e-355e-4249-9f1d-3f5140842c6c@sirena.org.uk>
References: <20240312112050.2503643-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iggJwz12uSdKoEYj"
Content-Disposition: inline
In-Reply-To: <20240312112050.2503643-1-alexander.sverdlin@siemens.com>
X-Cookie: Oh, so there you are!


--iggJwz12uSdKoEYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 12, 2024 at 12:20:48PM +0100, A. Sverdlin wrote:

> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
> ...
> Call trace:
>  kernfs_find_ns
>  kernfs_find_and_get_ns
>  sysfs_remove_group
>  sysfs_remove_groups
>  device_remove_attrs
>  device_del
>  spi_unregister_controller
>  devm_spi_unregister
>  release_nodes
>  devres_release_all
>  really_probe
>  driver_probe_device
>  __device_attach_driver

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--iggJwz12uSdKoEYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXwXJ8ACgkQJNaLcl1U
h9BkCQf9EVlXcWym4Zp1px6D/KCXicqACMXOmFF8zd90y65KnOt4p77NcSUkw1c6
DwMzaVvUZTgOmMX+NSOmq2xPANmYMxJXmynxTYJUg2+A0S1JTXSw76asE2X3dq5Y
HdCjORRDtIkPCygXXQ6eLD2FXXg9yqtoa/5+LHFDRXnr0BWnThZaKMHbMw3FtYf2
ediwu7aidAlRqEAApTjRHe5sWUcJRblKn0t7MXcd4x16hZE0VfD4uf1jvQ3WDQ8x
9alXAI9vHXgI23BWX9WwsryqxfZsuRz8B+SetRYoZ73m3NYX8XB3u9UvnBWwstg5
5X49wHTi8XK9otkm2fRSI7fQ6oaQ8g==
=ONKF
-----END PGP SIGNATURE-----

--iggJwz12uSdKoEYj--

