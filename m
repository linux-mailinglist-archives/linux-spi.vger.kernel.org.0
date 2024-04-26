Return-Path: <linux-spi+bounces-2555-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427C98B3F7F
	for <lists+linux-spi@lfdr.de>; Fri, 26 Apr 2024 20:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 538B8B20CCD
	for <lists+linux-spi@lfdr.de>; Fri, 26 Apr 2024 18:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF86B5680;
	Fri, 26 Apr 2024 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8B0GEuL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6211879;
	Fri, 26 Apr 2024 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156857; cv=none; b=HA284Skdg/TgV3r7adRnaEr1tYVp1R5WbEwruMFmJCHLHftCgaTWdMqU0uMLs0Gv4iopZY/5CcESyWDEnLfCZ9pZ/7v1BaZT80sOKNKiD/dK5KfxXrEc4zWeI4v5LVdKzfhS5WtVfmO4dr8C/y99oIX7jfzgI6LecvNT/lrTqJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156857; c=relaxed/simple;
	bh=rvrNC3JFwPV29Kb72PvC4nm2Zcfi4a+rQfPKPb10BJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mit+DsnadQIs1mQHZTRBDeHmes+GH0ZsuvlmvyhPwmV+s1cV12WmXCeeJF4P+KApcAl1jL5HvGnFjFg+s+mOKm1JfhxoWnG0+XgC7OFsGGVTOsrT1ldLh5ULo0ONtvYnSThAwL9XA0qP9p/jJb6cqvaLVWLcejewXHlzFc3g8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8B0GEuL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a58989cd1f8so323827566b.1;
        Fri, 26 Apr 2024 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714156854; x=1714761654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkrwWPKztMVNwrPeKwp9PKqeKIiGVRFaropmsH2a0TQ=;
        b=W8B0GEuLcjMhxg3jvENwOsQ6UDAEcSLFX4HLfOA42q0tHXOB/LqeyAGIotZasG638C
         sdJ3kCeo4LPEIVDu9njnZQ3uGJYxLFb0CWp6YpfzOhphK2E2L/6rhIKYxeeiYsljG7/X
         aLEQH5U6kjS8W8VNkrWKt+gTh29WXQLFWW4IluHYsh9wQ1TXGT0RucV0UtUaQ8PndjC3
         kTzvrxhPtOitqXrbyM9J4bsI7zuwhbOYkxrt05qJPfV5cQNwpOSg1PYVCF5bgFoJC1/3
         /0mXjj5LrVmpXvRdIhSHAkXTFki4zmKmXyl4QPCVDeWwpx5ITODMAkIK+uRsSoua+bTM
         gcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714156854; x=1714761654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkrwWPKztMVNwrPeKwp9PKqeKIiGVRFaropmsH2a0TQ=;
        b=lfq5edFIl275GZINrwCX/l3BSgJkFc0bJSkHcMLuCpkchmYJil09XudjPNqT5ArhQr
         qmpCyOuxPY6qysdUD0YTcp9RkGH5SsSCwM5JY1S4lnhp2k3zQ/HnPfDothX+gcmxoDIl
         +HfNoJb8R+pLcSWFxoQMPvt+27DV1awf01M5U3iY4m+HTMi9YyMILXVhrQ7vzW4vYc3y
         il03NrUW2JyPr78gw67l2ynaNTzO40Sk8Q7GyW0XsFvZDxm3mgyJoRO9y9o+LYsBRbah
         je2iqgaANu4pqLuVTfzMo+JMYf/GRwKTKZs8XO9nw8KyHTshUO0cRmUjLreka3Gchc37
         pn2A==
X-Forwarded-Encrypted: i=1; AJvYcCVmiG5Lyqwfz40al/ertz4VO59BkCsWEhIYLYSwCn06paoc5Hq3wue48UQVIlt5VjGmG+HoZkjiQONap1NST15gdt5U1fazQequHQ==
X-Gm-Message-State: AOJu0Yytll1frtukJ7KFNBCekvExsHwtF6kSQ1mlb3ln97SF4qoND0HL
	cxexl9jBpv/XOnbmDG4hA7Sf9umL4nyKT8YSZzoAbPxdcIfuucRfQsONIT+MIHEVQ4BVFgpP5Kp
	EWoZOamj5cfgHpMycnMJB9mDKvhM=
X-Google-Smtp-Source: AGHT+IE0xvli7hIPgIvifIqZD/OZw4V0JOTk/ZnSUiwkPN05lsv0DsC5yjcZFm+tfgQ+V2NJEEgMV9jhIAD4q2mywGs=
X-Received: by 2002:a17:906:b798:b0:a4d:fcc9:905c with SMTP id
 dt24-20020a170906b79800b00a4dfcc9905cmr257538ejb.20.1714156854157; Fri, 26
 Apr 2024 11:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714119615.git.lorenzo@kernel.org> <2047e9c8372b51dc263178a12e194b8826f1abe7.1714119615.git.lorenzo@kernel.org>
 <CAHp75Vd5VSMNy-bYQmcmRA47uTn567QiKmvDJGEkRUgVCk5PAQ@mail.gmail.com> <ZivUAZ2SKRJsESKF@lore-desk>
In-Reply-To: <ZivUAZ2SKRJsESKF@lore-desk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 26 Apr 2024 21:40:17 +0300
Message-ID: <CAHp75Vci=xupfi8zt-cB6dOFDhFntp7qvCqz8ZJ-2ucHXd4xhA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] spi: airoha: add SPI-NAND Flash controller driver
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-spi@vger.kernel.org, conor@kernel.org, broonie@kernel.org, 
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, nbd@nbd.name, john@phrozen.org, dd@embedd.com, 
	catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com, 
	angelogioacchino.delregno@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 7:19=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
> > On Fri, Apr 26, 2024 at 11:31=E2=80=AFAM Lorenzo Bianconi <lorenzo@kern=
el.org> wrote:

...

> > > +       default:
> > > +               break;
> > > +       }
> > > +
> > > +       return false;
> >
> > Why not return false directly from the default case?
>
> it is because we still need the 'return false' at the end of routine for =
the
> other cases due to SPI_MEM_DATA_IN and SPI_MEM_DATA_OUT.

Hmm... Can it be refactored? I think it would still be possible to
slightly reduce the amount of LoCs.

...

> > > +               op->data.nbytes =3D min_t(size_t, op->data.nbytes, 16=
0 - len);
> >
> > You probably wanted clamp(). It's discouraged to use min_t() for unsign=
ed types.
>
> do you mean doing something like:
>
> op->data.nbytes =3D clamp(op->data.nbytes, op->data.nbytes, 160 - len);
>
> maybe an 'if' condition is more readable, what do you think?

Yes, since we have only one branch of change.

...

> > > +       base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res=
);
> >
> > How is 'res' being used exactly?
>
> right, we can pass NULL here to devm_platform_get_and_ioremap_resource()

No, just use another call that doesn't require this parameter at all.

...

> > > +       base =3D devm_platform_get_and_ioremap_resource(pdev, 1, &res=
);
> >
> > Ditto.

--=20
With Best Regards,
Andy Shevchenko

