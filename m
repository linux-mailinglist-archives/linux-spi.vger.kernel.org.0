Return-Path: <linux-spi+bounces-4228-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B6B956B95
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 15:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FA71C22315
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 13:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2055516C451;
	Mon, 19 Aug 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwPRUbzR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9109516C6AE;
	Mon, 19 Aug 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073261; cv=none; b=msH+JZXBToYDqlUPzI6QmBwv4xFCkHtl0oQPnd66Jm94K0HUOfG3KmuiMQt9w/z3YoOEXVSCMHjzTVTSdCHSDBr/Ab5JFnaAk3BB9eu+xUkeGRSboAYEy57xzILF+jImE06NleztXP6DCZh9Xc4XQ0cQPB9OWEMt357X7MEYzqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073261; c=relaxed/simple;
	bh=qeEpcCTvs83cwTBoyn7nyFmxSbKELxCRPXfPvquEy3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p18cMNABFwLwI5MwypaTRub2SwV+p/KEV1lMYOu9axCHw6VhKSda9Cc9Qy1aKY6eZZC/qmLfE0d5+9Rv4BoPNS3wduc68+wPObCC6HidE42Kvrhbl5uGxAUbaTYRVkgjgHvEAZStbucrzboi89ibtPVZLEu7oqvUKKG1In8fPUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwPRUbzR; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44ff7cc5432so33627131cf.3;
        Mon, 19 Aug 2024 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724073258; x=1724678058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Wnf8Vek1pXTYVFxgy7NN2FbreAvac/mL1LGB55sZB8=;
        b=BwPRUbzRZjgD//KWbfZZQqNFkfynRW8x3drIatYSfxW6gEUOc7Q+090n31K3LKlT7b
         N7qPNplr6fQAflgGSDFunyr4wmrX/ZARKLq4E1nmzfcFsD/WB2A/Qb5H8WnZqnVs/Bi5
         FYzV4Zx7l1kvTI9DOH50hJRg/JYEjs+0j4HdnCF9wkFCtYCln7RkePMPsILlPRSf33At
         LVnLbiX+QBjKWkYa6pfacBXBYPSJQsNoJZXTmJZPrNM4vVySfWPPNLRF5FTUEeueWlEZ
         Z6QSwhkSbJRa1HopsWA4re5GFRj7ES5s0DpvMbqJY6jFplhXd3NYRiWLE+cGuYOxs4Hl
         SJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724073258; x=1724678058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Wnf8Vek1pXTYVFxgy7NN2FbreAvac/mL1LGB55sZB8=;
        b=sEVq/tci5k3LfOJQKZN/JRXHrsndixwbnEj7ujrKI3aSAiKYjX/4hixjYFaSrmYSam
         AXENsnwO3llsG7crLO3CWiTaIOuiiAJ18C3Ja6Qdu0T4ZBoy9A/qvvD41jLKn4/e1tP7
         YecsTnmQEWZAwkz7/DYvGiPSbM6vQUXxPcGNSj39QNmaca672z3secsINUxIJQ0HG8vn
         w4WCSwTToVMRnN371emTQhhldFXDKvk4Yg9YI2GnMzlMMJPwo6QZWRQSK5MP4AQLtcwj
         XExGfd3oMhhg1HU3akh46dQj80Iekn+mtlxYlEoInznkN4OZNE0gPNcB0xIp+LnnQFry
         Mf/A==
X-Forwarded-Encrypted: i=1; AJvYcCVxHEX0vW/byOktZ3gUEkuOBlcvoTo2V6YKQzeVmrMxc5287acmcngL6g8Zz6v5h9PeYGyzdgp4SRE+gsw=@vger.kernel.org, AJvYcCWorDZG2JxormOkagupyM80NraSocRJnuH8SAf6UlEmNomihusIYI/zR5IhB7WoUAGLS/fS70L6ua7M@vger.kernel.org
X-Gm-Message-State: AOJu0YxuNYMZJF7fLeytz6LGZvGYYd3Up/2bHLMWnCHpR5MT9mQqFfRO
	/3OVGu7wvT3F0bPRiDFsm2v/WOO/yaOaZkpMLUHa2uSIDRjVwhfbAl63uiOxoqIS0WOrIut2ICH
	siJe901bX+k91KpF4nyICES9OnAfqH7PDAco=
X-Google-Smtp-Source: AGHT+IFLBkF0J6o432Y3Zy+PaCUGi3zp/x8gPERl08DGLbLG4sy0WXZFbK+iZ5k2pEMDYH4oOpsk18fjk3P1xDR9I3k=
X-Received: by 2002:a05:622a:244c:b0:44f:e108:2854 with SMTP id
 d75a77b69052e-4537429fa1amr157807041cf.26.1724073258537; Mon, 19 Aug 2024
 06:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com>
 <CAAMcf8DZu4B2AN+=8xP3wuknqUtD-e-v+Ej31=08ibPfyL+dGw@mail.gmail.com> <CAAMcf8A59MqhZEswC5VmKZyThG7oG=ztEYd_yfuOwvGTvKzMow@mail.gmail.com>
In-Reply-To: <CAAMcf8A59MqhZEswC5VmKZyThG7oG=ztEYd_yfuOwvGTvKzMow@mail.gmail.com>
From: Vicente Bergas <vicencb@gmail.com>
Date: Mon, 19 Aug 2024 15:14:06 +0200
Message-ID: <CAAMcf8Ctr9rOZ2oOzk48haakJOO2bzyNURb2oZTRxJ3tnafXUA@mail.gmail.com>
Subject: Re: [BUG] Rockchip SPI: Runtime PM usage count underflow!
To: Huang-Huang Bao <i@eh5.me>, 
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-spi@vger.kernel.org, 
	Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 2:49=E2=80=AFPM Vicente Bergas <vicencb@gmail.com> =
wrote:
>
> On Mon, Aug 19, 2024 at 4:12=E2=80=AFAM Vicente Bergas <vicencb@gmail.com=
> wrote:
> >
> > On Sun, Aug 18, 2024 at 8:13=E2=80=AFPM Vicente Bergas <vicencb@gmail.c=
om> wrote:
> > >
> > > Hi,
> > > i am a user of the CONFIG_SPI_SPIDEV device.
> > > It stopped working between 6.8 and 6.10.5.
> > > The SPI bus itself reports no errors to userspace, but no devices
> > > appear connected to the bus.
> > > The platform used is RK3328.
> > > The only spi-related message in dmesg is:
> > > rockchip-spi ff190000.spi: Runtime PM usage count underflow!
> > >
> > > Please, can somebody review this issue?
> > >
> > > Regards,
> > >   Vicente.
> >
> > I've tried to bisect, but there is some strange behaviour:
> > The message "Runtime PM usage count underflow!" can also appear on a
> > good kernel.
> > In order to have a reasoble iteration speed, i am updating the kernel v=
ia kexec.
> > If a good kernel (6.6.30) is cold-booted, then, all the kernels
> > kexec'd from it work too.
> > If a bad kernel (6.10.5) is cold-booted, then a 6.6.30 is kexec'd and
> > then the same 6.10.5 is kexec'd it becomes a good one.
>
> Added:
> Huang-Huang Bao <i@eh5.me>
> Linus Walleij <linus.walleij@linaro.org>
> Sasha Levin <sashal@kernel.org>
>
> The first offending commit is:
> 29d8101fb9442544077e68e27839a1979f85633d pinctrl: rockchip: fix pinmux
> bits for RK3328 GPIO2-B pins
>
> I've also tested 6.10.6 with it reverted (and
> 456447ff1fe3c28e2fd7b57a79650f62245c6428 and
> 7127c68c76f120367b9a5053f524df0b603d4a48 as dependencies) and SPI
> works fine.

Sorry for the noise:
reverting only 29d8101fb9442544077e68e27839a1979f85633d makes it work on 6.=
10.6.
Ignore what i said about 456447ff1fe3c28e2fd7b57a79650f62245c6428 and
7127c68c76f120367b9a5053f524df0b603d4a48.

> Regards,
>   Vicente.

