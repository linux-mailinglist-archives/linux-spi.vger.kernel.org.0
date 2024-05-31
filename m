Return-Path: <linux-spi+bounces-3175-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B528D6279
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 15:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F6A9B264E2
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D20158A3F;
	Fri, 31 May 2024 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVZ/TzM1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB08158A02;
	Fri, 31 May 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161063; cv=none; b=NVUsutoRjsNtTyM9Lr2L6juwQwmJnQFlF0j47Lg4mtiGAzVFrDeOdWc3ReBUzMs7YeLVXpaD1dI31TfVAXb9Tako/8greJj3LsjaB3jle+I0IUyAynoLwxZFqallA1+H5zFTI49MGOy7/OoW6ObPAKT/JH5lejAlZdwRVEPiUHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161063; c=relaxed/simple;
	bh=vYhw5UUQUky0CjkeCADHyX32yK5HSVjizY87gvg4ohU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2ZoUkVT7Uj5xFA+Mqaj7Um3g4qC4XWLVP0wtTn/0Rnsf8yFec663doZQ14a6umlWUOWOpQGxqjTl7xawr16fIatI+DyydON0vywg4bFS1meosNFm1GRa7RNaoUF8gDub5mGohFGMOKS0Mwl3JthJNmJzHRJV4dr+31w/mGxJ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVZ/TzM1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a634e03339dso128827066b.3;
        Fri, 31 May 2024 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717161060; x=1717765860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYhw5UUQUky0CjkeCADHyX32yK5HSVjizY87gvg4ohU=;
        b=UVZ/TzM14sDH9Ni2LAl2Rp4j0lDvr3D9qVvz83R5Pskxauqtz5GvJzRoHG2NVoJ7R/
         f38hpqzP4YFWxIjpGBr44igB9iHLLsBjb5CZptyRK+YAhfkxJMGOfaDxmdcVcRvjyiUz
         +U+ZFSjeLr2EV+dRLyEcsjNmZq3MIBuADXTlfKbPP52MTeFc/mBYQPOZLN62ozvnS+TV
         uiXJQt6uh+FJzP9iBVXo6DFyk3b7NNBykc+B9h6bJdIBuY9prJAymsayNfysth29wR9c
         KyRecWr4x+EDg03USNoBIEKOBAsIKar3mBfFZRxaCClxdP4atNcNYfy0jnRIvECLJUMe
         KYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717161060; x=1717765860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYhw5UUQUky0CjkeCADHyX32yK5HSVjizY87gvg4ohU=;
        b=JKNLDkQqaUAUkuqleboOS2Rj1MBraB6gnZgLSiLGgEGtlGMyk7gee9CTYxlutHyQrr
         lSrJymKnp/sA9DlCNe0H9N8f+EXmYiFgJJR/f+ZcSjpflSUwK41e+7cEb180NMxfegin
         5KHQM5jU9zvar5EvaBuSlb3sULqCiStZgmmSUjUccPvboPdEPODXvLEONdoRdNj2ULh0
         iMw7rGsPeOjP/9/jnO/6ItsiUjoMmFiyukJEECKpWg5PzeM8hrFaUBZ3nwJok4/5QQJo
         MX1/kcu101EA4Ly3OeqUX2zKXEHr38kb01iGiS3YfbsMBoueHbqit7hBG2t+wIOKATC7
         wRPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXBjFsVd0FswBt7zj9D5TMypMgEG6ymHZ13NGC5bh2F/JRs0zWs0QsAQjstto1JhmQDOXfOBvwF2gVFR75+f4Tz71xvE1E4n/PAo13
X-Gm-Message-State: AOJu0Yzvfgpk6a4UvL+6UIEXXr4V/EkfAoiqyBjfb6kEMfkyf0XTeUFg
	WQGzbFkqgwce58HcAUb/YDTaz0lEb3ARgCw6WJls8mcctGNbJoUiW74RbFIrRNfL0Acj8q7bVMu
	UY0ly9x2JZhERt0ujT5zp5yEEYmYezadEmdI=
X-Google-Smtp-Source: AGHT+IF7FWWerFN3tYRlR39i7AAGTup3perSgx/iHdJSCfpMuOLcmfs82Yw11UmSdu3SrPX7aeaHxBP3X9/9vnws2t8=
X-Received: by 2002:a17:906:2c0d:b0:a63:49a9:7906 with SMTP id
 a640c23a62f3a-a68220496f7mr121453766b.52.1717161060258; Fri, 31 May 2024
 06:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
 <20240531094658.1598969-2-andy.shevchenko@gmail.com> <3305f8ef-ccc4-4f95-8141-67c7adeeb21f@sirena.org.uk>
In-Reply-To: <3305f8ef-ccc4-4f95-8141-67c7adeeb21f@sirena.org.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 31 May 2024 16:10:23 +0300
Message-ID: <CAHp75VeOTVWr5V09aFWbSYYnY_0Tz36AD27aKeYHqkOu-3tQCw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] spi: Revert "Check if transfer is mapped before
 calling DMA sync APIs"
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 3:15=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, May 31, 2024 at 12:44:32PM +0300, Andy Shevchenko wrote:
> > This reverts commit da560097c05612f8d360f86528f6213629b9c395.
>
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

Sure! But I will wait a bit (a couple of days?) to give a chance to
get this (re)tested.

--=20
With Best Regards,
Andy Shevchenko

