Return-Path: <linux-spi+bounces-3356-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DC6900A04
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 18:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5847D1C23C1E
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 16:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC819AD78;
	Fri,  7 Jun 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM4zMeXq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6186D1993B5;
	Fri,  7 Jun 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776447; cv=none; b=bGKGDgBbRtG5BwdiuLTxBUOLZtMGTou4kofJYpeq8SjCTAAb7zxvWSCM5X8qVedVDh7PNO/rFaW6uma//NYVvY75tm+YNPAJ/TjH+FFq4f5Y4qQNbQ1Tx5+R6xif/Q/YI3yGQSyq2wPz8viXNm1KwcpP2BP+Za39A3fN38wNqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776447; c=relaxed/simple;
	bh=75i5sv2osy3F6OTF4kf2ikAYvuYFJQbjbAFRxbsamyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHOv/WLQ/Szk7LYpG8WiS9CAotvMO3QoK7Wrpaof70k1fq/RrV67lNdnHbeHnAr8SH8OTX5nnyQ+oIf3AT0SCxl8cOoOdjHYouZ2SBVjTzr2eksL5El3cZsUN8nceOBfjhZtRbYZ3/TUAB/K0lRk8r4ajcwdfItdztKsG1lJjr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM4zMeXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3E4C2BBFC;
	Fri,  7 Jun 2024 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717776446;
	bh=75i5sv2osy3F6OTF4kf2ikAYvuYFJQbjbAFRxbsamyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BM4zMeXqQWVFCFg2mH29wyrnR+o2eKvoWuIxpECr7J46oTIBnl1BHtX6rlnJphVIh
	 ffvdsTjdzyd/gtT/PJuVDxQMXyNnYnS+sJY/XyS7gs8asIvAScvq/I5eLkFZu6xuOq
	 buOV/ae5NOUAaMNKmyiLN/gNQZWXb0adlfOwDxPnYsxyAUDIETApd+jhO/DlK86TxN
	 RrLsnqzK/Q8KW/X3NWrZhb8mWTVdOL5WwSOgsqZdjOmZFA32AMZGi4hq/C3B3ysasK
	 r/IbpaBoc8Q6nKxoVtEBTVZEoeQhqhtGOThSe79J6AnwxTHk8YaH/dwzjKB6/tccz0
	 ZJHq6C4BKg0oA==
Date: Fri, 7 Jun 2024 17:07:23 +0100
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?U3rFkWtl?= Benjamin <egyszeregy@freemail.hu>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spidev: Introduce "linux,spidev-name" property for
 device tree of spidev.
Message-ID: <20240607-upcoming-tidiness-401e5d0a8af0@spud>
References: <20240519211346.30323-1-egyszeregy@freemail.hu>
 <1ec9e8e5-0818-42b0-8776-d9cfb0585f42@sirena.org.uk>
 <9ae65e3c-f1fa-4ca9-8d74-12d92c51c5c6@freemail.hu>
 <e8837fe0-e93c-4133-aac1-f8f0a010f6de@sirena.org.uk>
 <30944fda-6d18-4fc1-8c73-bcda4814a417@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kswT3B/YF4mS8yoS"
Content-Disposition: inline
In-Reply-To: <30944fda-6d18-4fc1-8c73-bcda4814a417@freemail.hu>


--kswT3B/YF4mS8yoS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2024 at 05:31:10PM +0200, Sz=C5=91ke Benjamin wrote:

>     spidev@0 {
>         reg =3D <0>;
>         compatible =3D "rohm,dh2228fv";
>         spi-max-frequency =3D <1000000>;
>=20
>         // via my kernel patch -> /dev/spidev-mysensor
>         // linux,spidev-name =3D "mysensor";

Given you are describing a DAC as a "sensor", I doubt you actually even
have a dh2228fv*. You're looking to have a consistent name here, but you
can't even rely on Linux even continuing to bind the spidev driver
against this compatible if somebody comes along and writes an IIO driver
for this DAC!

That said, google seems to return no results for a dh2228fv, only for a
bh2228fv. Makes me wonder if this device actually even exists...


--kswT3B/YF4mS8yoS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmMwOwAKCRB4tDGHoIJi
0pOqAP9GO4kepCashO7Y3AjkXVJoHS4PoLhigibXkEbYlB3eQAEAuLd0e5h4rldi
MPTdtfAutdaysEwujDWjtqdtU4LhfwI=
=8StO
-----END PGP SIGNATURE-----

--kswT3B/YF4mS8yoS--

