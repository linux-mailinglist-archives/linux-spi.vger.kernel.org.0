Return-Path: <linux-spi+bounces-4328-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E00B95FF7D
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 05:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E87E6B22712
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 03:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D263118030;
	Tue, 27 Aug 2024 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oe4MJlZs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106CC4C83
	for <linux-spi@vger.kernel.org>; Tue, 27 Aug 2024 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727612; cv=none; b=XkdpdDF/qzZDal5ik3WEcoU7Bq+iIlYUmuG0g5ARvldz+09XfWUIwapOtUz0KuNJil4Br1gW4owLqj+arOa7HYAEgGE3MnRC94E7tVwtEvLg2a7zCfsM0h39/diKF7ITIWvTzKbYRrHUNePfUw4GvHDCz9hJuv3+B4g7RVv1UG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727612; c=relaxed/simple;
	bh=PesMy6+ZaljaMwUP3eDOzaceYGNPFc9NY5RXT3Ln9yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmn6mplLqzjpIVtIMnUUAlLDjb4Qjn7NqG4IHkw2N8mSVFoAFsfkQG7so96/t6ivRZLboFhXUWFo6jdS0/yXwwc/Fz6biIwhXPi38GSMTUY2zYat9O+eWX9bTjpMsMg+pNf3P5MYtrWgzEq+iZXZCPG8QdiKUFsZaOENvP7KUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oe4MJlZs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20230059241so40523275ad.3
        for <linux-spi@vger.kernel.org>; Mon, 26 Aug 2024 20:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724727610; x=1725332410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PesMy6+ZaljaMwUP3eDOzaceYGNPFc9NY5RXT3Ln9yg=;
        b=oe4MJlZsFs4bw91l7Rz8cnatwTM27HVaWXBxOXzlIESpwOgcFcvFC+zIExASWCaqwF
         ZzmzW3ISCi4zGOWUwZ3/Ybkw1N2lgDU5nmPmvo+9yldXYItjwlVE94/k/5udPm4vEQPh
         CKFb2RJcw0Ndre2SHWW8gGALJGOVY2CXTvVDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724727610; x=1725332410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PesMy6+ZaljaMwUP3eDOzaceYGNPFc9NY5RXT3Ln9yg=;
        b=hX/R47QPPpPgmnbWJzW2sbWq5UBeGcTVt2bLsRWuyXz1Fn9T/FwcbrNZZd0RP4Ayux
         CmAIW1Ztvu+ni4jBI6Ba8amYQSoV8/Ed1ORsUXKqVX5Gh8pP3FH/hb80s2VHn64CZa2p
         jmfqedOjjvuLXN509JDSm6f+eQxabVUgxAzovrMd0SoY3fnQIDSZ8DZgBE6seI2WtyGO
         A9vvmhEzdzhwkz97DWEAzkJwIfQ6svMTaguLe4iRw+NARztKKXz+XI/xc6xrl1HCnPs0
         4ha+F/u+YOExcHdjKfh82cW5VltgVQBfymIEPf17Lg8Gqtn3rW/szEWiwIl3M+U/9pSM
         ReEA==
X-Forwarded-Encrypted: i=1; AJvYcCUCiLEzs0IqOaCitGsfOpJ+BfwL2IWt+Hnqw2riE48WZOAt3oep5JQCa8SQfMaQa7I//B41/0o/reg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcDkjPnqUxBj5j4t5DflpgXvu5TY+x70i4JFumDUJxCTiMcY5V
	XeY1OFY2UX2PuIwVCnv8sDKrebLKB+SWzMU9Vq7RZCNyVC6Rp7lPkDZdpjCUP1uV3QLLQafhVns
	=
X-Google-Smtp-Source: AGHT+IEb0GbQBWS83a4fgrliDlU0XqPIGl8a0nC42uIOtl7NKWCg+VwKLewtMNp2gqlSiy9n54EaHA==
X-Received: by 2002:a17:902:da87:b0:202:18de:b419 with SMTP id d9443c01a7336-2039e544ea3mr98598755ad.63.1724727608700;
        Mon, 26 Aug 2024 20:00:08 -0700 (PDT)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com. [209.85.214.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dd985sm74404115ad.164.2024.08.26.20.00.08
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 20:00:08 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20260346ca1so106995ad.0
        for <linux-spi@vger.kernel.org>; Mon, 26 Aug 2024 20:00:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVq65oqfbPhZvyGKBtWfS0P+KHeDAiZfSmPJYh9I8L8LcOF3FojiuC3mH6VQIxSzmhO5yczpxsK5XA=@vger.kernel.org
X-Received: by 2002:a17:903:187:b0:1fb:1a7:a64f with SMTP id
 d9443c01a7336-204e1351fa3mr1790775ad.20.1724727606755; Mon, 26 Aug 2024
 20:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825035422.900370-1-jon.lin@rock-chips.com>
 <Zs0BRsNdZdI69aXM@google.com> <27302919-5bcd-4bcd-bdad-02aa48e628e9@rock-chips.com>
In-Reply-To: <27302919-5bcd-4bcd-bdad-02aa48e628e9@rock-chips.com>
From: Brian Norris <briannorris@chromium.org>
Date: Mon, 26 Aug 2024 19:59:53 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMjN7dVUQWgfMULcD2KgF448-q=Ue2+MYUftK6Ra8MWhw@mail.gmail.com>
Message-ID: <CA+ASDXMjN7dVUQWgfMULcD2KgF448-q=Ue2+MYUftK6Ra8MWhw@mail.gmail.com>
Subject: Re: [PATCH] spi: rockchip: Avoid redundant clock disable in pm operation
To: Jon Lin <jon.lin@rock-chips.com>
Cc: broonie@kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, heiko@sntech.de, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 6:33=E2=80=AFPM Jon Lin <jon.lin@rock-chips.com> wr=
ote:
> On 2024/8/27 6:27, Brian Norris wrote:
> > It seems like you'd really be served well by
> > pm_runtime_force_{suspend,resume}() here, and in fact, that's what this
> > driver used to use before the breaking change (commit
> > e882575efc77). Why aren't you just going back to using it? (This is the
> > kind of thing I might expect in your commit message -- reasoning as to
> > why you're doing what you're doing.)
> >
> > And in fact, I already submitted a patch that resolves the above proble=
m
> > and does exactly that:
> >
> > https://lore.kernel.org/all/20240823214235.1718769-1-briannorris@chromi=
um.org/
> > [PATCH] spi: rockchip: Resolve unbalanced runtime PM / system PM handli=
ng
> >
> > Do you see any problem with it?
> >
>
> I have reviewed your submission and although the code has been
> simplified, the execution efficiency has decreased. So although it is a
> commonly used processing solution for SPI Upstream, I still hope to
> retain a more efficiency approach as I submitted.

What do you mean by "efficiency"? You mean because there's
indirection, via the PM runtime framework? If so, I doubt that's a
priority for this piece of functionality -- simplicity is more
important than a function call or two when talking about system
suspend.

Additionally, simplicity has additional benefits -- it heads off
questions that your more complex code doesn't address. For example,
are runtime PM and system PM mutually exclusive? Do we have to
coordinate with any pending autosuspend? (Reading through
https://docs.kernel.org/power/runtime_pm.html, I believe these are not
actually concerns, but it's really not obvious and takes a bit of
reading.) But your patch makes it more likely that runtime and system
PM states get out of sync.

Anyway, if the patches really are equivalent, I suppose it can be the
maintainer's choice as to which is preferable.

Brian

