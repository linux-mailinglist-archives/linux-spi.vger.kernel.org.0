Return-Path: <linux-spi+bounces-7334-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F94EA720C9
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 22:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A273B7231
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 21:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D8F25F7AD;
	Wed, 26 Mar 2025 21:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="A0tc0IoH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8750A19FA93;
	Wed, 26 Mar 2025 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024498; cv=none; b=RLhT2ksuKrEYymgaRvUNU8JHa2UmuP5xQN9CkRf02/R8Y7z7WhDh6mbJWN/T/egeMbhO1FnUX2mLDb3aDBgFNhvOVmV3o6IneoXA5YhYXCKDfXoKTXe6ymjZjdqIaO1kC0G8FXfGgFFeALjl4h3dgkHFOMihGMSiRKIoA58Tpc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024498; c=relaxed/simple;
	bh=OBw9ipfX8DLQWYwCbr3x/zmBXAhxvC081tQVlHAiy+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XF90GPXJBV6jlGoNa9cwpFoGnm849O/qPl/tvg2RQPsABU5e170Ynj14iE12Q7IPfRPNmYUviqbPNXUN683xBNTl5efoLGh2rO//KRvQy1RjNftxvqE8qm7K3KRuPkK0TaZw99FHWvAhe7qnrNhSDQa8M9cKL8nZurZfw7ikhrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=A0tc0IoH; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F69C102EB802;
	Wed, 26 Mar 2025 22:28:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743024492; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=F8xEET/KGibHoNetoXRxyjjf3phhHE3/7Rrox+PgyYc=;
	b=A0tc0IoHhQmVH+iKTnDidJKCMtXcGfXyDU5bXXYHDPXwha6s64aFrEvupYQho2JACGAcY4
	GhR0i91+sl4Q17s5n0iI2KgWPA3M8RdfLK3cWtFpnN6KXTv7KW6Ufn8u6Xw+8DzFUqJGHv
	5XXTHLTISwWbP4YTiDqWymwt7/Y2Ua56KjVxwaEvoTFQ7M0DXaNLAHd/jUUeqnowbgEz0q
	vCyJcdigmcsI/NwlhIMz2M9aoW+l/Mk1IbxWJ6nZR8BOWFASE48IoTh/mvai1lDdDsCF12
	UFOmDPTm9JfbgEo1VnBprC/cIfXxWl5D3jTfD1fZk3NXW5wyxgkcUnX9mTUXRQ==
Date: Wed, 26 Mar 2025 22:28:11 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: spidev: Add compatible for LWE's btt device
Message-ID: <20250326222811.5313429d@wsk>
In-Reply-To: <5f514949-5162-4944-8424-bf19318c5611@sirena.org.uk>
References: <20250326174228.14dfdf8c@wsk>
	<20250326172445.2693640-1-lukma@denx.de>
	<83685ed2-f41a-456c-8a22-0ac069304386@sirena.org.uk>
	<20250326184553.0756c496@wsk>
	<5f514949-5162-4944-8424-bf19318c5611@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ks3BX76zcDf=4OtGr_CtXxi";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/Ks3BX76zcDf=4OtGr_CtXxi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Wed, Mar 26, 2025 at 06:45:53PM +0100, Lukasz Majewski wrote:
> > > On Wed, Mar 26, 2025 at 06:24:45PM +0100, Lukasz Majewski wrote: =20
>=20
> > > Note also that as previously mentioned I expect to see a binding
> > > document update too which doesn't appear to be here. =20
>=20
> > I've just send it to be accepted to trivial-devices.yaml =20
>=20
> As previously mentioned you should send the bindings update along with
> the driver code.

Ok, so first shall be the patch 0001, which updates
trivial-devices.yaml and then 0002, with changes for spidev (this
patch).

>=20
> > > Please don't send new patches in reply to old patches or serieses,
> > > this makes it harder for both people and tools to understand what
> > > is going on - it can bury things in mailboxes and make it
> > > difficult to keep track of what current patches are, both for the
> > > new patches and the old ones. =20
>=20
> > Ok, I thought that it would be the opposite - that you would see v2
> > as the reply to the old one - especially that the change is just a
> > single letter. =20
>=20
> That's exactly the problem.

Ok. I will not use --in-reply-to=3D switch.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Ks3BX76zcDf=4OtGr_CtXxi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfkcWsACgkQAR8vZIA0
zr3r7Af9F6q/GhqW88ZJpgmdXjoUCT3appA+loaa8LkyXE5J/k2jEsL5oWAkp7e2
bPhjl2yBDggw6MrpodSSH01/A41obcGI/2cMTwEfYXw3458vhxBgz8rxgD7S2CPR
XNESHJMiWAgmxvLJVP9vDqiwKKAWs5aBtFSkQpko41M316+8g2AYTaInMMnm3MuT
2P1oZf+AuCxksrjrta+Ct003xNJfAAghsaaRgulAXT2tDwCSxuXsWyTceQQKCcTq
1wRLXd885bDrxuzUxsA9UaYwGRosHK3Wz0+E6iOusuDa4Y0MRD7nMv8Ocvy3ox/N
ksRdPyEh/XLN/MzhUnsQ1mL6t4/djA==
=hRyJ
-----END PGP SIGNATURE-----

--Sig_/Ks3BX76zcDf=4OtGr_CtXxi--

