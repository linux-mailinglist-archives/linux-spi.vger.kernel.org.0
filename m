Return-Path: <linux-spi+bounces-6273-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEF3A08404
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 01:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FB716059D
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 00:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FA1175AB;
	Fri, 10 Jan 2025 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="c92s/R3d"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED8E28F1
	for <linux-spi@vger.kernel.org>; Fri, 10 Jan 2025 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736468979; cv=none; b=p+qtq6LxmZzn2pvYqHMePYW/p6ogdgceed5d68iNo+71wU3MnihIkUwMtT0CLlA0KSc03N75tPneJYpbO+eoiCIPsZuEb0bKB/u2XUMJiUoVAuMKzF91PWMq2aL/SSd0nmPb5g55HVVuBEip6uB+KtowmD7s8evp+cN9zPVnGTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736468979; c=relaxed/simple;
	bh=NmF9OpBmOlyhdjWseD2lyW2G8XKj6Wz2ZngKw21hv48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMatC/lJwG4KoXi9kd36Sxv4ruF939592OWc4Enpa5F4uNAZGyqnLc6hvQUovDn22eHiy+s2M7HcBIda/oOIBaBFA9xFUKNGgk7X4TsUIx7ZzXcqXUqZZ4ndty0oPAl+FsKhgUcdhSRXvppOSToNtkaeyyP2eaqptcaTJOFerHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=c92s/R3d; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D87E0240103
	for <linux-spi@vger.kernel.org>; Fri, 10 Jan 2025 01:29:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1736468975; bh=NmF9OpBmOlyhdjWseD2lyW2G8XKj6Wz2ZngKw21hv48=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=c92s/R3ddKrbwGsaH5vDhjC47JcOusOZuPzEE+8TlSn3i3ZDCO0vN+axB+t5PySC7
	 Uam8dKH1ZIMoydW8kOyecw/HsrewYs8aQ7ilBgVQ9nUozAiUo42AHKx0gaZuBz0Zjt
	 PHEoVKfZ+t8LnlghsbO3vIVkqNMfUVqIhaG10PPztTLX9R+ySVV8tdChF74FuTM4+U
	 L6NDXF08l44b10DSUVJXf6hzxv8BckdFqzm1xgdTG6iDzKNkkPhRm19v4cbLQM7gR4
	 1nN8HJ+QZhLtVR6+lTSthk4dsnPbrn5XCggG+Gt+qS5NL2I91c3BNjJVzAPQ+n41G/
	 VzexZo459L2mA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YTjG60LNbz9rxK;
	Fri, 10 Jan 2025 01:29:33 +0100 (CET)
Date: Fri, 10 Jan 2025 00:29:33 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>,
	=?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] gpio: 74HC595 / 74x164 shift register improvements
Message-ID: <Z4Bp7aBWWYehVucf@probook>
References: <20241224-gpio74-v2-0-bbcf14183191@posteo.net>
 <173593634037.257292.1488097273042214180.b4-ty@linaro.org>
 <CAMuHMdUqvTrSsiGuJ=VvNqsQm4eQs9rNTU8VBg+FzHJZxRnXow@mail.gmail.com>
 <CAMRc=McAm3A1movK-8q67UbKuPb8FQzVwD_me7Q6x-gei2PA_A@mail.gmail.com>
 <192e97dd-698a-4434-bd32-c1181ec85ba3@prolan.hu>
 <CAMRc=MewCR=W=_0RKFZR0gW2mvkMD-pKBWpXCeqOY4j8CXBSXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MewCR=W=_0RKFZR0gW2mvkMD-pKBWpXCeqOY4j8CXBSXw@mail.gmail.com>

On Wed, Jan 08, 2025 at 01:08:37PM +0100, Bartosz Golaszewski wrote:
> On Wed, Jan 8, 2025 at 11:26 AM Csókás Bence <csokas.bence@prolan.hu> wrote:
> >
> > Hi all,

Hi,


> >
> > On 2025. 01. 06. 21:16, Bartosz Golaszewski wrote:
> > > On Mon, Jan 6, 2025 at 10:19 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >> Do we really need to document and add driver support for all variants?
> > >> I can easily come up with a list of tens or perhaps even hundreds
> > >> of xx74yy595z parts that are all compatible, as far as software is
> > >> concerned.  As SPI was invented by Motorola, the original part is
> > >> probably named MC74595 or MC74LS595 (yes, ON Semiconductor bought the
> > >> logic division of Motorola).
> >
> > I second this, no point of having a new compatible which is a guaranteed
> > 1:1 equivalent of an already existing one. Especially true if the only
> > change was that a different company bought the IP. By the same logic, I
> > could start to sumbit patches to change all `fsl,` compatible-s to
> > `nxp,`; `atmel,`, `maxim,`, `smsc,` etc. to `microchip,`; `ralink,` to
> > `mediatek,` and so on. There would be no end.
> >
> > >> Perhaps we need a separate vendor prefix for the 74xx-series[1]?
> >
> > I don't think that is the case. Rather, we should document that the
> > existing binding/compatible should be used for all such simple cases (it
> > is called _compatible_ for a reason, after all, and not
> > `exact-part-number`).
> >
> > >> The xx-prefix and z-suffix don't matter; the yy-infix for semiconductor
> > >> technology rarely matters (there are a few exceptions, though, mostly
> > >> pinout, which doesn't matter for software).
> > >>
> > >
> > > I missed the fact that Rob actually responded to patch 1/3 with a
> > > similar suggestion (fallback, instead of a full compatible).
> > >
> > > I can drop this series from my queue if it needs more rework.
> >
> > I think you can keep 3/3 (the one commenting the use of `latch` as CS).
> > The rest can be replaced by another commit commenting on what it means
> > to be `fairchild,74hc595`:
> >
> 
> J. Neuschäfer: do you want to send a follow-up for this?

I'm fine with this outcome, but I'd prefer not to prepare this proposed
patch (for reasons of time management on my end, mostly).  So if anyone
else would take it up, I'd greatly appreciate that.


Best regards,
 jn

