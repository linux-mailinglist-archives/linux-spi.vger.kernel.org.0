Return-Path: <linux-spi+bounces-12430-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0CFD2F066
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 10:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FA0D300A3F5
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 09:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E9F3191DE;
	Fri, 16 Jan 2026 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PFRJQxxd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749335BDB8
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556991; cv=none; b=frsRYXih2ZqW8ijvJXu7VH2CdMjeGgfpc6E3AJ1eS26DBWtlNddoQPfP0lQMI3QksZf/r/zMFxIc2ANTACBO7/EeIvFVSLhxQSjcjrnFCw1vRKs/A/vaDHMNBbNA0g/rhocjDOpSj39npccoweMdl6fJsTRwInBtTLun29VtMQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556991; c=relaxed/simple;
	bh=Ts7W0YJf0XqYefChNjn+Q24/xkbzT6BD4J6xcR9fSgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IIb+QJzJ5x/TRA9Ae1yDTTlEYQgUkI8OIydcjMvb2pLM00zzx78NZoITpHv+d1EnixIHTcFeot13yM05kARbAFWThKHozqglM155g9gnQ/6JhWxh7uWMdo6ZqcOQS9CYvq71nFJvOmrQLJfSEuC9bSLh+R9w2d2GFA6qmwtPMos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PFRJQxxd; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1EFC04E4210C;
	Fri, 16 Jan 2026 09:49:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DD4E460732;
	Fri, 16 Jan 2026 09:49:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B100A10B689ED;
	Fri, 16 Jan 2026 10:49:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768556985; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jd6h5hFzmieFCQYs0f8OCOxP1CkipXv8Tf3z51jJqIU=;
	b=PFRJQxxdbcVL14k7lt8R02CN4j3nIePIljzXa6QtzCq0uqQi3RssnOcPVtK2SvWo00IFUU
	Mae3+ZAH9g+TKGpCAxa7UIbRT9gssNS/F3821Jqef9vHna5gpEWuDbPwPYOB9XH8us1Axo
	E5Vxb99EUJDsqOgtALWH7beI4MHnx9uFKC+8BxrFcB+6e4HwlC995mmP5RTcRvuuUd/Xbj
	42GmMzUZ7Qu1gU6+/sNz4aHWoqI1ktF/+wKYhTHsC1JxANzJWSpB6DwHYMYIkI/RYluGqq
	BXgLJZeRNzQSzCO/mbq2kUbibtWHoSbwQw9YGGH50Q6CYtEWa9cx33Fhdb5cXg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Geert Uytterhoeven <geert+renesas@glider.be>,
  Magnus Damm <magnus.damm@gmail.com>,  Vaishnav Achath
 <vaishnav.a@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  =?utf-8?Q?Herv=C3=A9?= Codina <herve.codina@bootlin.com>,  Wolfram Sang
 <wsa+renesas@sang-engineering.com>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Pascal Eberhard <pascal.eberhard@se.com>,
  linux-spi@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 13/13] ARM: dts: r9a06g032: Describe the QSPI controller
In-Reply-To: <CAMuHMdUHwqBrNMQTO-g7yUA_owWXxT6bPi34Oxjt-J7N0Q2CXQ@mail.gmail.com>
	(Geert Uytterhoeven's message of "Thu, 15 Jan 2026 14:00:49 +0100")
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
	<20260115-schneider-6-19-rc1-qspi-v2-13-7e6a06e1e17b@bootlin.com>
	<CAMuHMdUHwqBrNMQTO-g7yUA_owWXxT6bPi34Oxjt-J7N0Q2CXQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 16 Jan 2026 10:49:42 +0100
Message-ID: <87ldhxubt5.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Geert,

>> +               qspi0: spi@40005000 {
>> +                       compatible =3D "renesas,r9a06g032-qspi", "renesa=
s,rzn1-qspi", "cdns,qspi-nor";
>> +                       reg =3D <0x40005000 0x1000>, <0x10000000 0x10000=
000>;
>> +                       interrupts =3D <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks =3D <&sysctrl R9A06G032_CLK_QSPI0>, <&sys=
ctrl R9A06G032_HCLK_QSPI0>,
>> +                                <&sysctrl R9A06G032_HCLK_QSPI0>;
>> +                       clock-names =3D "ref", "ahb", "apb";
>> +                       #address-cells =3D <1>;
>> +                       #size-cells =3D <0>;
>> +                       cdns,fifo-width =3D <4>;
>
> <4> is the default, right?

It is the default in the bindings indeed, however the driver does not
imply that default and errors out if the property is missing. The
property is also marked required in the bindings, which is kind of
incorrect I guess. Also, all DTS explicitly set this value to 4.

However looking into the RM I found "Transmit and receive FIFOs are 16
bytes". I haven't tested that, I will.

>> +                       cdns,trigger-address =3D <0>;
>
> Where in the RZ/N1 docs can I find if these two properties are
> correct?

This property is mandatory. Maybe I could just discard it for my
compatible, because it is only relevant for indirect modes, which are
unsupported.

>> +                       status =3D "disabled";
>> +               };
>> +
>>                 rtc0: rtc@40006000 {
>>                         compatible =3D "renesas,r9a06g032-rtc", "renesas=
,rzn1-rtc";
>>                         reg =3D <0x40006000 0x1000>;
>
> The rest LGTM, ignoring my comments on the bindings:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for the review, but I guess if I end up changing the DTS snippet
I might drop it. Or would you like me to keep it anyway?

Thanks,
Miqu=C3=A8l

