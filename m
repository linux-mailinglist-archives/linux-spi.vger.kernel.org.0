Return-Path: <linux-spi+bounces-3456-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BB590E921
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 13:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687F22854B5
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 11:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B646084FC3;
	Wed, 19 Jun 2024 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipSTa62S"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB04D8B2;
	Wed, 19 Jun 2024 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795929; cv=none; b=cHw/qm9MUtiLvfQ8whcsVYRKstKjbZhlw77IoJMP3Jh7nFn5BFjAOU/za9v5KGcZJYepnFf6blW3LHk5TvdHX6VnsA0rNB7k/Hyx3/hkAJ3VRBdeetrraYbXH/Qvb5qd1XWqjYT8mHkHUW0huImqIkvcbg6/C2jc7dDArPP6tVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795929; c=relaxed/simple;
	bh=z4T+IJBLwyf5+aKRPm9GucoAyD3f08lBm6C/VluK0Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaJ1Ws767BY4NN173DDeLTE72F/DHkAOU2Ddc+1VarDzvga4PRUPxZNcHBfnpIPpCcJ318Pt+cxLxFHrcYekyEV7+lGcmF8DnThV3fPzOoPh64moqn9tpxRQLjoNK5dUlWCPyLrttZfkRwLY8YNYgF8EmJJOWXOyFS99njMJokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipSTa62S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F54EC2BBFC;
	Wed, 19 Jun 2024 11:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718795929;
	bh=z4T+IJBLwyf5+aKRPm9GucoAyD3f08lBm6C/VluK0Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipSTa62SfcCD6kWVUoBW1qjbaMOFa/kNXSXeFPQ/n8wwW0lG/18nkza5lJUwCeqQb
	 quHlYsyx81Og7GSKknkYPGpIWcApAhknBCQ4jsDn2VGdAqIJ7K2eGh6yWmQPFsceiq
	 jdVoTY5HHRzeMVOMEIIjPkJ84NkRRCCeH6lzcjqsTa0Z1rKJeC66LjJE5P+Y0u7ryh
	 PyBQqQWaHZRkEcLspdW64OAiywWGnljAeNCIRhRYnqBUa7INu2uPjOqNa5gsbRBSNi
	 hdqgVg2Cjgoui6YypjZLF+Z1obYbXfUdUzQKhvCFiHJuZc6kZlZeBDeOW9J3Q7cscY
	 KJUtQqN8az6Hw==
Date: Wed, 19 Jun 2024 12:18:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-mmc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, cyril.jean@microchip.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: Re: [RFC v1 2/3] spi: microchip-core-qspi: Add regular transfers
Message-ID: <20240619-frozen-angriness-8648636f1440@spud>
References: <20240612-brigade-shell-1f626e7e592f@spud>
 <20240612-uphold-dinner-a47b4c44be18@spud>
 <ZmnPh39YyfS4ocNU@finisterre.sirena.org.uk>
 <20240612-spending-stalling-62070dbbcf3d@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bZO+FHlLZI0c0AGy"
Content-Disposition: inline
In-Reply-To: <20240612-spending-stalling-62070dbbcf3d@spud>


--bZO+FHlLZI0c0AGy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 09:48:16PM +0100, Conor Dooley wrote:
> On Wed, Jun 12, 2024 at 05:40:39PM +0100, Mark Brown wrote:
> > On Wed, Jun 12, 2024 at 04:48:32PM +0100, Conor Dooley wrote:
> >=20
> > > +	//TODO: questionable robustness if both cs_change and cs_off toggle
> > > +	list_for_each_entry(t, &m->transfers, transfer_list) {
> > > +		//cs_change being set means we need to re-enable
> >=20
> > Is it not possible to implement prepare_message() and transfer_one()
> > rather than open coding all this?
>=20
> If I can, I will. I already found one issue with the cs toggling in the
> code Cyril gave me and I need to figure out why there's a udelay(750)
> required later on in the function anyway!

Actually wasn't too bad, glad to be rid of the open coded CS handling.
I still need the as of yet not understood udelay(), but it looks even
worse now:

+static int mchp_coreqspi_unprepare_message(struct spi_controller *ctlr, st=
ruct spi_message *m)
+{
+	udelay(750);
+
+	return 0;
+}



--bZO+FHlLZI0c0AGy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnK+lQAKCRB4tDGHoIJi
0p4lAQC9ueXu3bI/u1wcG0M7RbuNlGJDK37D2Q/ueWBcxQVIUAD+MkzD/mHoIpM0
MXOkMxtS9lWwiMt8z42Pg949gpXsMw8=
=h1cY
-----END PGP SIGNATURE-----

--bZO+FHlLZI0c0AGy--

