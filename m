Return-Path: <linux-spi+bounces-8367-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65864ACEB11
	for <lists+linux-spi@lfdr.de>; Thu,  5 Jun 2025 09:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA26B189B0EC
	for <lists+linux-spi@lfdr.de>; Thu,  5 Jun 2025 07:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551351991D2;
	Thu,  5 Jun 2025 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGPuRHe5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE8D195;
	Thu,  5 Jun 2025 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749109545; cv=none; b=TWJxmlzPHvc6XrxcnafuQ+2aGtgk8YbNhhKVsvjFsMadrncxGjpd5WDHI5TGEJVeST0uuJy42Y0ViEjz2GrTENfnNdoJY4tya8ooYcw8OdooI++KhqQ7uIS/GKrTFYFrJ8+KHeeuVTVcw9uZQKGWXLMuoKPkbvh2gG3HUTMGxV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749109545; c=relaxed/simple;
	bh=PjlNTKzwngQqNEBa3TbeQ0mzTtY1R9SNKZyGeEwznDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/kZ3P8GnhJMRcsPLSPIiVUpYicYVy/R7OJzlL2xR0Gcsa5pQ1dhQN6W+rY/PewjlHL0TB9/JeTGexajdsFu8fyRpa7MZd7I6iUqRK9sREndhAZiIYSlKVpEyBytDffyLbCTMUasq8L/iCZHnUpOqCEG/B0KLbGoz0uVVN/29M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGPuRHe5; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e2b601a6bso6919157b3.0;
        Thu, 05 Jun 2025 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749109542; x=1749714342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzdffW7bbYyaLyNz/ImY9z2KWcCazIf2IOAm//YVIGk=;
        b=kGPuRHe5olwqm4pca1ykV9yQIJyXsv2DfeMR0sV/SE5cV7nWuAZywo3L7eX4uvx++G
         zCPdCDScCRA3EdbJxFv+2eRJ23zNECOJXxHp2QhDupd7/runYWbUHL8/IchrBX+oxO/R
         pLjS0zY9RZtK7cvz6E1GMw8E3L7i0mWBx4mJvYp9kRxCc6YCQjDMiu3hYOttJj29iIT7
         thjeCzDspzpyxqFGPjgOEjaWE3hfi9Abrfa6wh94c9mgqSILaQIKvsZ+UI2dpjv74Wdw
         pe4tr8GSpsosErIEk8sE1EepzktlxqhzSSao/Rf51aHyAdZt3Bwq9jmRRgqpcL6GifwA
         dFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749109542; x=1749714342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzdffW7bbYyaLyNz/ImY9z2KWcCazIf2IOAm//YVIGk=;
        b=fR1ui7ugJbl2wv8d0ZD/Zx68VKRTqwiOwtb9WhP2i0iCGUBl2hg2iecVOmS7fMSNA/
         qi2TiO3wqnK9l3wAEdNBZ7q2XpOOexwEF/12694Gr6IPWI9EzmHNwiENpfUO76v8yNHJ
         RAFMj7dKZWMVVRipDcfZ4qAZ4ca+mbL4EIT4AFv4YqgNDst8N8nKVc95E4vYgDOXtr3m
         jGPnbPPGA1KJ1de2lpo96IFMPQmS8gbnSb58MCRGiWZjhWhcbnlhWOBDeuIq4VgAjzUd
         BKY5cpUxqii1iKFHCDuLSiEV66w73sILwiaKdrsyYoeRDop2TnVKoxE1pDmbi7C8HRDG
         hFZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6Mp6Y6mfrkQ9HRrnzBnFrhOvOlzoXOgME/aKKBdxxQ4T1Owfxteqn+7wZD3ruQ31ER6/BWckU0+nr@vger.kernel.org, AJvYcCW0t5eSm1f7Z8/q6F7AbHEZOF8TDievq0hjv9VbDVt86RV83v71AEIn/6u6moAN4DD0OAvyJs3lsP+W1/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxtGBuRRYUJU5Fnk6r1RHhOJ0Xo3NsrPjI7AnmkMwlDDtgs9Zy
	Br/OYWt2H6W9+z2C61s0DkoXCmqa47lBVsDcD6eNkW7aqVDqriFvheKh9iK1p6Sf2WK3ulFGIWO
	DPRknO8DToWkpBdCNH4f+Y1khLOGkcso=
X-Gm-Gg: ASbGncvdO2ZChhOfp/M1ToW4z1QcJUfIX0g0gV8Fbe4FUbfZ1BDOcSTGBvaET4oKwJo
	mUwnhtDhL4Kjz97jH39KmwrWQtxwYYNWOsqtAjxhuJJ2nib1BDGT2/crZqaCNc7ke5fTW8EKInP
	X2kd2lWJ9WbeZXiy3QW8aswDJ/52E0bY4=
X-Google-Smtp-Source: AGHT+IE0oww02nur6cCoeFmiqTdCDIBv8Z6wvA3Kmn01B2U7GulLjWjewIGmh/gv/aYnH1VfsT5WU3cX8kgF4m2M2bE=
X-Received: by 2002:a05:690c:6c07:b0:70e:272c:95ae with SMTP id
 00721157ae682-710d9b47619mr86616607b3.32.1749109542647; Thu, 05 Jun 2025
 00:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529130915.2519590-1-noltari@gmail.com> <83e59280261ad0769dd7e9f6135656c795836878.camel@pengutronix.de>
In-Reply-To: <83e59280261ad0769dd7e9f6135656c795836878.camel@pengutronix.de>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 5 Jun 2025 09:45:30 +0200
X-Gm-Features: AX0GCFsJCMU5XEm5qbA7gX2LCkkPq9rMz7qNnuLHOCLZ_E__S4YZ82wsdUpMrds
Message-ID: <CAOiHx=kFvXoPwes4AXsysxLz7ZgGzae2FayGw=BAgbaqfJ_Ukw@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm63xx: fix shared reset
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	dgcbueu@gmail.com, florian.fainelli@broadcom.com, william.zhang@broadcom.com, 
	kursad.oney@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	broonie@kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 11:31=E2=80=AFAM Philipp Zabel <p.zabel@pengutronix.=
de> wrote:
>
> On Do, 2025-05-29 at 15:09 +0200, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > Some bmips SoCs (bcm6362, bcm63268) share the same SPI reset for both S=
PI and
> > HSSPI controllers, so reset shouldn't be exclusive.
> >
> > =C3=81lvaro Fern=C3=A1ndez Rojas (2):
> >   spi: bcm63xx-spi: fix shared reset
>
> Both drivers currently enable the SPI clock before triggering a reset.
> Can the hardware cope with being reset before the clock is enabled?
> That could happen for the second device to be bound [1], unless the SPI
> clock is shared as well or already running for another reason.
>
> [1] https://docs.kernel.org/driver-api/reset.html#triggering

In a completely unscientific test, I disabled both SPI clocks and
triggered the reset, and the hardware didn't seem to mind. It also
didn't seem to have any observable effect, as all registers I checked
kept their previous values (both with and without clocks enabled).
Neither disabling the clocks nor asserting the reset prevented my from
reading the registers of either block, so their effects seem to be
rather limited.

That being said, the bootloader (in the one device I tested) seems to
keep both clocks enabled, so they would still both be enabled during
the reset of whichever is probed first.

Regards,
Jonas

