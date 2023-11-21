Return-Path: <linux-spi+bounces-12-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13347F2A7B
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 11:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3EC282288
	for <lists+linux-spi@lfdr.de>; Tue, 21 Nov 2023 10:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029FE2D60C;
	Tue, 21 Nov 2023 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bigler.io header.i=@bigler.io header.b="dJ/kdXHu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [IPv6:2001:1600:4:17::190c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE623B9
	for <linux-spi@vger.kernel.org>; Tue, 21 Nov 2023 02:34:31 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SZLN334lqzMq5Gb;
	Tue, 21 Nov 2023 10:34:27 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4SZLN24kbjzsB;
	Tue, 21 Nov 2023 11:34:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.io;
	s=20200409; t=1700562867;
	bh=Ue3HqBrGZjKNKmEwdQ/OlJMkl8TdBMvCZuihXhj55ws=;
	h=Date:Subject:From:Reply-To:To:Cc:References:In-Reply-To:From;
	b=dJ/kdXHut6B1ZSq3eh76siQ2FeZ9Ef2vfjpQA45qywQQD46YWhcP1RPdZgW6zpZDz
	 yC0iA2RMP7S06BAUhGdAnrAHMdDtZSXm9ZOOlDfjd0AlW4UhGaIZ0e1lL37cDTF7vG
	 uFl9XZ//HW4hZXfddP211QeUi4e2MBeD3lVQU06U=
Message-ID: <44e61a3385f84aa417a208ca348e4b8c@mail.infomaniak.com>
Date: Tue, 21 Nov 2023 11:34:26 +0100
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
From: linux@bigler.io
Reply-To: linux@bigler.io
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Stefan Moring
 <stefan.moring@technolution.nl>, Linux regressions mailing list
 <regressions@lists.linux.dev>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6Imt1UmVCa1pJOTE2Z2JOQmZHNndxN1E9PSIsInZhbHVlIjoiQWUzbThTRjNuL2xVaFBzcGVLdmVSUT09IiwibWFjIjoiNjJhZmNiYjZlNTYyMDUyOGM2ZTZmZjYwMjQ4MDg2Y2YyYzZhNGVhYzVmMDFhYzI3MWE4NjliODg3ZjE4ZWE0NCIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6IkNjOWhSU3dzandJOWYzdmFna1BrVnc9PSIsInZhbHVlIjoiTy9WQVJsUFRqMGlyaEx2ZEJUZVhSUT09IiwibWFjIjoiNjFhNjQwOWY1NTQyMzc0ZTAwYzE1NjNjMDQ0YjhlODhiNWNmODQ0MzFjYzc5NWUwODQ2ZTdlZTU0Yzk5NzJhMiIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.597)
References: <CAB3BuKA+qOY+UhWR-9Ov3qsz3wQr8q8n38MrEMf3FMCthr04yA@mail.gmail.com>
 <2fcdd99eee9ee4f5d34fa1abab2f51bb@mail.infomaniak.com>
 <CAB3BuKARgJhaVNFsP1FQ+2yLe18QU9H17fHKjc-Sf3izE+MZ1Q@mail.gmail.com>
 <86566391db9c5044f1a082bc8ec697a2@mail.infomaniak.com>
 <ZVsdNGyVrTJ/Kv3n@francesco-nb.int.toradex.com>
 <6322fd4c1967a518310140c35ab34f65@mail.infomaniak.com>
 <ZVsyVAapXTWnznFd@francesco-nb.int.toradex.com>
 <CAB3BuKDb6uucujD7ac-w4pa1GVNLSQUA4OGE7i074mQSU==WaA@mail.gmail.com>
 <ZVucAc2Nq0JwJ+N4@francesco-nb.int.toradex.com>
 <90abbd7a-e3e3-42c9-9be9-28e475f0fc9a@leemhuis.info>
 <ZVx1ic9/vxDDStoE@francesco-nb.int.toradex.com>
In-Reply-To: <ZVx1ic9/vxDDStoE@francesco-nb.int.toradex.com>
X-Infomaniak-Routing: alpha

Hi

At least in my test-case the  commit is NOT introducing this regression, be=
cause the bits_per_word is 8, so the result is the same
spi: imx: Take in account bits per word instead of assuming 8-bits
5f66db08cbd3ca471c66bacb0282902c79db9274

I do not have the latest  mx-sdma firmware can you tell me where I get it. =
On=20
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/tree/imx/sdma
the latest I found was 4.5

I tried to debug the code but it's hard vor me to understand where the prob=
lem could be.
I saw then I disable the dma with set

imx51_ecspi_devtype_data {
.has_dmamode =3D false,
}
the SPI is working fine.

Should I do some more tests, do some loggings..=20
Please let me know

Regards=20
Stefan Bigler

Am 2023-11-21T10:16:57.000+01:00 hat Francesco Dolcini <francesco@dolcini.i=
t> geschrieben:
>  On Tue, Nov 21, 2023 at 10:06:51AM +0100, Thorsten Leemhuis wrote:
>=20
> >    On 20.11.23 18:48, Francesco Dolcini wrote:
> >=20
> > >     On Mon, Nov 20, 2023 at 04:30:15PM +0100, Stefan Moring wrote:
> > >=20
> > > >     Can you verify the values used for the transfer,  spi_imx->coun=
t and spi_imx->
> > > >   bits_per_word inside the mx51_ecpsi_prepare_transfer() method? Th=
ose are the
> > > >   only two things that changed in the commits. Maybe compare them t=
o the working
> > > >   version?
> > >   =20
> > >   I would suggest to bisect the issue to the actual commit that
> > >   introduced the regression, I do not think this was done yet.
> >  =20
> >  I think it was. To quote
>  Whoops, you are right.
>=20
>=20
> >    spi: Increase imx51 ecspi burst length based on transfer length
> >  15a6af94a2779d5dfb42ee4bfac858ea8e964a3f
> > =20
> >  spi: imx: Take in account bits per word instead of assuming 8-bits
> >  5f66db08cbd3ca471c66bacb0282902c79db9274
> =20
> Do we know which one of those two commits introduces this regression?
>=20
Francesco

