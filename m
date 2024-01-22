Return-Path: <linux-spi+bounces-547-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D73B6835965
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 03:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E481C218C9
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 02:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E57365;
	Mon, 22 Jan 2024 02:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wSy0ow6p"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4EC2103
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705890867; cv=none; b=VFiPIWvwttAM7HsFWQBeewhbDTzU99+8D+JjDy5hrBpz6Z0fW8ke4+WGOOxufK4/bC6PYo/Dx6gWhYNwSGSAGEcBS3Q3T+3OucIEeoFVMCNX3vkr+HfD5FYzBK4x2HBqyJR3lR8mowYQEIPoe5fsvAPCPPD2+ieYBUUV2BELNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705890867; c=relaxed/simple;
	bh=Jc1vxH9oElnpYYtlCK7aPj6/1Y2UfDuvd4ovdGY5mNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gse6G1Y5jhUx6aT+GKR99eDZjApEoETGV3GRQs3APC08gN4Rz/6nwti78kX8o0nPw6uh1EXZ1btGxR64XfjpSiFGs0O90968GcT7yi6ljvb4HSEuYLyVi8oddze6vSxVElw4ZbT9aZOhu5vSrnLGhTCH0i+B3dr7A3GOLBtmssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wSy0ow6p; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29051f5d5e8so781421a91.0
        for <linux-spi@vger.kernel.org>; Sun, 21 Jan 2024 18:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705890865; x=1706495665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vE1OY1qe3mhwG3BkJPXvoUEM/xApQQR5+v8JigF8XJ4=;
        b=wSy0ow6pMBG1PJ96oGCgB0n7d951I/MC6wwoexJbX7kXQ8yudJDjb0Qml6M/1bfIg6
         7jBQMRxasA0efHXw0Q3iEXInc8LGUQ8ANIwEUoF7mC2O3eR8sejIjKsYc0cEmzJyiV5z
         aT1QjyB52rKR5JYzrggAgOT1jSMgdLMQY56pbBOwHAA3sVt4+HhKOOlz1qa+4KUFcPK7
         jed5mRU1vVvtQqvYZ8ul7otOHL5r9/xXGscQ1OCUF8B8FzRmefP8xk4WFiTFspLZstRE
         h05LER4ZyhkBrY5linJ8UhF1CS5x0AtkQ6OiBVQW/93oYmjV1OgajXbVfKr4fK+KGU0z
         ZFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705890865; x=1706495665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE1OY1qe3mhwG3BkJPXvoUEM/xApQQR5+v8JigF8XJ4=;
        b=i3vjx84ZGAKjlbHFh7T+gAxzDi1JWZJxG4EqFUKWrFm2x1DOkw9XrMp+ttIEAHdMzE
         5rgT0R0SN61zJlgEqDbcdUcA7gBULPCnJsNWHorBJU9mBRI0Zl9I+byY2S/REhlJAnAR
         Vr6uKW7/haeJgBaUUffJj3QkYRQqQc2QdOdtjC2x3mn8VhyUYE9O4wj/6KvUxu1sv0Sr
         RKC959DCMtQmYKDfcFdpRbhPHrmLt13iLwk+HHlgDu+hOCQhYQ9kNkJVeKcIgccaZvDg
         TO4DpQc4kU4TwbY/YtlfIu7UmNmRs1MFsiF3cLxYPCZVwrTtMbKcioGp3hSjbSOohTZu
         mMng==
X-Gm-Message-State: AOJu0YzsSeyZKogZfQaKcSxXGz4rHRmE2iwokzwVwfd2Wm5fc7LPuLNI
	l+2vNQT5Z4UXeJjJJ0cijB1RXRXsMl+frZCo35wrscsU1B9gKzr4Oowg+i/02rV+ua5rt0D9eqr
	vc5hKtLNbSigQ6pfgr1cWYYDV6FAJjQDoHpNB4A==
X-Google-Smtp-Source: AGHT+IHCreYFnEMtKrczTac/Lwewh8HBY/ndr1dl8NJfk9RxD/OaoribK0R4KjkkTDzQC+jMTlk16xwW4YFwr8oPLcw=
X-Received: by 2002:a17:90a:d082:b0:290:620d:b432 with SMTP id
 k2-20020a17090ad08200b00290620db432mr738532pju.41.1705890865679; Sun, 21 Jan
 2024 18:34:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120170001.3356-1-semen.protsenko@linaro.org>
 <k5ih3vurmzrirgfzy62r5nezm2sxp3zf2qa2bhzowybthkvduv@wjywn55v5hmj>
 <CAPLW+4nJKt4xNxXbqQ=c5rXCEau56Xd9ocNKqcuHLo7+-CH8-g@mail.gmail.com> <gmj7lfno4qcxwk7qimnsnostvjah72fbgcstcykly6nkzqrtjo@2ck2ny3ifqqw>
In-Reply-To: <gmj7lfno4qcxwk7qimnsnostvjah72fbgcstcykly6nkzqrtjo@2ck2ny3ifqqw>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sun, 21 Jan 2024 20:34:14 -0600
Message-ID: <CAPLW+4m-GPmF6w=Dgb_WbJ0B2ynRSRRC+ijY4Zym5i5BJe4eBw@mail.gmail.com>
Subject: Re: [PATCH] spi: s3c64xx: Extract FIFO depth calculation to a
 dedicated macro
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 5:27=E2=80=AFPM Andi Shyti <andi.shyti@kernel.org> =
wrote:
>
> Hi Sam,
>
> On Sun, Jan 21, 2024 at 04:11:21PM -0600, Sam Protsenko wrote:
> > On Sun, Jan 21, 2024 at 2:24=E2=80=AFPM Andi Shyti <andi.shyti@kernel.o=
rg> wrote:
> > >
> > > Hi Sam,
> > >
> > > >       void __iomem *regs =3D sdd->regs;
> > > >       unsigned long val =3D 1;
> > > >       u32 status;
> > > > -
> > > > -     /* max fifo depth available */
> > > > -     u32 max_fifo =3D (FIFO_LVL_MASK(sdd) >> 1) + 1;
> > > > +     u32 max_fifo =3D FIFO_DEPTH(sdd);
> > >
> > > Why have you removed the comment? Perhaps you could place it on
> > > the side in order to remove that awful space.
> > >
> >
> > The fact that `max_fifo' contains max FIFO depth is already coded in
> > the variable name itself. And with that new FIFO_DEPTH() macro, it
> > would be basically stating the same thing the third time on the same
> > string. Thought the removal of that comment only made the code easier
> > to read. If you think I should bring the comment back, please let me
> > know and I'll send v2.
>
> No, that's fine... you have a point here :-)
>

Thanks for the review! :)

> Andi

