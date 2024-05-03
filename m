Return-Path: <linux-spi+bounces-2734-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737088BADE5
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 15:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF2F1F234A3
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F9915383E;
	Fri,  3 May 2024 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0zmi1MU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29712146D5B;
	Fri,  3 May 2024 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743664; cv=none; b=PT/bt+bjq81nyRcD/OaD33HLCrbArMGNF0YsR+2MaW1mVJFTsQJmcoyg7eao4R+mwb/YwfW11xr1nqGrj6D2nd2wxsIqgqB9QXC0lwZl/kEQZpKUkjtz5VBKBR8wYN7tFqgRwgSQrPFahZ9FtYJLD5TrL2OIJBWHANsRYwR65aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743664; c=relaxed/simple;
	bh=+Jb4lAg0slsq+gv6gy6EBzkWRDloikAOOewkPitfTrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rucz4AItMyMh8DxlKqyT4dU+amaSbHNvLMzwy0KFAOOhuBLJ9iDfVwzZ98sSQLRE4i19YjxX7mU+me8HeIC9yfMO/nN4Em9VBsU5/HhLmTCZqaHlu0fQ9oj/ioQ79mL5EBpKMsypDRxPBZDgkDYZKGl+5wGlEW09EhYOjwDczUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0zmi1MU; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a58772187d8so1267549966b.3;
        Fri, 03 May 2024 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714743661; x=1715348461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Jb4lAg0slsq+gv6gy6EBzkWRDloikAOOewkPitfTrI=;
        b=i0zmi1MUvNie6r9vkyGTWCtESoxL0MYOh7NMGxbHPT5VS/6ahDndyuAS/BgFDKJT9V
         eAgCbzMGDMz3Xkb9QKMf5n5UCUC6RbR62haG9F4gKh3yxFRmFa9zdvAkBOyYFpuOZ4uT
         VZvo0DB42BMvwmtuvOJdqXU4AAYuoPIN+kRSliHxdv4uNs3wbFhYzrfMYRJ4mS3qSa0+
         HU/tuvx88qLomePev/zDOanJJfSHiLG3MOi/0y88XNwGSrmSd3lF35ZXdVGA4kWgViJm
         fzDj5Ccz6906DwkeOjLgRdXSdbxcaGV+oeh0IY1lUn79hdkwkV6LdNpUscOFI2TFDWGm
         CRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714743661; x=1715348461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Jb4lAg0slsq+gv6gy6EBzkWRDloikAOOewkPitfTrI=;
        b=RuVuSIyyj4arQJaFgvv8oFpRuGGoPdVnwEMxxYzOseW9QzDnou+k/wTt+NrDcX1R/C
         rg0XBVe0/3Yfoapdsjrzb0/BFo5MBFw+P4GPz1ydmTazYSdk07ZvjbHMVzJd39kQ5/+T
         JFTCPg+cfcpIsv9Sctlin2MiyvzZqkBBGbu6mr6sn0zd/3XGMxrqG/wsqvcWEqhiPJoN
         X9ZS+dvwcbcnnZFlD6I68h7FWqB70f4T06lSd5RlCD8AJ+REiPsGui/+l3F7N0/MeCJ1
         JO011TM8kO0ff1vpohBnqEUZtTlx0FO3H+TjXZmzXCbK7nbkGgRsOf6eBsHGOJN8rXpe
         ikOw==
X-Forwarded-Encrypted: i=1; AJvYcCVXUbtuddwlxmKGRSiwP7sHaR3XNU4NanxW7sDhWc42JJ6fk36HX1dP2NZ0zbbuSL2wCxl38YHPI+FuxjqbR99WYVQsL5uXljmH7ejSmUAiuCojHPD+UDUyz5gPPppd+1VWq56Ulw==
X-Gm-Message-State: AOJu0YygYbh7Hh5D0EViT+vHhPUJfhbMdhrCwasbD7p2eFVtiIW6zU8A
	0Vl2ae+qP4lcMEM6R6KrDG7WIHQ8hYJaZ1WLkMM5BIFj9hahbdIpJDQ+yJFOP7PGE0FaWThJXjf
	N7wIP3u5HRuKe9KxKyJzELFIBB40=
X-Google-Smtp-Source: AGHT+IHCwMQA70DCPDOHFKBLvywTmb3XJhioKRRRa2+J2zf2+AUi4IKRJDC4GLP9WjEqqVppgEyHNuVGQKIUpY7TkWg=
X-Received: by 2002:a17:906:3ac2:b0:a59:86a8:8d0 with SMTP id
 z2-20020a1709063ac200b00a5986a808d0mr2263616ejd.46.1714743661482; Fri, 03 May
 2024 06:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714571980.git.lorenzo@kernel.org> <08f55e89a1eb655402a748d700a023e1e27a194a.1714571980.git.lorenzo@kernel.org>
 <ZjRHSWEPbFijFXqT@finisterre.sirena.org.uk> <ZjTVaenC3xm-4-Ik@lore-desk>
 <CAHp75VcHuQ_7ZZQgysZOZ5TY=2pqC3uy_NoTF-iz6Wnu2cq2BQ@mail.gmail.com> <ZjTkj30SxYeTKTA4@lore-desk>
In-Reply-To: <ZjTkj30SxYeTKTA4@lore-desk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 3 May 2024 16:40:24 +0300
Message-ID: <CAHp75VfTfo4cZighemavZrNpV+HAAOP+BR-SCcMvxmBZYsQWxQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] spi: airoha: Add spi-nand flash controller driver
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, conor@kernel.org, 
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, nbd@nbd.name, john@phrozen.org, dd@embedd.com, 
	catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com, 
	angelogioacchino.delregno@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 4:20=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.org=
> wrote:
>
> > On Fri, May 3, 2024 at 3:15=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel=
.org> wrote:
> > >
> > > > On Wed, May 01, 2024 at 04:06:43PM +0200, Lorenzo Bianconi wrote:
> > > > > Introduce support for spi-nand driver of the Airoha NAND Flash In=
terface
> > > > > found on Airoha ARM SoCs.
> > > >
> > > > This doesn't apply against current code, please check and resend.
> > >
> > > Hi Mark,
> > >
> > > patch v6 3/3 has just a couple of cosmetic changes requested by Andy =
with
> > > respect to v5 3/3.
> > >
> > > @Andy: do you think we can drop these changes or do you prefer to add=
 them? (in
> > > the latter case I can post an incremental patch).
> >
> > I am not sure what this is about, do you mean the changes asked by me
> > made this driver not applicable?
>
> These are the only changes between patch v5 3/3 (applied by Mark) and pat=
ch v6 3/3:

I see now, so v5 was applied, and of course v6 can't be as most of it
is already there.
Yes, please send a follow up(s) to address my comments.

--=20
With Best Regards,
Andy Shevchenko

