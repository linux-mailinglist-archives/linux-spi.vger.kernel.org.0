Return-Path: <linux-spi+bounces-2312-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610048A16B7
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 16:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168881F240C7
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2722E14D708;
	Thu, 11 Apr 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUmz/1nC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE814D452;
	Thu, 11 Apr 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844442; cv=none; b=dQJjQ6lsfXnBZb4LUFle+mTpCTtgSe9yovtNAQNG3UpnCzTb0vkmvOtLsDOYv+jUOXkfCRuUk+D+ohOq42xAVURr/ZiCUDvz2DXpOvAHzqRxWalnkD5n5SfCIn2RsFBBFF6Gr3LytvKS5k7NK3PSaV+j1m6VjgH18qFsEDLeTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844442; c=relaxed/simple;
	bh=z7Gnpactd+bEKiKnoodJ6u3AD7OuKm+u/eZy8ytYg4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETfF67oIXN87i9kIqSr5U76pVFhitapaJz2JN+Zv2sUBSpju8fDSyuJyleB8cXVHBoJ4dQ2SoRKgC3+oAVeD+mKcSISrtFH+2beSvnmDnBOwJodesyKztxOvSmIQV1NRc56MLb/HMhZu+zMJj0q9TJUVxsMXLdnaFmB1tKsUWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUmz/1nC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a522e8e283eso5073366b.1;
        Thu, 11 Apr 2024 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712844439; x=1713449239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fduFw1SBftN215XOBDUKyrKltS8Gn+PWb0Vsua1KtZM=;
        b=NUmz/1nCNPxE04CpVLMut8o8d7hvBDAZVGHuI9FHYlUcGu//ahSYNI3RlU9LbsT6jQ
         38j2O1/BFStm40QuYtXwF6w1BbatFes1iyMofenA8A8lrgtzdFHwaWGThOU4UgMuO3dA
         VT1Imq8u3TDBEgd+LvvO/uOkM11c+P7qu5tLTP3ARsuf4xirTPidaxu/EZnWTDLWKc1R
         82wOGhFHUbudenNe1pgY4+VaOWpQ7BaNorgLjsX6Dc67k8e81ZImPHzTiyYQADZQPpfN
         dMoNy29OoAERUN1C7QRMSsAgNWhr21BMjIqZq4sFqj5uGQzW9CASCIK/GvFcfuR9gWG5
         3nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844439; x=1713449239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fduFw1SBftN215XOBDUKyrKltS8Gn+PWb0Vsua1KtZM=;
        b=nqOPy8i93JB4G1QRQFUbRCpYr5w6+2RdBJ6Exognnvrf67XCy2iai6qRq7M3U2ljG3
         If3je/DXp0iS5ZKq/rwfFEVJQLFHwW7xrnYel1rlrj9CnHZKn+op2TQOLAFe1xEGp5EY
         BXJxNlr9el75wAopP4PacjAZHq6zqvejQ6uto+Ky4/hLnLf3Odz++ZFceGP7Pr4GLtLa
         LGLtw4Togk1ZFSqJx33ClTTZyZT/IPQ5xywUO7E5mL4JSvymnfO21MktSetLPeAJSoy0
         HYGwaJZXoBaq8HiKECVS9t4EGMSJHT64OjPjYgf37XC+zx68IdMgRUdksroycxqYtY7e
         RWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWC77oJ/cswYD7eeWMWbX1Y4wDZdW7fkYf7SuD3Mxg/Ual26bOnUi8lyjqLUrZ1J38sl0qtRnYS+BGXmAurHrjRJKShjQs1ySlAEIITehURg/oT99IUZtXVz6Klkp2RDWHXp7LaA==
X-Gm-Message-State: AOJu0Yyix7zMyOc97NVffe8VQ6nr6cUItvYRJG3G5PKPFcOhp7VoBzIE
	gAfolSaL/qiMnmZd/L2ZquvCWx57qTESJ5vdhH7qr0GuHhzbNm0F6QUTUatsQS121KaemIwrIF0
	5B7Sj45Yh5bUJa2jop3+1BEC2Bt1s8JEO
X-Google-Smtp-Source: AGHT+IE2nE4SicZa+rnAM7uDYVxRsieV6iB65TiX+eKBHbq8Gzel2eUIuzYMmEi4CtGHHxkjrzHbSqHucsRWAU4rByk=
X-Received: by 2002:a17:906:3c53:b0:a52:2d14:e230 with SMTP id
 i19-20020a1709063c5300b00a522d14e230mr229567ejg.59.1712844438731; Thu, 11 Apr
 2024 07:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
 <20240411090628.2436389-5-ckeepax@opensource.cirrus.com> <CAHp75Ve00EuT0AdZy0b6OfqHySNkxTBuUbrv7z+mUgcrT56QWw@mail.gmail.com>
In-Reply-To: <CAHp75Ve00EuT0AdZy0b6OfqHySNkxTBuUbrv7z+mUgcrT56QWw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 Apr 2024 17:06:42 +0300
Message-ID: <CAHp75Vcsfa4p9xuNNOd89d+YCneG0GkGaV2A54yKccQx_WT36Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] spi: cs42l43: Add bridged cs35l56 amplifiers
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 5:04=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Apr 11, 2024 at 12:06=E2=80=AFPM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:

...

> > +       fwnode_for_each_child_node(fwnode, child_fwnode) {
> > +               acpi_handle handle =3D ACPI_HANDLE_FWNODE(child_fwnode)=
;
>
> > +               if (!handle)
> > +                       continue;
>
> This is _almost_ redundant check. handle =3D=3D NULL is for the global
> root object which quite unlikely will have the _ADR method. The
> specification is clear about this: "The _ADR object is valid only
> within an Augmented Device Descriptor." That said, the check makes
> sense against the (very) ill-formed DSDT.
>
> > +               ret =3D acpi_get_local_address(handle, &function);
> > +               if (ret || function !=3D func_smart_amp)
> > +                       continue;
> > +
> > +               ext_fwnode =3D fwnode_get_named_child_node(child_fwnode=
,
> > +                               "mipi-sdca-function-expansion-subproper=
ties");
> > +               if (!ext_fwnode)
> > +                       continue;
> > +
> > +               ret =3D fwnode_property_read_u32(ext_fwnode,
> > +                                              "01fa-cirrus-sidecar-ins=
tances",
> > +                                              &val);
> > +
> > +               fwnode_handle_put(ext_fwnode);

> > +               fwnode_handle_put(child_fwnode);

And still this leftover...

> > +               if (!ret)
> > +                       return !!val;

--=20
With Best Regards,
Andy Shevchenko

