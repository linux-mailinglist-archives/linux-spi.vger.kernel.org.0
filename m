Return-Path: <linux-spi+bounces-4799-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3C4976B04
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 15:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C2A282717
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 13:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4C81AD24C;
	Thu, 12 Sep 2024 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBeinoMa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86CB53804;
	Thu, 12 Sep 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148702; cv=none; b=OzhPylUUNnhHr4/sdGOa9Nt9KPdmJVELvTg7r1Zmf+A5qRmrkc8EsgFQWQRfsD3BwB6i/hf4ly4JlGGZ04XgYExbvTWnaqAssgavl8zYToPVVbTi3Fu1i5iJbIc6J31DE8vRAI0hufCOahgnl5K4m4EMwfyzWmchj4GNM7TaQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148702; c=relaxed/simple;
	bh=0J4Zz/JZ/ibBAf2DdCyLRseOgtVPUiPGuk2oQAO/GNc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LgJs1VrFC/bzz4r/O9EzYxTuVeIaCKsJXBobJotfE7mMhhyXcDmxk0rZ8+RoN/2v31sarlgoFM7AluBPUX1nZLaHa6z82MUxjMLxki3BJDOZ7aIkpzs+LUGtYaiWmRhJ0t/YNIj5c/Qldmcy1ivW6sBspeAudfATEn3EmK+/9Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBeinoMa; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c3c30e663fso1142477a12.1;
        Thu, 12 Sep 2024 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726148699; x=1726753499; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0J4Zz/JZ/ibBAf2DdCyLRseOgtVPUiPGuk2oQAO/GNc=;
        b=JBeinoMan7poy/x3E7KpnfzYIyDbzCD0ti3CJxotGioq7PmnekgXfuNT7Nn4Xv0Jmr
         EUY7N70Q2kfBil2edMqY/i1e8qtWRvVCaN9hmJ2rAQz9SRWTW57MdwUmiZMcvdPFQx+M
         i+ypTNMA+1SdzCEYIaUcOfOZ8pc0P6WGYlMO0AO+p5r8p1O1ctm2NlI5FUQVAr4zbw1b
         lEpyQKRh6+fe9lBdXER/0tMZf0Tm/d3950ikB3ZLut6XMsMi+KC/ayMnwfZyiU34EZ7W
         c2YAufP5R7ID2U+WGjRRbTZ3M6hmxxG0dC5c5O3BU1SGp+ozBZOQ3p3xkQlM74IssSJq
         9H7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726148699; x=1726753499;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0J4Zz/JZ/ibBAf2DdCyLRseOgtVPUiPGuk2oQAO/GNc=;
        b=bVtw0aibcJIbRW7MtbXixdrhByuPlJPMOjnzkD8QcyzS/94srsp7ohnjDRK4lXbJy3
         QkYjhuanoX+cWhRFUllv08r5zP8BfbSeMmb0XpB7XCNnyPY/MAm8G45BU85IWiOfN3TF
         vs+ynnO2MFECS5eGI05DeY8jh4Qq7F7GRAWi1lqIeXfDJ9GHIBtIrCir+8N0afzZy/m6
         y8jJK4RMV/P7cc4qXREr3yCutejAMmvQECeMImNoxmLHBq8oGNJspw63RAk1vUxLBGwy
         NBn49APhsgLT9RzSQ7GM2A7hci4UJEOxwQ1fpx9YBKPjSGUs4/xJvGssxXWuJdyfMktM
         E6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXleIB7FyXPjqs3XcYbwk11sXw9q6EnWg/QyaXMjHRQ0DCmbg2R+V/t7vZxX5SvFQSSgmTInhyuP5VZdAo=@vger.kernel.org, AJvYcCXuBllZcSqf9bpZN9mn88q3INbRglTgk5OYSu1NJSh49LxR7iXVLu8dOERThzi82R4ZJwJ75LJXc0aP@vger.kernel.org
X-Gm-Message-State: AOJu0YzM8U+0BW0/A5K/FvrbRsaEx0XgVFphcPO/Z3a4SbFE0hG8irwC
	Sge0zEzQ7ergOFXcoLoT+u74dzKFOdKIzuz7f+LE2vbJTV/CFRnY
X-Google-Smtp-Source: AGHT+IELXkUYy8PREGvMIHX2BYN882hFTSfzRyaoFG76FovqpwnlUqtNCRKTx4T5Wz+jmCmj6pHNNA==
X-Received: by 2002:a05:6402:2550:b0:5c2:4cbe:ac1c with SMTP id 4fb4d7f45d1cf-5c413e08a4emr2569807a12.4.1726148698526;
        Thu, 12 Sep 2024 06:44:58 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523bfsm6613799a12.53.2024.09.12.06.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 06:44:57 -0700 (PDT)
Message-ID: <2bf46273a071cc90e3b33c08bbb0fad475b6e0ef.camel@gmail.com>
Subject: Re: [PATCH] spi: ep93xx: update kerneldoc comments for ep93xx_spi
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>, Mark Brown <broonie@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Nikita Shubin
 <nikita.shubin@maquefel.me>, Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2024 15:45:11 +0200
In-Reply-To: <20240912132126.2991851-1-arnd@kernel.org>
References: <20240912132126.2991851-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-12 at 13:21 +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Two fields got removed but are still documented:
>=20
> drivers/spi/spi-ep93xx.c:98: warning: Excess struct member 'dma_rx_data' =
description in 'ep93xx_spi'
> drivers/spi/spi-ep93xx.c:98: warning: Excess struct member 'dma_tx_data' =
description in 'ep93xx_spi'
>=20
> Fixes: 3cfe73256905 ("spi: ep93xx: add DT support for Cirrus EP93xx")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> I've added this fixup in the ep93xx/dt-conversion branch
>=20
> =C2=A0drivers/spi/spi-ep93xx.c | 2 --
> =C2=A01 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index ffbe0d522bce..dc6bdc74643d 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -76,8 +76,6 @@
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 frame decreases this level and sending one frame increases =
it.
> =C2=A0 * @dma_rx: RX DMA channel
> =C2=A0 * @dma_tx: TX DMA channel
> - * @dma_rx_data: RX parameters passed to the DMA engine
> - * @dma_tx_data: TX parameters passed to the DMA engine
> =C2=A0 * @rx_sgt: sg table for RX transfers
> =C2=A0 * @tx_sgt: sg table for TX transfers
> =C2=A0 * @zeropage: dummy page used as RX buffer when only TX buffer is p=
assed in by

--=20
Alexander Sverdlin.


