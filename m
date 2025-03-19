Return-Path: <linux-spi+bounces-7232-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E99DA696B1
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 18:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A148837E4
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 17:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F331E9B17;
	Wed, 19 Mar 2025 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhg3cpZp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E841361
	for <linux-spi@vger.kernel.org>; Wed, 19 Mar 2025 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405997; cv=none; b=rDAhagMNwHm0zT887ZlCdigtIaoVmoiBD/4MUPSe9CfH4WZFBb2vXFDmuLPAtC7/EUnPYP4rM/7Towfed7Ma6Ri9KMcDWHm7XbJ007kOwPMNcP9/eijh6JsHRSS1Wn4O5IKZ44UWIODSRLM6kFmcaCX0nwVjDZ7HknTmgRDH/Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405997; c=relaxed/simple;
	bh=ATtb4qo49WDSA7/9SbN+QaUMp8KcTd08wF+80oGjOGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqD5H/wLdkV3TlqYQUhrb5Z++WB5gf6F+4pdu/CjCQzXgvtnY5gu5smHlmEe3xGCeOzZSTod6vYmFfS8xrYHq1urtxmi8BkPTR0gJCLtoX1z6EW7zty/Jvhj/ww3jEcO2MbrYH8x3jQtsAbQXRm13F2+kS8aaSb66EtTOMoVW6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhg3cpZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1315EC4CEE9;
	Wed, 19 Mar 2025 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742405994;
	bh=ATtb4qo49WDSA7/9SbN+QaUMp8KcTd08wF+80oGjOGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhg3cpZphGgqxWQMAObxSs9e4mKFEIziGS0zX16idm86/eN9rNZyY6lqEAN1+U/Gi
	 vyjth8vJJdl3KH0hH8ymxhOBl+MPG/jTyoSXcM1mMfrZvmseIgO+H0JNbc4fyUKVJ4
	 eQcYEnM1+oLxlNkI6CGSvwaVfLBvxP9J6ov9FHD2AkVCAubJGVOrROrx9Ymuf3z63h
	 39pf1WVgY7w7+OsSxhCr2KCiKoAYfF4RNlS2ul3bLY90zJsAye0Ee7vmGK2I9cHUdP
	 p1b4nmbYID+4KP4fedp7NLMdqzY632Se8lertWd3xhOngwBjMYfx4MfFv5PJDgaUAW
	 lWbwYFpLQaJRw==
Date: Wed, 19 Mar 2025 17:39:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, linux-spi@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: spi-mem: Introduce a default ->exec_op() debug log
Message-ID: <a97f8ddc-c9b9-45a4-bef3-cbc01c3d07c6@sirena.org.uk>
References: <20250305201140.2513431-1-miquel.raynal@bootlin.com>
 <a073191e-afab-484e-9659-66b957301db1@linaro.org>
 <ce648080-2964-40d2-a2a7-cafcb6592cd1@sirena.org.uk>
 <87h63p2c3n.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KfAfdwkxEvI9I6uV"
Content-Disposition: inline
In-Reply-To: <87h63p2c3n.fsf@bootlin.com>
X-Cookie: Chairman of the Bored.


--KfAfdwkxEvI9I6uV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19, 2025 at 05:56:28PM +0100, Miquel Raynal wrote:

> I'd say that for this particular purpose I do not thing that trace
> printks or events would really fit. As a developer, I'd definitely
> always change the function calls to some direct printk calls in this
> case. The verbose debug alternative seduced me though, so if that's okay
> for you, I'll switch to dev_vdgb() as suggested by Tudor, which honestly
> feels like a seducing alternative.

That's fine for me.  I do have to say that I tend to end up doing the
opposite of you and adding tracepoints to code I'm doing much with, they
work so much better so long as you can get the buffer off the device.
Low overhead, much bigger lookback and better tooling.

--KfAfdwkxEvI9I6uV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfbAWUACgkQJNaLcl1U
h9DIEAf9Hi762nmzhmBWUQtworyZN6E/a/AkS4Ok1OXrDlszXJiCiIPixQa1vcSO
HBrhN5l1J6DsdvH9Tc3Sj6geMyGRqGeXkoMUAZKrB3ovliKcBdBRaHFd6ceYeIyG
J6FHj86VV//WNSnVooleAEmeesTFbC867i22eFZvt3PxI1ZDOlZFjbCeHuY9+NCR
LEdIF8YoaByeXCApBESMGTK2XgikxKfi3TQJdvN7KU9PM5zAM/QB/t41B3EKe3cS
6K7n9+3uNgpOc/6tWsdiuXilnyMeVOv3WOpoGgodm7lqXYmeup1L3Es072MjRJEY
3MP2p1cjYYFAYgVEo2K+RoVaqDk0YQ==
=xu55
-----END PGP SIGNATURE-----

--KfAfdwkxEvI9I6uV--

