Return-Path: <linux-spi+bounces-5790-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CA59D42FF
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 21:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417E81F21C15
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 20:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DCB172BD5;
	Wed, 20 Nov 2024 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bbCw2Gej"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270EB145B18
	for <linux-spi@vger.kernel.org>; Wed, 20 Nov 2024 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134291; cv=none; b=BWCswy7Qmi+wzHSKcmZqzoor2B9qT2bCqtOki6ajK1uA27thJ/fjZlxqzpAy1vPOBOB60oPCTm5ld+c2jhwbO7b01oBAM4IFW7xFr3CU6k32VJYzy3gZZgw31CcY4yVoVaHDPTUQJYmsvqBtGOvuksvo2E5HgblI9k6iTQFC7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134291; c=relaxed/simple;
	bh=+rDU1z69SalK6JzR8mTFd+A6eY5KNtddrtHed7iEQks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fA7giBYdPcrVBGP7/NNUufYFbLdCymsQPC/ODQGxAf80DBP1dijPCLkTJXOJ9apPVcY/agHZjOrkyMh9UQd2iRUvyY52ebzhqa9ni93YU7QWLFhv7ErVNnRPqw8QVWKT3oXMPoUw5hAr5GFAV3QXqZVOX7duyQIS3vcQWy6+pIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bbCw2Gej; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ff3232ee75so2177951fa.0
        for <linux-spi@vger.kernel.org>; Wed, 20 Nov 2024 12:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732134287; x=1732739087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg+6xm5brW/79ZZOgxi+hS8YyznFJJFaoQ16T8rJB3g=;
        b=bbCw2Gejs3vwc+2M6S7nHlscp+CH3UkD8FYglZztXnWVbhTWa+7SSsHAVWq12KG9GT
         jenjCqKFlb1iOQKNKysh4ZmK23tIMfriQpNF2UN8eeuW7TyeQTMlDRmJNsOI8YHKUkkh
         kpw+JfdpZThczw8U6sZOWnvuT15vtwFt9g94g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732134287; x=1732739087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bg+6xm5brW/79ZZOgxi+hS8YyznFJJFaoQ16T8rJB3g=;
        b=Md8qLziGSaKA45OCA1A+OVQq3RUYU0Qmhz5OABBjgdTCD6/EeYaSmq1LlYPE19hRhF
         WZZOOkU4VynnuFRbe3V1lrWmPeY02vdtNkBJSEBw50wvSpexb7hXKzBNuMSlKTXDfkvx
         GBBSYYm68nkN9BssBOFUlvsvamodXdXx7pMYgGLbpSPXgF9jqGd+caKXKSYW7qBUedfy
         kSSeWeoXkv89MiY3Hx31q8UifogKibnkmBlm+7mxydOyGoutfF+qr4bA4hEpTLCD3sqF
         kpFVA/gxzAiqxhtoTIVes+C6sbGQ7QxFHBNtMk5d8xqbODA5LWrYaMF95hgahOx6YVCY
         hhrw==
X-Gm-Message-State: AOJu0YzetOVlP/HxsRxcdS6BVIOF1OWhHpUhZeXBHxhYdzS/ahePE3lU
	yGb+f09hM6O7wWqpKw7NxHb3kNeVcVMwcRHvcOm9CaEybs4J/1jdmNSi8yokAFmls+hLAmo3ILX
	oTjIfBQ==
X-Gm-Gg: ASbGncvEEiSy+yg8h6Mzf2/Z+q/qRcx1CL3qabIoXTl9PCbvoHsMMHNdnWw1V048zrJ
	G8wr6hR30CGXYni9FQJ/3KxT5kLkMOopgTw/gehCm/BHQnTdWy1cKompoUY1FiXskg21wTZ65zz
	fa8ZiqmA/RZYtL1mg/h3cbReW14VcvAo8kM4ZaodXF2t8/Gf7mYh8z4YjnG0GF+x3Y7WhLFCt26
	+vKi+39c6zc0oi7lXRkjTPp6eC9eWZVvY/17sC4o8wgTCED1+NdGyLAhWB2hBUF0FFDXasI/72L
	DWfw4XGqs20T/BaOfMnIH2v7
X-Google-Smtp-Source: AGHT+IFC6afL4LPb7h/7BgZjxNSTc1sH/9N4cRfNiY3fRMkNA1ihAoVYB6a3K6vGtz2Nfn1XQ2SL5Q==
X-Received: by 2002:a2e:9a0f:0:b0:2fb:65c8:b4ca with SMTP id 38308e7fff4ca-2ff8dcf6567mr24375101fa.40.1732134287018;
        Wed, 20 Nov 2024 12:24:47 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff44deac8sm1188408a12.3.2024.11.20.12.24.46
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 12:24:46 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso29513666b.1
        for <linux-spi@vger.kernel.org>; Wed, 20 Nov 2024 12:24:46 -0800 (PST)
X-Received: by 2002:a17:907:2cc2:b0:a9a:bbcd:e63 with SMTP id
 a640c23a62f3a-aa4dd54842cmr423495466b.14.1732134285864; Wed, 20 Nov 2024
 12:24:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1c6bb542f52ef9a8428a0f35dc21dfc7.broonie@kernel.org>
In-Reply-To: <1c6bb542f52ef9a8428a0f35dc21dfc7.broonie@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Nov 2024 12:24:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9TZSLX0Dtbh5_oQK7temAjQCScVFnEY86NYSAO83pQQ@mail.gmail.com>
Message-ID: <CAHk-=wg9TZSLX0Dtbh5_oQK7temAjQCScVFnEY86NYSAO83pQQ@mail.gmail.com>
Subject: Re: [GIT PULL] SPI updates for v6.13
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 05:33, Mark Brown <broonie@kernel.org> wrote:
>
> The Rockchip cleanups

Ooh. Cliffhanger. Continued in the next PR?

            Linus

