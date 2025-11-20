Return-Path: <linux-spi+bounces-11435-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73876C75E55
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 19:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E3044E02C1
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7DB333439;
	Thu, 20 Nov 2025 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kyk29MP7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E874A2E764C
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662792; cv=none; b=HgyZzc+KKnW0z3mGOUPnc4QOf9oRYa4fPEp4gP5N+/Ov6vMy9agfo8H73XqLIBLvCsNnACMo0i1k5CiRj5QSJJN+C2YNK9Q4e5wlYud7seeWNexn8830EM1LlcUxStmhJ/rktBhrOfnMXMYgUMl1d4cyfX23bwrXaCAx5G/U0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662792; c=relaxed/simple;
	bh=2frM4ZKJ9sHrFHvhxYMW/pljtv9IlgikwDwgYXbV9+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcGsy2vp3aSakhLt86Px+h2NwRbB6QplRAPKt6aUWh+Irw6YOR7w3DaPlKQu2XS5S3lYPUVX954Yx/nEZo2vJE9/UuBUN/icR9YDyKdcympvJGIU0ERfP9RhhFOQ0uWxl2vitWNZtDr4fecbRZB+Ff2mrLXzrBud0hQZlN5HBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kyk29MP7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59428d2d975so1361884e87.3
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 10:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763662789; x=1764267589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnYALWaCSwb3tCzOH7sb75PPH0v2Pj24u8FmC4zAj8Q=;
        b=kyk29MP7qKcrUq/lMPOHCAFiP6roy2oouvyrWvJhDLmYAwzVNM2DCq+YQ0glx4YU6H
         wfGraDVQzwEMJjMcGM1wwXpAEuGVByepve5+thh63Hr4ZS0HngBBDCvMTtAWISMl7xIA
         S+gaHIf3P36lFIl9p13wrxL7hTMNlrxYYDNUefUdQmMtf+6CRvN2Ww1lqyYhYS7QE4L4
         exmVTObHgB3Z31J5BcHtgTeQPwRqDfc0se2P9BHElwFYYAixboESwmwh6Pg9f085LpmG
         1fCCEzl5KAbE2C3TaUGu1iMlu9bn+hQWq4LZsgWOMJIgwZp6sefZhg1NLyIRhsstkNmO
         DboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763662789; x=1764267589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QnYALWaCSwb3tCzOH7sb75PPH0v2Pj24u8FmC4zAj8Q=;
        b=WOl92ODv3iJQy90jFIL5QdwbgPwaZ/zYkMxDV5wHmkjJnK08LdoF4dcsUNqj1MbEZC
         EK8DiarXSwAT7GSRdYFSPVxIRef2dG5yuVYoepEazDn4dkFh037lMxaIDwrp6Dvajujk
         SKD1w+miti7RlNIgyL4OyqQOXfHybbRj+W4CR3s8s1TwvUOVG7f9WqwYTEN1r/AgrZob
         4ws6LBez31IH/IQnyg9cN9qbiiyZ3Yoc+Te8YRnzttsqp1UasUwVtzu+Kzw05F2Q4pcw
         2ZCCkKc5QiNNQWNTDpfq5IC0g7NtA08gNvC6YVKwZ/hV4vMi7CRqLhoYwLxHvDlO0bRX
         OCNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH0lVIFjplnakqLIXkQ+HosPTSZI9DYKwfbWtkbLzlF2xAUnkrJJ3Ui4Dl7PtJB9+G0avpkR1M4vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5TrsDUoxwBRwqyaBgu3Ln2Rs/PzCAhhmC43hg6JwUr0UUddh
	KWe9TFN42ba/HWLvDdVSwBeyprdyjREqoc4V1JG7SfV0N7w9rDyCVqChOdWSgKKPFQ1Lx6nE+cS
	zDTyC1YYMEkFXzmcs/dfu+IkyV+KO34/OpnaafqWxeA==
X-Gm-Gg: ASbGncslwL19OTwX15uquvjw7f500q0uRCk3JUToBCSNdRbrEHOwJozGBgHT+LgD6An
	vq7dseGkNS5k7ZsQWr8NE+q8/t3aZtt6y/ymFs1mDohRWSp9zLnLMEqcpX6dXCtmL88NbcI8T14
	5UiSGcnIbiSOTlLF+ys82U8yOVF2lja1uwOdfBtMw4zrPfz7cBdr4nAoqAC+Ycyl6I9I0KT2+p2
	t5pUzanZecmtfkgf5yoOT4vsT+LB9sW8PE+AKuCxS5LfDkOL5EB9gnJkfQ4uh+nUR/H3LFXbU5R
	rqQ9aQLOQVJR1zBMnoi9NZqnQmlYYoKfL6Cz
X-Google-Smtp-Source: AGHT+IFJUK59m9cV2hdaMboMdwCuLYZSd6vorsTLduT0KYUQfG8bYza6yPNSkEBgztU1V5kaircoAsMSf6iO5hTasWc=
X-Received: by 2002:a05:6512:b01:b0:594:34b9:a7f4 with SMTP id
 2adb3069b0e04-5969e2f421cmr1562911e87.29.1763662788999; Thu, 20 Nov 2025
 10:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120163252.34760-1-p.zabel@pengutronix.de>
In-Reply-To: <20251120163252.34760-1-p.zabel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 19:19:36 +0100
X-Gm-Features: AWmQ_bkWVGFSZn3FalnS_qvDgjI51sEMsJrOYvZkmui2vXqgrMxEN-ruhSsnp2s
Message-ID: <CAMRc=Mfzzgx2JcBa1iG9L9ztF+S55cSNHgNurubPBsDteoLraQ@mail.gmail.com>
Subject: Re: [GIT PULL] Reset/GPIO/swnode changes for v6.19
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: soc@kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kernel@pengutronix.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 5:33=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix.=
de> wrote:
>
> Dear arm-soc maintainers,
>
> The following changes since commit e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a=
7c:
>
>   Linux 6.18-rc5 (2025-11-09 15:10:19 -0800)
>
> are available in the Git repository at:
>
>   https://git.pengutronix.de/git/pza/linux.git tags/reset-gpio-for-v6.19
>
> for you to fetch changes up to 5fc4e4cf7a2268b5f73700fd1e8d02159f2417d8:
>
>   reset: gpio: use software nodes to setup the GPIO lookup (2025-11-20 16=
:51:49 +0100)
>
> This tag is separated from reset-for-v6.19 because it may also be merged
> into the driver core, GPIO or SPI trees, if needed.
> It contains a single series [1] with changes to swnode, gpio, and reset
> code.
> It is based on v6.18-rc5, which includes the prerequisite commit
> e5d527be7e69 ("gpio: swnode: don't use the swnode's name as the key for
> GPIO lookup").
>
> [1] https://lore.kernel.org/all/20251120-reset-gpios-swnodes-v7-0-a100493=
a0f4b@linaro.org/
>
> ----------------------------------------------------------------
> Reset/GPIO/swnode changes for v6.19
>
> * Extend software node implementation, allowing its properties to referen=
ce
>   existing firmware nodes.
> * Update the GPIO property interface to use reworked swnode macros.
> * Rework reset-gpio code to use GPIO lookup via swnode.
> * Fix spi-cs42l43 driver to work with swnode changes.
>
> ----------------------------------------------------------------
> Bartosz Golaszewski (8):
>       software node: read the reference args via the fwnode API
>       software node: increase the reference of the swnode by its fwnode
>       software node: allow referencing firmware nodes
>       gpio: swnode: allow referencing GPIO chips by firmware nodes
>       reset: order includes alphabetically in reset/core.c
>       reset: make the provider of reset-gpios the parent of the reset dev=
ice
>       reset: gpio: convert the driver to using the auxiliary bus
>       reset: gpio: use software nodes to setup the GPIO lookup
>
> Charles Keepax (1):
>       spi: cs42l43: Use actual ACPI firmware node for chip selects
>
>  drivers/base/swnode.c         |  30 +++++++--
>  drivers/gpio/gpiolib-swnode.c |   3 +-
>  drivers/reset/Kconfig         |   1 +
>  drivers/reset/core.c          | 146 ++++++++++++++++++++++++------------=
------
>  drivers/reset/reset-gpio.c    |  19 +++---
>  drivers/spi/spi-cs42l43.c     |  40 +++---------
>  include/linux/property.h      |  13 +++-
>  7 files changed, 141 insertions(+), 111 deletions(-)

Pulled into the GPIO tree. Thanks everyone for reviews and patience!

Bartosz

