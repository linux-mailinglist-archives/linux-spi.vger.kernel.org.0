Return-Path: <linux-spi+bounces-156-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF98807151
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 14:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9389280FDC
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A143BB3D;
	Wed,  6 Dec 2023 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsyAeJ9S"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA895241F4
	for <linux-spi@vger.kernel.org>; Wed,  6 Dec 2023 13:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EBEC433C7;
	Wed,  6 Dec 2023 13:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701870935;
	bh=4wG2778RJ9BN1vj3tcdf+nWrzYvGBZUU1AlPFXB6MuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsyAeJ9SclO/4lpPCeNWcuTis9RwUp+wgN75mkvE2g5gxsgEWfVTmX60MBvkJR1n/
	 u+qdanMJMi5YxHGEcb2oU8ftuZsLKdPH7G3E3tiLWOc4mSjDhvOdzOr+m6GPfXGVEK
	 qVNWxEt2i9p6TP0WERiuGCaP7rXOFenGaow6ZwJgAr1bvcNTWQsbWPGBX861eSyfvZ
	 UjqlxWescK65kTWwX48fGqzNM/ESDqqcm+6vEdFmcLNiWLAz83sLr4bWNnTmjQcmxU
	 /pb5MIrtQDuAipQ73a8ruNiea/cDFVEEkGKDuHnIrNB4O+vpEo0ue8LgD2IfOjsvSN
	 o4agXSOsraQZg==
Date: Wed, 6 Dec 2023 13:55:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@zonque.org
Subject: Re: [PATCH] Revert "spi: cadence: Add SPI transfer delays"
Message-ID: <d8eb53dc-5158-4212-8715-052e9e99768b@sirena.org.uk>
References: <20231206134446.69048-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zGuUWPL8Su5KzsnF"
Content-Disposition: inline
In-Reply-To: <20231206134446.69048-1-namcao@linutronix.de>
X-Cookie: From concentrate.


--zGuUWPL8Su5KzsnF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2023 at 02:44:46PM +0100, Nam Cao wrote:
> This reverts commit 855a40cd8cccfbf5597adfa77f55cdc8c44b6e42.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--zGuUWPL8Su5KzsnF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVwfVIACgkQJNaLcl1U
h9DQLgf/eOjAdaTe1eSw1Z8YIUpxfaQZCyKkVEKPYnA8Z4ugSLnYtJVABS5T3rOB
/BDp3ibVeFfsiCwB8A1/HwLjjxEc7kx9AW6FXQq6prkno5tqSEvZmt/QQUURra6G
znSWwNeA/DlXiqKateYvmB5ysYQAR6qdLeFPhcLk7Bz7Cz02YeTsnBr8tGGF5s/m
SGoHZ1Ywc+QMzEzTqZ9oBlwVsc1LgnXVOn1WvlTSK+eRuhcuElcs8jYhEz/rsZcE
ATPiunC+YRmoUZeZIA1IbKzUNki8VnzmSS+1RE1JHwCtzZbRDWQof+WZ5bsjBwNZ
YcOfETV85Kv2ymlPTcsr0pFgDTX5+A==
=4v3Z
-----END PGP SIGNATURE-----

--zGuUWPL8Su5KzsnF--

