Return-Path: <linux-spi+bounces-7340-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB9A72E88
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 12:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3AF7A6716
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 11:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DACD20FAB6;
	Thu, 27 Mar 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyIYuwq9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAC120FAA9;
	Thu, 27 Mar 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073731; cv=none; b=oBrqRtLImmlNGtQVnmMTQQuxbn9FsmtMW8OITR4oGiUvkCk1nJvq5g5qVwA/ywRmmN41G5mIoKiXMRUmpRggAdnO7m0RyKV6YeOXAEs+YYlanIfpHzkVTCGJ71A4urRd0OTZZPkjrwQGAksb57v6VoYtTRVc1hO2ud15zEJrX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073731; c=relaxed/simple;
	bh=T/C1IUzTPhJ0AN1d10OTPlRbro4QgLVWrO1x971kKwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn9rhxBvHw9MTG4rnUGLZoj3v/8+kz52LEAnsMprrSRZHlSX/ydRDUGp1sjAPDyrQl9kOz/LVyald9p2yOxyhrvRZYL7gggq7iBXo7OWDcywc/unTjvIG9/uG4BXqZHl849WthB+kHtI+XZRw9J/AUpYpw+C3Dq6kVEMLnVLhuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyIYuwq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A43C4CEEA;
	Thu, 27 Mar 2025 11:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743073730;
	bh=T/C1IUzTPhJ0AN1d10OTPlRbro4QgLVWrO1x971kKwc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NyIYuwq92qkpapnL1++RMaYr29mPEFFyI9WshKXFK9pLSq4lxwFq42yWJOufZ6zLR
	 fVPRSAHkfDsKTmttLhgeL3SkJ3HvdoQRyR8+Ktkj2dHQ2RS9tEmrtrMPYYMBDJCxLX
	 Ad/+IFymViK6TuMRCpqKIWVXX17RK9vQ3Dzv6Ij6aH7m1++NMJPQzcaYFzZ9hQ/bua
	 cpO5UV1B9i07C0iyZJJGk8IjTePBYgzNYzgsh/gjqGQdJZh9CF8L/QbTGIvAflcKVk
	 9X7NOUWLUTVT18Infp5WvNgmmaFB7sRbCWsOlbncGD7sVGAQAKkZSZDsZgqMxzd1+8
	 7+DHZkNDF9HbQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-602513d2201so454873eaf.0;
        Thu, 27 Mar 2025 04:08:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2QXQ5r1UrSDJUqeNGFNbGlonu6Ra+wn8IKm80LmTtsNE2skikeMN/z8GQMFimsuL8S0JL1rbNugRHzh0=@vger.kernel.org, AJvYcCX3j3i30O78ayRO49corQsjZ/fwrV1khhnLnuypTEcb7aTLUR/NMlNQl2QaxPuUbxWgkA2ovzcA2Ikp@vger.kernel.org, AJvYcCXlPWrz9MvoZMPsnEAxfGddNKVPTx+mShQWBL54B9oJFdsbY+7ofW1w9yy7pjRByjjyqm9JYdUd6X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/CJthQu4tmrT3FpqfmnZ6yjph/afb2WyWhEsDMcaC9Izldg2
	p/NUtpNgFRfcZHwsJLvJBfIN8mPB3erMuCylUjuA9n5a6gU+9Ib0KZUuyDk4f0ci/hJZyeicB1K
	IMPVo2/yDIMduOK9SVR+py5UNxl0=
X-Google-Smtp-Source: AGHT+IEzurn8PX84DTZbLqJSvwaaZ/eB8XCLr0efqELPQTTYzC0Yup16jliPriSvS/8iQ71yl9XaN5ogWrNYP+wzo1I=
X-Received: by 2002:a05:6870:391e:b0:29e:6394:fd4a with SMTP id
 586e51a60fabf-2c847f04c10mr1532382fac.2.1743073730142; Thu, 27 Mar 2025
 04:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317093445.361821-1-csokas.bence@prolan.hu>
 <20250317093445.361821-2-csokas.bence@prolan.hu> <CAJZ5v0hJZBxU6SSq9C8gp2peETFWu0jbhrM82B5GvQkVXPR+9Q@mail.gmail.com>
 <3e6d7071-1ba9-484c-9dcb-c5da6ad1ffe3@prolan.hu>
In-Reply-To: <3e6d7071-1ba9-484c-9dcb-c5da6ad1ffe3@prolan.hu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Mar 2025 12:08:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jka2r9PaKsF0FE2qJaFfnVNGd8sZRE6Aay-Ugpzot44w@mail.gmail.com>
X-Gm-Features: AQ5f1JpUPqZNN73veAwvZFBlgl93lXp6y3hqKwdnBmubsLfvOeNP8EFhQHFKtCM
Message-ID: <CAJZ5v0jka2r9PaKsF0FE2qJaFfnVNGd8sZRE6Aay-Ugpzot44w@mail.gmail.com>
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

On Thu, Mar 27, 2025 at 10:02=E2=80=AFAM Cs=C3=B3k=C3=A1s Bence <csokas.ben=
ce@prolan.hu> wrote:
>
> Hi,
>
> On 2025. 03. 26. 18:38, Rafael J. Wysocki wrote:
> > I said I didn't like it and I'm still not liking it.
>
> You didn't really elaborate further, but now I'm glad I could understand
> your dislike.
>
> > The problem is that the primary role of pm_runtime_set_active() is to
> > prepare the device for enabling runtime PM, so in the majority of
> > cases it should be followed by pm_runtime_enable().  It is also not
> > always necessary to call pm_runtime_set_suspended() after disabling
> > runtime PM for a device, like when the device has been
> > runtime-suspended before disabling runtime PM for it.  This is not
> > like releasing a resource that has been allocated and using devm for
> > it in the above way is at least questionable.
> >
> > Now, there is a reason why calling pm_runtime_set_suspended() on a
> > device after disabling runtime PM for it is a good idea at all.
> > Namely, disabling runtime PM alone does not release the device's
> > suppliers or its parent, so if you want to release them after
> > disabling runtime PM for the device, you need to do something more.
> > I'm thinking that this is a  mistake in the design of the runtime PM
> > core.
>
> Well, this is the order in which the original driver worked before
> anyways. As a quick fix, would it work if we created a devm function
> that would pm_runtime_set_active(), immediately followed by
> pm_runtime_enable(), and on cleanup it would pm_runtime_set_suspended()
> followed by pm_runtime_disable_action() (i.e.
> pm_runtime_dont_use_autosuspend() and pm_runtime_disable())?

On cleanup you'd need to ensure that pm_runtime_disable() is followed
by pm_runtime_set_suspended() (not the other way around).  Also
pm_runtime_dont_use_autosuspend() needs to be called when runtime PM
is still enabled.

With the above taken into account, it would work.

