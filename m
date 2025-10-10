Return-Path: <linux-spi+bounces-10521-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A923BCCCC7
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 13:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319501898FC9
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 11:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9665248F7C;
	Fri, 10 Oct 2025 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+7NVtlm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F0A1E7C12;
	Fri, 10 Oct 2025 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760096771; cv=none; b=NpTyPdCVFkQA/kcjJV7Xp8EcqGgqWV4dB5XQqR2hr8FdYsxrmkiNRo6Xb6/pbq4Y+/ruMHyYor7ER50wQx46MLD+ECUCO/YXrkO27Yfkdw35YPwuRLvGnTadllVrqXtaAP81fm+V46Yqhcu9vHFVjUcmeMXtRNAXlihwsOUzO1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760096771; c=relaxed/simple;
	bh=VjRxcvWMrTGyGz85idIF5PiXEZxnTBbF4eiWaP7b8wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqn3cp9GXJAyHpTFd7qNcn8FBwmXIVRNO6pKqXhJFiNBZjjF/iOlvCq4j/aJu2htXx8kSgnpKy2CbxUDTKYca6X6x34gJKFzrOqNJlrK5iqJanV6pY7JZ/zl2jkepVLyC+otdSq8h0oTUCegHr1jLfcIqEVq6EsUBKjnScEdYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+7NVtlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE3DC4CEF8;
	Fri, 10 Oct 2025 11:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760096771;
	bh=VjRxcvWMrTGyGz85idIF5PiXEZxnTBbF4eiWaP7b8wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+7NVtlmySul0oHAyxjuJWWDer3RkdoMkGtEQoTnsSP09fys39swzVepuODsPzHt/
	 IQn+WqBkqPJkTTTickC9FsLyM9ionInKUUxaOOs12s6Uf0IayEGoPzKU2YEpGy7GxU
	 uL5P2q6o/61VyDwDFvPSVtgXLeF+ie7mP3Ps57DLmP197bxils85C0PGoEJSRfhnFl
	 RKKvFq5oheFHgZxZToQIHSvDAM30hijZFCd0QgQ92KfRz7ru6Yh48nZjeRmTMj7fcd
	 mpRMX0JCIs0/Ac+Iq0OkxnUlDu4o1udPiNJhm4ykRrLlagYbJqkl2B+2iwvW+JT/2O
	 G4cYQHfJNkd4Q==
Date: Fri, 10 Oct 2025 12:46:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Jun Guo <Jun.Guo@cixtech.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Fugang Duan <fugang.duan@cixtech.com>,
	Peter Chen <peter.chen@cixtech.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMi8zXSBz?=
 =?utf-8?Q?pi=3A_spi-cadence?= =?utf-8?Q?=3A?= supports transmission with
 bits_per_word of 16 and 32
Message-ID: <747574cf-3139-4e12-89b3-cbd396acd5a4@sirena.org.uk>
References: <20250930075644.1665970-1-jun.guo@cixtech.com>
 <20250930075644.1665970-3-jun.guo@cixtech.com>
 <SI6PR06MB7104D8834A40A802CF6CB085FFEFA@SI6PR06MB7104.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lO07HjWtCSe5Llfz"
Content-Disposition: inline
In-Reply-To: <SI6PR06MB7104D8834A40A802CF6CB085FFEFA@SI6PR06MB7104.apcprd06.prod.outlook.com>
X-Cookie: But it does move!


--lO07HjWtCSe5Llfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 07:50:24AM +0000, Jun Guo wrote:
> On 9/30/2025 3:56 PM, Jun Guo wrote:
> > The Cadence IP supports configurable FIFO data widths of 16 bits or
> > 32 bits during integration. The default FIFO data width is 8 bits.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--lO07HjWtCSe5Llfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjo8fwACgkQJNaLcl1U
h9DyVwf/WCMG/NpBnT9MMwlm16K+zd2lPXv/ilYeqE7QaTU7WWngAYWiYFEoOdDZ
cObq2XEyhZLmb+YN77c0ovhJyscBfdZVlspZMWAav6JEjc0h/7VqU/KQJzJTsy5U
Aj4UxRx8wpiJWWwryPrs9BN3HkxObvWeShGEU0+YDSx+O/UXdT894AfXl9WTL2sS
BfE57HUnGuf6tPrxcfcIc5UVTHm1BvejJhCzJGi7f//uOmGkUcenQH9yd2pl7gp0
DSisTawh2QppOhrPFNidR+gL8FqULPybe01fGSqodm2gKV65eywghOrzUMtYeMro
LtWr+sUCG4XghAmclVUDCNTozt7ZAw==
=cXcT
-----END PGP SIGNATURE-----

--lO07HjWtCSe5Llfz--

