Return-Path: <linux-spi+bounces-7855-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DC8AA78FA
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 19:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7713BED1E
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C40256C61;
	Fri,  2 May 2025 17:59:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF5192B8C;
	Fri,  2 May 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746208788; cv=none; b=uswit2b/57G5sqdbK/ImrEFtwZsXbJ0ERHWTfP52sUIMhwcigPhVCXSpLb6fX6WDOPL3c9zUzHdU3JivW1kNPlAcw4sPwdtzZCnxMTgLYFfqwSXw3/K6YmG9Mfvbhm29Iq+Q1Vl5hBYT3MkiNo9fPhkytj93rjngZ0JRTGIZhNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746208788; c=relaxed/simple;
	bh=b/OTnsE8RfLnan7+f0MIjo36FqZfl17OZEnEuYK+rSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/4iy+syycXYUpB5PCuISojSd8pMW8ATBbzk8/9rDaX8zKHTmY2PvUn/7qkIAJtb7AVtrpVyecNL0bECvX63VmmxDdy6tlM8rG1heYqam4BwE7BYyvvGk5qQqeWsxf+seewoms5yDaN417ekQLNV1W/trKBN5Iqzgj8dBdVQppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5242f137a1eso663759e0c.1;
        Fri, 02 May 2025 10:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746208784; x=1746813584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sl9ef/BMY04aildX7iZvdIu1ZnNRZ1wIdTW2Qi13624=;
        b=RxnXIaS/aAqwsZ9XdR5iOKXjn/nEyVPr6523kmTBstOm14710lkSZqPsXMVRkIFUxt
         /5g/ecJHpF1+tsJFUnleyqUO+8s93nJVmAuehLOP8TCDpJ1d4hDx1V4V/HB85YJNiA7v
         Ala5tAMFdJu+EX3PV/l7Y/PRjASauv2z3lOBAnWFdw8eFdOpQdUWHYQwIPyGYo4ckIzr
         tcXWq1OIkEhSjNIszW9ufYadWbeLPmm+X9eVwyPuGaBfeCpgmTlcxwaEHDYBEYacivi2
         judKKL5kB1Lzew/JGy6osOFYDK/3YYwF90QKYze6z1JoCwqJMInqzLAfCqQ2Ky4mxuh3
         a+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUm4qqb3hOjDfSywQdRngWNhRiOOqxFaEc53CCTCKkn6FqnIHaSgAJZs1VxlJxAPz8JWVzdMnboM0DD@vger.kernel.org, AJvYcCVDZ+MJuL4/CAUn+DA4B1W34orMs6nuZW0hMtVv8k4ywZ13CG/Udu9WoAqtNRA0cg3U6aEbcnCIObVTY5o=@vger.kernel.org, AJvYcCVmQLMbOmuG1ns9RBhgmGFFA3ngT3GyM0KNjecCYz0RepE9fpw0P5/xRT0LNn7yL1YE0/u+d7JcfOmg@vger.kernel.org, AJvYcCWr6OYz0Q57ERKfYaSeLSf2+o90nHRyqAijwrE/f3wdt80CMwDc+tEmavA2W5ZHmN6HI9bqu1t5wHYO21/ndG4QT1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjGzcQNtpV7tS3TvusyIN7JsECIjxKfRUoKrXse+gUej2ytTql
	dTj4ggOzLH9fuDuJmRVkstI5Iib1PTLSu5yipyUzMrfX5pv6qNg5bhkNKerX
X-Gm-Gg: ASbGnctScVGnuk8W8frix6MCQclj8DdFbUZWEDkUpGnos+uGZzxzF4dHgF7fzE0naE1
	qc3vS8agBCmqN/WzPFaLPTGnu9xdGH6UCU632SfyaiepzCA8EIvE/ieSCjeOMXYBxSDvuDKz3D7
	Va1tAX0eKekztQeAj+Y2ID+PrsKoLTBpJr+nGLD20NNRrqJ+Qhp/i4UpWMzsIO7sv66DgS7XS2p
	TClwecoO+mAEJcmUplxl1U5ZcvVtUI+F2S4vlvT34Iv6lq9gptHaI95ZXphuCb8qRAn1ZyBnmse
	M+FcQB5ImNqmnL0pBlGRHK2eTlKW7WD7G9+w3M3Ey8eZL7olWsODSJtz/F/koYi7IztTchBeX7R
	TWSs=
X-Google-Smtp-Source: AGHT+IFiasdWsyrBCYwcGtZ+H7jIO8LOmVSdNnuqgPclLm2sjy6Iuv06YrwGdKD9uJmu3OzSzpr6Kw==
X-Received: by 2002:a05:6102:534b:b0:4c3:b0:46fd with SMTP id ada2fe7eead31-4dafb6fab55mr3487064137.24.1746208784350;
        Fri, 02 May 2025 10:59:44 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8780af50ec4sm378240241.0.2025.05.02.10.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 10:59:43 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4c326617e6cso611392137.1;
        Fri, 02 May 2025 10:59:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYXFWSQpuS9PbiX9wzKvliPm4cb5STr3rSMDUzVqUDoHUl8/x6LclyNXRtgPs1lMJQIzOGHjquk2WDXd4=@vger.kernel.org, AJvYcCWtyf6DJZMSsV1ADLToZnOgYsLmZDtS50z1yFXkRfvCk61u8DQ7lOKMRljAWsIS3v0O3Z/hlvdE5L+f@vger.kernel.org, AJvYcCX8e3tUyCHNPYs6+uUGYSihPpN2wWzhqlksvqOcRfjFdTh73IUGZS7+SPlO/cAlm3IQ9g30VN4sIJ6g27AJN6gIoLY=@vger.kernel.org, AJvYcCXIDf6a4HaHkMJ+3zMrJsuv7IkhJXMRp3uJu1C+F62DRP2O/1jIeeX9SqL7VtFVRSKFChfTw9DJbe9W@vger.kernel.org
X-Received: by 2002:a05:6102:534b:b0:4c3:b0:46fd with SMTP id
 ada2fe7eead31-4dafb6fab55mr3487048137.24.1746208783751; Fri, 02 May 2025
 10:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com> <87o6wu2wzm.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87o6wu2wzm.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 2 May 2025 19:59:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvtvS-R7cZe-uuUJ+HT5SofTYfh-LwZirY_cMNw379hA@mail.gmail.com>
X-Gm-Features: ATxdqUHA2H0OlWRO7gTyxJQB6q0xcB37IEDN0q7ye2G3h7ZsBnu7gyQL1IWQjgQ
Message-ID: <CAMuHMdUvtvS-R7cZe-uuUJ+HT5SofTYfh-LwZirY_cMNw379hA@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] arm64: defconfig: add Renesas MSIOF sound support
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Apr 2025 at 01:23, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Renesas V4H Sparrow Hawk board needs MSIOF Sound driver.
> Support it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.16.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

