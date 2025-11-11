Return-Path: <linux-spi+bounces-11154-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C40DC4DA0A
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 13:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A606189500D
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 12:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AF732A3FD;
	Tue, 11 Nov 2025 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH+D4Tff"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA7239E70;
	Tue, 11 Nov 2025 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863557; cv=none; b=FM6fpR0Q3ILv6tLImWPu+emtTsGESDoDJxIOPkvvBs5rLwZWgncJU8++F3VuZN4PwmboZiSDky29jPc7Cc9sgscPwkobxAgSZSasL4YkSuzhj3Bw5Qm+U7ZMMiBzJqy/doJl9eNrJIl3PDRqRnrvCDvHEBfGPMTPMblFk3gOXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863557; c=relaxed/simple;
	bh=WlEDl4Mkx9lsXLC17Q76JUqc2sveCWPAL4FHx2Z1Vno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFvHnWR5AEYhC5iWg5/SUwVzF1i4WRH+yAcmTNfQ+suHAhrZvUXQa6EpO3QoTyDzElm/knqYS6JcBZdgsXTEfovDj44eXADjGWqk9iT3sio/L+hQrajyivIqPADzpBZF8fgSHSSXAOIIAdTDLtU2UVdtC9oRDfXXEneJ7eulzYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH+D4Tff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A38C4CEFB;
	Tue, 11 Nov 2025 12:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762863557;
	bh=WlEDl4Mkx9lsXLC17Q76JUqc2sveCWPAL4FHx2Z1Vno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZH+D4TffBclTBCVa0oiqcfp3pTR9AgP8klgDzmViwzcdTPcv9WdsRgs+H4Hh6wCmr
	 o8blumVcpS3ICNd4pOvi9COmyivEwnZwAqC4Zpj09RQGfCaHurmYzeuzcgISZVtirN
	 BAtfWbXoPvGwSH7+meMiaBkvanVnahZDnLXZyCrJWYvtpNes/bizMmR+M+ESgk257x
	 UdGDhLORkqaC7URC/iV6kZobtCTc915bWxjZNC6tCF0G6gYDPLnTVnOUFXncYXN+mj
	 7AB48nanvfhIPn4ROEwfzgplzmGEOUPax55zUTirKVrNYqtImebfCv2t9e5Gj0x+J7
	 wT9KasDvW3FGQ==
Date: Tue, 11 Nov 2025 12:19:13 +0000
From: Mark Brown <broonie@kernel.org>
To: liudingyuan <liudingyuan@h-partners.com>
Cc: "shenyang (M)" <shenyang39@huawei.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Kangfenglong <kangfenglong@huawei.com>,
	liuyonglong <liuyonglong@huawei.com>,
	"lujunhua (E)" <lujunhua7@h-partners.com>,
	"yubowen (H)" <yubowen8@huawei.com>
Subject: Re: [PATCH] spi: hisi-kunpeng: Fixed the wrong debugfs node name in
 hisi_spi debugfs initialization
Message-ID: <aRMpwbhRuS1ID_P9@finisterre.sirena.org.uk>
References: <fc10632d875346eead8bf488c56b6bbc@h-partners.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/f0cS15qVY0BzXB2"
Content-Disposition: inline
In-Reply-To: <fc10632d875346eead8bf488c56b6bbc@h-partners.com>
X-Cookie: You dialed 5483.


--/f0cS15qVY0BzXB2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 02:01:03AM +0000, liudingyuan wrote:

> Gentle ping on this patch.

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

--/f0cS15qVY0BzXB2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkTKbkACgkQJNaLcl1U
h9DAIQf+J5Y2QbxQRWNkxPme49L1jlgmvl/HOrSqKkWbdgwVYA3KUFZHtSYwx7/8
vuWx+hYx704h6KMpVAdUCgdFRRI28DJiCDt3lZL6kwZzaAueRgHrpDr/HQ7SW3ta
v/vuaO+Fn0FrTtoujjZRoburZHkZzpCILycFDRreXFPTnf/uaYMw2ky8AjPrXhRU
hysFqOYlnGm8sfemDHylieFmrUrDO+GI7lnI+AlsjI8kGG593BhngYzmOwRFLz+P
IbJsv82gPS/c0mByALDZTdvsvbBF3aQWqHN8D9JwFlG8zv7MZg32pCZVuWwuIG8Q
y/6toof6Zz4/LZZd1KGtr3ISMJiiBw==
=/zQY
-----END PGP SIGNATURE-----

--/f0cS15qVY0BzXB2--

