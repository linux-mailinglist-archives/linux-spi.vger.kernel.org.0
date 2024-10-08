Return-Path: <linux-spi+bounces-5135-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E026993D93
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 05:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D050B1F24CB5
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 03:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E9A3FB1B;
	Tue,  8 Oct 2024 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2it8aLk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2902F3EA6C;
	Tue,  8 Oct 2024 03:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358785; cv=none; b=qdeQB2lfKXXmd/2JpOr9aJ7A0hD7ofG8TdyBsEvIQ5DFiIraedmuuJRwpa+yGMCcxNQ3LlWcUUfuF+r5H3Zg3CHh3OZXg0/5OKmN5J45AdwvMVZ2mq8IbOr7gHNHlImADWgGlQc+9caNbDFMBK1YY0ykAGUvfXQJDaDZByNyWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358785; c=relaxed/simple;
	bh=ecE3ouQQyw3TmwVuM7oALCPm0mClhEa0ZQu77fP3nu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+hq3DA60Z7qZGMijSB28/rTphJpQ5mwP1MsP++dzxk7JoOcxaUNBT4A+7iSzHd4K0XSoVC6xxN8kRWaKBYlC1chHWMgKavLdWsperaGgGemLVXpQRdVsq4ZwHyC72sxTy0FV1kyk1ElUa92nDq7XxMglQd8OsNIYDtqYZ/XwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2it8aLk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso7016667a12.2;
        Mon, 07 Oct 2024 20:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728358782; x=1728963582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/PPjhQbwoqSXUMaC+vsNn6zKjcC3s3xpaP+vVQl7Rw=;
        b=f2it8aLkQZEHbWPKhWDX2qslRObe5WDxvIMPfaTg4DKX45CZ/5R1+S1Eu/cj3UgLI+
         vhRlUxAfS/iW4nJLvo7CQF9L31uH9l910yrpZnXt59ublC4v9f8G+fw/BmZxNsKO++MK
         bqkua//1U2QbIUdFEWPICv2iL73LFfO9R+XcsTmu0tGLP0xgI021VeU72E4OyWV6hKyH
         +bFjWYUooQF+gZBvZosumfRS8bYFyNJLIOHmgfTLWbzKq7FyWzd4RKgTiKHhSBYCNaEB
         +lHEIq7GZmvYicw3PFqWaEQQgiJ+HciArJBwbB9qDP2IiiDu6zRCQFVGznUsb7jy+ljx
         LT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728358782; x=1728963582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/PPjhQbwoqSXUMaC+vsNn6zKjcC3s3xpaP+vVQl7Rw=;
        b=vKBeyWM1ojHsViLHfy5EaG9uzYPGFzQTs3xae73dQTmLAqlzIBPTvuiBhWlDmu9SgQ
         8y56dPRHHyiEMJ+vyr+JuIGOuPPawhSBwrHLegxX24OnuU83b84fa7i+U8JSvKWXZ9Ba
         v3JNCFpoc14wXNwZDPAkmq978BBskQqc4wfwUvQwp0YA90FuXjzdh1Ce7Y1WVm0gMwKF
         uui3DpK5QNEyKe6jiQwXSBOQIRGYIekBjPq5JMwSA4aSgxXPJxC5z99RDbJrRGpNPOEf
         79/ohFyoZa+LRKK1kyvfQZ0Nxwai7WUpiLTDipXxxR7gP8gPzzWrervvRhLkcpZRuqc9
         juog==
X-Forwarded-Encrypted: i=1; AJvYcCX7WPpdVmQUVb/zKbibioLuXQaob5rsDelzjPMRPCWQDSsRNVcWrDJyuFjXjd79ERrieGhaiA+CF80x@vger.kernel.org, AJvYcCXKSGhx+4KWdN+HQHP7q6n/j6JBBmnk1KHDqXvPagEybdiogLznsy4KOoVg06ZqeWtkgZynv9P8XhR2jqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/EaMt385c3CgsNVXKl3PwG3g8bOYdG66NzmugtO21e28hieRG
	jXxIAlxHqQP8JaaN2c1pNvQb39BZ53EvJQMHF2OEHKhPrJjZ2LQ8JHCoXMVVe0JpFU/tAVlOGic
	Kh6M1okLOnNnto/Cx337eaScEaHg=
X-Google-Smtp-Source: AGHT+IGpwqBAmBnDkvWHxGABLWSZkf6HafdAPt/3FROqNjBraqMwP5nOnM4cihhM7pjwt4x5auADwUPhiR/jnxbsjFs=
X-Received: by 2002:a17:907:70d:b0:a77:c30c:341 with SMTP id
 a640c23a62f3a-a991bac3142mr1354878266b.0.1728358782135; Mon, 07 Oct 2024
 20:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
 <20240926141956.2386374-7-alvinzhou.tw@gmail.com> <5e7e0aa4-74b0-4262-8e8b-de86be54f0bc@linaro.org>
In-Reply-To: <5e7e0aa4-74b0-4262-8e8b-de86be54f0bc@linaro.org>
From: Alvin Zhou <alvinzhou.tw@gmail.com>
Date: Tue, 8 Oct 2024 11:38:27 +0800
Message-ID: <CAPhrvRR6mkF1L2dBhsfwF7UmWG_0rHtf2Ry9+LiAt8xZbfsLZw@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] mtd: spi-nor: add support for Macronix Octal flash
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pratyush@kernel.org, mwalle@kernel.org, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	broonie@kernel.org, chengminglin@mxic.com.tw, leoyu@mxic.com.tw, 
	AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tudor,

Tudor Ambarus <tudor.ambarus@linaro.org> =E6=96=BC 2024=E5=B9=B410=E6=9C=88=
2=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:45=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 26.09.2024 17:19, AlvinZhou wrote:
> > From: AlvinZhou <alvinzhou@mxic.com.tw>
> >
> > Adding manufacturer ID 0xC2 at the end of ID table
> > to allow manufacturer fixup to be applied for any
> > Macronix flashes instead of needing to list each
> > flash ID in the ID table.
> >
> > Such as macronix_nor_set_octal_dtr function in the
> > manufacturer fixup can be applied to any Macronix
> > Octal Flashes without the need to add the specific
> > ID in the ID table.
> >
> > Suggested-by: Michael Walle <mwalle@kernel.org>
> > Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> > Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
> > ---
> >  drivers/mtd/spi-nor/macronix.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macro=
nix.c
> > index f039819a5252..1a8ccebdfe0e 100644
> > --- a/drivers/mtd/spi-nor/macronix.c
> > +++ b/drivers/mtd/spi-nor/macronix.c
> > @@ -200,7 +200,9 @@ static const struct flash_info macronix_nor_parts[]=
 =3D {
> >               .name =3D "mx25l3255e",
> >               .size =3D SZ_4M,
> >               .no_sfdp_flags =3D SECT_4K,
> > -     }
> > +     },
> > +     /* Need the manufacturer fixups, Keep this last */
>
> you have a capital letter in the middle of the sentence.
>
> I'll replace the comment with:
>
> /*
>
>  * This spares us of adding new flash entries for flashes that can be
>  * initialized solely based on the SFDP data, but still need the
>  * manufacturer hooks to set parameters that can't be discovered at SFDP
>  * parsing time.
>  */
>
> Which brings me to why you really set this. I remember SFDP contains
> tables with sequence of commands for enabling/disabling Octal DTR mode.
> Would you please remember me, why you didn't use those SFDP tables and
> implemented your own enable/disable methods?

While the SFDP does provide a sequence of commands to enable Octal
DDR mode, following this sequence forces the I/O driver strength to 50 ohms=
,
which causes I/O driver strength to be weak and and leads to read/write
issues, so we chose to use a fixup approach to enable/disable Octal DDR
mode.

Thanks,
Alvin

