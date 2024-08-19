Return-Path: <linux-spi+bounces-4226-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A7A956B2A
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 14:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E695E1F22C5E
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D208016BE3A;
	Mon, 19 Aug 2024 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3yLYEun"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20F16BE0B;
	Mon, 19 Aug 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071785; cv=none; b=XwcSczJ5VnclFFYJuxb40HWJbJXf0sz4XBERT60YMEm6DIUoNa8ZTKB69UnEYAlWbVGs51O2GOmbRFgsOFjfiHBItEngK7/iz0Jak3D6VgVlhtCVGmu/tO4FaANB9kRCJRWfRM4k1Ov8t3ppkbrIn7ag1AabAxSsMCUrqNxFRsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071785; c=relaxed/simple;
	bh=lp8k/aBMEN0xCcGZEnHEVNQTqFuEPYrn79Hb8YVCiqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Es0sZVsmxGvkpmPEjRBHlXd68kh643rRuWHO42O9CnAODQ8O1I+z2tk6ImEqJNLU0ksjHCSwVLnBzT16yU56LPRvIrhuRKOwhDPg9YDnb7xBhnryMpjNHAzzEkH3m3WlZAWBSB7lJ1XQcmSVAU5GS6S+wjyMP7jmuybucEVw9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3yLYEun; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-704466b19c4so2465651a34.0;
        Mon, 19 Aug 2024 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724071783; x=1724676583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdQ6wlpcd6zBFrPcEejABqSNBgPTmAausutHEMyFQb0=;
        b=h3yLYEunsNhhrxBFJc8u4GlEQ7SMcPM9HZSnZQGuns7l3A6Y70Qxw3qokrBwjLXBRT
         lnoPsc/k/gNldtiHnt+gibunaAP/wp2pys63e3mDnh/Z9EaG/Mgr+PZNeurdTBJTNHy0
         PMNq++YV1ZHLbOL56HxlUP1vNgD3aFLPnJwXn4hjfyGgVP+36oelNYTuMgcIspZY4SKi
         8OHI8Oz6KTaHyTK+xHZmVkge7He5tgCkWiJJ1NQnSkM71vnsyXt0bR1s4hfsH5Vq8FJc
         ZrojGzJEqYnmJREQcPZaW31cnsDqRolNnn/ooHc95PN7LgmH3EeI6f301OSHhm6+036A
         IKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724071783; x=1724676583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdQ6wlpcd6zBFrPcEejABqSNBgPTmAausutHEMyFQb0=;
        b=CXxPOkhVIq5JTWjY3p91CgOhnCnxG+KscHcX2U29Wo4NngsIskNpdh/BsG8R9HSRJ2
         ZYgqKr7ZVZ0sluwJct1CZb238QxKuBYcxaFmu60WBM3VtfbAi/ymbFXDKwsKMWDyKUV1
         TnIRe3EFU2PiGYv7G2DG8jfUe7tRjieP52oIrpc8joODPVlbAMZnUYJ5o0fKAmTyGeqY
         5j6ImS7gey7SCJMCNW4f6Od9OJ6rid29yvZ60KkbIA/3qwIu1+jRyT7engUnH9ocUt8w
         w63CIuVYJovdZ+W7sjZurpAhYzFbCHgUepOz4bOyF7bag0ahSqkGsB0Z8LOekDTx/SYM
         GPWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP9vZMTftcIcw1AoSkJ+1+anc31UAHCnBqzbGvVkaqganEj812eRQ/CeO8fq6TKj/APL1xx6xbAyqj0N8=@vger.kernel.org, AJvYcCWqR0b/Neqz+IlHvJGPBINBk9gVI1Fca2XFYAqQ+r0gCgP3m2+g3ipXyflSl3xDv7scmRNrdulXx0ra@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5NR/522lxDF//Z95F8GWWWH4deJQca1A3+8E4C3UgalJjAN/G
	xig+3Y+enyCIlRv+HjyhnS/DsdB5F3nMGGcK3XvuwTs7neTUyGK8fQFCID5tIYBjGoQJ7WQKKix
	cSXZt7k8Rj18Jt+J0L7YCEtnhoLM=
X-Google-Smtp-Source: AGHT+IE15N0b76vGw7BFec9cXVhf38hULEmoTKL9SUvo9UL2HXloC4b5WXGxGQys+J/XAy9a6e+WeCdIzkhXZxd2VUs=
X-Received: by 2002:a05:6830:6602:b0:708:d84d:f62a with SMTP id
 46e09a7af769-70cac89c004mr14821717a34.22.1724071783245; Mon, 19 Aug 2024
 05:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com>
 <CAAMcf8DZu4B2AN+=8xP3wuknqUtD-e-v+Ej31=08ibPfyL+dGw@mail.gmail.com>
In-Reply-To: <CAAMcf8DZu4B2AN+=8xP3wuknqUtD-e-v+Ej31=08ibPfyL+dGw@mail.gmail.com>
From: Vicente Bergas <vicencb@gmail.com>
Date: Mon, 19 Aug 2024 14:49:32 +0200
Message-ID: <CAAMcf8A59MqhZEswC5VmKZyThG7oG=ztEYd_yfuOwvGTvKzMow@mail.gmail.com>
Subject: Re: [BUG] Rockchip SPI: Runtime PM usage count underflow!
To: Huang-Huang Bao <i@eh5.me>, 
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-spi@vger.kernel.org, 
	Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 4:12=E2=80=AFAM Vicente Bergas <vicencb@gmail.com> =
wrote:
>
> On Sun, Aug 18, 2024 at 8:13=E2=80=AFPM Vicente Bergas <vicencb@gmail.com=
> wrote:
> >
> > Hi,
> > i am a user of the CONFIG_SPI_SPIDEV device.
> > It stopped working between 6.8 and 6.10.5.
> > The SPI bus itself reports no errors to userspace, but no devices
> > appear connected to the bus.
> > The platform used is RK3328.
> > The only spi-related message in dmesg is:
> > rockchip-spi ff190000.spi: Runtime PM usage count underflow!
> >
> > Please, can somebody review this issue?
> >
> > Regards,
> >   Vicente.
>
> I've tried to bisect, but there is some strange behaviour:
> The message "Runtime PM usage count underflow!" can also appear on a
> good kernel.
> In order to have a reasoble iteration speed, i am updating the kernel via=
 kexec.
> If a good kernel (6.6.30) is cold-booted, then, all the kernels
> kexec'd from it work too.
> If a bad kernel (6.10.5) is cold-booted, then a 6.6.30 is kexec'd and
> then the same 6.10.5 is kexec'd it becomes a good one.

Added:
Huang-Huang Bao <i@eh5.me>
Linus Walleij <linus.walleij@linaro.org>
Sasha Levin <sashal@kernel.org>

The first offending commit is:
29d8101fb9442544077e68e27839a1979f85633d pinctrl: rockchip: fix pinmux
bits for RK3328 GPIO2-B pins

I've also tested 6.10.6 with it reverted (and
456447ff1fe3c28e2fd7b57a79650f62245c6428 and
7127c68c76f120367b9a5053f524df0b603d4a48 as dependencies) and SPI
works fine.

Regards,
  Vicente.

