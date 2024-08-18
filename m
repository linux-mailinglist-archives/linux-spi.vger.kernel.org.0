Return-Path: <linux-spi+bounces-4204-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36EE955E96
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2024 20:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2319E1C20A85
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2024 18:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4940E145B26;
	Sun, 18 Aug 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkeYS0ip"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94D8145A07;
	Sun, 18 Aug 2024 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724007322; cv=none; b=WzLNTwgCd9sMWUGkdqk5P5IG9xIeAYZyZBzaYOE5BBKK7o+Bs2FERy9BrD8TQlGvW2Qb4pbWg/bOrnGUmrQSxBk2fXy0BPi4oa54RbGrcrAb8XsfJIdQdCEQW1+pRC4vRhRcyN3i/OCK1EUfxYeXBCW+dIjR3alNKxMwghaEKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724007322; c=relaxed/simple;
	bh=dDpsyYGeA5eOoORAHthUSrzLb3KqVvSbYH5TmClOlN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAtLL2x50iP9y6i0FEN/c8N0cK1LSndWGoM2pWYldxLmLPOVMy8xvBVYHRExfzgtrX8S5KnoG7g6v0CAnQdk5qawu4bPp+NFR9gyz/VKOvGXgeG/udrHhxqhxRohtwM/jd367rU/SoCARVVKGpggx4/KIq3ecliFr+zdIM11x18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkeYS0ip; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f6b7250d6dso1449014e0c.0;
        Sun, 18 Aug 2024 11:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724007319; x=1724612119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkBZ2h3iZ+EDA0daVELGPM/RkHd4UmsNjGPdeD3JG/c=;
        b=IkeYS0ipvlUWo5H77F1aqnxosj3W+LwrOltolpmaEUBSirHkz8Wn4xCCsNEsBa69xL
         j/XLj14AJ5K+jOF1MKU+BI+64Vu+8A1YZtNLthrGbEF5W7ptnHEZxTBntVUx6EJiGI8J
         ofR6adMWfaxkG0rSXR+7vYiqkcNKDHpcu9BBRSddvpK5xI8fjhyPZR/XpAVynicL1TDc
         1oB0yXBPCWPtA9URlCioJrwXwPHMocbmvhBS6npDQvyeFsstwQsYbNb4T98efTIcuo9H
         Kggb99yVgqqDqvu9XpvDuZmBX8JqA/XHMII9BC0jCMFDsi555wCX1Fc85vIyhAKaF9cz
         ebow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724007319; x=1724612119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkBZ2h3iZ+EDA0daVELGPM/RkHd4UmsNjGPdeD3JG/c=;
        b=V7BRynis/TPY8zP6rNAZITbe6zOGsD/Hz/2tMKtRzFwBJXnSquccvmdhFokKK//Vv8
         iYkA3aG1xQ0EqlbBozVfebBgT5KvqpV1LosmfBj0o8aNW+crRKTe7WejPLjecPnTALi6
         6LA5Qx2jZdkORXrTQa975mGuYzkovr4gbHKfsB3DdRLrmIpxQDWG0cYd6R4k3XR1CiIR
         Pgtf12CMDyFmvE1ykck/nySzbdyjp1ygZ03ggEKvJ4kSdMxMV0N8XWQOW1jbfzb66gx4
         D2mRt2BpGOh08veGVNkHhAW2LfswT/r6J2+DPnbiqzCsrL6VngsZHowsQG4yT3AyBM9H
         U5Tw==
X-Forwarded-Encrypted: i=1; AJvYcCV8NNeUZEQqANztyh2UvH59ekA52OgiUHbIqhqL5Qp8nfJvL2b5uH4ZXp2krYLHuNajh8+Bu3ddB9V9RTI=@vger.kernel.org, AJvYcCVDhtajXi32+2u2BjKHE9Yo8n/DWAzVH7o13jMjgAd8Ycmbf6bjZ4m2Xdkr7dKn5cy5KD0A2wLZ9N+o@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4RPCoey0HSjOtn4Ea7PkF1vf7QDyybuCvCjggqQQ2967yJjkj
	Mmxo/cMK4wHnma8A9WDDtUV9q8KbW1uXnUuuuImbH0IxGJekGRpEevB05is88WIxE5Tl1hHvevA
	HCCbNpHzKalJy9gU9XJC2I+8hOYY=
X-Google-Smtp-Source: AGHT+IFZcpIY2jJOe8nKCi4fbnzwuApcj7YtlLR/l2dWkzI35yiS0NekFFlrICVUkru2Zj1GA1KAO2SuPef0fE7RkrA=
X-Received: by 2002:a05:6122:3094:b0:4f6:ae65:1e10 with SMTP id
 71dfb90a1353d-4fc6c5f0eaemr11007678e0c.4.1724007319530; Sun, 18 Aug 2024
 11:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com>
 <d35a5c5216ee3d0321c725aea61e0326@manjaro.org>
In-Reply-To: <d35a5c5216ee3d0321c725aea61e0326@manjaro.org>
From: Vicente Bergas <vicencb@gmail.com>
Date: Sun, 18 Aug 2024 20:55:08 +0200
Message-ID: <CAAMcf8CFED71FKUBpRy+FZNf8XKim1fuxW1C+ErZQqLsaWm1yQ@mail.gmail.com>
Subject: Re: [BUG] Rockchip SPI: Runtime PM usage count underflow!
To: Dragan Simic <dsimic@manjaro.org>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-spi@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 8:26=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Vincente,
>
> On 2024-08-18 20:13, Vicente Bergas wrote:
> > i am a user of the CONFIG_SPI_SPIDEV device.
> > It stopped working between 6.8 and 6.10.5.
> > The SPI bus itself reports no errors to userspace, but no devices
> > appear connected to the bus.
> > The platform used is RK3328.
> > The only spi-related message in dmesg is:
> > rockchip-spi ff190000.spi: Runtime PM usage count underflow!
>
> I'm working on a related patch.  Could you, please, describe your
> use case for the spidev driver, i.e. what board are you using it on,
> and for what purpose?

The board is ROCK64 and the purpose is to update all the software that
board runs, which is stored on the SPI NOR flash onboard.

I have not tested this kernel version on RK3399, but it may also
affect that other use case:
https://gitlab.com/vicencb/kevinboot

N.B.: My name is Vicente.

