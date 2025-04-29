Return-Path: <linux-spi+bounces-7800-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8F0AA10A6
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 17:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341993AB843
	for <lists+linux-spi@lfdr.de>; Tue, 29 Apr 2025 15:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8508A226D04;
	Tue, 29 Apr 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJMKZghg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4448C2D1;
	Tue, 29 Apr 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941202; cv=none; b=u2u5OtXRF7PuTda0yiC68nsXmXQ3A1EKLz7X6psddK0LrKAPbrXMc9eOqMN+PL+tBsJJmjmWu59HJ4M6nTf0SzVDBmICEWstH4XoORNFE8cClVfqDPM3Qp+ZzuKeaqFGlLAgkjDNcV3j40oTvHZjVwSLOQrkb9KFFw/083d4+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941202; c=relaxed/simple;
	bh=CrN6P12JVoXq0VzTYIezovmF77P97iZPbBUkrdCau7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y5hk+lAozR8gGnFeVKl7pO9bw3o3ylkk4e0yXbsidCcSJSQNQcnS42vmulWyS/eOLzLsbCQA2V2MfnkxYhs7df5r3IFO58JpNWc+sdui6oESiVmYjFGoxBBenTP6stw6NJbJb46L8Ua0eyEHhJgzo88NjdGUCT8esLUTyeX8ers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJMKZghg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39ee5a5bb66so4046097f8f.3;
        Tue, 29 Apr 2025 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745941199; x=1746545999; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uRRV5VQKmG7WVso+6vlqTuY2N9DktX999E0cQzgs5ls=;
        b=FJMKZghgcZY+pnR3AnxVLdR2Xmoyl/Ni/QAWsOdmyEPb7k5c7cYqer1A1FMAUC6kLG
         Lqnbv7t697qh2zd8vjCHsbB4Xg5+sdDkCHPbsXcOTD3HSB+vK05+I5E7L+UT8I5aofUQ
         hI7s38iclle1BoWY1mlMu62rBv48MG0x0csbbnrWs8VsmOTBChTOuur1IlCs/GaGVlyN
         5UOq9zhylir6zamKiVhOTSHyD0af6Z1KqFEcKBBH65zqGzmVDZmqVXhjhZ8qq1JNykdx
         lADir4B0v/O+F/8fpTJRGgW3NpKUfawb+kBqSJmCHtNzkSOGkahg5pJvnKd137PoXU8e
         sJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745941199; x=1746545999;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRRV5VQKmG7WVso+6vlqTuY2N9DktX999E0cQzgs5ls=;
        b=j6ii+deqVZ7Qk5yVLQeTiCAR4NWbI6cVxAMz+46tYyr+D1k9EsDAWddgk1HQO0vN6R
         h8ph/4IFuVWAb7B/pS7TnNJiBSh0yB51Dr+aeMcIgTQW/Q7gvtu23iXEyqgBwUix5+jN
         JVuNkyMmpa+INH2hugOq3EjaPvlqJHGCLJ7hlFoefeoYl488XxlkUEsC5oBSKb8iAVpu
         lMxZHHrUifmBoLich4kZ4iYuYS/f6FA496yM8tnMYXQ3l164wD7YmCKPXKLq3ak0T2br
         62e9x5uXwHYrNv4PXWFVRixr9zHR75+YQs+004YwfLWctRw6L5wGpaHQfqssx3N64TFM
         IbmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiCaT8N8dpSOx8hTPNhja8TLP1lHsHodH191EI0Mu6v3w66eiIPdwnnJJNtKyFCLReDG/xAMHX9AdE97w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlNs6FTv5Gr2Os/hpAonztKlKdtJWIwMZZEKEcHjBMwrGjpLi6
	hbY/uPBxaDpJKSCWz3OZ1DbuNXtg8aEt4GIPtXV7MBXJDTPiNuoS8xPndxru
X-Gm-Gg: ASbGnct317MjVE1l6UPyOnWQ2qtdhDb+xvXNpFhqo3i76ZR68S4H1WmL+zEQjpeyEIg
	F8SS10gTWrHv0eMai7lTP430r4BrhyaKKCJzT/bu5cU1huJ/ep2qYyIKQkso/osHomFexVnTLa0
	IAIfkKVmTYHSAUqZvPZ0m/SmEtfBFkn0m/N2yrH5KePWiy95hyxfhHvfAiMID5M6eKC30EhB8Oa
	MO/oJFEgQWDuz41nKnvSjth6q0HRrng1/tSo1JFJrSUt3tqCA+2F/tJ1lVhwauihMMwC+KQQTfD
	GuGrIndzRMjrkiz8obTa+d+k8t/bS4kHI/CpV/wRr3+w4onZrouRklSj5LrPMJXbm629s5jy0id
	PPp1khlYjvyK+
X-Google-Smtp-Source: AGHT+IEvNOkswmzuTDrFfDXMdU1HhqIZ6y2XMAglm3nMj1C1EkfGRBxuFw3NEa1k/GsIAgd7gHE8Bg==
X-Received: by 2002:a05:6000:2489:b0:39e:e499:3efd with SMTP id ffacd0b85a97d-3a08ad7764fmr2604535f8f.42.1745941198769;
        Tue, 29 Apr 2025 08:39:58 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e461casm14562706f8f.74.2025.04.29.08.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 08:39:58 -0700 (PDT)
Message-ID: <a380702d474e9b1f361f7224e20e40bdfb8a810b.camel@gmail.com>
Subject: Re: [PATCH 2/4] spi: axi-spi-engine: don't repeat mode config for
 offload
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich	
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2025 16:40:03 +0100
In-Reply-To: <f68231bc-6546-4eaf-a8b2-fc31add33a1f@baylibre.com>
References: <20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com>
	 <20250428-adi-main-v1-2-4b8a1b88a212@baylibre.com>
	 <ca7708856683596894b5fb9cfd6caa164535a50a.camel@gmail.com>
	 <f68231bc-6546-4eaf-a8b2-fc31add33a1f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-29 at 10:24 -0500, David Lechner wrote:
> On 4/29/25 4:08 AM, Nuno S=C3=A1 wrote:
> > Hi David,
> >=20
> > The whole series LGTM but I do have a small concern (maybe an hypotheti=
cal
> > one)
> > in this one...
> >=20
> >=20
> > On Mon, 2025-04-28 at 15:58 -0500, David Lechner wrote:
>=20
>=20
> ...
>=20
> > > +
> > > +	writel_relaxed(SPI_ENGINE_CMD_SYNC(0),
> > > +		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
> > > +
> > > +	writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
> > > +					=C2=A0=C2=A0=C2=A0 priv->spi_mode_config),
> > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi_engine->base + SPI_ENGINE=
_REG_CMD_FIFO);
> > > +
> > > +	writel_relaxed(SPI_ENGINE_CMD_SYNC(1),
> > > +		spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
> > > +
> >=20
> > I would assume that SPI_ENGINE_CMD_SYNC(0) + SPI_ENGINE_CMD_SYNC(1) sho=
uld
> > be
> > executed in order by the core? I think all this relaxed API's don't giv=
e any
> > guarantee about store completion so, in theory, we could have SYNC(0) a=
fter
> > SYNC(1). Even the full barrier variants don't guarantee this I believe =
[1].
> > There's ioremap_np() variant but likely not supported in many platforms=
.
> > Doing a
> > read() before SYNC(1) should be all we need to guarantee proper orderin=
g
> > here.
> >=20
> > Or maybe this is all theoretical and not an issue on the platforms this
> > driver
> > is supported but meh, just raising the possibility.
> >=20
> >=20
> > [1]:
> > https://elixir.bootlin.com/linux/v6.12-rc6/source/Documentation/driver-=
api/device-io.rst#L299
> >=20
>=20
> The way I am reading this, relaxed isn't "no barriers", just "weaker
> barriers".

Yes, sometimes just compiler ones. Bad phrasing from me...

> Quoting from the linked doc:
>=20
> 	On architectures that require an expensive barrier for serializing
> 	against DMA, these =E2=80=9Crelaxed=E2=80=9D versions of the MMIO access=
ors only
> 	serialize against each other, but contain a less expensive barrier
> 	operation.
>=20
> So that sounds like we should not have a problem to me. (And if there is =
a
> problem, then it would affect other parts of the driver, like when we loa=
d
> the fifos with tx data in a loop.)

Well that just ensures that they are issued by the order you wrote them but=
 it
does not guarantee that they end up in the same order on the peripheral its=
elf.

Anyways, likely not an issue on the arches we care and as you mentioned it,
there are other places of the driver where this could matter. So, I guess n=
ot
material for this series.

- Nuno S=C3=A1


