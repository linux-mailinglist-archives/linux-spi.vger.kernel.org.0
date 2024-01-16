Return-Path: <linux-spi+bounces-484-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F3D82F1B8
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 16:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF0C285352
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC091C296;
	Tue, 16 Jan 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsp2tg04"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E21C294
	for <linux-spi@vger.kernel.org>; Tue, 16 Jan 2024 15:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09D9C433C7;
	Tue, 16 Jan 2024 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705419702;
	bh=jxCyQZwNbDNl0nONyJqst9sda5njmxl8cVr5tAs4E6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsp2tg04xZe2Jy2dRXcM8+R4ecZ51WGAX+kSDrAtwOBxWt/I9Lx4ltnsdsE0YWvNX
	 hw1chck62SipAPkHdFSufV9TyIcMBHe7mTwXXFdXVYz6I20fKkghQaynL1OOk6tuSd
	 op36QQ84gylzFofdKxjfE6z+w1myyfEMw54TAyuCAtQVR2uRTSUNDdiAxFO2i5ChjE
	 lnG8Odo879NgvHo4ifG4DDEHw0fZl162yVc4RlRz9vApM/iOWJZlxxTAxNECzF/Ipv
	 HUPMerxJQ4MNXnYPlXmMrbqwmc07PsvkhHmVvakoJSDb+3aCqlaFWuGp0zaMKoV8gC
	 u6g1M1M9BiJCQ==
Date: Tue, 16 Jan 2024 15:41:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-spi@vger.kernel.org,
	kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 23/33] spi: slave-mt27xx: Follow renaming of SPI "master"
 to "controller"
Message-ID: <9e396453-3979-41bd-bcb3-0a4c2fe3d804@sirena.org.uk>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
 <ce0557861684ad5b6c51cf8f537c69b5a59947f1.1705348270.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lnhaZFfqnb7DhkjJ"
Content-Disposition: inline
In-Reply-To: <ce0557861684ad5b6c51cf8f537c69b5a59947f1.1705348270.git.u.kleine-koenig@pengutronix.de>
X-Cookie: Programmers do it bit by bit.


--lnhaZFfqnb7DhkjJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 09:13:09PM +0100, Uwe Kleine-K=F6nig wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
>=20
> To be able to remove these compatibility macros push the renaming into
> this driver.

There's obviously a rather large elephant in the room with this one :/

--lnhaZFfqnb7DhkjJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWmo68ACgkQJNaLcl1U
h9D8lwf/ZhQYFD3maLXuFyT7mmGI4bKhBsI2Ql4UpW1PT/I6J1tKGKk/S0oeVCDl
uG32Z9pWSc3IBPBscsn8pbRilVB9bkNuNNaepPUOjOxLVf+ivmT5xA/C2/o+zVCl
eJIY2VTANVTlGi3VI/vq7zdKWrvIxb4edbRxXp4yTsBD5UPVneUoQM+nh5Xne5Bd
bDkvHy2hpGfSfyG9Vh+URa7WOAF56O67k+IImTlCGAK0u0h/qaf5mpkQZbqvwyW2
oBsPHiQ3tdcu+iBRUhcA+U/YjfWIsHUr1xSGrr39R4slchpzd9BszpFU8V9XP/Ep
GUzEaPW8bhWmt+GoQI+1B+jrllxWOA==
=ijMg
-----END PGP SIGNATURE-----

--lnhaZFfqnb7DhkjJ--

