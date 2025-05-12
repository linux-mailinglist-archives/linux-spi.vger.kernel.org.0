Return-Path: <linux-spi+bounces-8096-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 118F5AB402B
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 19:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B7A19E70E3
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C62254AF7;
	Mon, 12 May 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljFQYBCR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0FF254879;
	Mon, 12 May 2025 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072241; cv=none; b=mcxBk9Samq1kFxK9AtRmqfWla4N/WQr3Vf2ZxNgk0ltdkakcGBrC0O1hcl83ueK0GpBY/NMm5xPHDqb5io29Vcs2V8KtflO7Jchz8F82UxASYAUzE4x8J03Pzj2UhfTL+m4yx3KjYw4ZayHa72mzuL4amH/ef6rHNhOYKyVZTds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072241; c=relaxed/simple;
	bh=50J+L6yppvWnD5FxHuOHSb8jlzLe4Y+CMyEYV6+hIsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJGnN1gNx+dPygB+Mq4mDlZ2S5Zq71/RC0pBXj8qfax7CLZWKIIzXe16CGdzmRg4YH8NDNpVIA5MZMaGf3VjnlKwQRJMIlkb5Eyuf9JoIdc0z27RIb0BtCylBmYgVWsqJZKZfUHpnYjDjF/iGYJVEw7ImIUZznkdF3yS8Zg+xPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljFQYBCR; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4768f90bf36so51318811cf.0;
        Mon, 12 May 2025 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747072238; x=1747677038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSoxyHvUrLiSc3/psAWBZmLYF3TjkhwktVK+c+jvBxs=;
        b=ljFQYBCRYzWPi+svJQW+dLUgjPLRPrvmbTS3kHl1a/fCEAdSKyvT4HCYuEWxnF9k8L
         Lm/+PwEqXMFoxzvjPzZSHBKu5BiR80h0KTBzpcmsIGZe+2SCQ0f7+cpXylQBNSlN28ft
         0WjaHjp/L187d33UxQJRA39XaAVe1IbEfWWsscQhg7n+yUgEO6DrxCjIYYxGs9HNm9tG
         rvC1+Hl2rhf0Me5++u89fJBuWcEaxt9g1mJD+glRln0qE+r4NcmsPBp7+fo22DJgof8D
         SpsebPLpui6CuWRy4PwtSm4T59HaxGPBn01quwqHnyCc08FBxzWycaidj4xD8E3Z1QVS
         FAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747072238; x=1747677038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSoxyHvUrLiSc3/psAWBZmLYF3TjkhwktVK+c+jvBxs=;
        b=tB6J9e2rfy8p+IEkVl1P85WKs/XPlrBX2GBtwbLizrzwVbFOY14bUIRto9pwsf7I7A
         Qgoa7CAzuORCpVFvVhp2GcoMnZQFM+aP5G4t/3yuUdSz1JPKu0/4LYz05wik3o5NO8Wj
         KLx9ByyQiSuY302yV9FR+LglVgkCiaYtDRKG+yDpfnwm0S30igvKrSDHAHahUWT+dqsx
         IPPhkJFJeSuQvhyNeZZeIPQ8sJmL/JvjBZr9NoqffCMBb8ZtE9vuh2hZ9z2fhBXgktif
         fIcI5BY/L3YdLKvUvNmPR543R2PI213EKEEcSd5yL25l7qqFSH/99wa5o7XSDC0LEsWL
         XZZg==
X-Forwarded-Encrypted: i=1; AJvYcCV7s/RI9IVLxHqN8Oav3HhHOzgID1axgnVvk/TLjKf5VWQvB0vbGJ9hhe9PelPcUfHM4E68AqG4vN05uCRy@vger.kernel.org, AJvYcCVogW6vZrkIN+tUS4+qiwfBE59YG1EuG4mlEWQdpSoP/MWe55BXCoMGZFkPj2+FHj1g72CXjQYSn7KH@vger.kernel.org, AJvYcCX5C7SmtzGsuFkYTt31tfr5swiazETnUN0Te44RVGk3elzr3IePA6AM9RyAUu64rv8BBUl04W/UecJR@vger.kernel.org
X-Gm-Message-State: AOJu0YzrrwQZw/6ACD+7rcn6RrfE2t8wbO/3+Izk3ZXYSwN+7FYbFN1k
	Wiuw2kwfnHjla/QzPYNeTLQBipYICBApFkqj1egMCLvAmQAYMjrWxgyyBzP1LiTMN2I2qXAurQx
	sdZyaF48GASE3jKfHB+JZAGjooqQ=
X-Gm-Gg: ASbGncvmMXItb5DRfpC0YB/PTCe37XZcue29sukFkrHYiocMZNELc8m3Z2dbJAQdbng
	GgyP77R65tRPdpw2gt8enU9u//ClXHKIe3xLepQ4hcaYhmm/NaThnI4XbWWhEP8TJUXckn4yD35
	MueXfaTh0lqp/heR/PdoWB3HFWHtZf/vQ=
X-Google-Smtp-Source: AGHT+IGkeH40cXRztWXpSrCJ5q6XKPbNvx7k9EkmvL+Je1u1a0S2VQUWKi48NLpznn1NHqP6LSPKlLPZSwHilThRqUc=
X-Received: by 2002:ac8:5f91:0:b0:476:a895:7e87 with SMTP id
 d75a77b69052e-494527f40e7mr184965391cf.48.1747072237855; Mon, 12 May 2025
 10:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
 <20250510-wmt-sflash-v1-2-02a1ac6adf12@gmail.com> <mafs01psu89sx.fsf@kernel.org>
In-Reply-To: <mafs01psu89sx.fsf@kernel.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 12 May 2025 21:50:26 +0400
X-Gm-Features: AX0GCFuTn2-A7ifRuVywFd5v331R4uCu7HoPZVJQ7gQFF2XE3zSvat71MlVoTDs
Message-ID: <CABjd4YyRScBgDbi8Sk0D3vxcmLF8+YBetUdkfhrS_4Y7M+gS1g@mail.gmail.com>
Subject: Re: [PATCH 2/3] mtd: spi-nor: Add a driver for the VIA/WonderMedia
 serial flash controller
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pratyush,

On Mon, May 12, 2025 at 1:20=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Hi Alexey,
>
> On Sat, May 10 2025, Alexey Charkov wrote:
>
> > The controller is tailored to SPI NOR flash memory and abstracts away a=
ll
> > SPI communications behind a small set of MMIO registers and a physical
> > memory mapping of the actual chip contents.
> >
> > It doesn't expose chip probing functions beyond reading the ID though, =
so
> > use lower level chip opcodes via the "programmable command mode" of the
> > controller and the kernel's SPI NOR framework to avoid hard-coding chip
> > parameters for each ID the way the vendor kernel does it.
> >
> > Currently tested on a WonderMedia WM8950 SoC with a Macronix MX25L4005A
> > flash chip (APC Rock board), but should work on all VIA/WonderMedia SoC=
s
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >  MAINTAINERS                                  |   1 +
> >  drivers/mtd/spi-nor/controllers/Kconfig      |  14 +
> >  drivers/mtd/spi-nor/controllers/Makefile     |   1 +
> >  drivers/mtd/spi-nor/controllers/wmt-sflash.c | 525 +++++++++++++++++++=
++++++++
>
> Drivers in drivers/mtd/spi-nor/controllers/ are deprecated, and we want
> to eventually get rid of the API. The expected way is for drivers to use
> SPI MEM (drivers/spi/spi-mem.c). SPI MEM drivers are usually more
> general and not tailored specifically to SPI NOR flashes, so it might be
> a bit tricky to write drivers for specialized hardware with it. But I
> think the drivers/spi/spi-intel.c driver is written for similar kind of
> hardware so it should be possible.

Oops. I've had a look at spi-mem, and it seems like it's not a
particularly fitting abstraction for this controller.

From what I understood, spi-mem primarily expects to be talking SPI
opcodes to the controller, and for the controller/driver to bring
their own chip probing routines. This controller on the other hand
abstracts the opcodes away, and wants someone to tell it what its
flash chip can do (the controller itself can only get a chip ID in
"normal" mode, and it needs to somehow know the chip size and
standard/fast read capability of the chip). So pretty much the
opposite, huh.

In the end, I only need something like spi_nor_detect() and can do the
rest directly on top of the MTD framework without touching any SPI
opcodes after the detection is done. Is there any other non-deprecated
framework that can provide something like this? Maybe physmap? It
looks even older than SPI NOR though :)

Best regards,
Alexey

