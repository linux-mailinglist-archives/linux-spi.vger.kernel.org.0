Return-Path: <linux-spi+bounces-3178-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E578D6606
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 17:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24DD1F2394A
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A02481725;
	Fri, 31 May 2024 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9n10dvg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D445016;
	Fri, 31 May 2024 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170420; cv=none; b=dAgBe9jYFTLA6va0jUa2BLEXpoanR/xyw+1fIQy/clBVVD0FLQ/GcJQnyD0Vqjj0oQPa6yvXVzG6kLG2UD4RSyGIk4zcdk5qO9BvbN6WM76IGoeblCxnSDiNtk9GApgP/GheOuJqLFNluVa2NNDVnPC19lbv9pI6Jt5vM8i1Fdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170420; c=relaxed/simple;
	bh=SwCMaLnNOezhPRxRJXyYP48o4h5KECH13gYp5P8VBWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkbn99tS1fCWcDRRwnZBKqQfUqmbzk/Dngl4sFXjFbIURI4He3kgIHAIWie++kYY8lkulHYfzelBAx3hrYbgpZl8JZuB0NvMUkKtmVaBO8I0uIz+PeIbNcSgvhz1rlrcgGODa89P2UbFop9Rrs+ujSN0DyR4tJFGEgXk6f/gYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9n10dvg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6269885572so419003266b.1;
        Fri, 31 May 2024 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717170417; x=1717775217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48EstrLpq9HK/FsTvnvsJGqmlUDmcchwC6PKHbWTt30=;
        b=F9n10dvgebx8VsQai8jLPTGtuYGgrSxQO1su96cPywPrHHymFLXUKoxaF/G2mog1Fw
         WGlT9C7bkIpyxqe9A77OC8GP+aZGOKRLc6DUnQyMdxJPahlAbE88NJmF1nliGv6LvO13
         At93xyKK7K2zao9NUEoH9/vRoustqo5BJYdpukqQ1O7ZMAQc+N+R8pVyA/ojVYIqdzbN
         JifdNWtfYpnRYhBQIEnDZRs83ZDHNEPLHn7CZjbH41qrBUMX6YLlKKz+7bzsisBadxw9
         C+syfXKliwbIACwsII2c5doy6MLTog98ljXFB7l+M3V5a1HAN1YDtkpXIUyz7794vhr8
         FPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717170417; x=1717775217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48EstrLpq9HK/FsTvnvsJGqmlUDmcchwC6PKHbWTt30=;
        b=sRqySYwWv4cgNcvlF7S2scvoPIhifLzjAC4C0ndt/hKq6kz9M1njL4QUNglHxJuEb4
         fb13cqId+O0707KqUdBHb0RiktexAWL4b9mHFoE6FGpz77bcInZXlKjgq8ACXuiPpz49
         wFImwYxX8SUrYQPPUOlD4jJRCMkztPicCOLsB8ORZRkJipIjPL7J9R7nZ43pYkGSapdj
         Q5T5jB803jVqjY45a5Asl7zMsp9UPvX5VVsxKTnUH6etU+EcSxlL8UqB4Yl2T1PXCqBY
         VxizTLDeZghC9hOINX9hdE4qpl+kqvj5OdqOP+EE2g6Iyu21oTF/y7WYhwmS0z8dEfel
         JEaw==
X-Forwarded-Encrypted: i=1; AJvYcCVPfzNxDCwZ5LhhlMTRUBw2wIejimDTF9Zda+nRHNALQ+6KH9HMYIw9d40QESu5EdqqQYXosWPNS/K9ZJLo+BWHcbBLs5352Hyg1jnNFFXEyN4F++XSj4VkfYPm1ZCMccOGA5Wcxszf
X-Gm-Message-State: AOJu0Yxm12rqEIaqTlplBWyJf6PS9xqVi6DoCcHrzb/hFOVFtESPGXrq
	0YIWTq2ePbJh9OcYF514fDtsfp1014fFxy91THouNI7lQ/+hT6LvBIoa4aDo3JZRY2L/My58GNe
	ozem5N1h0Y4/q082uSE0PwUcS0Ak9f1kma7U=
X-Google-Smtp-Source: AGHT+IGPjiNCV2UUTK+ImDQEt15a4oaGfh3IHRwJvNBGRaBL6QD7adiqFpU0qW9oExT+rZrtNdKKeNbVE+jmeP7IKhg=
X-Received: by 2002:a17:906:e907:b0:a5d:239:1a59 with SMTP id
 a640c23a62f3a-a65f0911017mr463694266b.3.1717170416890; Fri, 31 May 2024
 08:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531094658.1598969-1-andy.shevchenko@gmail.com> <1ea41944-a107-4528-8e8d-559c06907e3f@notapiano>
In-Reply-To: <1ea41944-a107-4528-8e8d-559c06907e3f@notapiano>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 31 May 2024 18:46:20 +0300
Message-ID: <CAHp75VeG9K3Ar4UJnGxus3zz_vtt4QfFdkYQ8=6D8pt2aB8kmA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] spi: Make dummy SG handling robust
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 5:37=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
> On Fri, May 31, 2024 at 12:44:31PM +0300, Andy Shevchenko wrote:
> > There's an unreliable code to handle DMA mappings on unidirection trans=
fers.
> > This series does two things:
> > - it reverts the seemingly unnecessary change
> > - it reworks dummy SG list handling
> >
> > There is no need to backport that AFAIU, but no harm to apply for v6.10=
 aka
> > the current release cycle. Guys, please test these.
> >
> > Andy Shevchenko (2):
> >   spi: Revert "Check if transfer is mapped before calling DMA sync APIs=
"
> >   spi: Do not rely on the SG table and respective API implementations

> Hi Andy,
>
> applying either of these patches causes issues. See the traces for each o=
ne
> below. This was tested on top of next-20240531, which works fine.

Oh, thank you very much for prompt testing! Can you test just the
second one without the revert?

So, your patch seems needed for the sync API calls, while I considered
only mapping APIs.

--=20
With Best Regards,
Andy Shevchenko

