Return-Path: <linux-spi+bounces-831-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D7183CF6E
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 23:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA471F22347
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 22:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4723510A2D;
	Thu, 25 Jan 2024 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VO+BhBcB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23D11187
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222103; cv=none; b=dPdiWwLPjeoySoySXFZf4Skvg/UfAD5wO4vosukg0/n9h9/uNNyLG3YJoZgkkwaPxy3tnVECRIdd3ATSlYniN2WkLEdtA3tDd63/KKFSmnD0tck40DS/ApBCwGwheOWMo7jYRgS8Nudtf1gNqlKFRrjtsSDmbHdmG8LxJA/WiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222103; c=relaxed/simple;
	bh=PWubl/XtYBpas/AdivCCWYMQQNqPtjT7WZPtVgnZW+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4cKE/1d7EW8QhOKtB8x+yYC2zmqsthtTcmvq+KAapH5Yy4WwbIZZr2AG77Tp2dKThltleFpFO39Rz1tf+YCn9rn23h4cThYoDn1hfYUxUrJNeP9l1XzSQ3L01kGsItIlI2Bg72M8DcG6agtz5Nr3WZWtbyj6dFjXNUfhqTwvng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VO+BhBcB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so5543654a12.1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 14:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706222101; x=1706826901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Eb0c3haY7NyGtB+8UjAu5Wtfyd5HZxv9SnvbZwJOFM=;
        b=VO+BhBcBfOPmcG1cPgDAU5nnE9lVBnxh4uTePyfceSP+NDbNp+77ub6+WkdDe2IWGh
         //oOTFgFYLmVobOMyrt3vO+Fp9VefZ7ZC/Y07TKGM+0vDiL05geJOKM0DtKiOlzcq97q
         ig1UYrbMCjq3bDQCUt6bTIgqmidkKMkzVvb8wMvNd+52YMdTDhRBJLB66eygo9dZJnZy
         1pHmHEsshFa1TViFRsy+va8Qi8aAKLFoER0dYXy85NZpYa4zvdmRTykZNxtxNCX/Tf6D
         oPpxwPMmQEsEWrhoPphPT+zmUd27avLnH+OnK8HJGY4uANbt3drRJkNwK1qnzwtxZGvN
         UBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706222101; x=1706826901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Eb0c3haY7NyGtB+8UjAu5Wtfyd5HZxv9SnvbZwJOFM=;
        b=XFLSRaYlS5UXFXSDsiMEMOHV6+gCwIkFT24oo4LzeBdLYvXuGUmpDJeg6JsSu0DTdC
         xOoBYtAZdNi/qHSW1Y7wJ9Mniqf/MXGDoM40Xt4xABpuit0UwcSSF2MElx7sv+jZKSkW
         FgjcOBoM1+Cwflcqa72Aop4nMcPaVFt0pspZ2AGYOBXeJAhcKA+0IxJX2c2c1g3lUTBb
         +izLMP2VR5G229bdtBtPHgc+rppOuMgcxNbFdsxJYdp/hcJNbZiHG1j6v5ufY5gcrkYK
         BQ9tP16LfyqABLSdA/TGbWl1SAFhQ7aswsCw2LcOu9XeEoFe7iT6DLp+YM92msD1GWQ4
         Vkbw==
X-Gm-Message-State: AOJu0YwvUW7gkm3o3SVXpu4LKoOvdenU7WUfY3ym6cDSdUmL/qQWMCBm
	cmN9Tad78gA42sPot6hC12h30b4MgBcQmAu0t4CeiFGFhdbmAnkd5eL2SR3l//HreHG9QIIAYEF
	e/ho5RNgAgIut4+GlMDDD9cEoCylhkWQ45fn+AA==
X-Google-Smtp-Source: AGHT+IHK8NjbfVjiOJVvhHwvTy+ErZQG3JChXcCNJ9tq7pj1tBuCcj9cSgMmIm2WuK9z6omDkmihzA64FOxWzj9qVZk=
X-Received: by 2002:a05:6a20:2453:b0:19a:66a4:7966 with SMTP id
 t19-20020a056a20245300b0019a66a47966mr509176pzc.55.1706222100868; Thu, 25 Jan
 2024 14:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <e233f4ff-9ed9-42bd-8ffb-17b66bcf2b5b@sirena.org.uk> <7c998d34-919b-46e7-8942-75da94d5ac21@linaro.org>
 <zbxkm5jbngci5dp3oxcjccnltpht7wsyrvvekozwcsfv5ly3r4@ms3c3bzxgqqx>
In-Reply-To: <zbxkm5jbngci5dp3oxcjccnltpht7wsyrvvekozwcsfv5ly3r4@ms3c3bzxgqqx>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jan 2024 16:34:49 -0600
Message-ID: <CAPLW+4m_AAnsXdpcwrDL2dJNq6+2sRg0fv4nB1tpF3ufMX=TNA@mail.gmail.com>
Subject: Re: [PATCH 00/21] spi: s3c64xx: winter cleanup and gs101 support
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, arnd@arndb.de, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	Andi Shyti <andi.shyti@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 4:25=E2=80=AFPM Andi Shyti <andi.shyti@kernel.org> =
wrote:
>
> Hi Tudor,
>
> > >> The patch set cleans a bit the driver and adds support for gs101 SPI=
.
> > >>
> > >> Apart of the SPI patches, I added support for iowrite{8,16}_32 acces=
sors
> > >> in asm-generic/io.h. This will allow devices that require 32 bits
> > >> register accesses to write data in chunks of 8 or 16 bits (a typical=
 use
> > >> case is SPI, where clients can request transfers in words of 8 bits =
for
> > >> example). GS101 only allows 32bit register accesses otherwise it rai=
sses
> > >> a Serror Interrupt and hangs the system, thus the accessors are need=
ed
> > >> here. If the accessors are fine, I expect they'll be queued either t=
o
> > >> the SPI tree or to the ASM header files tree, but by providing an
> > >> immutable tag, so that the other tree can merge them too.
> > >>
> > >> The SPI patches were tested with the spi-loopback-test on the gs101
> > >> controller.
> > >
> > > The reformatting in this series will conflict with the SPI changes in=
:
> > >
> > >    https://lore.kernel.org/r/20240120012948.8836-1-semen.protsenko@li=
naro.org
> > >
> > > Can you please pull those into this series or otherwise coordinate?
> >
> > ah, I haven't noticed Sam's updates. I'll rebase on top of his set and
> > adapt if necessary. I'll review that set in a sec.
>
> it's a long series, please give it a few days before resending
> it.
>

Also, I recommend splitting it up in a way I suggested before:

  1. First add gs101 support with minimal amount of patches (without
.fifosize introduction, etc)
  2. Then do all those cleanups and reworks on top of that

The reason why I think it's better than doing that vice-versa is that
I feel (2) can take a lot of time/review rounds to get polished and
accepted. So this way you can make sure gs101 support gets applied
sooner. It'll also make it easier to do the backporting work later, if
that's ever needed.

> Thanks,
> Andi

