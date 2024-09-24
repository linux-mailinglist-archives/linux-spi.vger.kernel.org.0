Return-Path: <linux-spi+bounces-4938-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C28F983B87
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 05:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF701F22C06
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 03:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358401802B;
	Tue, 24 Sep 2024 03:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp6u31FX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7129738394;
	Tue, 24 Sep 2024 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727148393; cv=none; b=ZOoAboTgQ4QwmM2OQ3YuwIsCYyKr10TTHJPS6aY+10xDOtN6Kb8r5brqjzNgk0v41JXMliz89lZIbOQOrFVlWSoari2OxcfQjN+MzQoJ68sXoxIt3xxB5yB/hFS821WMXtwEad5SOG2hjbXb2z3KlVfE/HDM0txap8S0ONhCcRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727148393; c=relaxed/simple;
	bh=w1eDQMS69JSGKWx1MEFGeoLJVt87GsVPOWmSaoAnaJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ql3VvgeYuFfIwPUMnvHmeY0jGJOyR3hkMeIxiYzIDz5Wjb72Y4i5jlnWnNgWe8Qnrk/F6F/1sy2Ntk+TLXy/dyBWwp9WBSXZtrRMDo051bYPQp0rjNl8shehKO3oU+PRmtkCzzCK4+dCMK22Z/PGbF0cfy4F/EiXxIHbaohEqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp6u31FX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so714260966b.0;
        Mon, 23 Sep 2024 20:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727148389; x=1727753189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56PjDxigXVOIzQ1oNphT+JNMfW878D/s9pl7IGdWoto=;
        b=Xp6u31FXC4y21mu6S3ta2h8TVCYtgtXwGiNWlNJuqA0j/3zxW+xCUPMDZmXhsLDjWD
         orrKLQY28Vgb7jdW0oZDdshbr5vzQz2TCfJPrKUrO2+SryOItw9f1PLlx4zETNiG6U8R
         zCvr7Sva/FelulkzO5uDVcoA7XfKWl6yG6PT0pIVojciiqe8DqeGOM5cTygQY/dzEC39
         HFDD3OU07QbuOq55tGCZptfIAXz/OdQGZNVcKKwbtTcfh8yU02A3mjYoJ3zE5znm3mdj
         j5K1QKzInMjaridCpugnoOZZrKoLR5o5N6TWBsJEUoJIfcvnhXekxE7L84KTQ8VysQbT
         qBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727148389; x=1727753189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56PjDxigXVOIzQ1oNphT+JNMfW878D/s9pl7IGdWoto=;
        b=M04T63MRZkmNlLz7o02wUNP7t7X5n+pykOLRb7wP7WXwSXNThLwxIEUP5iYXYRc+Sa
         JnpwgWLNifL4Qq74uQBm3DMpkvCTqgCPQyOcCnZthRaTS5xAo2ZlhsMsOpsAOjoRauvQ
         ZcVcWm0gJugXB+xGEXxT1k/4llkD94RtSxU238heEDj6LjUEx0Bl+KWCH00Jp2GcGRAP
         gAc0OzXYHq02Yxd9sojgdS5fda8ilCPyZSr6hqgDKxx4XABrTysAMkSq7eAtHOaX40Ed
         WjtF+fZM6ueboBfO5GtsljkKizb57DcqX6XSsf3F03osa0fDstCtSfynf3ySVpTIT4QF
         TW5w==
X-Forwarded-Encrypted: i=1; AJvYcCUtubXmAMz/sLzdcDqi0CMGvjhgesfRSgSRCqGlzSY8x8nmMBC5CAEp9cUg4j0A5kPcjerGmb34YXoL@vger.kernel.org, AJvYcCXp04b5YBLDtjEZQLYPGluhJsfBRs8bVopr8HYp98u5ORM1R3aFkE+bBzMZNjZrx3KrShh9gWuILgoMcGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhMpTqpH0nPX6gE5SHw9ml/wZ9Stb/7WgS6wR/vvAdWWnatHDq
	b/MmRPpLlCNVT1jSWLgerWyzvKBTR4q8jDl/4FnULzeZqQz+INgMtUFlP60X9E45RQuAC9wsX3k
	5iS9axG7Axa1CHiwnf8Z3Sn6xwQeKo9ZY
X-Google-Smtp-Source: AGHT+IGhbAJwqXzVtJkfn2cS/fzTwtEm2nUykTxtIPRIuWSQCFK/QHe70KrLsbuDrVEt9/2u3Glg6ejNSJlGt4J1q+k=
X-Received: by 2002:a17:907:f148:b0:a86:700f:93c0 with SMTP id
 a640c23a62f3a-a90d504f5c6mr1240193466b.35.1727148389175; Mon, 23 Sep 2024
 20:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
 <20240718034614.484018-7-alvinzhou.tw@gmail.com> <97134efb-398d-4c21-a915-87a5b4f1b29a@linaro.org>
In-Reply-To: <97134efb-398d-4c21-a915-87a5b4f1b29a@linaro.org>
From: Alvin Zhou <alvinzhou.tw@gmail.com>
Date: Tue, 24 Sep 2024 11:25:34 +0800
Message-ID: <CAPhrvRR3U9=0DuG_FQ81ZJq+RLe6Bn9YO831Mx2n3NkeV3MCdA@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] mtd: spi-nor: add support for Macronix Octal flash
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pratyush@kernel.org, mwalle@kernel.org, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	broonie@kernel.org, chengminglin@mxic.com.tw, leoyu@mxic.com.tw, 
	AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>, 
	Bough Chen <haibo.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tudor,

Tudor Ambarus <tudor.ambarus@linaro.org> =E6=96=BC 2024=E5=B9=B49=E6=9C=882=
3=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=882:54=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi, Alvin,
>
> I quickly skimmed over the previous 5 patches and they are looking fine.
>
> I don't get this patch however.
>
> On 7/18/24 4:46 AM, AlvinZhou wrote:
> > From: AlvinZhou <alvinzhou@mxic.com.tw>
> >
> > Adding Manufacture ID 0xC2 in last of ID table because of
> > Octal Flash need manufacturer fixup for enabling/disabling
> > Octal DTR mode.
> >
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
> > +     { .id =3D SNOR_ID(0xc2) }
> >  };
> >
>
> Could you please elaborate why you need just the manufacturer id here? I
> would have expected to see a specific flash entry instead.

Grateful to Michael for the valuable suggestion. This addition of the
Macronix manufacturer ID enables the fixup functions such as
macronix_nor_set_octal_dtr to be executed without the need to
create separate ID entries for each Octal DTR NOR Flash in the
flash_info.

>
> Thanks,
> ta

Thanks,
Alvin

