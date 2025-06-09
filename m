Return-Path: <linux-spi+bounces-8385-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF1FAD1A5A
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 11:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED4C1889F99
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 09:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DFD1A8F6D;
	Mon,  9 Jun 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O54UYKfC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7DBBA45;
	Mon,  9 Jun 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749460544; cv=none; b=dx/5jXhXYnr03JHaTnkviOY5hFr4GcV+D9ro6EtaPO9mQZAg/iuh4I6o7DzX9yx6EHMEC3kESzCQueC/735AGrXwr6oFO4VrlXR35Z0VUk+DWWJZIlzQP+P/03JE37y98D1078jP/DLGI0Iz5jjtQRPQ7WXsm6aAwdL94wc+jaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749460544; c=relaxed/simple;
	bh=SpmkGucy2RS3jBDTNw16VboUFxkjN0cf7us7G6qbOho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lh0WLVf+ossePWkqde3c1OmyIf8aOaXRqAVartT7CPcW3UwoBHlSNW+RV28aSSB8dL/W0ydRqYRQsLYDn0kBbyYgmSYOsSKTf2iMe7oloKVCmoIh/j3spfxoxU+++TbgH7eiBB2RTxfMiIaNBgY/FCWMeFpwGdMCHMTsqIs9oHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O54UYKfC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c46611b6so5097839b3a.1;
        Mon, 09 Jun 2025 02:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749460542; x=1750065342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpmkGucy2RS3jBDTNw16VboUFxkjN0cf7us7G6qbOho=;
        b=O54UYKfC26WlOd2zlUvRMrb/r6wwJckBcweM7jTnLNvgM6+OjsDorQNxBg3FGXUOxe
         4LwLQBVvdZ6pFPG0N7K/sZSShedke2mAyKEsRpjxDJLW4rduMMXBj3ZbwWnMrTTrwdfs
         Zud6Qj+zN1d1LWGdNqWvGCEBiKLfJuH74XE+ypB+qNGBfCgCOxJXAbOa1kVvMP2c1ugI
         1jhkf1HUmzkhw2+7AaKBabBLJn8bkwtORLOFsmcvjxefS6/FCXkSdqAtHUwcZwWbvsI4
         zKZziARWYstyc/LdqXiHys/NcnOtt0lzQJs0AfPEMYTnB8w5Q3INIpwnWzItW/YEPDaP
         Qs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749460542; x=1750065342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpmkGucy2RS3jBDTNw16VboUFxkjN0cf7us7G6qbOho=;
        b=Sni5DM6fuQ0HFGB2qV1mpEqoF/gu42jdHn+ByX1aW9t6vkEReTQEYqnozuMfy4ozqW
         bBkf2DC1vxjqSRr9RnIAjh9JhDR+5xl2++gUkTj5n4eonYzqB6U1sOQ6toVF7Q/SNBGR
         6EQ1A85tgPbMd0T1s8jMGSxvGD0gQDALEDuh6tNxYXND80HKdmcuWRnBnfaIkGRiM3or
         voCyqipNxc2vSwg98e4vufcc0sDYZeZyWglIyCjOsNNpSslgFSZTiHKM7JtNSYzEbFoT
         u5viQB9nfyWyrkxWLvbMNMQCO6XJTlPxAZar3f20ZvGAeaJI/A5tjcVS9BDjdVxUs0HV
         NIxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6lEdJuZl96XKHttFJFkQGXn67dRUtD7reOeQ+UbC2GJ2QPvTolG86oTHIhybAjNwXw9wWX+4V60er@vger.kernel.org, AJvYcCVg8XLhxpmbgXwmxvFlIkRDQAdiaohZnBnHNRjknii8dEpfIN9xYWCM5Cbi2GCixoGzqOK+Y3RLauCbcSGj@vger.kernel.org, AJvYcCWKOk72v4ibGlDWiHKZ6H90eR6nyikC0MICQEeZcZiSFc/XKgE+S08Df8c6ClckliyBxvVjxSQuuN1P@vger.kernel.org
X-Gm-Message-State: AOJu0YyY1Jz6TCNufn+hzlMhghSZ0CloGFnuJny3RCzEx8sO9EQpzjZR
	E94LJ3zcqPnPjx4QYmpgYxxlQcQe6tMe9Rjslk1bovneHan5lIjRfLd2DCh4+6lbxpxK6eSCEs9
	I6lpf6scNhtXGx9JhVYpr2Jg7gH8Y2Ev5UyTLN8dJVY1r
X-Gm-Gg: ASbGncu6+6FDYNHJf5ypJ1jSfqDWTJmYhhfwKKLOoVsmbG8O7aYr1FbesUVtcP6h/LF
	5T/tNUAjGMkiR0RzJNOEYJJ+v4stJkwTNurkovf4eYQvvsVNzo0w+XTiE7yRWRtvRyDzjLRJNZK
	fYqBqWoEhg8Y7UpeVNM7LBd922mE2TXEq40pIJZ8NkyVo4H41c5875
X-Google-Smtp-Source: AGHT+IFEiclBaTJZlih4iswbFa1U+LhgFwjDy1Wcd+BvQJmUmpObry6wPhiUxn5NKpdaFyOWKSitROu6/8JAQhawYRU=
X-Received: by 2002:a05:620a:460c:b0:7ce:bd8b:2d08 with SMTP id
 af79cd13be357-7d229862b2cmr1761187785a.10.1749460530096; Mon, 09 Jun 2025
 02:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
 <20250510-wmt-sflash-v1-1-02a1ac6adf12@gmail.com> <20250514204159.GA2988411-robh@kernel.org>
 <CABjd4Yz3w75PtkRk_edzD5yf6b2xPuf20gopbm8ygddgCBfpkw@mail.gmail.com>
 <2b520ae5-eb0d-40eb-ba73-cc18759f33b9@kernel.org> <CABjd4YxRMfi3ZFQxhB__6U4Rm3KQ7bm6J=wQLWAkpb++61ddEg@mail.gmail.com>
 <87y0u1z3jk.fsf@bootlin.com>
In-Reply-To: <87y0u1z3jk.fsf@bootlin.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 9 Jun 2025 13:15:22 +0400
X-Gm-Features: AX0GCFvOvTOTy7296A8LugdUtVGVag1zgpyjF2HNfUyXz1MiexIEF2mhKUtpCQk
Message-ID: <CABjd4YyMavJ414JY4bfouTDy41wB=aajJvJ6vCM55mdEiTFPDw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add VIA/WonderMedia serial flash controller
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 1:07=E2=80=AFPM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> Hi Alexey,
>
> >> > Happy to reference the spi-controller.yaml binding if so.
> >>
> >> SPI NOR flashes are still child devices of an SPI controller. You can
> >> look at other examples - aren't they all using spi-controller? Why thi=
s
> >> would be different? Unless you found some cases that are different, bu=
t
> >> then which ones?
> >
> > No strong opinions here, and no expectation of any special treatment
> > :) Just wanted to consult on what's most appropriate.
> >
> > My (subjective and perhaps unfounded) expectation when seeing
> > something advertise itself as an SPI controller was that it would be a
> > general purpose SPI master, to which one can e.g. connect an SPI
> > driven LCD screen and get it to work with generic Linux SPI
> > infrastructure - which would not be possible with this single-purpose
> > NOR-only flash controller. Given that I don't know how flexible or
> > restrictive other examples are in terms of driving arbitrary SPI
> > devices, I thought it's better to just ask.
> >
> > What I'm getting from this exchange here is that I'd better use the
> > spi-controller binding and respective node names regardless of the
> > fact that this controller cannot drive arbitrary SPI devices beyond
> > NOR flash (which, as I'm getting, is irrelevant after all).
>
> Just for information, there are several SPI controllers which are
> optimized for flash handling (not only NOR, though) and for that we have
> a spi-mem layer which allows to reference a set of SPI memory "only"
> callbacks. On the description side though, these controllers are like
> all other SPI controllers, so the same controller bindings may apply.

Noted, thank you Miqu=C3=A8l!

Best regards,
Alexey

