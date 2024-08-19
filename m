Return-Path: <linux-spi+bounces-4230-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79037956D73
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 16:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36518281178
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066F216C685;
	Mon, 19 Aug 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMfgqcrM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E5E15F336;
	Mon, 19 Aug 2024 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078262; cv=none; b=s1qac5v4h3p1HhFP5y+C2CTPC/+IdTEPmAkVZ5/3aC3vK24PK0cXG9wyrrSpddOkSvsDoi9BFNN/sa45x0qKMEyMhgJ1jf4xfwSEJaDxZynnw0Alz/yN4abX+kjAWaPCaHDnpzCIzh18NKZ43J9QMLhorWthZSaEpaU3S7ch4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078262; c=relaxed/simple;
	bh=JTnWVMvWno7wb24qY7+dCZeMGgbDqXTbc7a5NZ88QvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFLZTe7zBT3LLj/V2ggdgao7V58DBFGRwF+1R/tKjUUBhKrAUNQ2vHunCYxjX8t9WUk86NVi0TMDwttWhEmRUI/eSSvwahRG3XJJtyYGW1uVeMDQYlHnkSIOrL8M/UUq7lb4Sbz519vI7LOS7Z98f6IZSVe1pqLSCf9XQ/Et37A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMfgqcrM; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db12a2f530so2967430b6e.1;
        Mon, 19 Aug 2024 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724078260; x=1724683060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTnWVMvWno7wb24qY7+dCZeMGgbDqXTbc7a5NZ88QvI=;
        b=DMfgqcrMHQdxapsxgnLGXt3p4zdOsTAAWpuDEQBq9TcZseVk7j44uASFuVlaXlKqE0
         JKX9jTUIOdSRppSWxI9B+LmZP9/rDe27nTJjmo7NrnvK99Xr7zXPO0DMedBSTbnZ1gif
         39oIYbtCTsReSOuqgpxtwLtSkozvPxNTF81/rp4B42fC4Fk3eW+tdVsq356Z/MhUFwi/
         IYQ1VqW+bVvj6RVFZHnv9qyx0SgsICCTolXEoh23d/wdEfj9XXMiPoY1PHug+TvT8g3v
         cYyyKt3/fAOyFN9rklIgsqHR4Ce59n46/0Prdyyd++11MLcjgF5XPIBMKI6uu/Wq68Wn
         Qa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724078260; x=1724683060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTnWVMvWno7wb24qY7+dCZeMGgbDqXTbc7a5NZ88QvI=;
        b=CyxlGF4M+lsRhDltt5FDQMs8f79nPURULBYWiDkZQJ/l+Hr59biQeyYptWCT2DAguK
         tJE3FXuXvOJjtfCWZsYI9oeJLruUK31JXXiNccE67nhZ010TowGf0oWZBjuEiKf8yuER
         EzwJeDEIT2ze6fclDU9TE6RUb84WHxAVgdezaEoSq4cDUuZE23KHB1h2ME4DA0e8K42p
         4UrGYGi08NxyG306uOiuA0RqNtiLV7sxqGbKoZnPQMXRDS8tqhBMSjXQCERsx1y2bqAe
         YGzT8yRUg+dYGJAq9Ale19oHkhbA7rIpFVKTTUbW3G12n2jwUXrbmLUucgnKTywta/1t
         6ZoA==
X-Forwarded-Encrypted: i=1; AJvYcCX7fuOwMS6wm5ULz9XHP5VOLjLvNz3WxFvXT3pYY8qjqVFFzRqtVQxJrwegzenm1bcJGBoVXugHdTpnlg76ab6/HNkxNQUuVfI6qv/GRDOu/jN9mYbciFggtI3aPy6hu57ca93gVVDl
X-Gm-Message-State: AOJu0YywTDLLGswefmPWaL1qv5KyoSbiS6++wYofhW+dudP9+2DMYgHP
	TSrqDnZfMspknmWtBiEh8b3SIgx5dNL5w0b7rsB8y/zSL48blA0aob5wYLfZWpaoLp9s90NMgeB
	TIOD2BQ9O9s2V/9tQDeJAqjlZ1EM=
X-Google-Smtp-Source: AGHT+IEIMKuCROk4UKJ0V128vJxPpf58Ob3VgbLfepoK0u7fYdeYSni6/KOEUJbQPo80EFHtKiLq1ktsuj1uRRlvKBY=
X-Received: by 2002:a05:6808:2219:b0:3d9:222e:40ac with SMTP id
 5614622812f47-3dd3ae3531bmr11209758b6e.44.1724078260399; Mon, 19 Aug 2024
 07:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com>
 <CAAMcf8DZu4B2AN+=8xP3wuknqUtD-e-v+Ej31=08ibPfyL+dGw@mail.gmail.com>
 <CAAMcf8A59MqhZEswC5VmKZyThG7oG=ztEYd_yfuOwvGTvKzMow@mail.gmail.com>
 <CAAMcf8Ctr9rOZ2oOzk48haakJOO2bzyNURb2oZTRxJ3tnafXUA@mail.gmail.com> <D3JXD607339U.2F1IAKUSM59UP@cknow.org>
In-Reply-To: <D3JXD607339U.2F1IAKUSM59UP@cknow.org>
From: Vicente Bergas <vicencb@gmail.com>
Date: Mon, 19 Aug 2024 16:37:29 +0200
Message-ID: <CAAMcf8BAiva1GB_1AoVH-Nq8sp81KdtVe=rUMVjV2ZxCiM4NAg@mail.gmail.com>
Subject: Re: [BUG] Rockchip SPI: Runtime PM usage count underflow!
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Huang-Huang Bao <i@eh5.me>, "Rockchip SoC..." <linux-rockchip@lists.infradead.org>, 
	linux-spi@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Sasha Levin <sashal@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 3:33=E2=80=AFPM Diederik de Haas <didi.debian@cknow=
.org> wrote:
>
> On Mon Aug 19, 2024 at 3:14 PM CEST, Vicente Bergas wrote:
> > On Mon, Aug 19, 2024 at 2:49=E2=80=AFPM Vicente Bergas <vicencb@gmail.c=
om> wrote:
> > > On Mon, Aug 19, 2024 at 4:12=E2=80=AFAM Vicente Bergas <vicencb@gmail=
.com> wrote:
> > > > > i am a user of the CONFIG_SPI_SPIDEV device.
> > > > > It stopped working between 6.8 and 6.10.5.
> > > > > The SPI bus itself reports no errors to userspace, but no devices
> > > > > appear connected to the bus.
> > > > > The platform used is RK3328.
> > > > > The only spi-related message in dmesg is:
> > > > > rockchip-spi ff190000.spi: Runtime PM usage count underflow!
>
> FWIW: I've seen this issue as well.
>
> > > Added:
> > > Huang-Huang Bao <i@eh5.me>
> > > Linus Walleij <linus.walleij@linaro.org>
> > > Sasha Levin <sashal@kernel.org>
> > >
> > > The first offending commit is:
> > > 29d8101fb9442544077e68e27839a1979f85633d pinctrl: rockchip: fix pinmu=
x
> > > bits for RK3328 GPIO2-B pins
> > >
> > > I've also tested 6.10.6 with it reverted (and
> > > 456447ff1fe3c28e2fd7b57a79650f62245c6428 and
> > > 7127c68c76f120367b9a5053f524df0b603d4a48 as dependencies) and SPI
> > > works fine.
> >
> > Sorry for the noise:
> > reverting only 29d8101fb9442544077e68e27839a1979f85633d makes it work o=
n 6.10.6.
> > Ignore what i said about 456447ff1fe3c28e2fd7b57a79650f62245c6428 and
> > 7127c68c76f120367b9a5053f524df0b603d4a48.
>
> Please try if unreverting that commit and adding the following:
> https://lore.kernel.org/linux-rockchip/20240709105428.1176375-1-i@eh5.me/
>
> fixes the issue as well.

I confirm that 6.10.6 without any reverts plus
20240709105428.1176375-1-i@eh5.me also fixes the issue.
Thank you all.

