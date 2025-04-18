Return-Path: <linux-spi+bounces-7683-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322EAA93F92
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 23:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5388E070A
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 21:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151EC1DB124;
	Fri, 18 Apr 2025 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgqdujH5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE61B6CE0
	for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745013138; cv=none; b=o7xTWizRLdko3fuxMg7Nxwam4za33kD2znwftAT8WC10R/95xuA3QOqQl2bsOW9LIdpjB8dg2bMr/xu6P8FyY6VWPlCAMM4lSwa5C/smdNKZrrb/4Mx9WItoe4XrPVHqs2C+T5rRER8ANYto26TiTZDxDeP94AsACKJm5ACU2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745013138; c=relaxed/simple;
	bh=N7TanafbnuUEls/FFcZxrrUNd3LlytQUrsEw9mUviTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeNnQR/hrSBZvZLivqFiy56SDaZ3VkKbtkCP3PGOPgBOdlwYF11XiFV6WKtzZ1FcCxOAtJvlZW6j39y1Jh0GnWcXBH1SrkRrBIt3rCnb7+ydNAtFL2AJBzVNat9GpRK7hxDcciifSl2Jcg+psvZnUVJcSlcbKC5nQ9PaJASJLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgqdujH5; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47677b77725so24373961cf.3
        for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745013135; x=1745617935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJteemHQdPIHijdfba5JF3B0sKiKzz1cQmWIpU4FubQ=;
        b=WgqdujH5lFjfHMyRZXuldXQ2tpGrdAV4wQxAhioq8xb6yC56hgtypvEQSOPa9P/PbJ
         x87arD9lyob798CKylR5B2qoE6S3iGVn1HoijuiCEI/uGsY7faCIxbCHefVAcri3Pjkh
         03K2hwZJX4IIBCSKUZdHYwvBqkB27kP2vWHIXbtddFEVuVpx/mHFzA3BmlA5se4FIn7D
         Goy0HImxcOBsPuIyzZ1YQFn5gbnVZIjkrgQo12+u3fb0zk+Rx+DfHAOYXpahpCHHLN8g
         ftpQr4aGk5N5osXfT85WSbWiSPaogYG2gg7j5NuY23xpM9SBON3aBhsmaQaUrIdqqpcj
         3/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745013135; x=1745617935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJteemHQdPIHijdfba5JF3B0sKiKzz1cQmWIpU4FubQ=;
        b=U3LJdVxOY5OTGoZfWIua5Q7wKe0XyChWhFw9R18JesdbEPcXWwYPE7jYk5o9GTXOnd
         aVbiMY1brJk5Av8UuJY4+JCS7wJmNP+OQ0x+iSZ4bG0v3c1QE/28yCdfny0peYqVqJFD
         P+5aOybksfESQZe9OGxZRAKy+Yx1GEu/lybKmS/uEqZhlKJVvgbMpH2Q9i/7bkKkd53A
         pK3En/gOGWdVMZW0Md900/bGAS1WDQwRIABP0N9KkSdqJvBQNQOkl0sqxAlLSGQNf2hh
         Qddh+iES65rZn2aLdmUwNgZ57Y5mhHEdiNFZvsS+llT3jVg4CjRsL6b+ZX4D/DkzNnJI
         DvkA==
X-Forwarded-Encrypted: i=1; AJvYcCUe7JWHGZqvDvrLS9GBvhCYGr1dsm7lFF5oFHcgOnhCjKvc8bdMbtMR2Ba10BZpt7Sjyk2TB3CgpjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlsYJBb9y3ETtDwgaIaKZVZZOPkOy5JwTVaCw+ZHhBwmSFR05B
	J3Oj3FIAd1mIPvZuWz/494A8lIPn9zQGh9LK9UGQJIpauXG+glrjF/dwro6eTsLuTucBEKq0uuF
	0A3P11lUnDrOjNU6LGNKCIF3EJeC1J6Xd
X-Gm-Gg: ASbGncvfZ2MnGmXE+oH2sjwNZ2cL/PtUa7A6C3rlrRKlGs0RCKq4grVa2HjMQmUJKxg
	cja+R0R17Q3mzCMOOyRERAZo4CTSQIeqV71Yl2ICU+1JXialTDmpE7CX8BsHWLBSW327El+3pIn
	sRln1AWYoZXft5sMpsGYA+1B8=
X-Google-Smtp-Source: AGHT+IH4Ilebq7fpF0wTTBCMo8d/IRhgIAzPurEDsbKeAt92njYWwpiEJcXnrNeTE7a2Ay3CPF5CbL4vcIyHuwHf2aM=
X-Received: by 2002:a05:622a:11c7:b0:476:ae71:eabe with SMTP id
 d75a77b69052e-47aec4bd58emr86100721cf.50.1745013135412; Fri, 18 Apr 2025
 14:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418175542.13820-1-andres.emb.sys@gmail.com> <e0fab22d-c929-4111-9f4c-fbf4fd525c58@baylibre.com>
In-Reply-To: <e0fab22d-c929-4111-9f4c-fbf4fd525c58@baylibre.com>
From: Andres Urian <andres.emb.sys@gmail.com>
Date: Fri, 18 Apr 2025 16:52:04 -0500
X-Gm-Features: ATxdqUGQCfKRuKkFD4CNhSE5FnE-oO6F71ulWnTR_YgztIxSQGoC38YM-YcZa-o
Message-ID: <CAMihqu8mw5+jK_tm9PkKg9n6_ACJvpfRcWyZv8xZYoUrUtRLwg@mail.gmail.com>
Subject: Re: [PATCH] spi: offload: check for match callback when a trigger is
 being registered
To: David Lechner <dlechner@baylibre.com>
Cc: broonie@kernel.org, skhan@linuxfoundation.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 2:49=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 4/18/25 12:55 PM, Andres Urian Florez wrote:
> > Make match a required callback when a new trigger is being registered,
> > this allows that other functions like spi_offload_trigger_get() could
> > safelly invoke the callback when it is required
>
> s/safelly/safely/
>
> >
> > Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>
> > ---
> >  drivers/spi/spi-offload.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> > index 6bad042fe437..6f4c5188e6ad 100644
> > --- a/drivers/spi/spi-offload.c
> > +++ b/drivers/spi/spi-offload.c
> > @@ -434,7 +434,7 @@ int devm_spi_offload_trigger_register(struct device=
 *dev,
> >  {
> >       struct spi_offload_trigger *trigger;
> >
> > -     if (!info->fwnode || !info->ops)
> > +     if (!info->fwnode || !(info->ops && info->ops->match))
>
> IMHO, this would be easier to read and understand as:
>
>         if (!info->fwnode || !info->ops || !info->ops->match)
>
> >               return -EINVAL;
> >

> >       trigger =3D kzalloc(sizeof(*trigger), GFP_KERNEL);
>

Right, I will apply your recommendation.
Thanks!

