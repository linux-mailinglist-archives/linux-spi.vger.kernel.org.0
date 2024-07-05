Return-Path: <linux-spi+bounces-3758-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1204B9284CE
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 11:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A6428C0CF
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E974145FFF;
	Fri,  5 Jul 2024 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNiCsAyD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668B713665A;
	Fri,  5 Jul 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170684; cv=none; b=l0poGgJ96wvu9wcgyKDYf2mikNRwBjCgfzx4IPCUZ2Q8H9e0l2k4UVoxbK3osFx+gOWWD1gj1UgaEHPvz7mntc/sZ61yadSWdkkbP9HSI40SBaIGHE+fbFT4IzQknyWPX/vJN8M7+/XeGSEYsgVMU8fVmmnf1WVQHwuC9ZKqpCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170684; c=relaxed/simple;
	bh=QIcPI42a2XmJ67V08YpOuVNPZ2MunvlkVsGdZitSm5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S85XKNHLt/JxTse/DGo0ds35iQLrOKo11PkKBwC7SSprIr2bo43ULeCYuax3SHyl7t714opzxegHNucar6KnyjLQs4WHvuu4R4CzX2YZsnZFdj5WOz+0k0X2ett+kptOjNwowHyFi9+Ski7ZOMHhqLJ1gqNhrdQvImim8Bq+5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNiCsAyD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so2401277a12.0;
        Fri, 05 Jul 2024 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720170681; x=1720775481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tFVTuWApmF08b6diV6/k3QYObKt2iVbPWZ1EGAddbk4=;
        b=UNiCsAyD9hsgVawtysSXnrq22T4FyV90hKDBKg2482l0rOfnTlhKhjXek2vvZkJllO
         eZPIrqfWX0ZtE0vBg4yCHecGTuE6RjkJU+tsBvK2ITUdbrwADitfxMdENiZANxP+8DL/
         839EenaF9c1iLbbph6FNr5m/vJKmG/Fv54NKJqbtQck1ilK97L9Ff2PxOV4bGnUEjU/j
         WIG5A+xMwKNwBxVleuO4fRBkFJEOO/K6g1UUyU5nkeIJ/Wf4tAZ0OMdS9HGbmgDibG9z
         Sc1McL7cEcO1a6GBSrm4cyBX4VQjig9doDAbmYoEmjFzXcKsYGJgGHtitzovmsY768mP
         UUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720170681; x=1720775481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFVTuWApmF08b6diV6/k3QYObKt2iVbPWZ1EGAddbk4=;
        b=hO1Wq0k55qRRtrBzvi+U1ZG0eUcc9xAyXZ7Bvgl6nLpp9Rx+sV6XLSLnYWZ4J+Ry9q
         VW/VZEeH7Qz5BcvvOiuUrRvSSzRn8l+3bDk0loVD6WCA/LQyDClk+ZD2wKtAKV0f2sry
         kpeEQKgU4MoBAnDNh3sciyTgXb4BVHSUK1xqk+BiwzY8R5mGUTZLFe4fcx/KtJaompGA
         8OiRqE3e97SeQDcfaDh8LQTqiEGixO+eWtBvSliTfgr5AR4edtM2CcNi0bR0gCs3uo6/
         MRfsBtoCOapmzZCF4I60IEV0iyLGiaaitvLVuGTf51IaaXEYS7eGZa66IRbsKMxyGmSC
         b8GA==
X-Forwarded-Encrypted: i=1; AJvYcCVj1wkqq7ZdRFCnf2x6PE1W6NiNd7rI5HzXSPoWSMonKeMw3ZLw+Jy3QRnihS5azWgAbDFu50F5w8TQX3OeWcVJUCM9ehHrG2d7geXKpq0+169HRAFSYPDPzheL0t1DoaTheyu7RSdwcfBMkbqsgqqHY2sk8ifL/hd1aNtRVQaPCG5gJw==
X-Gm-Message-State: AOJu0YxE4OKmLU8U2a4yvvMQJS94NTAmd4nJgYJxK61IkEfWVaJnWgvY
	E/HReTPuMt8q1dwrO5Ri33iPeL/vbGDDvquiJ6V2XwQOY541THPPTa6CnPBJj/YADR4IGLOfkyH
	Re1IbbH5o0nvcAd9ZDFr/0tJOSmY=
X-Google-Smtp-Source: AGHT+IES48Ua4k077GMXI81WDVe5sTbjVgDZ5/aHC4u0ds3E3f/Es91e9OxI3B0qRmmnO+D/15fo0gyY/p1G3e8/rwo=
X-Received: by 2002:a05:6402:2710:b0:57d:4692:ba54 with SMTP id
 4fb4d7f45d1cf-58e7ad25580mr3260066a12.6.1720170680522; Fri, 05 Jul 2024
 02:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
 <20240701121355.262259-5-kanakshilledar@gmail.com> <20240703-juice-refreeze-62c468a56ea5@spud>
 <ZobU6K/R3pfHrK9c@x1> <Zobhkf5qr13rKcWH@x1>
In-Reply-To: <Zobhkf5qr13rKcWH@x1>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Fri, 5 Jul 2024 14:41:08 +0530
Message-ID: <CAGLn_=siEF=srN1NLgi1i_EocnQH1HRpCPyTpv+bivQ123iq-w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: add basic spi node
To: Drew Fustini <drew@pdp7.com>
Cc: Drew Fustini <pdp7pdp7@gmail.com>, Conor Dooley <conor@kernel.org>, 
	Serge Semin <fancer.lancer@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> > > > --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > > @@ -17,6 +17,7 @@ aliases {
> > > >           gpio1 = &gpio1;
> > > >           gpio2 = &gpio2;
> > > >           gpio3 = &gpio3;
> > > > +         spi0 = &spi0;
> > >
> > > "spi" would sort after "serial".
> > >
> > > >           serial0 = &uart0;
> > > >           serial1 = &uart1;
> > > >           serial2 = &uart2;

> > > I'm pretty sceptical about adding more of these fixed clocks, rather
> > > than waiting for the clock driver. Drew, what do you think? Should we
> > > just add one more to your fixup list or would you rather delay? Guess it
> > > depends on how long more you think that clock driver is likely to take.
> >
> > I think the clk driver [1] is in good shape but it has not been reviewed
> > by the clk maintainer yet. Thus it is hard to predict any timeline for
> > it getting merged.
> >
> > SPI support doesn't require any driver changes so I'd be inclined to
> > allow the fixed clock in this case. It will be simple to change it over
> > to a real clock once the clk driver is upstream.
> >
> > Acked-by: Drew Fustini <drew@pdp7.com>

Alright! I do the suggested edits and send a new patch.

> > Thanks,
> > Drew
>
> Sorry, I meant to include the link to the most recent clk series:
> https://lore.kernel.org/linux-riscv/20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com/
>
> -Drew

Thanks and Regards,
Kanak Shilledar

