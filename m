Return-Path: <linux-spi+bounces-2732-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E708BAD26
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 15:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2497B1C20DDC
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 13:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0877D153589;
	Fri,  3 May 2024 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPJvLcdk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907C657CAF;
	Fri,  3 May 2024 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741643; cv=none; b=SgRxvc3QqYZqhw1cz+5SG1lsCgh3BP7YllzMWERgOlhMun/HpT7ysxtQJ1k/Yy1bN9VeKgxomsn1GH0NZZaieZslrWAQrvVXECvvqW2CRFLbwfGlZAu7RIminsFZEZoz84UgCHH3pxImdIoUvEpVvVwfFw9tvOXok6+xmdycaWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741643; c=relaxed/simple;
	bh=2/MtgxZmlmI6RFPcKKGrAXmBZooPJyXpn9LKisUZjaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XP6Mkki1tjAjmLBCd+5lmWnFwpQpVe4BgsHIVAyI5+dEk1Y/dep7LNIwGw6g1PudlYJqmN0hInCo4cLiYG6dCa4Pv4HKHXvAvAK8z2Dyauu/Prcr4L5MvuwekrSXM3GsgJAWBXiXxMLYrkPek/SH3fTapIb/qF9o3kBsTg16/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPJvLcdk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a58e787130fso503449366b.0;
        Fri, 03 May 2024 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714741641; x=1715346441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/MtgxZmlmI6RFPcKKGrAXmBZooPJyXpn9LKisUZjaA=;
        b=CPJvLcdkcKhJlRjisJBdJBsu/EclVrGuBwH2vrQro35HLEe7Xm0rvrD2Hi9MX/55/o
         L0fxM4/8SX+TG7iQAFKPfjdOoJVbMnAnJBz1SG5X6CStkO3qjx28+F1vQPYa03oR0iAW
         02Zs/UTP3G8gWItDncXeShI1awf+CyhzUFtVFeDPgpVuwNF8u+YFIp/FQt4AtqytUFcZ
         9YLNbZauYL+tdma+BcNYYfxR+1VBlsn0zKNkOC8KkD00F7YNh1iiNWX08L5nIDa7g+an
         /+fKd1Nk9glkzHPSpQkGoaXpjKT9k0B3RS8PjivTim/jWPOFd+olw98jU0O0THzKFemi
         4t9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714741641; x=1715346441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/MtgxZmlmI6RFPcKKGrAXmBZooPJyXpn9LKisUZjaA=;
        b=ryjWi6tL4/CuuwzdY6qThRNDFgtTVXV8uYl0hg7cqYv+zjDCDdVLfmQ53Sxr/mQBxO
         UL1s45B21Pu7wfszuSvSOpApLc9PnVkuavWR6yA+rAje5uPn+By+KQY+kbTwkUwjTqjx
         I3ZTxjZvJ9cOGB1Ly7s9owLx6CI7YHS9uM/3KQDIZZUXRjI3gELTUlUbe287b9bP+8y5
         KAAzQ1E3b67gbMLJJ7JDyPRsaZHQxuG7aMnnHHjSEQAgdy4CQXT3XMeKjjPOwNiSirOJ
         CFkEWtJdlQ4eNUvhmWDj/gcx3ZsiX/NDFHTekxgkUG0qKzJngx2mshHSevDOiuIyYZR4
         6ROA==
X-Forwarded-Encrypted: i=1; AJvYcCVhzpSD9fxmEh72f0XOQ6bRKTaipBbMYcOVeb24gLWCqEmIcMPt/m36w+aciAIaz8ycyfOgT6zt39AA+xDmIoHaQKdXQxQFv1M72TzVJmzFdExzhjcgvRnTy6/57Jbmmm2kzV4kEA==
X-Gm-Message-State: AOJu0YzTOgkU1wDX9yvJAqGc9MsIbJ4uPS1Bi7/cCyjMROmUlpm6zyPH
	1N/2ctx0zMJ2h/OhMTqAzhM2HaSh/ah9+m4WizVW7Pzxp4e5ht2jwMgkH/riBb+SaaVlvzG8h52
	Caz6rPATraSA+JkB9n17N/MbbKjY=
X-Google-Smtp-Source: AGHT+IHg7XHZJmkffiibiAfe8W/O1QdYSBuoDLmLmNyfjjngZLubs8aDpp9aqEgDLvV5r+tfrMNSBzbztUOzAPr3rIg=
X-Received: by 2002:a17:906:f90d:b0:a58:eac2:a54f with SMTP id
 lc13-20020a170906f90d00b00a58eac2a54fmr2234202ejb.18.1714741640821; Fri, 03
 May 2024 06:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714571980.git.lorenzo@kernel.org> <08f55e89a1eb655402a748d700a023e1e27a194a.1714571980.git.lorenzo@kernel.org>
 <ZjRHSWEPbFijFXqT@finisterre.sirena.org.uk> <ZjTVaenC3xm-4-Ik@lore-desk>
In-Reply-To: <ZjTVaenC3xm-4-Ik@lore-desk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 3 May 2024 16:06:43 +0300
Message-ID: <CAHp75VcHuQ_7ZZQgysZOZ5TY=2pqC3uy_NoTF-iz6Wnu2cq2BQ@mail.gmail.com>
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

On Fri, May 3, 2024 at 3:15=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.org=
> wrote:
>
> > On Wed, May 01, 2024 at 04:06:43PM +0200, Lorenzo Bianconi wrote:
> > > Introduce support for spi-nand driver of the Airoha NAND Flash Interf=
ace
> > > found on Airoha ARM SoCs.
> >
> > This doesn't apply against current code, please check and resend.
>
> Hi Mark,
>
> patch v6 3/3 has just a couple of cosmetic changes requested by Andy with
> respect to v5 3/3.
>
> @Andy: do you think we can drop these changes or do you prefer to add the=
m? (in
> the latter case I can post an incremental patch).

I am not sure what this is about, do you mean the changes asked by me
made this driver not applicable?


--=20
With Best Regards,
Andy Shevchenko

