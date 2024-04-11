Return-Path: <linux-spi+bounces-2313-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053AA8A16C6
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 16:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B021F28CF24
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76AA14D452;
	Thu, 11 Apr 2024 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyhXOBi9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD814C585;
	Thu, 11 Apr 2024 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844510; cv=none; b=hvrEYVkOJ1izEbMAgJtbta20Lb6k2epJGiEUiOxR7hbcemwbT6fGNndNTyqTsV6O89ybBsVVb/Ky6DzJ/jjH/KK+Unn7bcLDk+SfiwxX8go5Yh8UYM0wTwUb6Xwo+i82WGhfbMHYuUmVwE3CPt6obNh0eIFYDdeVYHyr/QB1E28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844510; c=relaxed/simple;
	bh=2xiLM7twiy5jkVVhIVXoBLTpiQp5Us0+N61JD7FznAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fsu9cGv1JSjcg1E1hM9lI5gYhIZ5/2nAOrYp7aPPQRPJn/YfaDT90ifix2orgJ/RNkRosvt2MjXy7eHciwHT4WNw6uYU4PWkcrh9COk6YG49cxQGONYzuzcTySBHI53nljJS+CkaBCOsJwT+Tpe5itBarj9AdujRpSRWPqYrcxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyhXOBi9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a51fea60c0bso330852766b.3;
        Thu, 11 Apr 2024 07:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712844507; x=1713449307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypOD7b3T18miserl1UONOtTJ46K6f/bSweaZD3jtFgY=;
        b=iyhXOBi9QJpQwjf4RPaiFz95UyMUrrqkuMrUtQR5pH9HawJnIWD1pl8BiX00xwPNrV
         A5uQJlKbAA/x+8OYi+7Y0TcWPPtTN1ZZ4F3BzJuQSjRo7TdVA1FAiRoQv0LvKQ1mkw4C
         NKT8LeX95SovM/CoXbL5mgmRWUEKoinDUog3lAvtNhwnFkiQsCxluaYPzXD+27by3QZy
         Fpm77/ZX8pb/X4UGTdZy5IkO77X+ids6Bt1xeZ/+WFssWgHvtqtzGhmwzvH+OEpGFCRI
         Bp5IQZwM9yyKlIZaSVbfETH/AzEkPLvaddxuPc9J0Y4lbE6zQzg++aodiAx0ceZvzHWR
         FUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844507; x=1713449307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypOD7b3T18miserl1UONOtTJ46K6f/bSweaZD3jtFgY=;
        b=nToI/OAxjX9tN5jsEFLGZ329gMWVp4itl17TTXmKozYDAoCDFcBh/jMj1DgG2NlvXE
         aA7akyo9rfGCKnroea8K2Iq/WD9YUrIN5d9dTmQp0e0Z80Oab3BXOeKLoYnAUZo/QcLo
         rLt6dHZnSAxKOEwQBpsrmQzrcxc3Z7g5KuVZ//LcESApDzjVg6d/P8BGEHNgOGXR1dQo
         AYFybzW3pLeAxFgHZAGlv7SX8zC0S4gKJwNcrcv4z2KPOrK0e7TCLym+D48nbXNp9t9o
         PWG9vTW//iKxlF/TnuIpWUvX0XVRKOBAA12PzHqUQinwoiaaRz/1zcxwFIYtdk11SU8l
         Lc0w==
X-Forwarded-Encrypted: i=1; AJvYcCXlKIqgrSQLZOaCbZSqGV90Gl1nWtP4w7/FYwFg8XonNNa2ccterJ4EAzOE+S4jndZH1NbGxoLuQMfJFZQy5RLuEaYApiNY7Tipj/wbiIHNPPCL0Bybub5EEIXo554x0z1y85piBw==
X-Gm-Message-State: AOJu0Yy7y0VjfIfTIhrOna7Y/8YcqONrMkqH6DPz03sduAHezCXvd1eD
	jfogF6bmK9/SAaZHFaJKlhGkx38xU4TMthEa9o3IX+K0HTmT441lS4eChB4tG8ALufdIO4CLZgr
	Xr+WFW7v+7TzR7a+uFBuOAnTbkgQ=
X-Google-Smtp-Source: AGHT+IHCCUW5pQ7As5q8Fa4CpR6sEU+jgEASth8z+ewPZdYWB35AGV24CkdSBomyVN6wnJC6eVhutQxk8WDgiL+Oxes=
X-Received: by 2002:a17:906:45a:b0:a47:34b2:ca4b with SMTP id
 e26-20020a170906045a00b00a4734b2ca4bmr4458267eja.50.1712844507516; Thu, 11
 Apr 2024 07:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
 <20240411090628.2436389-5-ckeepax@opensource.cirrus.com> <CAHp75Ve00EuT0AdZy0b6OfqHySNkxTBuUbrv7z+mUgcrT56QWw@mail.gmail.com>
 <CAHp75Vcsfa4p9xuNNOd89d+YCneG0GkGaV2A54yKccQx_WT36Q@mail.gmail.com>
In-Reply-To: <CAHp75Vcsfa4p9xuNNOd89d+YCneG0GkGaV2A54yKccQx_WT36Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 11 Apr 2024 17:07:51 +0300
Message-ID: <CAHp75VcNGQaBoTTkg86=66MrReeFz0JzwhrQinsQdLLAvgpTpg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] spi: cs42l43: Add bridged cs35l56 amplifiers
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 5:06=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Apr 11, 2024 at 5:04=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Apr 11, 2024 at 12:06=E2=80=AFPM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:

...

> > > +               fwnode_handle_put(child_fwnode);
>
> And still this leftover...
>
> > > +               if (!ret)
> > > +                       return !!val;

To be precise it has to be refactored like

  if (ret)
    continue;

  put()
  return ...;

--=20
With Best Regards,
Andy Shevchenko

