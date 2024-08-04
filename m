Return-Path: <linux-spi+bounces-4136-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DDB946F50
	for <lists+linux-spi@lfdr.de>; Sun,  4 Aug 2024 16:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D59B281993
	for <lists+linux-spi@lfdr.de>; Sun,  4 Aug 2024 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6013BB32;
	Sun,  4 Aug 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MJh13q/v"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D5C3BBF1
	for <linux-spi@vger.kernel.org>; Sun,  4 Aug 2024 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722782054; cv=none; b=BVTcErGA9IR8sm4wOe2kcsXs3PpArJT7b8wpAUz+r02oOBBtz1kkh9qVcLj+vCoCskWCWbRNxYNjjkn0beFtk3FQ1E7SwUGMdP0TrZcCa+8DWrkgqupAfKzVFx/Xm09i4sfgo01/nJh3HfwPhu7fWrcJd9k4ublv6Kz2FJwO7qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722782054; c=relaxed/simple;
	bh=2lx3g7N36zwl+ThoqCfB7bZOdmmAoxKPpweee5Hr2W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYt9Z5Vu8fT1v9E+v3sHkUUbn6dTM45KTNCjLLDZDBXiq2zvb3mFzcvOhz7FFYFFSGWINiLeZmLCkfX13L1ea+C7xNNbQ6AvSDpKYfejssyM/Vm6D1SxgBLJawYWiFnmoiCjYVMDBhbjKzw1fzozcUSpANgxz6RsOuHnsZsQeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MJh13q/v; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=2lx3
	g7N36zwl+ThoqCfB7bZOdmmAoxKPpweee5Hr2W4=; b=MJh13q/vmVE2a0vqrBQi
	+hNRiubSP7c8MJ+S3suTHjV0BvYqaVAfhRvA1XESe4nPonoep/7v18aGCnQKUyd5
	AMAqPUKluopu3/23u2Z9A0xWOtn8d4mTeCghbKyoTsOBej2zL++hClFpwpmcXiR2
	xUxSMalKS9E2xG4ZK3bH9nSfarMJD0jwfFEpcN4ESGKL7W0lt12j7DPYpHzWH8+b
	BmO4uZVLdFGe3642ejEd19Tr5jkHJ5ba+1iVddnGH/ThMllP0fh3vxdHhFqozlG6
	GAPfZK9hgflqweiRzUNrJVaaeEOcwpQPDue1TOsx+RujOiNS3zU2/kxyyfi0EW0y
	mw==
Received: (qmail 1704320 invoked from network); 4 Aug 2024 16:34:07 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Aug 2024 16:34:07 +0200
X-UD-Smtp-Session: l3s3148p1@dzzsc9weyOVehhtX
Date: Sun, 4 Aug 2024 16:34:06 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: tiwai@suse.com, broonie@kernel.org, mika.westerberg@linux.intel.com,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v2 2/3] i2c: Fix conditional for substituting empty ACPI
 functions
Message-ID: <Zq-RXoAhH1kZvdRZ@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>, tiwai@suse.com,
	broonie@kernel.org, mika.westerberg@linux.intel.com,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
References: <20240802152215.20831-1-rf@opensource.cirrus.com>
 <20240802152215.20831-3-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K5x/eKI0KCQaJbDH"
Content-Disposition: inline
In-Reply-To: <20240802152215.20831-3-rf@opensource.cirrus.com>


--K5x/eKI0KCQaJbDH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 04:22:14PM +0100, Richard Fitzgerald wrote:
> Add IS_ENABLED(CONFIG_I2C) to the conditional around a bunch of ACPI
> functions.
>=20
> The conditional around these functions depended only on CONFIG_ACPI.
> But the functions are implemented in I2C core, so are only present if
> CONFIG_I2C is enabled.
>=20
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Applied to for-current, thanks!


--K5x/eKI0KCQaJbDH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmavkV4ACgkQFA3kzBSg
Kba8kQ//R2hJFFtxTxAWIj5wBKxOw1RDWxS5D/37YhhcWnBCvMzImW/Dtlt7uoYB
P9O1xQTLK7B0dxkzDX6glvIg94j46CWLsBTtUzCMu1yBVQK2FojAfxrOfVePSoGR
FkBTjSAMhG6lJDQcipJGnDG1KdnMi0RJ9Y8FERD1A81YsLIkIDmIIUXPU6kmolsn
RV1fZARoqLo0BuWwE2xZAv4fAULs2t62Z9LEIHlY//8IJnaCZT256BPU7BNK2tHj
Rg3pa4U1aKmi8aWtiw2KTTrsTilvZFSvtdpjuePaFXZ+OJdH3JSh46dpajZ9b8qU
/uEf8tz/O+UwDRvNLDlaTrH3mwjk1ks5D0tx5cXe4kpPhk9b/RXEFkGZiY5+owot
N5WrNepRptCuJMDdv0XYbF/Hr/c9k9PsTasEkM74bxjJ74NinsMNua9jye8hV7n5
HKJWiXRCjXMA5cjG+RCpshi5sDu0K3oBgTonKhl1RasqndzwL4mljYGRgkjtabvG
MiR7lVvmqSwX/xRqKaK5d3tx0f7F6PY8KMJ0a0zVTmC1JwfjQh2CuzGNw8AUxWy/
l+1sRjuc0lWFtG7YcVPnZenNKxX/yy3raDgpHL+dtJZmoRSqFQj7oapUbhhakf8H
F+IQ72ohmiUnHz9POIDEr9/aGdtJn6K5B24xl+PIFh8IOlWXMjM=
=nS/5
-----END PGP SIGNATURE-----

--K5x/eKI0KCQaJbDH--

