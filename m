Return-Path: <linux-spi+bounces-11312-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C31C6E610
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 13:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5E7E4E07D4
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 12:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F22286D7D;
	Wed, 19 Nov 2025 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bPZ0tQim"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C10A34DB62
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763554115; cv=none; b=NLi0iuPtg6SEvajR0OwBMwh2By/XNRh0+JOjykfN4dsMeNCCkyY4m5RTRB4JmVIaIWkZRpiyU0aIcZFlt6/RJbbNY6y6lcHUX890C1HmLp0d68cunj9jQg7tKtda/973bhaLq2mzFq02LED6uMyVKsrGvTzKUwz540dkbitSpys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763554115; c=relaxed/simple;
	bh=Wz22VNw2koGqXzDFonKTJXftJJ4grDjQU40zXPDvokE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9wcJFjqxMPZaYoCor0gC7AI7YM5x9ETIZHG8ranceXNZnfJjJZAhXbOwZO8p8uaJab18TFT+8lOPibWL86xP6uUS7JI/cKN70QZvBjkEBMK8DGmJLow7n+AJIA6QKALQG28of8tWjC6zfXFxgmBRtF+2w3WpI9nmpug4Qb97Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bPZ0tQim; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5959da48139so1115483e87.1
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 04:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763554110; x=1764158910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewpfEurHKI2PvmBBBNex6EdDDdQ+CHyaRtPaFhGL58c=;
        b=bPZ0tQimRxYS0KttpsMDNJjOxaczScgdW+WONGZB9ML5bBJJkMv7bpkEeBoi0EjG7o
         9qG4in33emt/xX9jZyQXOXYzD+/CfZMps8dhawqWGaMRUKYr4MXvRjFqTflkK0Qj0wCg
         uVgW0nqU2SQbUNISd4K5ywrb6LmL+iPZkZUNiMXjQDOd3XjVnkLH6wpcIW0mA5dzPPIx
         CnpCg7DmoPETYOnl5B6TtjRI2dssrp1Kic5lL6JlTl9frcMWJiziIn/uu1XmOyUkUwFC
         b88wV6wgPHJzVdAijwOW4gVTA5QU0kSYX9efyIx+iZUzjdEZhytkKeoc7a3gooDvo8hj
         VMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763554110; x=1764158910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ewpfEurHKI2PvmBBBNex6EdDDdQ+CHyaRtPaFhGL58c=;
        b=Wt2t0AJrLvPtZYLh9cwVFjMqwA0yIm3qXw97UMU1Teenm8TJjfZhqJnNUOpUQXOP6d
         IHDJmxfeqwHjKNmeNIRkYwDQA5DunOYnCRSsD5XNcCU7PT5EjbSShBOXB2OadSDjpiAL
         gGrrvQdp28hHNe3KCtVJax/0tOtq5RsuzGE+DsQAi+r8MpJ5XTudvLhd1ATjmC6F6okM
         5BapBayvRkBDxbJHkKZ8XNfP1HJ04Nuu2xM+iwaQLnqTQpAgPBU/9sScZIXfCcY8gYFC
         VwpQrQ8yyan7cf33fOph9DOXJoxLvmO+XW1kMhAuozdwtNiR5WiFiehz3HHi9GBSUbPr
         r8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCV6sdbrfifjK5TJKWm5ZyQXrLKJm1zcXNhRb/1oCI16xATAgnD344/kn0A+yieAEc+HBsokE+h7f3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOi2NbDT8dtdukQerwIqpSmSx1qXd6A2+BJiuMVSszw7umBwIK
	PiWXGxnxU5e9V2h8uDYKqKcGAX63FBh3zRlBvyyWhphjv1cGUDwoDgKF3HpDCIB0MaXlHkm3cbn
	013toWOn0RobudMwOQVgD4V6opuu3YBw0SVjYxnixkQ==
X-Gm-Gg: ASbGnctxwOdyuMJL3fRct1vcQ9HTCBPSuGB2yl/LVWplIje4hy3Ix8cZhKcIkwRslpS
	pXsZDz/jk+Akdx/2yCNWKiTTgbNPDR8auKh2h+e1MAlAEpQWPAAS6Su1SIyAS9k7KVWhdd5zb+V
	UbAnjqQXm/hJ0+RyQjWMkm9uFKXzCfyumvxCjJ7i5x/uxFwflz/ETJ3CNk1UnI3eHgXZK1cB0D3
	kxQqHjIOtjMKyDhX8mSmfY9XNfSF7lg6Sz4JtviXVBrEaTd/S8SyGAF125UpusJ3voEF9Jqn+Lx
	SzjvsLvQj3EcGANygb6Kt5YSguY=
X-Google-Smtp-Source: AGHT+IEiGjNOAm1kQqnCeHwbRlO6IgCR+SqHq6pVLksSOJ/nlS8jiL0+ZqvV+AivapMAr8Hre7giOlaDHHZ2z4EJLc4=
X-Received: by 2002:a05:6512:b9a:b0:595:8200:9f79 with SMTP id
 2adb3069b0e04-595842134a8mr7324699e87.43.1763554110316; Wed, 19 Nov 2025
 04:08:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org>
 <aR2OU4se7lxcMtGW@opensource.cirrus.com> <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
 <aR2Uo++k1NKkk2sj@opensource.cirrus.com> <CAMRc=MdFDAmqcJ3PMsTbeZUb9imM+fzHzQ_9mQ1T=syDoCcQJw@mail.gmail.com>
 <aR2gVzKhfN38MHAR@opensource.cirrus.com> <CAMRc=Mck8MiAm_nxY_L6Zw4cH-vYf24zSkPp=bhnUw68Q6FV=g@mail.gmail.com>
 <aR2i6lNNWEbQk0fx@smile.fi.intel.com> <CAMRc=MdYcdrQSDWKDHrx4-Y4-y92AQqr73MoRC3ws-X==SL0MA@mail.gmail.com>
 <aR2o2R30TbVOcqZe@opensource.cirrus.com> <aR2vrdBwF_oJ9H7k@smile.fi.intel.com>
In-Reply-To: <aR2vrdBwF_oJ9H7k@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 13:08:18 +0100
X-Gm-Features: AWmQ_bnlt7xm5Xhl0pfyQ1LEQXKZB_3reTw9ahGMipNq4xhMIivl8EVAqCbA7aE
Message-ID: <CAMRc=MfQTY7REt4Mty6mzv9Onwjv75LMU_RbJCM4LSgT74RHsw@mail.gmail.com>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software nodes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Maciej Strozek <mstrozek@opensource.cirrus.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 12:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Okay, you got into fundamental problem of fwnode design it seems.
>

The problem here is not that we can have a single secondary firmware
node, it's that we can only have a single software node. But that may
not be a problem because the question here is: do we in this case
really need the software node assigned by the ACPI part of the MFD
core. I'd say no, see my other response for a proposed fix.

> (below is the summary related to that, but it may be not related here)
>
> If it's the case, there is no easy solution for it right now.
>
> And going ahead, please, don't even try hacks like recreating a copy
> of needed properties from the parent fwnode to get an independent child
> fwnode.
>

Are any of these properties needed/used? If so, then maybe we should
consider allowing the primary and secondary nodes to be software
nodes?

> The proper solution OTOH should be decoupling fwnode from struct device
> and making there a list of fwnodes.
>
>         struct fwnode_handle {
>                 struct list_head node;
>                 ...
>         }
>
>         struct device {
>                 // asumming dropped of_node and fw_node
>                 struct list_head nodes;
>         }
>
> This will require at first to make sure no code dereferencing fwnode
> (and of_node) from struct device. With that enormous task done, the
> rest is much easier to achieve as it will be just API's internals
> refactoring.
>

Yeah, let's talk realistic things that we can improve now and not a
task that will take years. :)

> With that done, we may stitch as many fwnodes as we want where the order =
in
> the list will define match priority.
>

FWIW we can already do it without changing the fwnode_handle
structure. The secondary fwnode also has the secondary pointer so it's
effectively a linked list already.

> > I am guessing this code has perhaps been more heavily tested on
> > device tree where it is more common to have nodes for each cell,
> > whereas ACPI is far more likely to have a single firmware node for
> > the whole device.
>

Bart

