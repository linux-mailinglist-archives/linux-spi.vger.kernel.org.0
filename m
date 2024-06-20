Return-Path: <linux-spi+bounces-3503-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4D8910818
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 16:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464192824BF
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 14:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E711AD9DA;
	Thu, 20 Jun 2024 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OL5Nao81"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85181AD4B2
	for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893527; cv=none; b=NSUKAr2ZKqj4qh0ebMjSV7F0LuxeyEsy3W6SGsqO3oiyNN9TiRUW5ZXUsI188CeA5LSVEG8WYyL/hp8npbs//vJprHDIUjH3HyS4nqWl3NYrma299n1t74bbn4FSpAto8Pd4khqpZDZWFhun6TL86/S9797wWtNKdEmWvRHsI2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893527; c=relaxed/simple;
	bh=SQMNm/Wgloa85H/6Ml/z+UyGgCgN9Pm78Q6nwvCTYt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yu41Nl1za7yqbJZW55uNPjbaAHh4P4Vrmt8URgBo0Iv+pIa2M/aCuJ8CVDh8upjnbl1XecbSDufeaMxXYmMVQjrYunQgIM2fG2LZ7U+qnjeA5kdCrdMfmTMVwqRYB9MwbFlkvO7hsCceVGgcMzvKnYPZN2Mub9qTMm9oDUPC/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OL5Nao81; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-63127fc434aso7848967b3.0
        for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2024 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718893525; x=1719498325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SQMNm/Wgloa85H/6Ml/z+UyGgCgN9Pm78Q6nwvCTYt0=;
        b=OL5Nao81oJKls2x2xNXV9G/VLUWSItD0Hd5yBzxZJLJGqX9SgVyy8wVwhM+yLR3Pt6
         VOmNxrF+DkaYmKE/3PIJU7OlYgDBiw5J32MA5T3egKvH3nwuOu17c3OpzwWVC+/Sr/Wc
         +uoGBWMVqX4jjUQoWheH+2bByYekd5OpcBXVzVVCajXw8b1o7GFQxrPzuEQYQhUZTgpk
         Ia3I60JHSstYsf12I4wXrEnQJwSSVFXLhBlkltpMs9G2RDxnNbwIk7cspOMP5/LnCP4O
         y+o9oVIEFY5qGPvpEZQw9/MRcgpz+EMbDnxh6ZGVZtMDSs0mf9ZTmOvQGBml8eRBw/aU
         6CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893525; x=1719498325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQMNm/Wgloa85H/6Ml/z+UyGgCgN9Pm78Q6nwvCTYt0=;
        b=n3vGYjOCewh+iJUdM5/+XhGD+vlXuQECn8RbscFjEJ6Wevqp2vE0GiRCBlw71NoNam
         5egvvd1V/V+p0F7tknfMymq1Nf+0vNo0rJDuoh4TMe1rbqEyb8+chu04mmES6N9y2jDl
         8wMctlYSSTlCtRVakd4iFcoAAH1mAgxk36tqB9o33N4Khk/a1wVLZHIf3gLRhvAwkLxz
         DUqBu7ZKT6JJTY/ERYjJcuyuPCd4aKSwHXWMmpRT1VqnaadVXNJztirzKdqKLQCbuOK3
         qtqLRUGdSt+AJD9QUMfX1qOd92I/MHk2uXkm9aUSUhDLIehXdA/9b19p0QacbOtjlzrv
         shjA==
X-Forwarded-Encrypted: i=1; AJvYcCUCNRKV0qarerzDXOM5Rc/koETJwWHqINv9T1ayv99J2q+QbahQovC7CUzSrWxtOkwDaCTO4gpZI5USeh2PCNNijYeINjRkMTGX
X-Gm-Message-State: AOJu0YxxDA/pwydP4+F8Fw9X6R1q3ZRaFp8kWM7osqu+jQoifRRyxrDB
	6v8pqAVjqdPS3nGbiNaqYSfk5pgaxyuiZ8PUd77a4LRbvJveaak9FtG0FkzTAHs4lyY/VfgRo6G
	dmubahREUiZhU/l3alOOePClb0LWSAaV/vS8VIuTniGXWqCdW
X-Google-Smtp-Source: AGHT+IHR7fpKdExIeayYO8J71ywzwR+4VpYOIFbdfii6VoqwkxcVhItB0QotOZnRgehcLXlgkNKGKaigbbl58w+Xms0=
X-Received: by 2002:a25:8188:0:b0:dfb:1ea:23ee with SMTP id
 3f1490d57ef6-e02be17b1bamr6168497276.37.1718893524724; Thu, 20 Jun 2024
 07:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612-brigade-shell-1f626e7e592f@spud> <20240612-dense-resample-563f07c30185@spud>
 <CAPDyKFozcUPuMooDHVSBZomHTGKzseVf9F=YBY_uQejh9o3x7g@mail.gmail.com> <20240620-sabbath-ambulance-b8764fb386e9@spud>
In-Reply-To: <20240620-sabbath-ambulance-b8764fb386e9@spud>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 16:24:49 +0200
Message-ID: <CAPDyKFre12rqqwar8sfoWyc6duS3psp4OT=W5ToG9r_EdqH89w@mail.gmail.com>
Subject: Re: [RFC v1 1/3] mmc: mmc_spi: allow for spi controllers incapable of
 getting as low as 400k
To: Conor Dooley <conor@kernel.org>
Cc: linux-mmc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	cyril.jean@microchip.com, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 16:12, Conor Dooley <conor@kernel.org> wrote:
>
> On Thu, Jun 20, 2024 at 02:50:15PM +0200, Ulf Hansson wrote:
> > On Wed, 12 Jun 2024 at 17:48, Conor Dooley <conor@kernel.org> wrote:
> > >
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > Some controllers may not be able to reach a bus clock as low as 400 KHz
> > > due to a lack of sufficient divisors. In these cases, the SD card slot
> > > becomes non-functional as Linux continuously attempts to set the bus
> > > clock to 400 KHz. If the controller is incapable of getting that low,
> > > set its minimum frequency instead. While this may eliminate some SD
> > > cards, it allows those capable of operating at the controller's minimum
> > > frequency to be used.
> > >
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Looks reasonable to me. I assume you intend to send a non-RFC for
> > this, that I can pick up?
>
> I do intend doing that. How soon depends on whether or not you are
> willing to take it on its own, or require it to come in a series with
> the spi driver changes.

I can pick it separately, if that makes sense to you.

Kind regards
Uffe

