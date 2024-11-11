Return-Path: <linux-spi+bounces-5681-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D4D9C4615
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 20:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEA42838B6
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 19:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56915170A1A;
	Mon, 11 Nov 2024 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr0d2xAf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729A2AEE0;
	Mon, 11 Nov 2024 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354338; cv=none; b=iAGyLz0cKY1GjOJF3nBrXefnxAvoRQ3pU6J7CuTUPoECVoJLk741ZbZhimZFlM7yJMFvoa1O5pAeY8g6QwNNiRZvFDsaxDLxfQTC/H9Y/iTy6rUSLelvlFJJHCpoDbiUr8PEP4PctT2xeshrHlUlNNa9+XPUDQkMir6LqeTuS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354338; c=relaxed/simple;
	bh=d4MgOboHDGtArnfKiEq9gLM88LKKae7ra0P3dbQQh+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPoEfnIney3NSqA4ZKNWl3xpi8rAAK8sr3X2/eoyLOdkZ/zfFwJd1ZXIxXpk3L0yjxf51oUxj9CBF5YhWd4z7FFdaPnypNsImn/GnJn0wceaFQGpSZYSpq1BJ6t1Z98r7jLSjMugaPsTiplTkZqap/rZ4qxmDNIHJ7ftYl4+x7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr0d2xAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2182CC4CECF;
	Mon, 11 Nov 2024 19:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731354337;
	bh=d4MgOboHDGtArnfKiEq9gLM88LKKae7ra0P3dbQQh+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nr0d2xAfMpq6SNZ2t+tAWHRm/SOmakiGQ9MWVnJfK+KhLB/SeyZ8RFVtTDTx9CYcM
	 GzzCHp3/npKlx6jVZ97g01NSgbyUVMhbtHMmmSFu323D36vo5XVFNUdipdozTJCxHd
	 ZyfmA8KBfNMRUjHCV+KqOm38DLJG/V+2lEEUNKgf2LkYMiQ8Y1DknmdSoNa1P9pTBU
	 BCyZNXIlX+svZbS9VKhjg0zNgHYrTHYubQ8OzDNgXPpsOrrHDlen7axLHaq7jIoZeb
	 pZ3SjyxYz7EjQBQBZ+TRuvnxyNpX0ScEIvjfYJ1WxoHz+J6x7TmIqLeDCogfmWt12m
	 JqtJvQDScsWfQ==
Date: Mon, 11 Nov 2024 19:45:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Leilk Liu <leilk.liu@mediatek.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: spi: add compatibles for mt7988
Message-ID: <20241111-progress-prowling-218c6deeb80d@spud>
References: <20241109105029.52748-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9tiAjd6YQ+IiB3Gu"
Content-Disposition: inline
In-Reply-To: <20241109105029.52748-1-linux@fw-web.de>


--9tiAjd6YQ+IiB3Gu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2024 at 11:50:28AM +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> MT7988 has 2 different spi controllers. Add their compatibles.
>=20
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--9tiAjd6YQ+IiB3Gu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJe3AAKCRB4tDGHoIJi
0mw1AQCb5apX26pqvjtNd0u/x/gAxpqpZjI5yV2+/RYZnNyFvQEA9vWKqaUMxxMG
5FhEkO64XoDuZC7W0YM+ELEVVtXM0g8=
=X0+9
-----END PGP SIGNATURE-----

--9tiAjd6YQ+IiB3Gu--

