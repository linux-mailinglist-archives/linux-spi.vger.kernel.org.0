Return-Path: <linux-spi+bounces-382-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A379382761E
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jan 2024 18:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574ED1F234A4
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jan 2024 17:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51AD54669;
	Mon,  8 Jan 2024 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j2QX8bAi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F60253E36
	for <linux-spi@vger.kernel.org>; Mon,  8 Jan 2024 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cce6c719caso22129321fa.2
        for <linux-spi@vger.kernel.org>; Mon, 08 Jan 2024 09:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704734142; x=1705338942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhcmxUh8JpNw9VG2lpkQDwxahGUDO7wjwTVRAGTPxjA=;
        b=j2QX8bAi5E5ntxFXE5rNmTT3GtM9aZ798SitzWTMgl+8eg8wWJ/AcXWZOcWXW7pDSP
         +NGHuK1hoBptQ8yjNhTYvHh/dZW5FdI4TFr6DBVrNGc8l8NDVfBeY6Tjeo5oDPcEtBpP
         06vYu04CPYqQNXJp9wb6Lz5LCVhhYAtgCW3vw4vYir+I+otcPTRtEV0awbucf0aSnHnt
         n3D7kDIugSiUvnemXNZVA/Uw2o1HRCmj4ZeWjpyWLDajVUhjhq3abzlWfoLL0XVUGNPh
         6/GIokDm4tCt5P47pcKz7/2wTnSZOFYA02dO3bZ8RaODm3qVQp47DM0KiVnbC+tHh6uY
         r1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704734142; x=1705338942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhcmxUh8JpNw9VG2lpkQDwxahGUDO7wjwTVRAGTPxjA=;
        b=l1N/9+ze+cUU36AsmNwgfh4o/u/WJJSuN/ILFMKgVbCBaR9uiuKaMqQmKQG4RUyfUh
         IS8P9y7xP3UCErs4WJBw8YTNo1Oo5Iz5b9oHzKLV22k0TafmuypfA6VWjEXylDGRjgbb
         +Vwj3iYV7COXO0hlwKnR/3Vh8s/JXNTgYr7/PRcD0I/CiWpAOnLTjx6eeV5mColfV/dn
         x0S6FxH+jQA++oqHquirYOdd+GP4b6WFANH/s6DZbhMWWZsAIK9m3ZBijdzpPgViIqKz
         Smj585EwV/N2U7AnK0JKPQHH+3qKrs9UXkhDfOHWEixvbh9X34xCFjtFPBTKIzOHpLmZ
         8h4Q==
X-Gm-Message-State: AOJu0YwmU/vw+ohB9GqnhA+0ZmQfU2LtIfQR9rF9j0hkFqbJvt6o+8nS
	fXDukgqTjtUfAnIeFT1+aGf5AE0H20efNVqfPXfvbtc9TPOMDQ==
X-Google-Smtp-Source: AGHT+IG3rX1ILTMGzLZZdp1B52tdxBx7OKgMOIVcoQaLg54QYbSD79UEfIQDySh7E4DnU1YKnMS9AGGlYHyDYRnHfPI=
X-Received: by 2002:a2e:9a84:0:b0:2cc:6fef:d80a with SMTP id
 p4-20020a2e9a84000000b002cc6fefd80amr1741294lji.4.1704734142596; Mon, 08 Jan
 2024 09:15:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
 <20231215-ad7380-mainline-v3-1-7a11ebf642b9@baylibre.com> <20240107164356.3e8df266@jic23-huawei>
 <f431e418-0b7c-4362-be26-9d2f03e0de07@sirena.org.uk> <CAMknhBE7eUMzcD0bdymrhL2Lw3FubB3aHDWmJFD7YnaGNYmQ9w@mail.gmail.com>
 <0a774bc6-3bf9-4b5f-92e0-8bd673e71a33@sirena.org.uk>
In-Reply-To: <0a774bc6-3bf9-4b5f-92e0-8bd673e71a33@sirena.org.uk>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 8 Jan 2024 11:15:31 -0600
Message-ID: <CAMknhBGNDV7+C4wE8ced5jhe-0eydo7g8SZMJwLnFi+y_qon_w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: add spi-rx-bus-channels
 peripheral property
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 10:39=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Sun, Jan 07, 2024 at 05:02:56PM -0600, David Lechner wrote:
> > On Sun, Jan 7, 2024 at 3:27=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:
>
> > > This makes no sense to me without a corresponding change in the SPI c=
ore
> > > and possibly controller support, though I guess you could do data
> > > manging to rewrite from a normal parallel SPI to this for a pure
> > > software implementation.  I also see nothing in the driver that even
> > > attempts to parse this so I can't see how it could possibly work.
>
> > We currently don't have a controller that supports this. This is just
> > an attempt to make a complete binding for a peripheral according to
> > [2] which says:
>
> ...
>
> > So, will DT maintainers accept an incomplete binding for the
> > peripheral? Or will you reconsider this without SPI core support if I
> > can explain it better? It doesn't seem like a reasonable request to
> > expect us to spend time developing software that we don't need at this
> > time just to get a complete DT binding accepted for a feature that
> > isn't being used.
>
> I don't think it's sensible to try to make a binding for this without
> having actually tried to put a system together that uses it and made
> sure that everything is joined up properly, the thing about complete
> bindings is more for things that are handle turning than for things that
> are substantial new features in subsystems.

We do have plans to eventually implement such a feature in an
FPGA-based SPI controller, so if we need to wait until then for the
binding, then we can do that. But it would be really nice if we could
find a way forward for the IIO driver in this series without having to
wait for the resolution of new SPI controller feature for the complete
DT bindings.

DT/IIO maintainers, if I resubmit this series with the
`spi-rx-bus-channels` parts removed from the iio/adc/adi,ad7380.yaml
bindings, would that be acceptable? (Also resubmitting without this
patch of course.)

