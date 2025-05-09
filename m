Return-Path: <linux-spi+bounces-8047-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616D3AB1BCF
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 19:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B263AD1EC
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 17:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FBB237164;
	Fri,  9 May 2025 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIeI3oew"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99768F77;
	Fri,  9 May 2025 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813298; cv=none; b=r+HEOM13rrpzVUcMe4Zx5GWa43Ekq240Dp2rG+3gXI53HwTYUPDOkFVCXWqvovP65HSOwbJdC8PmmQCrmkSpGyXgeXnLhsXS16W+baqk1igrR64tCA/dn5mEkL1JWzuPR+08pqUhoZc8pxnyT1rX61LAlI06Et16jGxUhCMf6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813298; c=relaxed/simple;
	bh=KOJLYiG65TWuBlIxtqgWoUH11LDO0PGmxxByMRSQU9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZMyqo9W8vbo3S3+59tALkJnslgeb11pnoiJm75oonWMS4HSy6MQ1o5IaEL1+P8Qu5SgtN3r9WjUbeAmt8L/GPFu+LaYp3WgM6Uu5aq6CK4zJrq6wA1Pd0jqwGJKDRJwhH9VIbkquwUikcfbpSQZmWnRivoxmStikERr02yksiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIeI3oew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2FAC4CEEF;
	Fri,  9 May 2025 17:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746813297;
	bh=KOJLYiG65TWuBlIxtqgWoUH11LDO0PGmxxByMRSQU9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kIeI3oew9kGkoFgw29zR9WHx9t00qjurtl2Mk5eDdv66tHBjgg9ctOKP44Ec81FZi
	 dukEW6W56aKMfGTle89s1IoThDu6ex/UGgvmEnRPtPALYBltoOFFYEwyTc1zjiLnc/
	 zBG7Uvq3LbzZrwzO/DXWgxVAPxxPq2AgW8JpPY6v/3SOBp62UcTvmV3404JlQoTvG+
	 goiK96XDKF39oK4R+9acrWlAJ6619v+ZZmUYb/DHyS2ggcgtA92ndAS23ZmgyYBrVH
	 YmUJgMlGQnJEA7Mw0ce6c1fxkuVtJdalgvO39qn/wxLhiciRG7R8fcqYcdlcDxzB23
	 AFQRNDXGvU8xA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso1647934fac.2;
        Fri, 09 May 2025 10:54:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0w5q2PIlCt66DTck0h60gN4TZj/3ZExzh05Pg+IefCu0N+pUPJ9RylNJdZEdDA7Vzz+UwgAZ6PtZa@vger.kernel.org, AJvYcCX/NzBCyylLhf9efya/Pe52c+OPat5NO6Ou+NU3O1l8j6lcooDXXQnw80zTjInG8oCLlOGKWv8vP0k=@vger.kernel.org, AJvYcCXxth4dIpv1Zn8/Fzt281HYO/8P8wPgijDFiAJyhyaksB7ut35vzEwFbGw9ejHabyq4ZKTgGKk5hcVOtPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xkIDV15BD0AjH3PfTyCAZiw9FonpzfsMiB9UAcy5serCikyJ
	nYn6G/tgDUl1sHEbnmrw1B//fkz4UD0M1goSVgetnOJetmIKGs4u1ZVittIv1XdYJ/BhhGlU55d
	opsHeln0AY8EF6+xkalqTs4cGnDI=
X-Google-Smtp-Source: AGHT+IH+jDF/fm0Bn7a7TtISeRixJH2NGz85rKoIe9PgVRkGUorVZ8oAkej18qlnfpmvd8IxnZLcR24rfpdzrPlIZTI=
X-Received: by 2002:a05:6870:f206:b0:2d4:ce45:698d with SMTP id
 586e51a60fabf-2dba4216488mr2969585fac.4.1746813296734; Fri, 09 May 2025
 10:54:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327195928.680771-2-csokas.bence@prolan.hu>
 <20250327195928.680771-3-csokas.bence@prolan.hu> <CAJZ5v0jmuzvo-xzGBDhGVBbY7svbrqEdi-SeJrx5BG=qtN6ZiQ@mail.gmail.com>
 <b38b27d4-c3d3-450c-8634-2e07f393a76c@prolan.hu> <CAJZ5v0hRsXw45utNMEhLB=i56tsJDz8AvYfV2stPbtRHh09HUg@mail.gmail.com>
 <8dadb7ae-1a7d-48d4-8dbd-40f6d9f35a6d@prolan.hu>
In-Reply-To: <8dadb7ae-1a7d-48d4-8dbd-40f6d9f35a6d@prolan.hu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 19:54:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hmmtiKnJ9=ejZXP3YdQYJ5pojqSAU2_KP6Y372-NQ-0A@mail.gmail.com>
X-Gm-Features: ATxdqUEiOx41ppybYx5hV00Fa-RDYzYUrpyGFFfZ9PKXJsOblhz9_YvaMeeRbSU
Message-ID: <CAJZ5v0hmmtiKnJ9=ejZXP3YdQYJ5pojqSAU2_KP6Y372-NQ-0A@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] pm: runtime: Add new devm functions
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Varshini Rajendran <varshini.rajendran@microchip.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexander Dahl <ada@thorsis.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Pavel Machek <pavel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 5, 2025 at 9:02=E2=80=AFPM Cs=C3=B3k=C3=A1s Bence <csokas.bence=
@prolan.hu> wrote:
>
> Hi Rafael,
>
> On 2025. 04. 29. 13:08, Rafael J. Wysocki wrote:
> >> Did this end up being applied?
> >
> > Just applied as 6.16 material, I'll let you know when the tag to pull
> > from is ready.
> >
> > Thanks!
> >
>
> Thank you! In the meantime, I submitted the DMA cleanup part as well,
> for now rebased onto pm-next, but there seems to be no diff between it
> and dma-next in the relevant files (drivers/dma/dmaengine.c and
> drivers/spi/atmel-quadspi.c).

I've just added a tag from which this change can be pulled:

https://lore.kernel.org/linux-pm/CAJZ5v0hNb8eB2tAig1BiUMHLQ3JRak3EXFid9qmHz=
6iWvh5q6g@mail.gmail.com/

