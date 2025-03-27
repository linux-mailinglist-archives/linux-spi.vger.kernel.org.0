Return-Path: <linux-spi+bounces-7350-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C34CA73742
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 17:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6993A96BE
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC72214A98;
	Thu, 27 Mar 2025 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee/NDvK6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1A1494DF;
	Thu, 27 Mar 2025 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093939; cv=none; b=pX+AZM3Cvn7mYkaOiMPQunizp9dhS26BpH3WZJ+i472sdnJcK3lrVj3Ux84RmLVyClItqV8wxBsrCvSeO9yilSfPBv41qdBS/gN97NG0owmQB8TYfGQkz916B81XRqYelu0qackYJbDNfQ/aaHt04oLgT6waGOH5aMdqv7Ixs4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093939; c=relaxed/simple;
	bh=wF9ipZcNB/0eHsPWmPL1B2OKg5FK6fHZ9xznjO7EbCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lA4hH56o3rtB0At+lZWZSKcsoXCOblFeUqp+qDdlqagEGVPlTQaKRSenee85g3nDaLH7npQ1oZthc/NGX7u9aglfAVwciRLzZ8Jz1pbT+ApLjKe2L4c18KLjgwouARBTQJ0xsv7WKFNv/Va5ghDGBhzuUs2aFUKN12LJ/GL4I5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee/NDvK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197F5C4CEE5;
	Thu, 27 Mar 2025 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743093939;
	bh=wF9ipZcNB/0eHsPWmPL1B2OKg5FK6fHZ9xznjO7EbCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ee/NDvK626Bb1Uwbs4E2o9wZFY/lDaRZ9ubxJ2LqrUxRJv05QKJpPL29LjJyLY/6P
	 dHj8Niub6QEuZNQvjQXcwhFbZBnRGTyESUQ3sxsMQkOYaWq+FDkrcrOlTJ8I8lyul/
	 32fwtOxeZSNCDpQtmsZ4BZ/74bLr5WDE3tbPQ9I3vHpeEXOzb7dJYi9RzYQus8ehgS
	 IxOKP3EGHHVR4coLmVaOaLR92Ve20Ao9JxK/jMdOXTqHUreYkDK5YscR8nwr89sR/p
	 u4XZR41/eGeZH8cQv76pph6ery0ym0w9cCuAi6VTLgjb6CwGkTOu++qK82XIjoNuWc
	 pOEhT/pk2CkLA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c75830b455so680817fac.1;
        Thu, 27 Mar 2025 09:45:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHLPcBJ9S2GhZelzaGtxAewdDMHfMg3Uuj0ub+/WMEOexrmEfRwSejleahxEjZA63KhY1dbRWweMfLKx0=@vger.kernel.org, AJvYcCUQKGUDUbC2UwYyynfMTLY6Ta8CCwD3slb9b5tec/uTaQgbfBjXm8+AamF3ZhCDyWdsFebM+w7MkrU=@vger.kernel.org, AJvYcCVFrAkLFom7YdoQaj1vCNZjWSXKXR9x8OTnZJYZqkKOBE73NbRS+zcnozuh3VDIVXifKaOaMMQCHrbf@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzToYtL8jCnWYLCcKVzkR9iKHp3IeNFtNqcVBtKURv9Zc9mZP
	cbkNd6A9xze/ZajHZn7h6nUj8Q33AubOtRC+hZB9X5+/Ylxu899nhieOjqIHEYuoPd8pLbp21hr
	joat+a9oiGqRSmd9UaerOq8gu+Ec=
X-Google-Smtp-Source: AGHT+IEdHzMes6epfYuSawV3mY3iFmhRhmu87zpi8OHs6t+XHe19Js4YCvurVJX69p7//O4r9UNp+Qm5gzHXegJPAmE=
X-Received: by 2002:a05:6870:218f:b0:2c3:f8e3:bdb9 with SMTP id
 586e51a60fabf-2c84818f575mr2572277fac.28.1743093938185; Thu, 27 Mar 2025
 09:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317093445.361821-1-csokas.bence@prolan.hu>
 <20250317093445.361821-2-csokas.bence@prolan.hu> <CAJZ5v0hJZBxU6SSq9C8gp2peETFWu0jbhrM82B5GvQkVXPR+9Q@mail.gmail.com>
 <3e6d7071-1ba9-484c-9dcb-c5da6ad1ffe3@prolan.hu> <CAJZ5v0jka2r9PaKsF0FE2qJaFfnVNGd8sZRE6Aay-Ugpzot44w@mail.gmail.com>
 <d926d2c2-8cc9-4a71-b8ca-b5f03ac9afb8@prolan.hu> <CAJZ5v0iS20uPhqNOnkj36rTBGQF3fecF6Hq4JU4=wz4pSzrFyg@mail.gmail.com>
 <bcf363db-8fff-4fb1-b29e-300f7b8bc090@prolan.hu>
In-Reply-To: <bcf363db-8fff-4fb1-b29e-300f7b8bc090@prolan.hu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Mar 2025 17:45:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g2cjZwJYjd7Jt-dDDaxjCPwmkAzRZM1HDT4tod7RiUUw@mail.gmail.com>
X-Gm-Features: AQ5f1JpMAgH4hDdx8tpla6GgEclU1a-D6wPVXKpe8AogK9pUv3F-grNrK0it6P8
Message-ID: <CAJZ5v0g2cjZwJYjd7Jt-dDDaxjCPwmkAzRZM1HDT4tod7RiUUw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] pm: runtime: Add new devm functions
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Varshini Rajendran <varshini.rajendran@microchip.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexander Dahl <ada@thorsis.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Pavel Machek <pavel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 5:11=E2=80=AFPM Cs=C3=B3k=C3=A1s Bence <csokas.benc=
e@prolan.hu> wrote:
>
> Hi,
>
> On 2025. 03. 27. 15:14, Rafael J. Wysocki wrote:
> > /-- devm_pm_runtime_get_noresume()
> > |   /-- devm_{pm_runtime_set_active() + pm_runtime_enable() (in this or=
der)}
> > |   |   pm_runtime_use_autosuspend()
> > |   |
> > |   |   Note that the device cannot be suspended here unless its
> > runtime PM usage
> > |   |   counter is dropped, in which it would need to be bumped up
> > again later to
> > |   |   retain the balance.
> > |   |
> > |   \-> pm_runtime_disable() + pm_runtime_set_suspended() (in this orde=
r)
> > \-> pm_runtime_put_noidle()
>
> Ah, so basically what I've done originally, just calling
> `devm_pm_runtime_get_noresume()` _first_ instead of _last_, right?

Right.

If you want to use pm_runtime_get_noresume() to prevent the device
from suspending and you do that after enabling runtime PM for it, the
device may suspend between the "enable" and the "get_noresume".  Doing
the latter before the former prevents this race from occurring.

> > And pm_runtime_dont_use_autosuspend() is not really necessary after
> > disabling runtime PM.
>
> It was done this way in devm_pm_runtime_enable() already, see commit
> b4060db9251f ("PM: runtime: Have devm_pm_runtime_enable() handle
> pm_runtime_dont_use_autosuspend()"). I didn't change anything
> behaviourally there.

Yes, this is fine, although not really necessary.

> > Also, I think that the driver could be fixed without introducing the
> > new devm_ stuff which would be way simpler, so why don't you do that
> > and then think about devm_?
>
> Sure, I could quick-fix this, go through all the possible error paths
> and whatnot and ref-count in my head, but it doesn't fix the underlying
> problem: in order to properly use PM, you have to do a bunch of calls in
> some set order, then undo them in reverse order on error and remove --
> exactly the thing devm was designed for, and exactly the thing where
> it's easy for a human to forget one case by accident. Thus I prefer to
> use the *real* solution, devm.

Except that you need to enforce the proper initial ordering or you may
get undesirable results on the way out.

Say you call devm_pm_runtime_set_active() after
devm_pm_runtime_enable() by mistake.  It doesn't do anything, but
runtime PM may still work because the device gets resumed at one point
and if it has never been in a low-power state in the first place, the
"transition" may just be transparent.  On the way out, the cleanup
action for devm_pm_runtime_set_active() will run before the cleanup
action for devm_pm_runtime_enable() AFAICS and so it won't do anything
again, so the device's parent and suppliers (if any) may remain
reference-counted.

That's why I'm saying that it is better to combine
pm_runtime_set_active() with pm_runtime_enable() (in the right order)
in one devm_ call and define the cleanup action for it to run
pm_runtime_disable() before pm_runtime_set_suspended().  Then, the
mistake described above cannot be made.

