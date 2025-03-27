Return-Path: <linux-spi+bounces-7343-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A20AA73426
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 15:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0D77A2458
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD33217666;
	Thu, 27 Mar 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPBGvvbO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B62F30;
	Thu, 27 Mar 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743084875; cv=none; b=IG9WwDq7MV+daBPZFiyRZa3GYVVDeAsP6zm5LDsMs2BFJZpdCQmTXdrfMPmp8NGZq2DNG0OgG8hcfdiRih9ZSvbNHPNeU08Tm73cnwqj9JbMXmU5Cv1hUcQiOnX2J08SXfruNwCQ/pFyVjxa+IFaZ930oPZ9OkggwoFC+fjDQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743084875; c=relaxed/simple;
	bh=w4Ot+NJ1fIKId9/UtayH+CL2iXIxeOMvWpD9ZyZebd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyiEdh94GHan8sAGioY39wqf9hhz0B8xeDmB2FeU2XBr2pxxjhMDq+QyJKRvltCZdyZfwaUUTGvdy5M1re1OZ9Fou3k1CWDDiP4fBLKxSbkrViapwrbAu8QqOOJ9Q02FT69kTcUMY24mulndADMaskdtaiRngBM9OgP9YL6HmuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPBGvvbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E192AC4CEE8;
	Thu, 27 Mar 2025 14:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743084874;
	bh=w4Ot+NJ1fIKId9/UtayH+CL2iXIxeOMvWpD9ZyZebd8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qPBGvvbOGqHHShLX8F9C4g/cKbUmTbutuWRAWAUycsmrAfTWEZi0ts/CoaFtJRFeQ
	 rBMNVZmn6ZTRyxeNQj+56TgLPjKt01Qw5jvnEMPiXxFAI2MyKlEz/2UloLoTq1Snur
	 7zkuQ1xSoH+igpsP0lbuq2F4SoF7xxs7XchKHntF4WhME1jiljar0hauKLsU6rcynL
	 EdtJyk//oD9vLvxdOxNCz1U+oxUQBu1MQoXq2wgz1GHrdO2Qs0Fl6TtYCjWdDqwRY5
	 SnnK9wpGL3yUnxuywctYmnnZH/anK/U1lzEreY2qX4c28uMVRGnCBrcq93qW9nastT
	 oAVr9QRmWTxwg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2c81fffd523so314834fac.0;
        Thu, 27 Mar 2025 07:14:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoxd0DBmZrKw0ADDBgVoEUWYm6G8Q1N044t03BIsUFjGb/lWKqg2mg7XLsgLPyM9i43ychXoyvBoQo@vger.kernel.org, AJvYcCWF1LVoSkHNJACw7yuDr/C84seoSSUeCHQN2KyHBmRIGAFK0tsUsVwR75sG53faK4q/EDNmhvzq0e9vHus=@vger.kernel.org, AJvYcCWpXI8MlYcVT5xGIFPOBS6k1oLKrz5lZVjqhHAVz9tpc5We8DE1amQ/EHBvaXKA8rjKaccUJ3pyZY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOc0oFNYHgXAY28OoxRjEzftnl4Eli8lqZkWYfhDnYX5usJ1jb
	0/mQnxkW7J6IJcMxM+37SP9bHfCtA0gvVga5gPpmc6DlsYv2MjpAEGrOVUCOQpKySEhS8v5xBuK
	eprq4ZgCPGVKEjtqY2/IqCQAjUh8=
X-Google-Smtp-Source: AGHT+IH2NiX8CmCRjkXpYJdSzQ4DKgyG9QmT+eImwWOwgFfr6VV2oODH1uFOd2mQAceOPDnob8QqR5e86hHjoIxI1Co=
X-Received: by 2002:a05:6870:aa91:b0:29e:2caf:8cc with SMTP id
 586e51a60fabf-2c84823c035mr2075911fac.37.1743084874119; Thu, 27 Mar 2025
 07:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317093445.361821-1-csokas.bence@prolan.hu>
 <20250317093445.361821-2-csokas.bence@prolan.hu> <CAJZ5v0hJZBxU6SSq9C8gp2peETFWu0jbhrM82B5GvQkVXPR+9Q@mail.gmail.com>
 <3e6d7071-1ba9-484c-9dcb-c5da6ad1ffe3@prolan.hu> <CAJZ5v0jka2r9PaKsF0FE2qJaFfnVNGd8sZRE6Aay-Ugpzot44w@mail.gmail.com>
 <d926d2c2-8cc9-4a71-b8ca-b5f03ac9afb8@prolan.hu>
In-Reply-To: <d926d2c2-8cc9-4a71-b8ca-b5f03ac9afb8@prolan.hu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Mar 2025 15:14:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iS20uPhqNOnkj36rTBGQF3fecF6Hq4JU4=wz4pSzrFyg@mail.gmail.com>
X-Gm-Features: AQ5f1Jrkvob9yUT0LQxY3y65ur_Gm5qICTEtJi93M14j4zS-Z_SGAwa0jOwyHms
Message-ID: <CAJZ5v0iS20uPhqNOnkj36rTBGQF3fecF6Hq4JU4=wz4pSzrFyg@mail.gmail.com>
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

On Thu, Mar 27, 2025 at 2:24=E2=80=AFPM Cs=C3=B3k=C3=A1s Bence <csokas.benc=
e@prolan.hu> wrote:
>
> Hi,
>
> On 2025. 03. 27. 12:08, Rafael J. Wysocki wrote:
> >>> Now, there is a reason why calling pm_runtime_set_suspended() on a
> >>> device after disabling runtime PM for it is a good idea at all.
> >>> Namely, disabling runtime PM alone does not release the device's
> >>> suppliers or its parent, so if you want to release them after
> >>> disabling runtime PM for the device, you need to do something more.
> >>> I'm thinking that this is a  mistake in the design of the runtime PM
> >>> core.
> >>
> >> Well, this is the order in which the original driver worked before
> >> anyways. As a quick fix, would it work if we created a devm function
> >> that would pm_runtime_set_active(), immediately followed by
> >> pm_runtime_enable(), and on cleanup it would pm_runtime_set_suspended(=
)
> >> followed by pm_runtime_disable_action() (i.e.
> >> pm_runtime_dont_use_autosuspend() and pm_runtime_disable())?
> >
> > On cleanup you'd need to ensure that pm_runtime_disable() is followed
> > by pm_runtime_set_suspended() (not the other way around).  Also
> > pm_runtime_dont_use_autosuspend() needs to be called when runtime PM
> > is still enabled.
> >
> > With the above taken into account, it would work.
>
> Ok, so which is the correct order then?
>
> 1. the way it is done now in [PATCH v5 2/2] (which is the same order the
> driver has been using before anyways):
>
>      pm_runtime_use_autosuspend()
> /-- devm_pm_runtime_set_active()
> |   /-- devm_pm_runtime_enable()
> |   |   /-- devm_pm_runtime_get_noresume()
> |   |   |
> |   |   \-> pm_runtime_put_noidle()
> |   \-> pm_runtime_dont_use_autosuspend() &&
> |       pm_runtime_disable()
> \-> pm_runtime_set_suspended()
>
> or,
> 2. swapped set_suspended() and runtime_disable()
>
>      pm_runtime_use_autosuspend()
> /-- devm_pm_runtime_set_active_enabled() [new fn]
> |    =3D=3D pm_runtime_set_active() &&
> |       pm_runtime_enable()
> |   /-- devm_pm_runtime_get_noresume()
> |   |
> |   \-> pm_runtime_put_noidle()
> \--> pm_runtime_set_suspended()
>       pm_runtime_dont_use_autosuspend()
>       pm_runtime_disable()

/-- devm_pm_runtime_get_noresume()
|   /-- devm_{pm_runtime_set_active() + pm_runtime_enable() (in this order)=
}
|   |   pm_runtime_use_autosuspend()
|   |
|   |   Note that the device cannot be suspended here unless its
runtime PM usage
|   |   counter is dropped, in which it would need to be bumped up
again later to
|   |   retain the balance.
|   |
|   \-> pm_runtime_disable() + pm_runtime_set_suspended() (in this order)
\-> pm_runtime_put_noidle()

And pm_runtime_dont_use_autosuspend() is not really necessary after
disabling runtime PM.

Also, I think that the driver could be fixed without introducing the
new devm_ stuff which would be way simpler, so why don't you do that
and then think about devm_?

