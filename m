Return-Path: <linux-spi+bounces-3191-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 410688D6BE4
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 23:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722901C24EFF
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 21:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DC981734;
	Fri, 31 May 2024 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkY7LVZn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE780034;
	Fri, 31 May 2024 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191971; cv=none; b=nY0jUVVECHioPV01ZTN9o0WUCjmfGqMlH3TwXji9w0FbvDeB0BcTJVFrRPKOMOc0FPhey/Z96UdQWou1oxpbSDgntf0BW6fSE5v0vxMtm2JmypQP3uNfDUd+wT7DrEbPKClnpH3cj/RLYZwLW2mPEJDshvjJclHI5q5xJWjDq7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191971; c=relaxed/simple;
	bh=Ax0ZyJOVsJMqf3GkJn8oJR1x2sY8yNWTx1LHPubxfPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1NqBsEtPvXI8uh38GYzkqCKZNM8RwWLSgE9glfE/9dJvM41r1E7Ph1Y89qaDawTmZgRu7dtsrPkRtBx86kvEzSuILNG4giBa7/U93TujNYoVjFtBwOUT2dU3tpDMUVw/lpWdZAReDWwhUYKo1Yz293EJmZ7TLUpxvxwDmCHACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkY7LVZn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a2f032007so1961127a12.0;
        Fri, 31 May 2024 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717191968; x=1717796768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ax0ZyJOVsJMqf3GkJn8oJR1x2sY8yNWTx1LHPubxfPs=;
        b=OkY7LVZnd9qD3ZTKutLcKGH3OD2lEZi+CvVmPIxuW7iNAHCED2cqDWzjdgm0bQnode
         BO5BV5tiGmxB6Y1+OS1UnveMTDI3//KKcWNbNerAK3Xb0yNt2KaN5EEOviRNNKFT0YrZ
         vzAWM6pjyGd4q106MY2jwWIJvUqy2KwFCHVMwhNRodxjdDKMCmbPktu1P2Q22TytYe+3
         ceLtMypxvExiyY87AUqHi4817J9CEZSXc2UvONnpoignFn8VRZcf59xAMKjyFGimNqfE
         JvThuRi8qZHgQ5KMV1ify30UfIy8donX3a0cbsazeIg2yj0OcPG8Qv8yfiTRSINXUdyu
         MvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717191968; x=1717796768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ax0ZyJOVsJMqf3GkJn8oJR1x2sY8yNWTx1LHPubxfPs=;
        b=HqiFCr2xa9mBvom9D+GMepdnX+lFT+T7Yw4g+T8v83Ibj9kcJVUq6aafMuFBh4js8x
         2Hve5/Ty0XbBeSxKWL7RyaFEJruFxZ1UPF0mQ0Lnu/xQEm1fHb1w67YJFNpa++CXUhu4
         A417ZgjzPNzIDja8bgc28TeoresKTVLgV9YW9mwXQVHqgZamEuzrUnqW3CUSh7TynuXv
         G+gjdH0/HGFQxowDXeSLgofG7nwt0oIk/VtvtAXkffWI4MJM+jwo/T7hFfD13w3TgBAi
         aoWxBUhDTMCOk99/mR3HAlby6gmF04Fdt4ttkjNPzbRiHCW3bv2ogwOWC3ipiASRRwlZ
         34jg==
X-Forwarded-Encrypted: i=1; AJvYcCX0k30oAwlDv4EO2pvW4n+ziry82UzOlkIkstFeEnwLlbPVULJvIM8EqAFeGsBNXtip3lU1uWRfSWgNedEe7WnEjtY9AJ+hssaKWPZU7+CEyea3Pq3YC/luFthGqzg7vPI9qlzERNq4
X-Gm-Message-State: AOJu0YxvYHLpuuNGIoznTpXwBY4NIED7ippsABxfJ65R7SAwDeulodrk
	t3RKWGmPshmOcPr1DjUSVJLHaE9KIz/3MH1JgrDnBnA1XCjVo7rRPv8/qrckdpWc8EsYPDuYF5t
	SlQTf+f7Ig7xi89VR7ltk6S8yuMg=
X-Google-Smtp-Source: AGHT+IF2JFzwO5h9jWIbwQwlcBnpViCMfdgYP0QRsx/mlMurfH6n2y2K95pbPdxLBZOKzRyClZLaWoOaVrxqGYHBhfQ=
X-Received: by 2002:a17:906:5281:b0:a59:bdb7:73e8 with SMTP id
 a640c23a62f3a-a68220499f5mr195797566b.53.1717191967594; Fri, 31 May 2024
 14:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
 <1ea41944-a107-4528-8e8d-559c06907e3f@notapiano> <CAHp75VeG9K3Ar4UJnGxus3zz_vtt4QfFdkYQ8=6D8pt2aB8kmA@mail.gmail.com>
 <CAHp75VcHsE_vb12rwgf6f3q4V_wUVq5tckA5QgFhwUHaYKjwWg@mail.gmail.com> <3f0606f3-c781-49e1-a946-dc9aea77f835@notapiano>
In-Reply-To: <3f0606f3-c781-49e1-a946-dc9aea77f835@notapiano>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 1 Jun 2024 00:45:30 +0300
Message-ID: <CAHp75VehYoEFPV4jTdXh4D5DSGUkHzska6tuvB=BrZDpZhiv5Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] spi: Make dummy SG handling robust
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 8:14=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Fri, May 31, 2024 at 06:51:46PM +0300, Andy Shevchenko wrote:
> > On Fri, May 31, 2024 at 6:46=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, May 31, 2024 at 5:37=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
> > > <nfraprado@collabora.com> wrote:
> > > > On Fri, May 31, 2024 at 12:44:31PM +0300, Andy Shevchenko wrote:

...

> > > > applying either of these patches causes issues. See the traces for =
each one
> > > > below. This was tested on top of next-20240531, which works fine.
> > >
> > > Oh, thank you very much for prompt testing! Can you test just the
> > > second one without the revert?
> >
> > Ah, you wrote "either", so it seems you have tried that already.
>
> Yes exactly. Both patches are troublesome. Patch 2 causes a slightly diff=
erent
> null pointer dereference, in "dcache_clean_poc+0x20/0x38", as the stack t=
race I
> posted shows.

I have sent a new series where the last patch has a massive rework of
the cur_msg_mapped flag. Would be nice to see if it passes your tests.
The main idea there is to actually move to per transfer flag(s) from
per message one.

--=20
With Best Regards,
Andy Shevchenko

