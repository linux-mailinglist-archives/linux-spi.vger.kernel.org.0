Return-Path: <linux-spi+bounces-9154-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4033B0D73C
	for <lists+linux-spi@lfdr.de>; Tue, 22 Jul 2025 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935B5189F93C
	for <lists+linux-spi@lfdr.de>; Tue, 22 Jul 2025 10:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493932E06ED;
	Tue, 22 Jul 2025 10:20:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D0B2DFA59;
	Tue, 22 Jul 2025 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179621; cv=none; b=K+8vG+w7tUcLrlnzTh6i7fxBl61isNLOEMW4euQZZVMaCdH8LKQYYTDxZ3rl6u0jfIS7fpzZ2A7rnHTTWAdHq2nvBtkJmX/7GSxSVlmWe5pOeQSuFUMc6o2c62d9te4p2INcXTA8JQkZpJ9H8D9fY2b6xezme4RskR2qck9p7u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179621; c=relaxed/simple;
	bh=FY/g2nytNwGTYIlxhvIPA3OaPQkLlCJPhaAgPjZYxmQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWPizmYWxJHPciIvMZwzxDbRPfgdV4XAllLPdke2y6aWU3wMqUSJy4ZbvaGhKoQAJx6pwcp91/nKNWEDqfzpUPYWu/H0PHtTGmwWmsyjBJsCQwZEE2vkVAh28IpKK9nCm0yUFV8Q1zd9dsLM9JUzkLdFa+eipdmurnAUA2cSBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bmY8949v4z6GDDg;
	Tue, 22 Jul 2025 18:16:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6FA181400E3;
	Tue, 22 Jul 2025 18:20:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Jul
 2025 12:20:14 +0200
Date: Tue, 22 Jul 2025 11:20:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: <hs@denx.de>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown
	<broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>, Conor Dooley
	<conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, Grant Peltier
	<grantpeltier93@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Michal Simek
	<michal.simek@amd.com>, Naresh Solanki <naresh.solanki@9elements.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring
	<robh@kernel.org>, Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
	<devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: (subset) [PATCH v1 0/3] spidev: introduce trivial abb sensor
 device
Message-ID: <20250722112013.0000597e@huawei.com>
In-Reply-To: <2e9c96c6-6dfb-4232-a9ab-a3e78b718fc2@roeck-us.net>
References: <20250719063355.73111-1-hs@denx.de>
	<175311337130.327079.7374455187420344577.b4-ty@kernel.org>
	<d677ecd9-42d6-43fe-8fe1-a5afd4d270e2@kernel.org>
	<8a8106ea-83d3-e02a-9ae7-ea4a66e4c248@denx.de>
	<2e9c96c6-6dfb-4232-a9ab-a3e78b718fc2@roeck-us.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 21 Jul 2025 21:58:10 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 7/21/25 21:05, Heiko Schocher wrote:
> > Hello Krzysztof,
> >=20
> > On 21.07.25 18:24, Krzysztof Kozlowski wrote: =20
> >> On 21/07/2025 17:56, Mark Brown wrote: =20
> >>> On Sat, 19 Jul 2025 08:33:51 +0200, Heiko Schocher wrote: =20
> >>>> This series introduces the changes needed for trivial spi
> >>>> based sensors from ABB, currently operated from userspace.
> >>>>
> >>>> The last patch adds the spidevices to the DTS files, already
> >>>> in mainline.
> >>>>
> >>>> make dtbs_check showed no errors/warnings for the dts files
> >>>>
> >>>> [...] =20
> >>>
> >>> Applied to
> >>>
> >>> =A0=A0=A0 https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi=
.git for-next
> >>>
> >>> Thanks!
> >>>
> >>> [1/3] dt-bindings: trivial-devices: Document ABB sensors
> >>> =A0=A0=A0=A0=A0=A0 commit: aad2f87cbcab56b322109d26d7b11842a09df91f
> >>> [2/3] spi: spidev: Add an entry for the ABB spi sensors
> >>> =A0=A0=A0=A0=A0=A0 commit: d60f7cab7c04944a79af16caa43c141e780a59c6
> >>> =20
> >>
> >>
> >> That's unexpected, Mark. Patches received two objections/comments and I
> >> don't think discussion was resolved.
> >>
> >> ABB is huge company, probably making hundreds or more of sensors. The
> >> patchset basically claims that all of them work with spidev. It does n=
ot
> >> providing any model names or details, so it seems really incomplete to
> >> call them trivial devices. =20
> >=20
> > I do not know how many different sensors they have, nor if that departm=
ent can
> > speak for the whole company...
> >=20
> > What I have as information is:
> > https://lore.kernel.org/linux-spi/2477dc64-92a0-9dc9-d168-56646d0d796e@=
denx.de/
> >=20
> > and I get no more information about them currently. May I should
> > add some sort of trivial into compatible name? Something like
> >=20
> > "abb,spi-trivial-sensor"
> > or
> > "abb,spidev-trivial-sensor"
> >=20
> > which makes it clearer, that only ABB trivial sensor, controlled throug=
h spidev
> > driver, is connected here?
> >  =20
>=20
> FWIW, I always thought that devicetree is not supposed to contain such ge=
neric
> information. Is it even appropriate to list something like this in device=
tree
> in the first place ?
>=20
> If so, what prevents anyone from submitting hundreds of
> "<company>,spidev-trivial-<device-type>" entries, using the same line of =
argument ?

Agreed.  These should have separate compatibles based on what any OS etc
might want to bind to them.  Just because their model in Linux is spidev etc
that shouldn't mean a generic ID is appropriate.

Can we at least have some examples to motivate the discussion?

Jonathan

>=20
> Guenter
>=20


