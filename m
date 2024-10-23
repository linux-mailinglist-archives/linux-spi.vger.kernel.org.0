Return-Path: <linux-spi+bounces-5326-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE1C9AD4CC
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 21:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230EE2838E3
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 19:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3964E78C9C;
	Wed, 23 Oct 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GkEDh5i/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762551D9A4B
	for <linux-spi@vger.kernel.org>; Wed, 23 Oct 2024 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711684; cv=none; b=h8Jvpw5oDa3VZHi0Bix5O6CMZAle0FN1eTXdCbtMEAX2k5cgqFMKEJYFpFP3XhVVvoWhiCygKqM6P2383Xqmb60J/sW5ypZTp+2vqxVrzcm0GIuMg6htnHdrR6ZQ9+fh+LqtWTCFo0yJjH3qDAp62+xad/g3+t5LagC8QpIUHyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711684; c=relaxed/simple;
	bh=jVfaEMDiqxEbMojHP9PBFB3cC/z3et13Xb9WEIyCI8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjW1JX2g0jD/eYYBfCNAryRtz4r6BBK8lX5bN+W5fBzJVvS55J3KctxhRiK4YA5cGL4kg6wlIwjMQhQy1R3hcOU3OVUH55c/UolMgM6eGY0aciBrJoztSk0UdZty4scVMCfe8K+I2cSBCtqGcOWsTqWhGmyzXFsyDA2hkWh4cfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GkEDh5i/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso162540a12.3
        for <linux-spi@vger.kernel.org>; Wed, 23 Oct 2024 12:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729711681; x=1730316481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hmLs1fnyFuhch9ym0D8390T3Il2G3hywHxmDwOxNics=;
        b=GkEDh5i/cBiseatG9J8e+wJUzyaRuneSeC6QXhSCI2VD2LCmG9PmGonO85gWKZbMp8
         lLw+0xHFOb3s4iK0QlaVZ+r74NOt1k7Q6ey9pZBe2HBfPc4IKB18nGm/snVDFXf1U4ga
         5v+UAJmTwYLlw7IZlf7WO21BxZ25GtAQDd3jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729711681; x=1730316481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmLs1fnyFuhch9ym0D8390T3Il2G3hywHxmDwOxNics=;
        b=cGabsVS7Zz4egZN9IEm/QDE5Q/oCLPE4Ci8sGBpoDzjpN+Gg94N5IO3LYDrP8Ubirm
         L9HcZ97I2Ny6s1i8xem8/N1yeDMdQJdTStNlwHFZvmrqmcCVTqVpbJfWA9n6R+SM8I4Y
         t//GFw3jAVyTdX8vlTDIcbeYFH224KTZAvTnxu2uO8BrRIynRaDEDbU/VV4paA4mb154
         FnNQzRpdXMyuppcpMGFlymuFet4uYOwyyX2yI6OUftq38Eq3piYkIp2XCsSaymdb24cd
         cC4m1M6JJTIyHZRlwRA8+tOuKvbfFIRHMofF0ATVVaG/FuPiX7DFz5G9XHGpXbL3WMca
         Nd1A==
X-Forwarded-Encrypted: i=1; AJvYcCWtIPkoUa0YQRQqj7WrpE0MNKojxbdod5K015ZisOEPsQwbQNxzxNosBI3Lmf0Eknl25whL3pueuO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53umrOgW1qzAvju1m22DKWwqtOP0hYWhbgqFajrYL2HydPSc3
	061UoWXs38KgqEkVYFT85+lrP03ziiaxk1riZGvAi90EPqSIQ5aaCEX7UqSNCeTAHrIchJ1+g/c
	YGaUxCw==
X-Google-Smtp-Source: AGHT+IHHxnOqbYNuYM8H3hk/GypFp667pEmKc72nvxLNt0+u+jGB3j+Az8mtknRvpnW3CnQhjqcI5Q==
X-Received: by 2002:a05:6402:5202:b0:5cb:6690:eabb with SMTP id 4fb4d7f45d1cf-5cb8af9562amr2623247a12.24.1729711680681;
        Wed, 23 Oct 2024 12:28:00 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b18csm4718677a12.62.2024.10.23.12.28.00
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 12:28:00 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9aa8895facso11334766b.2
        for <linux-spi@vger.kernel.org>; Wed, 23 Oct 2024 12:28:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqq24GAXYL+eZRDpXGQ9TFpLrKl3NTBo7Q6oUBpbV++Vevk/dqHZCa4DotXTqaPvpdJSdL8htI+j0=@vger.kernel.org
X-Received: by 2002:a17:907:72d5:b0:a99:f4be:7a6a with SMTP id
 a640c23a62f3a-a9abf91ed4fmr407338266b.47.1729711194415; Wed, 23 Oct 2024
 12:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io> <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org> <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
In-Reply-To: <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 12:19:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Message-ID: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Peter Cai <peter@typeblog.net>
Cc: Tor Vic <torvic9@mailbox.org>, Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, 
	gregkh@linuxfoundation.org, wangyuli@uniontech.com, aospan@netup.ru, 
	conor.dooley@microchip.com, ddrokosov@sberdevices.ru, 
	dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com, 
	geert@linux-m68k.org, hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org, 
	mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru, 
	ntb@lists.linux.dev, patches@lists.linux.dev, richard.henderson@linaro.org, 
	s.shtylyov@omp.ru, serjk@netup.ru, shc_work@mail.ru, 
	tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 12:15, Peter Cai <peter@typeblog.net> wrote:
>
> Again -- are you under any sort of NDA not to even refer to a list of
> these countries?

No, but I'm not a lawyer, so I'm not going to go into the details that
I - and other maintainers - were told by lawyers.

I'm also not going to start discussing legal issues with random
internet people who I seriously suspect are paid actors and/or have
been riled up by them.

              Linus

