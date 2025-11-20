Return-Path: <linux-spi+bounces-11417-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D815C7520A
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 16:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E643833DC4
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A2B366560;
	Thu, 20 Nov 2025 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="t8RNyaMr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49C32FA1A
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652558; cv=none; b=NaN9rzKOnH7jyQFzD0W/bOeTs9cvqA2xvR2ti9DzT5GF+8tKilP/mYozAdJrg8+LJrhpThl48sn193T/16gYq+Anpl5ursSMhFSps/dHskxWa7Q4ZpHM0hpwJ9azIdp2UKBGoi7KWhidfLHckaA5frIFfABZbkvZjHi3L1U0jIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652558; c=relaxed/simple;
	bh=um+CI5cBHeGChwX7KjitHJqTVTZIuNNoC5BfrLnZ0wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERaCgQL3eCKeDcRani9BPhW486RN0+zMKN5ZP/+UkR+Y7WDwLb9/6uPKXoUsZxO+qXqpmKMulbv7DaDooqvay6yz9R6ir2PPYqEOmG1ZR4YfzaC6zYeX+Arvwjl9XxAbzFJJDD9Y1GqEZR1RQ3cNipGPjFgoZP1LL6Qv557wNMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=t8RNyaMr; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37ba5af5951so10903571fa.1
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 07:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763652555; x=1764257355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=um+CI5cBHeGChwX7KjitHJqTVTZIuNNoC5BfrLnZ0wQ=;
        b=t8RNyaMrYAlJeYQXkFJFNJgumPX3XvrgMNW3J+pZ5ECpX1/5FiEAMv2+qrZzI8r5h6
         CV0bVVV2PfVlPVN7X/kWCLvg4921BuUJAyeYFPOic2aiiN6qX/AcgIm/if17zrx3Bo6A
         2KmMYEE79okn5fD9qMhhALHam+Sd9CxpXDF+VYuIWYGHDoe7H3hh9a56qv0C+hVKLpY+
         JrmFopxxqKCGIst5EO09GkBXZ/MSdBJvq3jg4Z9fJKAY/XRE1r9XvPsXFJdVGyb1+rkB
         +bPI807K12PNgYOCAnbpEyLKml2tdu3HZx2DZ83cfJCtqN/Cvfr5WeuEdKczcc1Jb6Cu
         NnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763652555; x=1764257355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=um+CI5cBHeGChwX7KjitHJqTVTZIuNNoC5BfrLnZ0wQ=;
        b=NPjg6E4L/Vo2HmiVVw/NS5xBB7dd6bh8SXD8AQxMkjWz7BhJJnmQQm2BC9sHI5qGY7
         pO43P2UVtiSusqgGA2P+hMhb0lklIpL+g2XAVmXALLkHf62o0T57s8j8HbOdh1IztGVs
         FqDhcayT3PbXB/dyjZhIlu/J/qsiZvcW/idsRmjlNOrDsZVKvPG2ksV7sAmE+IJ6mlaq
         exNHtI1qUqdB9izINGing6tCIuOFO9WgKTcNVWZVSNrRNI+cr5jFCk1IguiZ2KfJatc2
         C6hxpT6gAOJfqRZ1SINK4JWhLeUrXBvh3BOmPsrgRAJn0yHykBnZ81BpINGOSeYzl48a
         eDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8QSvKRW9DRcIMQui8m8u8nLr66oBsDBHJe9hO7IJ5XojVVRLvT+KLiE7Igxomeh6zsG7sa0Ceuig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGMBQRcKk3FTpTkCNtwkHExI70a8K6cn/llOUxoacTr5noczo
	csn2LpMqvip5Z2DAiJePHNaLJUky47sKVzDNL8sDIjLK377LmHZD9SrqVxmcJ+vITtnml2V+pIk
	3tJ14IzfW+5kIRI2XOtkqAV/ZRh+6Oxma3wiwgNEKHg==
X-Gm-Gg: ASbGncs2CziZPDk4wK9GvbsVd3Eo4F9dDfcfxCtuJvnhFi31Hahiez31oRDv1t2eEvU
	CQCDHusf+AJGcEriz6Dkyx6HNRncQgKlsqeWxZRp4RYJStWPJ6H4d2I1mji4pYa7vFeso37tvXZ
	7yC/1k3dVGkBEQtlEiAn8s3wSPgk1XKBbnkljWKtf4jVrw2aCaG94G+9v7kgAHxTTWQ0cx3Zjok
	RecFOk42zknAudz6zHgta/ZOrQyMXg5jDBbK9RCoBR9cJXCa4eoW235QnKBUiTUH3u3ZXLVNuuu
	yNMI/1khAIf90fzuYChDR6DvrQ==
X-Google-Smtp-Source: AGHT+IEwidjnrwli0on3X1tYNsofRsV5iuRR2IvcQDVcZgif5EMNUWatPeED9AltuvQHRMHzZ8zIwLVcLIsqUGVZxNw=
X-Received: by 2002:a05:651c:f1c:b0:368:c52f:fb64 with SMTP id
 38308e7fff4ca-37cc67a22ebmr9554811fa.34.1763652554706; Thu, 20 Nov 2025
 07:29:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org> <aR8ubexLrTgmxtpv@smile.fi.intel.com>
In-Reply-To: <aR8ubexLrTgmxtpv@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 16:29:02 +0100
X-Gm-Features: AWmQ_bmTkA8uTlF3NGcgGx57EX7_URhlcWrn-F13z5Yf1pKxFzyi3Y_bNfqlVVs
Message-ID: <CAMRc=McrnapFwpgRHOckgX4k7UkpaJwWXnRp9Z+WfWw7m8cqpA@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] reset: rework reset-gpios handling
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, 
	Maciej Strozek <mstrozek@opensource.cirrus.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable+noautosel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 4:06=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Solution seems still OF-centric (some of_* is in reset-gpio are left),
> but the series in the right direction, thanks for doing this!
>

That's coming up, don't worry. Though I don't think it'll make v6.19.

Bart

