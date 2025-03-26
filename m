Return-Path: <linux-spi+bounces-7331-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C61A71DA5
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 18:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7508188C063
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 17:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9B9219313;
	Wed, 26 Mar 2025 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="aMSBvJQZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D73017E4;
	Wed, 26 Mar 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011158; cv=none; b=le6UdtNUPIxk6BHtG2VJi2tBZfR/ofOOwys6iDOhSC9l3GUUCX2c3wAioYC/4uL7TyC7pI0yMANm10xL4MtIbs3M1R6XBYc0Bm2cuvvme6U95PzFtBMpejwne8j5id7miK2Vm0dgmgJ832Sb8KajnsgRbtHT0TNb+vvm6YLK3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011158; c=relaxed/simple;
	bh=t1iLPADlrRh7sTkLR+8K2hYQjsHR9MdLT3BhEufi6uY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuP0moeR8JKfq/7/+ikkpdcmur3liaXln2yYWx2E0YKDf+9l5MNqogQWsYZkcMlBX2VqAnyzQTalErJV5YL+Qztvm6YJLyhIwTmIINnnlvAtU+OvDwP+Z+NEK+cNyKnDrcrlHgrBSfCUducnWUMiUzsIZDX4gr6CzXmKRAHqKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=aMSBvJQZ; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E79210246DBA;
	Wed, 26 Mar 2025 18:45:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743011154; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=H2uGHhEWg3JZ/p8Dt7d9szFu3FMB52FFPqrpmORpQ8A=;
	b=aMSBvJQZByJxxa9rDE0UHlPGY9xvTFLXnmGeZg2qR59XMscq6ggfcXSetM6lLMrLC3mUKl
	vZSBOK2Ld/1tScvTiyLVpeNZUHU+PfhaB+e/9+h7rBBvIa6Jy/bl3RlT5+ZwQHY1Qg6Lzi
	IEK+k6MJ2zjbFDIYsA8WNyLftzzZbS+yF/ys6ORRM2Op8NYcJywIX5yollJ45PvZsvoiX9
	DMJX3WQbgVEX4UOiVlaS85mLREDqIdtHv9Eg+fX17Wvc67Bjg+yUch9l7ZP936PGPRZTUL
	a34vC8u8BU1hNAkudOgOlDTaBeYR7WfPiQV16B3/itcTj4klOD7Uv8wHdJufeQ==
Date: Wed, 26 Mar 2025 18:45:53 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: spidev: Add compatible for LWE's btt device
Message-ID: <20250326184553.0756c496@wsk>
In-Reply-To: <83685ed2-f41a-456c-8a22-0ac069304386@sirena.org.uk>
References: <20250326174228.14dfdf8c@wsk>
	<20250326172445.2693640-1-lukma@denx.de>
	<83685ed2-f41a-456c-8a22-0ac069304386@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2TmOQDCUmF/H18MMAiJ03ic";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/2TmOQDCUmF/H18MMAiJ03ic
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Wed, Mar 26, 2025 at 06:24:45PM +0100, Lukasz Majewski wrote:
>=20
> > Changes for v2:
> > - Use 'lwn' vendor prefix instead of 'lwe' (as the former one is
> > already well used in Linux sources). =20
>=20
> Are you sure?

Yes, the lwn is already present for a quite few years for this company.
The lwe is just the different branch.

>=20
> Note also that as previously mentioned I expect to see a binding
> document update too which doesn't appear to be here.
>=20

I've just send it to be accepted to trivial-devices.yaml

> Please don't send new patches in reply to old patches or serieses,
> this makes it harder for both people and tools to understand what is
> going on - it can bury things in mailboxes and make it difficult to
> keep track of what current patches are, both for the new patches and
> the old ones.

Ok, I thought that it would be the opposite - that you would see v2 as
the reply to the old one - especially that the change is just a single
letter.



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/2TmOQDCUmF/H18MMAiJ03ic
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfkPVEACgkQAR8vZIA0
zr00NQgAhPs6iLe5eGeJbcOnS+YaVgIIuosnstmqfPtM4c2H9vVehP1fyt6p0+6e
NcD1H2VXAz78n0ur9Ba2/FLfIJl8xDNT8npBxybJVvEPy6xWEkcxIcKkqYkuV0xB
oXeXTuWcK9p8Amqm35OInDjBrIie5rKpMpYxhJ1HeVeD7EgDGNQc3rMW+jBXN2DL
2U9fnw6rg1xOQPnJX0RsRgZCUT4Z6PyuzvjlnoNv20JMchJx12PnXbds46iFYAhQ
MflE7bsOZWxHxXAIwu4yEAY8hsBegOXDPQedaLLSx8s+mkuhraYqyqkzYYLnRs5h
aUPENLEL3T4ikgu6LdrV6Ag2Pngvng==
=uKOe
-----END PGP SIGNATURE-----

--Sig_/2TmOQDCUmF/H18MMAiJ03ic--

