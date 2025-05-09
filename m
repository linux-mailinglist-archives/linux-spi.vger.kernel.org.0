Return-Path: <linux-spi+bounces-8011-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DDDAB0F72
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DAA4E7693
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303DA27A132;
	Fri,  9 May 2025 09:43:44 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDD026FA5C;
	Fri,  9 May 2025 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783824; cv=none; b=Hc3N0ZgUnodyxQWAKwzc7sQocCz6O/IVDh8CwKR4tctLd2BALWokcKL0DYd32Escx7G6y7iuMPamgsxuUocoLwSEM86ymvkOPGJPf8eZZjFjPUKu+Qu4Tf9GJCcgNjGDvxH1kj3YCQKzRHN2mW+oRMOWxny9WiUduep7RmKl8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783824; c=relaxed/simple;
	bh=834zGv04IRnQteHT+UDNWIj6Z4grl57drScKWT9bOJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhBh8LdLft6YJqs4mr+LegJp27/eBCWA5LXQqaritlru/Tl9hukDPB4nJywEUHCgJYNIElPCEhFwoaBoBXoTqWSlcR0tqdwoy49f0/DtSo9Uj18eC7ujiqcpqfhj81tS+V9oFoztqAJBxeaHf1v5geXzwtO/zFUOeBp9cv2gm34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5240a432462so1225809e0c.1;
        Fri, 09 May 2025 02:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783820; x=1747388620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cS4MQBXJCl1oqMu5q/7hz+EdEY4RzMbBhX3NYiefBfE=;
        b=Oyuu1UEHTmbhBCqgIjeB1Szi+O/uN6jNe3XfjHx9c7TZHeYPRw8i65WeJ5ox88C+a5
         kptj73P57YLzQ0F2UznFQopDoX1irFcR4VmpVafhsQJM8TaOeyFkOYMb5qCkrAq/V+69
         4C46+nc8qu8F4pQYzwCF2ifUP2Upvv/sBUhUAqD8zj9UNDyS9A8PyULh+ho1nnI4niDS
         E765Vk4mzqG5n7jDcyo5GTABNrvDmeYz9OqdLTXCADL1rIO1UAvMaiwCQ/EyvlvA5wY9
         zEddN20dCYP1mwQZmDgdCaF9B5ozZKB4Kd6vdzQ3p8xFzDNJZojSbQ4ibQbzDTmdWtdV
         bdpg==
X-Forwarded-Encrypted: i=1; AJvYcCVUtITT6V/9V0ZN5VvVD6BzFUB+bJy/+i/xJtxwuuWHBRxbtrDqURvQDwpsAm7l/Evy1O/tNGufrSXH@vger.kernel.org, AJvYcCVuc8gq2h6dSNsJz7VU0J9z2Ye+IX8G4Xqa9MrPUW7EOGXbHHVfH/KRatGTyfdXEPFyw90NyWJvtNJn@vger.kernel.org, AJvYcCWAaHc5eVJ+T0Ko1S/rCKjiwHdmceTpYsNgHCGp/kKXU0Fa9yA0isn3gLpIGUxfWZyKmzNW12H0QVuizPs=@vger.kernel.org, AJvYcCWuB6j0Ot9J5BCDs9eCZAkGROrfUS+lpHbIztGlszZc5uz6Fpsg7OW3T/z+BO8Ik3QAcMXSr4LmZ7kxX7siv49JDBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqcPGlgTU9PsKX6mOJZfg1gh43orlMLDpuVEHkpCVLjkveFHK7
	jSWJP1kpXICLq8/jE7/5nHESb9sJs+qqNpmTXCL9+HXHf4dGkoXPZzFmxwad
X-Gm-Gg: ASbGncsFxhje7g4Vvf4tea8pHAxmx4lXVB5NTVRzyW6m0bcjBBtpQqIvnd+D9A3G+8O
	ri7p/4bjVlfJnp6xVPMw9UBa+dfsTwVmfo6x/zPzDG9qZsXeRbRHVT3PIZSJx5bgo/zGxS+Fm/x
	maqkwBzQztsoFffTzQv7v/FkPjwGbxfV0fHV33Ojhbp8Ln0Lq75mmms7khVXUXLKFFll2hWKuxp
	gOHtGmEt9JetZ4YdVh73oARIhq5tnspO134ZHa252i+csFtBkH/NLWFwj3U51mohfpuXY07U1iQ
	X3AEkEa3JHKa2HCFzrzr3CfFnH1UqsZxCyz9yyvBkPz8LeAGX9J9P51/RRp3YP5kzfGVj/abKr4
	Swfw=
X-Google-Smtp-Source: AGHT+IGnzN83hnsqtxTdYCKHNn4V9xtxZJCDqUmIOdoBDH1Xh1FKafRwo2jllrzXTGqjifKFOMpiEQ==
X-Received: by 2002:a05:6122:c8:b0:523:eb47:2884 with SMTP id 71dfb90a1353d-52c44437f67mr5006067e0c.6.1746783819817;
        Fri, 09 May 2025 02:43:39 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c5372af6csm853937e0c.14.2025.05.09.02.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 02:43:38 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4ddb9d80bffso856091137.0;
        Fri, 09 May 2025 02:43:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIvg3/b96AxfKTkyYn4UaiuTaH77MwwndzH4nR1MpHKSBcqIwL9PJ0SN09aWXzKwTqLZ6UgW7Ocm1m8hc=@vger.kernel.org, AJvYcCVsfFZh1qygGY5UanncokoLXRPyAEjKHR967wiRDeriGL0OFjyPSDEawKhG3XuHfwqaC9m01gqqVfa0ru+r/SBhNtA=@vger.kernel.org, AJvYcCW8CuRA0wJGV+Yqg0Ng7Yfnz4fXbcU/vqLBS3j4GyVot8svcpJpAnS/VKaCyI53uY9txlo5iOMcw1F3@vger.kernel.org, AJvYcCXf2YngmdKht8lIIha3t2wY+q2yvTme1lOAP1Sgh4V5TaKx2gnMiiaothVzGQlhdD4YFPPfw5txv6Vb@vger.kernel.org
X-Received: by 2002:a67:e893:0:b0:4de:f0c7:e7bd with SMTP id
 ada2fe7eead31-4def0c7ec9bmr516832137.8.1746783818083; Fri, 09 May 2025
 02:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
 <87o6wu2wzm.wl-kuninori.morimoto.gx@renesas.com> <CAMuHMdUvtvS-R7cZe-uuUJ+HT5SofTYfh-LwZirY_cMNw379hA@mail.gmail.com>
 <871pt1cfg1.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871pt1cfg1.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 9 May 2025 11:43:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVDWDCdF956VFgj95Cp-RxN9OOJ3QVgOV0C_wD+EXQktA@mail.gmail.com>
X-Gm-Features: AX0GCFsyZGmx95i7hMWHQTatrG9GkM2iIfCYJG2cY9QxOU_CGeNsHMOWbwOsqtQ
Message-ID: <CAMuHMdVDWDCdF956VFgj95Cp-RxN9OOJ3QVgOV0C_wD+EXQktA@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] arm64: defconfig: add Renesas MSIOF sound support
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Wed, 7 May 2025 at 04:39, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> > > Renesas V4H Sparrow Hawk board needs MSIOF Sound driver.
> > > Support it.
> > >
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > i.e. will queue in renesas-devel for v6.16.
>
> Please let me know if I need to post patch for renesas_defconfig.
> I'm happy if you can handle that.

Looks like you beat me to it ;-)
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

