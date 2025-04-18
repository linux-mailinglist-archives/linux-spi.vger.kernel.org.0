Return-Path: <linux-spi+bounces-7677-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 116C1A93AF1
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 18:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19F63AD477
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBDA214225;
	Fri, 18 Apr 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnwMit1q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29805208A7
	for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994287; cv=none; b=m96czaXtjQAlHL2OrIgomJ3yum8jypX3jK1Wal+QyGl1BSaaCOOpCpPlAY3Bmt8zxkBkKAo/vuA5TY5dEe5Kg0VQ79cFKdkaWoMqk+Ib7NsBnfx+yyoFLk52T1DJaBqYEFmEHgkp2MvRma+r9VzkPhlt3rOvfmdbt1O+Abu7G8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994287; c=relaxed/simple;
	bh=/5ELJ7DHBo7SO474xxhl1JRYyMeZhpPLdOM7oAYrvbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4rD8F4eY/r6xRMhsOuwiOZGS945OCJO0u6SsV3OwRV7uLNuSTGvXEzES0XFfowFKOMgMCxmPCgBtCJDj5CYx2Pfm8OU6t4RqypvMVLIlREP/9Wra+NsTejJFthT93UE52AXWmnTdxfKZo6U0lnSWxfGhwfvAlMyjOoiJ2KZhCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnwMit1q; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-477296dce76so16397911cf.3
        for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744994285; x=1745599085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HltuWVU5aHHUDpIeZdyPKZP/vjN5Ipqa3E4AFJgi7t8=;
        b=lnwMit1qymYTVeRL1XchM/Ou0oTJEwISiovr4h4LNy/zxSnswZnvhJeAKNfUlooWv7
         D3vLtVYbBN6yZzM4BcVbc7xHQw7GInNnzYFF39TLxkFOrewpr4BzUo2fBtnDQ44LpEm7
         waKILHQZy6ZZS20EJvsegRD/cnol6nkqCxCZDfkTH9zNAyOlX50x0ChFW0LhLHCgp7kl
         QU0q5vWLWt1FRVl2RpDlZ6qeW5Dn7PINmx/MalejxP5pJRV8wPAke2k0APmicu1zS1CB
         10/rsVONwqM66+4xbmUZQA8iJwaAE7ILTu9Jufr65ciFctP1aNpaZnQy9PiMlLHzGRZi
         6oOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744994285; x=1745599085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HltuWVU5aHHUDpIeZdyPKZP/vjN5Ipqa3E4AFJgi7t8=;
        b=a32lAMcKfgkd3X2tECInyTS5qXkT3HfEQvIofIXYhoGrVNiqY1rEYp6zjmwn3W86a4
         P01ALVq9d+pZrhq5BsHGHZxA5uJ+0CNSBmy1nS9gqTdQ1Blgs35RUpsPrqDLPvtdS0eH
         CqdtMDW4KkjKXWigFmKMQoOKTlNsNP41qYvq+/azDRTXNOFF45QUquvrdunBlFeK6Y+k
         KGgt8Qi7+lQBz53zy2SJgeaTBAZ3SH4QCwpTHac2DOfRNqqTaTdAd5u2ijUGPOm3hV+R
         1VY7qIEuPKjxC4Eu+KnA/mgjjuTPPLdYbCD1z3rUdzAf/4A8yy+jIPbsKORCuZqTfZ2d
         hozA==
X-Forwarded-Encrypted: i=1; AJvYcCVb1cwMJEAdTF52OVTNNb0lFNj2EZFfNcrDh+xhTgoDI+vmZIf2fBw/S/APbUr2vxDgudDrQFCgOBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2uPSu2pC1RoeeltBobBkE+MDXIUb0OvRU0tNEBKZcjR04cY3l
	2J9+UKfvTX8Xm8U4xrUz/xVUOvg1O1FtDgHBvemefGZkBWbWabOvf1oIaOTnHMXjIZQFzbDOEk5
	X/JcacLcyq62CBKfyzTnT0CIVwLo=
X-Gm-Gg: ASbGncvnvdJvCjVcKG9MLWv0a6UzdEeshi6h8GFU3gozzcSYBKlD5hpEi26Yetw6hx8
	i6H1wbXkaof7mlNKd+Qsw4HiddbS3yMp02eOIzujRfvvZEhBARKPVMYFxeS6+qR2lJaCuIFtWL8
	g5pCoLwcZw97j1MW9chNDX9E95
X-Google-Smtp-Source: AGHT+IGRep05XaYBgAf7gd5IaE/EBpdYoaEb56t9bXaMS3LAR2osRbNIAUhts2rgwnX6qqFAx2fL3vonQK177QuGR34=
X-Received: by 2002:ac8:5806:0:b0:476:77a5:3104 with SMTP id
 d75a77b69052e-47aec35b7d8mr60169381cf.11.1744994284821; Fri, 18 Apr 2025
 09:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417232319.384094-1-andres.emb.sys@gmail.com> <6d6b5ea4-0f08-4618-9fe2-d681cd2f51ea@baylibre.com>
In-Reply-To: <6d6b5ea4-0f08-4618-9fe2-d681cd2f51ea@baylibre.com>
From: Andres Urian <andres.emb.sys@gmail.com>
Date: Fri, 18 Apr 2025 11:37:52 -0500
X-Gm-Features: ATxdqUFBiVmgUvBB4emNkLkW68Lkw6XsxxRB_DJSZqRkCRXSa-M1hrtJ6_pD5Sc
Message-ID: <CAMihqu_GcW9PuXdacfNSop8MByh1O6RkczAO7WphFpCAxcm8Tg@mail.gmail.com>
Subject: Re: [PATCH] spi: offload: check ops and match pointers before use
To: David Lechner <dlechner@baylibre.com>
Cc: broonie@kernel.org, skhan@linuxfoundation.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 9:20=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 4/17/25 6:23 PM, Andres Urian Florez wrote:
> > Before checking if one of the triggers matches, check if 'ops' and 'mat=
ch'
> > exist
>
> Can you please explain in more detail why this change is needed? For exam=
ple,
> show the code path where we could actually have null pointer de-reference=
 here
> that would be fixed by this change.
>
> >
> > Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>
> > ---
> >  drivers/spi/spi-offload.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> > index 6bad042fe437..fcb226887488 100644
> > --- a/drivers/spi/spi-offload.c
> > +++ b/drivers/spi/spi-offload.c
> > @@ -173,7 +173,9 @@ static struct spi_offload_trigger
> >               if (trigger->fwnode !=3D args->fwnode)
> >                       continue;
> >
> > -             match =3D trigger->ops->match(trigger, type, args->args, =
args->nargs);
> > +             if (trigger->ops && trigger->ops->match)
>
> The check for trigger->ops !=3D NULL here should not be necessary. The on=
ly place
> where trigger->ops =3D NULL is when the trigger is removed from the list =
and that
> operation is done with the spi_offload_triggers_lock held. The same lock =
is also
> currently held here, so it should not be possible for ops to be set to NU=
LL here.
>
> In fact, there is this later in the same function:
>
>         if (!trigger->ops)
>                 return ERR_PTR(-ENODEV);
>
> that could be removed (since we have shown that the condition can never b=
e true).
>
>
> > +                     match =3D trigger->ops->match(trigger, type, args=
->args, args->nargs);
> > +
> >               if (match)
> >                       break;
> >       }
>
> If trigger->ops->match =3D=3D NULL then the trigger could never be used b=
ecause it
> would never be matched. So instead, I think it would be better to check f=
or
> that in devm_spi_offload_trigger_register() and fail registration if it i=
s
> missing. In other words, make match a required callback.

Hi David.

Thanks for your comments! I did not see the full picture and now it is
clear to me that it is not required to check the trigger->ops in
spi_offload_trigger_get().

Then I will create another patch to remove the trigger->ops check that you
mentioned in spi_offload_trigger_get, and make match a required callback
in devm_spi_offload_trigger_register() instead.

