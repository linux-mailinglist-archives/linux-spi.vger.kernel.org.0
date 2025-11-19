Return-Path: <linux-spi+bounces-11297-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3E7C6DFA8
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 11:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 033754E8DB4
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0134AB0B;
	Wed, 19 Nov 2025 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BXMvpk9D"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB1034B18C
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547624; cv=none; b=ZVdsqbOHruN3Jtzk05GSnA2uIx6XgWHIkVGTRjTVx9rOfkkVzSB4EYZjPkSQz/bTLzSsyWwFMw3iLsFrfKWP9p5orUq9NFQhzrKUTsUnJQ6yeWI23ce4kvgrzhteMf8UWXoaEG9UdhhuBJk6Qc1CBG6RkFv0GWVyxlLSq54v7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547624; c=relaxed/simple;
	bh=Mbr1GEkM9xYFDu4S/6bju2g/+16MPey22wuL9HdBgqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBnAX7kCLVUlDsvPHePccs3LBrny1gd9zpH6MuGw+hkT4QynFY14T6+ZgK1YnQoGf+2Ooc8hU7RQp/qGIoHsVOBPWSdTyf2lNhhLrtt8VkxHIm2DXQQzs4LfoofDQErNQvDO6WxRT06yr8TzzwH89ru2SzMF+YJSQZQK8SxJwXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BXMvpk9D; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59447ca49afso8260739e87.1
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 02:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763547620; x=1764152420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MFJCn3c4UR4GwSlThpgcg2jrHtg1WRuJqiIQ/LTMcA=;
        b=BXMvpk9DZx2Vd+q1YrnkOgQ2Qae0pfW0d+lTHIC4ZkX9C+WcCZ8KinmU7EBrEGKEEN
         JyNowtb36EshKF75/40Mfna1/DlQN3TAYZ13szMbum4iR7he5qXQI41sFfZks6Anc48r
         n8R4pYPTbWDNGXcU44Yl71OqJuXGBI70Ed8aNOqBrEk5j1EQzu0RIgwTxNu2Aorh04g1
         CeIC+7vSLgiT+qBSD0/k4ZyJawW2JQbaWKZHNlxcy9tbFL4bEmslLArX9IUQ8wPQ4NNv
         P9g2U0dmaqZeOBNwBwFsEhCCa0kn7tx8rbxUJu3F1ox85wH90mCmtIxMxNMBo8l5UoFU
         iD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763547620; x=1764152420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1MFJCn3c4UR4GwSlThpgcg2jrHtg1WRuJqiIQ/LTMcA=;
        b=UW/aV+tTUMkXCvm6j+8BQkv/kDQ+k7CChVmhFlZFMwZqO7z6L2Ys/JpEmxm+L0OG4K
         zX0TkbCtzEAk/mx0IhdJJeR/fSJhemsTjhJcTijva9JeqXgj9FkcvIyjTRJTGNA+yR6t
         UpISGDKYdq6kbeQRHLqsmu4CsQbYg3EvYOx30ug7HB88mGNYGnjK0n4PnC0SdiSQKFWA
         VUueOZjbPP6NIK4Uk0U8v4X8EKAVWWvB3k6u+MjrPd2WGADNvW/UYm2pg3GcXUopqxOJ
         VpqnVyM16Lmz13nnpZIFSncwTuzKy6tiOjSgq0SCdmhNfgLDOtfAynxlJgycY5KrZp3G
         r+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJDPtiTKsIcm/F6Pl3m5jroHl4g2Phyj60zyoxxCAL7MWvBN2fwck3G9nH/6H7pNd9qJDgsucTL3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT1vHSNq/GTBaaz7Oke4/KeOpFG0Pi7tU1RzafPFjOoF21g1Mc
	fJaU5VGM8xPRbr9u6jCIYNl2yRcNLdchd5r+/vwQXwGW4EnZs/A1JWhpaylPeI4dgdm+6SRSr2O
	nj4D3AM5tVoHqRFtsVwMERqFGGH2oFOeswyy90oWgLA==
X-Gm-Gg: ASbGnctwtlAnqyZwPDpBAU4UYAuBdgTPMHhd0cF2TqD5kGUK2SStAk9iOAxkqbbaQtf
	lwucqcrsT6u/Kt2qmMfmMVN7RKR+inMt679+f42Lm9rFvz2aC/cqQxLC7cMLsPTLDW9Mm3XYfSu
	0Nut9GU1PEY1x2tjVWf6+u5TM37ljJ+a2KlRFUVC7HMCPwMLSGjMLS8MddjqlIywO/olPHl+aD6
	OKDR7ygjQBAQPp/8vUQloTyUYEvxCg42IgHplXAGi4TxYBzdAPbF3dmvO4s11u1eBqOQcl3T3YD
	2IRg33zPNlHP37tR3hz72B82EqsI/bHYABMV9Q==
X-Google-Smtp-Source: AGHT+IE9JNtroGt9E2E3gNsepDcRAdRdpTP4zu7ST2CCOq3eXo9u4Q/AbYdzyst79Jmme7gLdAeTImqEaeDklMC3tHg=
X-Received: by 2002:a05:6512:1251:b0:595:8258:ccc4 with SMTP id
 2adb3069b0e04-59584262dcdmr6735337e87.47.1763547620283; Wed, 19 Nov 2025
 02:20:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org>
 <aR2OU4se7lxcMtGW@opensource.cirrus.com> <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
 <aR2Uo++k1NKkk2sj@opensource.cirrus.com>
In-Reply-To: <aR2Uo++k1NKkk2sj@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 11:20:08 +0100
X-Gm-Features: AWmQ_bm0yTqfRlnBzZMPw34K9JVDcn7WLMejW8cq3FVbPsn4cNJ_e6iNwTVFcL8
Message-ID: <CAMRc=MeVt6PJbDRaFijMfmiPA-wXCSA5Kw2ZEUBDGg-g+55N_A@mail.gmail.com>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software nodes
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Maciej Strozek <mstrozek@opensource.cirrus.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 10:58=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Wed, Nov 19, 2025 at 10:40:30AM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 19, 2025 at 10:31=E2=80=AFAM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > >
> > > On Wed, Nov 19, 2025 at 10:10:24AM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Currently the SPI driver sets up a software node rerefencing the GP=
IO
> > > > controller exposing the chip-select GPIO but this node never gets
> > > > attached to the actual GPIO provider. The lookup uses the weird way=
 GPIO
> > > > core performs the software node lookup by the swnode's name. We wan=
t to
> > > > switch to a true firmware node lookup so the actual link must exist=
.
> > > > Move the configuration to the MFD core and connect the SPI and pinc=
trl
> > > > sub-devices with software node references.
> > > >
> > > > Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers"=
)
> > > > Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > > Closes: https://lore.kernel.org/all/aRyf7qDdHKABppP8@opensource.cir=
rus.com/
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > ---
> > > > Hi Charles!
> > > >
> > > > Please give this a try. It's only build-tested so far. I hope I
> > > > understood correctly that it's the SPI driver that needs the "cs" G=
PIO
> > > > from the pinctrl.
> > >
> > > Unfortunately it fails with an -EBUSY on adding the MFD children.
> > > I will investigate a little more and report back.
> >
> > Does it fail in device_add_software_node() in MFD core? Is it possible
> > that the device already has a software node for some reason?
>
> Yeah it seems there is already a software node, although somewhat
> at a loss as to why, the only ones we add are inside the SPI
> driver. I will poke further and see if I can find out how it
> acquires that node.
>
> > > > +static const struct software_node cs42l43_gpiochip_swnode =3D {
> > > > +     .name =3D "cs42l43-pinctrl",
> > > > +};
> > > > +
> > > > +static const struct property_entry cs42l43_cs_props[] =3D {
> > > > +     PROPERTY_ENTRY_GPIO("cs-gpios", &cs42l43_gpiochip_swnode, 0, =
GPIO_ACTIVE_LOW),
> > > > +     { }
> > > > +};
> > >
> > > This drops the undefined node, that is important as it lets the
> > > SPI core know that device is using an internal chip select rather
> > > than a GPIO.
> >
> > I really dislike the whole concept of this undefined software node.
> > This driver is literally the only user and I'd love to just get rid of
> > it. HOW exactly does it let the driver know to use internal chip
> > select? Can we do it differently?
>
> The SPI code lives in spi_get_gpio_descs(). The basic gist is
> it will use a native chip select if the gpiod_get_index return
> NULL. The system came from device tree (see Documentation
> spi-controller.yaml) initially, then I added an analogue to
> swnodes a while back in 9d50f95bc0d5 ("gpio: swnode: Add
> ability to specify native chip selects for SPI").  I have no
> great attachment to this way of doing it, however, it does
> seem logical to me that the system is at least fairly similar
> between the different firmware types.
>

I see. Then maybe we should at least generalize it to a high-level
"swnode-undefined", move it out of GPIOLIB and provide a proper swnode
interface "swnode_is_undefined()" so that we don't have to open-code
the string comparison like that. That's not related to this patch of
course, just throwing out an idea.

Bart

