Return-Path: <linux-spi+bounces-2350-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDCF8A5729
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 18:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B0E281BA4
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 16:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB8E7F7DD;
	Mon, 15 Apr 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgR0ZZDC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0EB1E535;
	Mon, 15 Apr 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197429; cv=none; b=hINC1Kp5jUdSqNKz/5hFk4547q55uX8ucQFTDa6ZxAQVNd6iw53RRO72gLWDaNYY1eB0z1xI/WvfGmoGGzc8m+fhnd0ijR0/IppTXnPDq8Dp3rqCSb/eHpDBKbIydUD14oU9Qpgox5HK55ZFE9oTP9ESiLER487ZpUS/boVmi0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197429; c=relaxed/simple;
	bh=adlG9ThoI0FWP3p/YXTf9kCHTPhcyGfodw1TKc6YgV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q43kKGio5rTWjrFKzQuJAt3NueSMZ2arQo2DlG/5p1nMxKdbAy4XxNsHEF/ann90MUTiKora4lxVrgR7nHiGoER0Cf1zbz9jzHMqXgWB4IH1uCavkeUzSsQU/v77FCNlFUTgQ8cOTOJiX1SE7ww9gcHY+9/lYW5V4LzRZsKbPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgR0ZZDC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4715991c32so438239866b.1;
        Mon, 15 Apr 2024 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713197426; x=1713802226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adlG9ThoI0FWP3p/YXTf9kCHTPhcyGfodw1TKc6YgV8=;
        b=EgR0ZZDCRulSr/x5KnB66gzwwB016sEFK4s2hQrbiMGLUCvx1P1IcMGEuR0TgwVLU6
         2FOzOH7/eiUqMFxVAY9AyfLMSaytU7bxB6+PTlhdPLmcm4dagrG1TvV7YIlDOIql/Q1N
         fjJr9wQh0o4cyRNmv+qrKgaFA1UEhwhfu9LBuThR9eT5lGubccIcGrDiX91sIGHiHJRb
         BU58AzgDPSYVPW/1RLJZnTJSD1r2OQY0eGEMxoAY/ky+cy6jAJner30K3A8VgkVquQ1o
         V168LSpkmWtwoddtiWTKqg2B6nMLsLXfwm2IuI5XU0wkn3qjSIa3ztahpKsT0AVqyeiS
         lK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197426; x=1713802226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adlG9ThoI0FWP3p/YXTf9kCHTPhcyGfodw1TKc6YgV8=;
        b=s661igjl5GqU/5H6WJUV6x4g9hf4IofvdcLfvL11BrPoFGKQmLx9OyVEJXojPUs3NP
         Hw6oaD6SHTgD+Y5/8amy3wHmlcY8e2SUVilLp2oqzMGEgq7RlgBO51QOPIfolorn1LZy
         EElW8My7in9BflvGP4jkXIwr45HhFo7wJv33HhXXkBMxWNxcs5AEJY+VjrRWY22mGhfP
         LHf4FUZBB1m/Mu9snW63jrySYDkYSQh1Zi4V/zsi43GMGKgNkV8HALxIrwHUQYcClJCj
         cDh6DRBYNBOkgHflQoXp8hEEdQ+xYeSiRwGKmtiWl6Se9xIxkCPrhj2rbeIL2fSjhemo
         V0tw==
X-Forwarded-Encrypted: i=1; AJvYcCUhKi6G5hfYBMCOAg7kTtUrKpBR73a+bL5h2fmVsSBP0TWzmIfpY82qudwWkmxeN7lSMU+q7/VXOwNysJGVp6cmGhoBzZaXQpS6ZdxsbaAnV8FdqPHmrr2FxWt2ythhOmC3NGOw5g==
X-Gm-Message-State: AOJu0Yzq+SVvXEGiALeP6jLS9FnLXOsl1m16MujJ/59Rxip0L1/nW2sC
	AmYpPpTlPDBC8XfFyaCdfFBXvQSWru8ZYkCrA3cHr5r/X+K5WEyPB4Rc5W24kwQWekEDuDY3ZjI
	D3DujqIf7AWsoNptNB52FOi3UG8A=
X-Google-Smtp-Source: AGHT+IGD9ATATTkU/ws5npKD3eZ4W3thR3D2oP4GxjTiRPjIZ0SoCYIcc4l7J96NjRJ0bZEjlqpxMZt2EfGsQMkA/VA=
X-Received: by 2002:a17:906:d20d:b0:a51:ad60:ea32 with SMTP id
 w13-20020a170906d20d00b00a51ad60ea32mr5665895ejz.27.1713197425732; Mon, 15
 Apr 2024 09:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415140925.3518990-1-ckeepax@opensource.cirrus.com> <20240415140925.3518990-4-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240415140925.3518990-4-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Apr 2024 19:09:49 +0300
Message-ID: <CAHp75Vdee7SNk5Y9+qeZAe4B2y_U5SPvGSL5hSJFwdQ_dL8PLg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] spi: Update swnode based SPI devices to use the
 fwnode name
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 5:09=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> Update the name for software node based SPI devices to use the fwnode
> name as the device name. This is helpful since swnode devices are
> usually added within the kernel, and the kernel often then requires a
> predictable name such that it can refer back to the device.

Assuming we have no users like this right now, so there won't be any breaka=
ges.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

