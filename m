Return-Path: <linux-spi+bounces-3179-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7691B8D6620
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 17:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F898282FF0
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A09F5381A;
	Fri, 31 May 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpAYRMV5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023315CD62;
	Fri, 31 May 2024 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170746; cv=none; b=EQUpVL3WXGaSLXyTxQheFABLgfOMeTNwJN/PXgEYHD4Lv3hcy2MsK0zsD6UqDXGLczXY5kP8wNCQXbXonwXzJSfllXwVqvXtJEziV8Cp2ZbMh1RSbP0PfmNqZlQblEmoTRtN5z++JtlXD/M7AP5uALPLkl/9rbJyFNY6f5etbTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170746; c=relaxed/simple;
	bh=h33iTaw5SrLKIZZPrLstGAQpq2Jz/IjEsivDBhPYmTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJA7y2oAbpt5lCjfw44KjiNVpafM16VYLzXe/kEm+wnaXG/y57+JLSNeT0yM7ZtN2WEIaCwOhVh9U/cAY6sWVIA71qTbR4fxJh2ODK9cxX9xzzscB52faF8Va259GBWO9ewyMbAurWkhIxt8mnXkYP2PAY4utq0AfgOP59IOb0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpAYRMV5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6858bdc9ddso99582666b.2;
        Fri, 31 May 2024 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717170743; x=1717775543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h33iTaw5SrLKIZZPrLstGAQpq2Jz/IjEsivDBhPYmTs=;
        b=KpAYRMV5pAVWV7U7VMzoNIItm+dr6eEMXgscqvGFI0fGbyvNQoS1OL1O3p0EKEiidL
         ZKzZR9/pnFOYHcLHcn46pbIGcrrlqELs6n6mvrzmXKIvd6Dx5I/tKlChEf0zqIRsYg2+
         XrLwhctIufUYWPNj9tyjQE4KeHjZwAVkXDvpnNzdvxwHv8oRLEGiAmlWMkAVxRoyRIbI
         y2otcxMnfKJiQc4FYim3qkbqL+3oJiELrojclaaD1/X+4l0W0IXuIKDeK2jfRqWwMICq
         J2GKk/S4N0mtqceadUWtOWmZzGbVxP+urGqbhQzn6H5TdSgVSHq5dY3jmHvBLt2S7M7j
         jJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717170743; x=1717775543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h33iTaw5SrLKIZZPrLstGAQpq2Jz/IjEsivDBhPYmTs=;
        b=vrYUlXZYE0xXWO2bCZtEzwM0a+e6I7ZilhW6HGUjThaEdXQ+35rMGeJzZVSAdLIkw8
         Fmroqhp2ql8tdFPkDWuVdKioYHHb4rf2LY0TumBdEeCM46Oyz960d10/2g16nMiNzhae
         C3CG5/bTkVw0zhXcy0BS6T/QQYrX2PE/sPVVbamERbDWb1gJhOwhVsTzqhKrO+L2pkar
         +rcfPzX1A/W+FdXEit2ZImpGvWfaSB6rwMyMRvn80MJxmvrNIiWnClDDf4eE/0Dzl63w
         hTLqbXI505dcI3XXY15jywxGPVILf323MzED6R5F0rtGrH6kqVtZLl5e3BOm+OW37k/9
         hPYA==
X-Forwarded-Encrypted: i=1; AJvYcCU9fu+tMsFCu4Y+tSOhCD2E3gZAJQ2drIXrxyHzOvGXQUGt0hNEsap+Xixz2tYe2MBnrcwqHAZnAQ4MQEaZ8jpFbs0vz8wjqx6MyVsWjOET3y7c5/oUi9AjUnXri+IuFOn2jedxmEDO
X-Gm-Message-State: AOJu0YwkVkDaFuDf68u68nMcGP4yTS4daCeSDAv2t0aPKMLCaX/nePt6
	VPFStYRmQN1JJUGN3h6Qx0hl4BoGNXQMU13Sc5FKhHCJqwMDzUKGszQ+MO6W421JPcLtDsXcI6C
	/HVpm9xrTzFB/Zddv5eIsN0vNY64=
X-Google-Smtp-Source: AGHT+IHF2MeOHvv48FrUFGRoQjsiyyWp+nFdSGTIxDQKjCSukxIZ++hVa/FJ3YE5N1/a5G8Gn6QHSqKLwM4zu/PpLGk=
X-Received: by 2002:a17:907:76e5:b0:a65:c99e:50c3 with SMTP id
 a640c23a62f3a-a681ff45272mr187552966b.26.1717170742734; Fri, 31 May 2024
 08:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
 <1ea41944-a107-4528-8e8d-559c06907e3f@notapiano> <CAHp75VeG9K3Ar4UJnGxus3zz_vtt4QfFdkYQ8=6D8pt2aB8kmA@mail.gmail.com>
In-Reply-To: <CAHp75VeG9K3Ar4UJnGxus3zz_vtt4QfFdkYQ8=6D8pt2aB8kmA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 31 May 2024 18:51:46 +0300
Message-ID: <CAHp75VcHsE_vb12rwgf6f3q4V_wUVq5tckA5QgFhwUHaYKjwWg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] spi: Make dummy SG handling robust
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 6:46=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, May 31, 2024 at 5:37=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> > On Fri, May 31, 2024 at 12:44:31PM +0300, Andy Shevchenko wrote:

...

> > applying either of these patches causes issues. See the traces for each=
 one
> > below. This was tested on top of next-20240531, which works fine.
>
> Oh, thank you very much for prompt testing! Can you test just the
> second one without the revert?

Ah, you wrote "either", so it seems you have tried that already.

> So, your patch seems needed for the sync API calls, while I considered
> only mapping APIs.

--=20
With Best Regards,
Andy Shevchenko

