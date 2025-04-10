Return-Path: <linux-spi+bounces-7512-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CB4A83B6D
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 09:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A81E170701
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 07:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95C91F0E50;
	Thu, 10 Apr 2025 07:39:47 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B91B81DC;
	Thu, 10 Apr 2025 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270787; cv=none; b=hA/SxEOCAo4Ug/r09sYtvjBajQguZT5ZFZNS7cxAQMcjJBtjRYjAfF6B0pwBzMTb1tCb7YG1SntaDKy/5JFeEtsFtRWAmDL8JT0EtJ5XTddpQZoPD1orxgM109SlaoaVXM2esU9KFbdrwOjWcfK9qNKxpYXUQ+Ty9iCRpg0yQU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270787; c=relaxed/simple;
	bh=L1sXf+9FqINNB+qS1AHvdqZAgpqLVBCQX8MZALCtQgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+YFpR3jwHL4XgFEMLWjK0nvoH7XGxu+FKWwNQ7gqjw0IePM2xWzk5FpFy6CXLneYWxvySWMStSEADq32yXiVrMDGqOp1euR4oglKa39Qwu4rsqj2NSJFDLvO6A4Sa8lIMEMdenkbmxvj0BmD+dsVE1smIXXGrk8d9BH40hmWXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-52413efd0d3so251099e0c.2;
        Thu, 10 Apr 2025 00:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744270784; x=1744875584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdhhHhNL4jcHghdMHoTj4SWhcku+gXEaGiUBtSR+CRE=;
        b=vjdnqTMvqWNS4lsIxxkaD6zQE3lahA5rXyQhniwRrIea3ISpQxpnFJSMpJ+lJeDzxH
         bkiLmWB4TsTbJBWdKv4mfGFKB/xC73ftzTBUvxbDut10TMEc3LAMqpEmV3ktsBpao1BT
         Dy9s7oeXFpf/uRxC+rOxWZk+pgd3FBWHNgMZlMne31ZzWx8kny4d0tNWE6zT0Y46HcZq
         o0QA5lMfHRJS8lJpMKIdnZ2KUuGH+qkErN5OOshu5FLoj1W02odETrzQLsWSOU9Yuvj6
         oIZx1OZxeSZi+d+MHojb08ApfKqCu/OdcVH566jY24OxC99T5jxIvwY0LiLyiJ3pBjjh
         tuyA==
X-Forwarded-Encrypted: i=1; AJvYcCVh+nyhY+6pZfjBiXBm8S7MhuNu4VxoCVl0jMz0PE6MPpJ7/2cwldG+lXGkeJw9RJ+02Cd1PwBgnLPF@vger.kernel.org, AJvYcCX/zPaBifESNxr8JrL0MUApeojAXaAtholdGnBmMB68sy06cQEEp+M/qjWBbEZoZ5HyY7r9pI2Fmzln@vger.kernel.org, AJvYcCXcGJD2LkNuiUGB7tPFM9N8lbJ8W8Yf9PL5SY7LKgnb5Y9OzyqB6HoJbSHKLgB8zJHPEMbG9GWhNLL0iBA=@vger.kernel.org, AJvYcCXoEzL0M+ezC6h07k6ZJu84mi4EEmtrlw50D4pvDIiSS404+DxN+K4QGVyk3q9W3anO/4zBadylAZT8ZuucL87zdkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJN4M9TLzjD0hCHEPqkzqSAa0Z7r46P5kjhiYs+ujWHZwt6BXh
	LIjF8wmSwypgs9tDVamXxBVqli+RbvSbwVKf4c/0bTXmyDEHNN9LmsNJtiVkijc=
X-Gm-Gg: ASbGncvdnHHEhT4+FfYPGx4nhTSrkdinQNSGYxxInR1k1PWOgW4IZqtcrUiMWrsX1iw
	dbogEHbfT4jIEg97MV0F0faSiM72P9s9cTSqhrHGg3ZhsSnV76wo2uwq9D2IIXHDrN+7s7CLIIs
	g9XyDk2cVNPxw7S9HhWas/frBAUTwptoS+61OEeGJEql8go917kQDrhHnK0/RBvgqAGQ1iE09vw
	yivj5EUSfGiJsB+KhflIQBrmd7xkI7XiEPH5Z6I/rP4MZrtNFvKsI2Bkw4j0AUbA77mL0WJG9rC
	Ci8Vq3Cpsmo9r7ZeU4WbGkVKx6VPKP7MQEhOx45RVK+StoGhTNS7Q6+/sk1Hp1fVrOxpyzarHjK
	valk=
X-Google-Smtp-Source: AGHT+IFNUEigN4Q8OdWD5uHh1HcaRF0zgQhg092oSOiRrItqQWX8wj0NHnS/0WN4hRWDsvBUyfXH0A==
X-Received: by 2002:a05:6102:c4e:b0:4b6:20a5:8a11 with SMTP id ada2fe7eead31-4c9d34801dfmr1290034137.1.1744270783970;
        Thu, 10 Apr 2025 00:39:43 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-875560e4a9asm545013241.6.2025.04.10.00.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 00:39:43 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86b9d1f729eso215830241.3;
        Thu, 10 Apr 2025 00:39:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUY04djTYtfpwv/W3C8nQL1f7l83x3WSf8aeHPR7kL1Pr6GMqnjE0Zruz8SwvGIq9ig1SGH4NpDLNYez2k=@vger.kernel.org, AJvYcCVIfSy+hXA8jZSZn2iuSSl5Y6P0s0ZotsNp55r3OTGx8hx4nnPLq2NOdKNPqJM/zKDE2wi6RuDDl6Kfev3Pn86JpO4=@vger.kernel.org, AJvYcCWNpoZyvxJFDz+BUMTEZvk++xTHdlifIKsqpDEhZxXvR8pVBiOZSPMZLX1raJ/69rAwEVPMt3IHwOzd@vger.kernel.org, AJvYcCXDE6pYy+/MUI/VLKu+AYnionbgV1DGB3cGT0JhEBVccvxBFvW6SdrcURmSnZo5zED1Q4zCXbGCflBZ@vger.kernel.org
X-Received: by 2002:a05:6102:3f0c:b0:4c1:c10d:cf65 with SMTP id
 ada2fe7eead31-4c9d361f9a5mr1118125137.25.1744270783521; Thu, 10 Apr 2025
 00:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
 <87wmbu9may.wl-kuninori.morimoto.gx@renesas.com> <CAMuHMdWL_C-Vg3d+fAK_nXvzeZNNPDkkzPjB1oHRKHh16rZUHw@mail.gmail.com>
 <8734egnbl0.wl-kuninori.morimoto.gx@renesas.com> <87iknclp1w.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87iknclp1w.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Apr 2025 09:39:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXYYYAabmsuVmM6mAqNM6XHyzKsScwAr0TruSe_LMo1kQ@mail.gmail.com>
X-Gm-Features: ATxdqUFE85rUT8Av9gY4HgZmbdXhKV7A7wBHH1G6a_BtzkDiwH5i1TwKTn-l6uQ
Message-ID: <CAMuHMdXYYYAabmsuVmM6mAqNM6XHyzKsScwAr0TruSe_LMo1kQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] ASoC: renesas: add MSIOF sound support
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Thu, 10 Apr 2025 at 04:37, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> > > > +config SND_SOC_MSIOF
> > > > +       tristate "R-Car series MSIOF support"
> > > > +       depends on OF
> > >
> > > depends on ARCH_RENESAS || COMPILE_TEST
> >
> > Ah, yes indeed. Will add in v2
>
> Renesas category Sound drivers are under below menu.
> So, it is not needed on each drivers.
>
> menu "SoC Audio support for Renesas SoCs"
>         depends on SUPERH || ARCH_RENESAS || COMPILE_TEST

Thanks, I should have checked that...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

