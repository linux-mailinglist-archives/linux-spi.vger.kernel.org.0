Return-Path: <linux-spi+bounces-4206-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D39955ECE
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2024 22:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE87C1F210A2
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2024 20:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC1312FB34;
	Sun, 18 Aug 2024 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8eHaiei"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D215E96;
	Sun, 18 Aug 2024 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724011817; cv=none; b=gjOH5hlrZo/juRUqDKBMDEV17i8ldKOGs/Faq4ov/C5PTYv4gFbpFAS/0gtYFuQ0VxYGdmcknw7vCFs2t0FF8EjkHDUGG3MgmFZGlK0mfWe1hnr7EL661bZ0IB0fxO9PF1IBrITC210cakKgr4Of+J3V5qeOhC5x9BWD5X4FIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724011817; c=relaxed/simple;
	bh=uJGDB56sVeipkrQtaQqsgJwyDlIKrHdunQ5iELVKJy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeMrJ9mfd9ExPP11EQ762inCzIPhy5XgPuhZUUK0GYYz9KpcYmmURBlj96NbCAkB/embL9HR1k84RnDeCbqQYbjdOX3ABYZ1MIvRXUO/ELrf1XFv2an4FYIJmVHLop71as7kV57Qd4/533O6gzgyRrpmDsAeyQs4OEcLb7QQb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8eHaiei; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db1657c0fdso2324616b6e.1;
        Sun, 18 Aug 2024 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724011815; x=1724616615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy/+jzT/NOiYw3uhsQ90salDPTFe4qnoDBEo8k9h6Rg=;
        b=V8eHaieiVDLz5m3usH1RccfBAEimd0v8WRGF9Jsfq9sG4bkor1k+3ecRBX68H7KeG3
         VSwHoy9W+p+Zxrnr4Y1Y5R741EWzQLUpIPqAwVkX8DcCbzREcJH8DbiCvjr9eIRxGPO2
         yHDkmBjUqPU6tfTvcoZhWdcGYy5ckP20pyROOy0g+kzPoQOMnUJXIqUp26lq3/Q2bJmT
         cQwbHujwOEHUNpnOW9AyzyGnvbRgow3ataq2wvTwGwc8LZfVZhgll39zfPg0jfwAzVNi
         tYcKqwN5oVkCyKWDpooxn1U/pIC7Zofq9EGDRmfftlQYBCsT8LY1OQgWriz0XtZTY4mR
         zRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724011815; x=1724616615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy/+jzT/NOiYw3uhsQ90salDPTFe4qnoDBEo8k9h6Rg=;
        b=qeVg9IGtWWzCW+kPCSLzI7ysGkx+MLYljkSNtzVZpiXF9v1r4DOcu59jnDJDqlPzq7
         kJmuRN1s2nT3alkfMHCERzESkq3/6kuiCexsB2R6U7XSRukMuqFcOg9NpK2Wv4n3h3SJ
         k402OVPxZd8Upa3xSwQNZre/JyqRcN9qPzDELx4r0f51T/JO8B+YVwCaTclGUEpw9hzi
         ojmtgV79Nhcr8OpAlVZUDFkYN7Gz++fbqB4saKH792gk0Kza+h/shIxWjMsO155JtRTG
         8r+YXgUjExbC7H4qTbvS9I8drlBMKzQXIC4gAxMkrOHuWC75457lG6ByonfCGE2aYD/w
         0NsA==
X-Forwarded-Encrypted: i=1; AJvYcCUnu6MEHlKOft0IGJbdMybXaLnE/b+s8JSL4/tPdGTEI0+DWYQrHTXG9x4OVjvI89//eBbFxisq7CBchTzD2v5esHT1N1PZn8az5143MSKNKygetnkfg1cYpAxdUVVF+pSLo5wDUfod
X-Gm-Message-State: AOJu0Yxf/J1AgqwgBloDjZDxMhfIzz+UJeZg2zdab4ouLmeVyLklYUYU
	dMQSgBJSbdFSm6fQQ3Njim0hoo4B9PrQpIkinc5eQe3PdQk9m3A1m+kMfcdHIiA/Y1gEUAKrbV0
	7h3UR76kgxPYlgCBg+4mE6oU9LcM=
X-Google-Smtp-Source: AGHT+IHJoFs9kq0DonN2CXQEo5pYPafXJaMBOnGljUPRyg7t7x+vEVzjt5+Y7d1CumebXA2fN+0KbrIMpMBtlZEUGPo=
X-Received: by 2002:a05:6808:e87:b0:3da:bc80:b233 with SMTP id
 5614622812f47-3dd3ad546bdmr9654294b6e.17.1724011815630; Sun, 18 Aug 2024
 13:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com>
 <d35a5c5216ee3d0321c725aea61e0326@manjaro.org> <CAAMcf8CFED71FKUBpRy+FZNf8XKim1fuxW1C+ErZQqLsaWm1yQ@mail.gmail.com>
 <4455b5175d3c372c15d9732f03b9eb20@manjaro.org>
In-Reply-To: <4455b5175d3c372c15d9732f03b9eb20@manjaro.org>
From: Vicente Bergas <vicencb@gmail.com>
Date: Sun, 18 Aug 2024 22:10:04 +0200
Message-ID: <CAAMcf8CpkZHY6Awyo3LWZXfkqbZ1z3YcvF5W_08uv-XNov2j-A@mail.gmail.com>
Subject: Re: [BUG] Rockchip SPI: Runtime PM usage count underflow!
To: Dragan Simic <dsimic@manjaro.org>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-spi@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 9:20=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> On 2024-08-18 20:55, Vicente Bergas wrote:
> > On Sun, Aug 18, 2024 at 8:26=E2=80=AFPM Dragan Simic <dsimic@manjaro.or=
g>
> > wrote:
> >> On 2024-08-18 20:13, Vicente Bergas wrote:
> >> > i am a user of the CONFIG_SPI_SPIDEV device.
> >> > It stopped working between 6.8 and 6.10.5.
> >> > The SPI bus itself reports no errors to userspace, but no devices
> >> > appear connected to the bus.
> >> > The platform used is RK3328.
> >> > The only spi-related message in dmesg is:
> >> > rockchip-spi ff190000.spi: Runtime PM usage count underflow!
> >>
> >> I'm working on a related patch.  Could you, please, describe your
> >> use case for the spidev driver, i.e. what board are you using it on,
> >> and for what purpose?
> >
> > The board is ROCK64 and the purpose is to update all the software that
> > board runs, which is stored on the SPI NOR flash onboard.
>
> So, if I got it right, you boot your Rock64 from the SPI chip that
> contains all the software it runs, but you also boot Linux on it from

correct

> a microSD card, to update the contents of the SPI chip?  I'm guessing
> it that way, because the size of an SPI chip is hardly large enough
> for storing even an extremely size-optimized Linux system.

No, everything is in the SPI NOR flash, which is 16MB in size and it
is enough for my application.

> Anyway, I wonder why do you have to use the spidev driver for that
> purpose?  Why can't you use 'compatible =3D "jedec,spi-nor";' to access
> the SPI chip through /dev/mtd0 under Linux?

The bug report is about the SPI bus, MTD is a service provided on top
of the SPI bus.
If the bus fails, then there is no MTD.
That said, i don't use MTD. The bootloader reads the kernel, dtb and
initramfs from the SPI flash into RAM and boots linux entirely on RAM.
There is no persistent filesystem on top of MTD.

> > I have not tested this kernel version on RK3399, but it may also
> > affect that other use case:
> > https://gitlab.com/vicencb/kevinboot
> >
> > N.B.: My name is Vicente.
>
> Oh, I'm sorry for mistyping your first name.  Should've copy & pasted
> it instead, to prevent such typing mistakes.

