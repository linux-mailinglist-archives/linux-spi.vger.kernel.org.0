Return-Path: <linux-spi+bounces-12438-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D12D3073B
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 12:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20073314E3E9
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 11:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9FD378D68;
	Fri, 16 Jan 2026 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DxVUHhQv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977DF376BC2
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562823; cv=none; b=hwWfViycO2vrq+K8Sd7CfpLJUif5SysHRi/6jvTeEYfBhW6NcxC6PYtMh2VazFy/XsyVqm3pbvIm8HVcv2lDGi/2xIhWOO+78IdsrHhcTXmCeavPE/bIoNl9/alN+42hsWTz+3bA9+8KYyXDy3B0Fg6U329wa7/GukmI3FUeLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562823; c=relaxed/simple;
	bh=UD5nhW/byvJ+BqnsUq5Zxgn9awz6cxrGdcE03QAcfN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5cTSwpnAUTGL1uBc55JzEoukLvSzG537WhKLI97f29LqbXQy6sJ5KaAx7IDpvB7D5cAgPHRdcq4O0XLSXnBMJKe4G3uIwpx8qctzZJDR1oa7RQphgnYxGxT/FeaUyDDhz/qKKQkVHniJY1ljynFXQN+H3h0eQsFqCtY2b25yBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DxVUHhQv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=UD5n
	hW/byvJ+BqnsUq5Zxgn9awz6cxrGdcE03QAcfN4=; b=DxVUHhQvCY9EWZScBCxP
	im5RRclNw0qZpqdiR+YAkCJzgp+8TX2yAUPTlR7CWCPwQ5hwWxh8ewm4vUlqolSg
	x+B8rpY/m7RgmU796AAJiPHQpfuKNzrftgojWjwNeX3SU2o/Q9HUit65iwOCtHj4
	WhticAUIsUzjt4nZgvTya8gShR8KCnaKsrG18q0ueFQZQA9WvsYzrAUdlsa5SRrk
	HgXaqGr8ULuokaCkmfLdc46Sxoin/7SPqhzgwKW0T7yorniAEHAD5LouOLlDNmVX
	TGqHfSU2pmCftQ+octncdTpE3jbzFXbbGN+yLe4bfyKJf0WK1P0vKPbcIxt7IcaX
	qA==
Received: (qmail 2892996 invoked from network); 16 Jan 2026 12:26:51 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Jan 2026 12:26:51 +0100
X-UD-Smtp-Session: l3s3148p1@EeImnn9IVqIujnua
Date: Fri, 16 Jan 2026 12:26:51 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Santhosh Kumar K <s-k6@ti.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 00/13] spi: cadence-qspi: Add Renesas RZ/N1 support
Message-ID: <aWoge3-IkPqVxmf4@ninjato>
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tYBdv2s2XUNiSNx0"
Content-Disposition: inline
In-Reply-To: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>


--tYBdv2s2XUNiSNx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 15, 2026 at 10:24:51AM +0100, Miquel Raynal (Schneider Electric) wrote:

> This series adds support for the QSPI controller available on Renesas
> RZ/N1S and RZ/N1D SoC. It has been tested with a custom board (see last
> SPI patch for details).

I can access the SPI-NOR on the Renesas Eval board
(r9a06g032-rzn1d400-db.dts) just fine with it. So, for all patches:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I'll send the board DTS addition as RFC in a minute.


--tYBdv2s2XUNiSNx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmlqIHMACgkQFA3kzBSg
KbYHHA//c8oRrN42MUJUoNq6ioR19Cgx/RKcbbcfUCqLeg+RXkn0RD2jzEJdj4Py
ra8hrHjZtlRCjZKwlJXGtTGjVMvKP+4fE/QeCKzjaQZZivtza3Whkr24dDSL1vRH
PSD5tuMUja8l+8q3dSdy8AcCYA01JzP2Bgn/O2BsWsYa0YIHpfQuPjH0ECSyFjVb
6RPGxruFPj+Zc31B05NRKC+uPZLYUQIxOp76ooSIx0wiEanvokk1JUqo7IEWNEyl
nab18iw5oz+2nRlwiKZOMgjnzIoocqmPAN6r8V9y6yTHARKkpoQHGXpJv7/YCd/P
GsnZdCw2toSq+TQBsawxDPkAWTDFv50RhI/+o+zpAvVWnVdC0Iay+n2bFSpyUwB2
SWsOPwrclpmhf/nKx7mMAOVYbK5AXQFnNT/WnIZ97CSO9hgbT7boWMcR1x7e42WU
C6bENfRhb91fk8tazlRTFvPWTWYgCTjJtrP0FKbIYkKCw/JUPMLkRdMaD5lXZ1t1
YPW52wKrZcGBrLXXxK5bujwtw8tMREl+KbxQ085ogf546Jq9DOPOnf3bIW0JYkkB
WCvjycwBGyGygIEU0zTqCdIrstT8XZ2yDMgXhJAeKMr3IxAxugnU6hfbjuqciKtQ
1vAS7WDulcl5QBQ0miw4K2ww/Rpro/Ozzhcx7aeLvSKkItooAX8=
=cuJn
-----END PGP SIGNATURE-----

--tYBdv2s2XUNiSNx0--

