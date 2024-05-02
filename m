Return-Path: <linux-spi+bounces-2695-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9588B961F
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 10:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EAFCB21539
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 08:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FB22D04E;
	Thu,  2 May 2024 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsTt4rcC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC02D045
	for <linux-spi@vger.kernel.org>; Thu,  2 May 2024 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637291; cv=none; b=ARTOfRyYbIjaAcov+ygzHlE5XPTQyrrDF0n5XIz4eOMmY+vH3XxKze+rfjAXwNilCWTkDmUYBjgUTJLZyKTsQfePAM1PYFe1a3+Z2T5uHLcCtCgYSOwjHKU4a8nCnGTQXSOwoUGeWk8YgMxVgNs1O8YX7pLnCbDkYCIllrQdebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637291; c=relaxed/simple;
	bh=Tfp3g8V0aVnCRLq10EyyqukrcFGEY3Nfwl4SQpl+VwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAkTloLYY54Ahik3Ybq62L0EVmh9ULwpE2XK6TB0N/nN6WAJJOnG4e4YKGFcT5ilcLKDvXpPWQIr9Q4FVkpKWNscKIGaQ6jQBUaSDi59yMfMWMIacz7ZXGFrMLn7wOy0rn+PUFIGKanTxKc+teRkGJU6nYEGvTB3sHCCpCoAnMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QsTt4rcC; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de8b66d1726so429354276.0
        for <linux-spi@vger.kernel.org>; Thu, 02 May 2024 01:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637289; x=1715242089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZf1UN1L/Rqc3VF4m9QS0otqoTAznMU1NUWIQvEmWvk=;
        b=QsTt4rcCesE6TDGp69d5sEftlFYQZ3uDS5NpO+JF5hfzk8bgB/SYXTEHeEySUMbGEJ
         zf6oJLgatdyf1jUQzOPdtVDNZwCvMhpUf/urki8H+D/mj2ELBPeV4vhbddOsolcxxzcH
         /uOtxYNi2+LpShIf44QM7bO48H4VNA11GuEcoV+NrxfVKE0tR1vtl52zqX/krC+v2c3P
         QbG3Ojml+s/5oS7nG4hWTrDwluEE/JrjOgGlWE83wo4RxsOpMl3BH/BLrZmwHzwUdBmK
         tSf+gbtp6aja7cOPs45JDEbyI9BunNtjd0KWDaRlPG3Wp0N81umDGHy4fzdY2k6UtVyI
         JjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637289; x=1715242089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZf1UN1L/Rqc3VF4m9QS0otqoTAznMU1NUWIQvEmWvk=;
        b=FQr62AsyLOUPoJHDHV4axw9guWd9Km48YkaNwTp0phu6YbO2bnJephSM5OZ0aqnkCC
         AIG/WgzClhKM5wqXpr0JY7JW0tb9B5IfjDTJQobHkgEzBUEYcZQoWdr3eCb1w+SGisDf
         n4vM+GdOIyzwlX9Vo558fZFXIXrE75sBKL9sMjW0cBV0Qtq4eyoTTYdKmTr55VuZyUQX
         wChkkXa8IOatBfvjjxHPoVEVmhviIVcIArgyHTlbD5q6BEAHt6dHa40bC3oN3rQEQbOS
         byb+S84mpRyedfAwsUKA8scZOY2tFGvkn0uAcTkvMs2z3D5QNvFo+/NbrqROfHJzB56n
         mP/w==
X-Forwarded-Encrypted: i=1; AJvYcCV/l2kaa70bzW6cEA6bajhg5oc//RynzZNQ3h9d/d8ZVT1bpW1qo/PVgAEdjZFR0FtgnLkfO9FrfdBSd3xMpAXk+mZLMFtfxaRd
X-Gm-Message-State: AOJu0YwhJ3+PBBaRcOS7Z7kqd0MU9Vbdg57Nu+RGlx7cSIyGe/LN/RX/
	GbjXZ2S+mlC5sXjfhCx3IVS47UScx2NVZGoeWCgX3CgHT9kVvssbwfWzciyMTfR2ggpe3faAxue
	ypn/5fYJPDoqJjgustYp63IOApgnm/8mTgDy+Tw==
X-Google-Smtp-Source: AGHT+IHg0BJp5L3AJ3cmZrr+G9OhRDbfgMItRirP/XPtKut2c5Z/lA4l03TlTvhccBF3NweJuJ9pEzEQzcj9kjQP3Ms=
X-Received: by 2002:a05:6902:1024:b0:dc7:4265:1e92 with SMTP id
 x4-20020a056902102400b00dc742651e92mr1729041ybt.23.1714637288608; Thu, 02 May
 2024 01:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-3-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:07:57 +0200
Message-ID: <CACRpkdY_z1fkn4U6exOQQPouOfaNLs0wCYgBZJtWs+sd5EGymA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] spi: pxa2xx: Provide num-cs for Sharp PDAs via
 device properties
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Since driver can parse num-cs device property, replace platform data
> with this new approach. This pursues the following objectives:
>
> - getting rid of the public header that barely used outside of
>   the SPI subsystem (more specifically the SPI PXA2xx drivers)
>
> - making a trampoline for the driver to support non-default number
>   of the chip select pins in case the original code is going to be
>   converted to Device Tree model
>
> It's not expected to have more users in board files except this one.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

