Return-Path: <linux-spi+bounces-5211-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C874C99B2F3
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 12:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5981F23212
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 10:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B45153BD7;
	Sat, 12 Oct 2024 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcsA6/oG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55712D1FA;
	Sat, 12 Oct 2024 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728857; cv=none; b=Vj9p+OXeOizT37OdIOJ//vSUPuGuz2uy7yHEpPqvB0WCP4rSLVP1dJv6YaNfeons7g6ceSq51eoDssNKFAruN6kT5zN2DOm437bzvHhhORZL2qgoElUuJh/kDDpZiccUqva+Ua2fqMlHn6DpgQBh43yKQkUqDVXrxZ/VQoyK2yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728857; c=relaxed/simple;
	bh=wJYKu0uRsbmK3knzfdjBFSoPpO13iM3QNntBkT1HUl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBPq6FzGgF+oYu5wqNvx4/07Or5+SLt2zid0SElWEnyUie/0dmM1ihMmxVWuE0McjSxZ4O7bcK97rYPWWuUDwWnn09vnWuV35C2zdnCQ5MJ6sFMNn64Z530JLBU5P9kwaZlkcBrI8/xi4SolAXkPllC9nHRzzTdPfRL6Oa/WY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcsA6/oG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D41CC4CEC7;
	Sat, 12 Oct 2024 10:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728728856;
	bh=wJYKu0uRsbmK3knzfdjBFSoPpO13iM3QNntBkT1HUl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcsA6/oG6+GMfVLg0bFNMrtpy9jfkSUew4VVUG4l84/ernbvG25JFGmlsXcMjPiXB
	 EvRbjsyaoqn1RBvH+SckgVdjSYnEy5lDTDqkQbRStkIcXVuI2Ox5hoIZVtiTUq1ZNQ
	 5F4VCr7xm4AsazEKEOwigzKRHpQW0k4OLjkiwKIOB/wYFLH5yptQZ8nMlJbHrS1n3q
	 56GBO6k4/GQbuONWMBJdmYAq1W4m85VP2Ri7soUytu4vYTRAMAdyagqa1/N6JVjywm
	 ApspArO8iwWXGkfTnIoFA+AE8knuqX+OJkvkOQP7o9Xixil8NuCsRATz1ULvNvRcT2
	 ZMd+N2JKxfuRQ==
Date: Sat, 12 Oct 2024 11:27:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] spi: do not initialize device chipselects to
 SPI_INVALID_CS
Message-ID: <ZwpPFfJ_h29NxdMJ@finisterre.sirena.org.uk>
References: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
 <20241012-spi_multi_cs_cleanup-v1-3-dc491113880d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RDuBMNDL7fArFyFD"
Content-Disposition: inline
In-Reply-To: <20241012-spi_multi_cs_cleanup-v1-3-dc491113880d@gmail.com>
X-Cookie: Editing is a rewording activity.


--RDuBMNDL7fArFyFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 12, 2024 at 11:53:37AM +0200, Jonas Gorski wrote:
> Now that we know the number of valid chipselects, we don't need to
> initialize them to SPI_INVALID_CS to be able to know if they are valid,
> so we can drop both the initialization to SPI_INVALID_CS, as well as the
> check for it.

Dropping the check is fine but it seems useful to set a poison value to
unused chip selects for robustness.

--RDuBMNDL7fArFyFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcKTxQACgkQJNaLcl1U
h9D9bgf8D7vLcn+R/qk0UWN/zmADJ7e7IxiyWYnBg0DL4r/47R3VK/GZDvnG785m
mxe9exDQSEo12yuOwOaZnx4WL6i8BT1C4LstOUJb84CQkbxKAecT+hyJgfPI8LCO
m5u2/vQhOvxTVMN1ihWqXEGmIXU7JnI3odX4KShwmxMihCXtvlWYLXKN5khJjBp0
i84MNG2oJGv6FCNuFmF+c9/udMkrGfIvxQvLg2ntc1l2F3EoeSIwWmEjSD5FSM3o
3VadRpoRQBlUfx2mj8ljSFPJufRexvTPcLR60J5VOKKoPmJCD8tS5HHMnlISYmsT
ut6IScdSFIjz0aGgfVJuCXs5CqhIMQ==
=9QCf
-----END PGP SIGNATURE-----

--RDuBMNDL7fArFyFD--

