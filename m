Return-Path: <linux-spi+bounces-2308-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0458A158E
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 15:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57CA1F240C3
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 13:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF24C14EC58;
	Thu, 11 Apr 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoVAAgOB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7B714C594;
	Thu, 11 Apr 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842252; cv=none; b=ExFzoboYRWHhO1Tk1UdhOgg/fThH5xAIXjBfb/hPZ+0wp0Cp1vEVOw0VxQ8huVPpbwvM+tT0PeQ0sEeZpdtTR/QtzxaPkHlwOtxxKwfAObQqO7gDk1SdLVLhYRqyAw/X47GxghKDf0XMjCeH5yJadIClF80Q5OsR71oOuP5Sv7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842252; c=relaxed/simple;
	bh=qvzJYzSFUTXPdDAX+VtKWKtJKrq2HC23Kyq401ntFGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bv/PTOFyXJtjL9ozoGQdLTjuOmYfFO/+C58XElnl4eDPBTKwyZayCibpyjelHdTEK+j4U262y8sXZ3tBAsKWfvhSvMKuqswzGENOYIUgRYQL33tsuNpc2VRvBpN5jHbdXB1e76ROdcyuokplHQ02Oc5BDzVnRnImCVzFoPfbMxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoVAAgOB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a44665605f3so869953266b.2;
        Thu, 11 Apr 2024 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712842249; x=1713447049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvzJYzSFUTXPdDAX+VtKWKtJKrq2HC23Kyq401ntFGM=;
        b=ZoVAAgOB1qgcOmq3c6F4pFYIVom+qVWQ4iarbu5jIF6wWI9fNzHy0wAIdgVCQKU6Am
         2wlB75+yFK8rF2u2jx0VAW2jAb5sc5N5+yHcSVshEUxUB6OaWqaa8iD6a7lRZONCS4A1
         d18374st65rw/HuX8gayqghj7brLHKrQg74PBIIlP30ItJ3nVOyHYi1j4zBnVVkHoWk1
         Z+Nzb6bVvlaqFJb5ltmDYCuxnK8kmWnrAE5lgqsDhDTW34d/yOAavUBwrbLVTFfRxd64
         5Nsjak7nG5s0GOR72cwtf1Mi25HUWzA5ORNtlg37eGRPd4uKGm7RpDvftKEh15BNc45X
         TO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842249; x=1713447049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvzJYzSFUTXPdDAX+VtKWKtJKrq2HC23Kyq401ntFGM=;
        b=AB6u27iEBsnBR7Us9UiZKJveUELOicI8j+/kCrlw+PwMFAWZftEhNRGnZNB3Yv8EOC
         PQs3JRlRWz8LqTAOcAPOlRi2AITbxKUgP/fz39wzIjPM9CX7u7Hf0ZcnZRYXHuW7EAok
         qjanwmo/zp6l+4Z2ZGO0F5Xy34C22yUjmXFyW4n+NU09QENwcXOQGPz0I5z5ht8eLg+o
         /6FOCLr3zhB51ZRbqiVehTG5RwY28jOamUsfYFvdB/q6zY2aLutALmE+4L6oijfTI6b/
         BYUDzDAkS3WR5nNCtbgmeXICkq6eGj2tJ/lU5mN8+S6vGnSwwoAg0TCkmLRGbKCzUnFj
         nf5A==
X-Forwarded-Encrypted: i=1; AJvYcCXcME2cupSY/oU8d950f1X/He4f6CaFlVKNAxobuJ5B9opnAmE1QidC32H/PyKKqNkPrJJSzTkApwpJfunD4zkZdADRxmnSHHSqbvCt6CxZalD83HxETQkX9/au6f+av/TAvSKg4w==
X-Gm-Message-State: AOJu0Yz3Kgs/FDljPx7ZOeSDRG02Fyy/zbIp0JXG7oB3fQuFk4+u9z42
	f75CBOJPR68RyZAXLMEaAN8H4Gzl7XBy1n8hOZxLyZH6ZMy0oR2TION7ViW8f/m7frgo+WPvgLQ
	fw/ybDIBtk4RR3RpSahz8kZRZQQA=
X-Google-Smtp-Source: AGHT+IFx3lm0Op9fIYTjTrR0A0oe3IhVAeGuWcQFMIFTBGlf2iM3O2WvTgztQ7Stz6xLWWGyTXgvzF1N349JPzbb72k=
X-Received: by 2002:a17:906:a88a:b0:a52:15dd:20d8 with SMTP id
 ha10-20020a170906a88a00b00a5215dd20d8mr2564278ejb.26.1712842249336; Thu, 11
 Apr 2024 06:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com> <20240411090628.2436389-3-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240411090628.2436389-3-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 Apr 2024 16:30:13 +0300
Message-ID: <CAHp75VfAoKvvnQr74-rpJhEv=U=o00Doji-1zuV3-_+n+cbVVg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] spi: Switch to using is_acpi_device_node() in spi_dev_set_name()
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:06=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> Use the more modern is_acpi_device_node() rather than checking
> ACPI_COMPANION().

I don't think it's valuable on its own. There is no clear motivation
why to do that, I suggested it exactly in the conjunction of not
introducing two ways of fwnode type check. That said, you probably
want to elaborate the motivation in the commit message if you want to
keep it separate.

...

> +#include <linux/fwnode.h>

This header is not supposed to be included by the end users. property.h is.

--=20
With Best Regards,
Andy Shevchenko

