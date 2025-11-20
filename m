Return-Path: <linux-spi+bounces-11397-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B21B2C74090
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 13:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AA2835538E
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B05332EB0;
	Thu, 20 Nov 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GERHWS0q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231D613DDAA
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763642935; cv=none; b=gqecjYohShooz/+ND/JJczTV//QSb/SHcQV7aS9SM4C5lTp568pbndLpZ6qfpkhc8XylpZZiz1CI1kuPDfmQlsdSCCmSLOSYfcz0p6K1UybvLv+oAvStNjciJGxTQlkAKrP9ycwWadsp0j4lIVbWnafYakkkCtBbvP4p2Onp1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763642935; c=relaxed/simple;
	bh=QszSyfHsiGjkrHbYRf6SmZaH9jktHwGlTFWPEtoR/GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDweQqdPdDYwtV2FkJaJKzXpRALu47Xx/jzpjiqL7ul/lno6aj8K9cXop4ReWdTk1DCrJxPG9ni5JIB2WgMPVtr7PENpl4MFW3At04nT3/YHwSqxF5uYlBjInqL5bYjR3QrXT8SRqOtNadgBPWmyUp0YrBTfchwHbbS1+8xV9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GERHWS0q; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so1787406e87.1
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 04:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763642932; x=1764247732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+7f7M6DCfSfmR795eB5NaYEjHvGAs5dcS/1A2HWNYk=;
        b=GERHWS0qYVvJYAMmjze6Rz9QWtUA+iha2w0umQe/X+bFiVzJrr3OusgU9DdH/UoEkG
         x8LXHKjfshI4z5pVy5lnrK5Uyb5SkiAM3V7u7TSNH7GwcfKwASb3fyfPZkH++GplQf4L
         zx1qbxI7t8g2ek9xgzWNtAEuMohGc3agdpkEGjsxFSu0QoPwEdAyrgXXasiK1VKWphJ3
         Y/KWc7QypeO/W4KkBdCDz9XZrGHv+/CSlpxvGDp2Lg6dhVSJvQ3TvMoOvR3ne6gUzRpY
         oPej2HM64gAaulwUea2KvIbEq+VVnqMNe7NlGQ3evQ+DEzPXyyndQ4QPPi322UORy8Sj
         Cxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763642932; x=1764247732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4+7f7M6DCfSfmR795eB5NaYEjHvGAs5dcS/1A2HWNYk=;
        b=U5Beb4QDCFflF/Q6v6j1+StFPYm/yCSozTRYtnWmNyJxpMIF98cF9fFCdp4OFgUzFb
         jTJscvvaJp6CXlRhpbVeRra+06lZEZTybxjyHcdN/cmB0OcCmSp6Sg3NDYmhPGAo+Sef
         GMNvBV/SB//PGHQiEk/It7B7b/kYGhkpz/MMZvUcZMQwz4c7fXstMv2QLgJVYcHylWim
         y/fmqDpzYSigZyltrR7JWUvOr9sGX1Srxj4IubEbGdFsLp58YYK3ecfhu1A7U3igQisS
         +Y0Rti9qAp257mVsPXX3ieeqEttsABogW0SjyeEZHTnZuTUDPkyqGqkSbGed7GHQV2Z5
         xPRg==
X-Forwarded-Encrypted: i=1; AJvYcCUVCOs3HD4WKWavKNDYABHQiYs7xCB/0WpRrF68AhATs2tANshBwDyrQpYxVB3Qc4HBqNIBUrMracY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7L+WA4cbd/vaFe3MfTkxChYk1jKYs+bIuBFDMpD0TxaqhsyDq
	U4Z9bDg1T3Ft2z6vdUTWPe8WCCzpllissxpynQexVv6VqvmaMcTy0XY1chBWoUDFTKAvqYmBaB7
	6SwVlSlU64R3ksJ+pKkaTzWim++gic5MxGdWNBqnUx5upGRwy0i6ymuzo4w==
X-Gm-Gg: ASbGncv5u5BkFsq8BZNGbP/87q26j9drGuSt86mB5IqjbGkqwBrRBrditR5cyyDFnMq
	iaWntGdeqKqCpIPaahrvOda7sInnOzbzzqwwciS15J7WXhdkcxKEsm+6V9WbDlfDsa/t5xgBt/J
	QsraxCpQqi/xpnfBhCzVkdY0pr1SZFJPymIjYW8Z6g4Ts4dtzmcCZu/IKuCzQg6LYIU95R1d0YH
	tslYlZN+YMi/VrqpMeZxx4+gdVwhBOJZ+fX2aBIF07HKgfMzPRk7ju+weyU0TWFf+X7jIxtHQxS
	1AW6ILBBh0HoAGqKKBr6XdnWDCh8YD3gyJoq
X-Google-Smtp-Source: AGHT+IHtPxEusmFHAqDBUrkOJxRZ/X4IbUxmjWqAxxG0Qj6Kpr/Igqhw1qG/rgsHpfJ6m+QoMn3iyKCVK0sogbui6zg=
X-Received: by 2002:a05:6512:1153:b0:595:7b24:d352 with SMTP id
 2adb3069b0e04-5969ea35cb9mr950413e87.24.1763642932237; Thu, 20 Nov 2025
 04:48:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120105907.1373797-1-ckeepax@opensource.cirrus.com>
 <aR8AmhcY_y93O3GM@smile.fi.intel.com> <aR8MxX1g38dq62rI@opensource.cirrus.com>
In-Reply-To: <aR8MxX1g38dq62rI@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 13:48:40 +0100
X-Gm-Features: AWmQ_blpdqZK4kLMFnU68YczdedkB7-cJbNuHqRc55HD2cSqCSm9Ym7-aXPpiyg
Message-ID: <CAMRc=Md=-BEAz62ims0v3owBmDxvTmg9eFHG+8Rp9gPWKagZFw@mail.gmail.com>
Subject: Re: [PATCH v2] spi: cs42l43: Use actual ACPI firmware node for chip selects
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, broonie@kernel.org, 
	linus.walleij@linaro.org, andy@kernel.org, p.zabel@pengutronix.de, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	bartosz.golaszewski@linaro.org, linux-kernel@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 1:42=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Thu, Nov 20, 2025 at 01:50:50PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 20, 2025 at 10:59:07AM +0000, Charles Keepax wrote:
> > > +           struct property_entry props[] =3D {
> > > +                   PROPERTY_ENTRY_REF_ARRAY_LEN("cs-gpios", args, AR=
RAY_SIZE(args)),
> >
> > No need to open code PROPERTY_ENTRY_REF_ARRAY().
>
> Sorry yes forgot to put that back when I switched back from the
> dynamic allocated ones. Bart let me know if you want a v3, or
> happy to let you fix this up when you pull it into your chain?
>

I'll fix it myself.

Bart

