Return-Path: <linux-spi+bounces-6223-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C1AA0219A
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 10:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED14B1636F0
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44591D63F7;
	Mon,  6 Jan 2025 09:19:19 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB52AD16;
	Mon,  6 Jan 2025 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155159; cv=none; b=b/IXMxKcixWkhOSglj3tbX7wz4jjRL2X7pUPz+If5NB6pHtSx4h809pJvxjrUR6bsCcDynXXDbY4p01CwnUU6gZ/SbhHzcVAqBSE1gIyXvSPnwP4s2xtL8XkrSEVPS1vty0bapoFtjYhPh+FCbgVHmNMSuZnTAo8fji/JAIXgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155159; c=relaxed/simple;
	bh=yRVUAg1DrN0y4lvUMOrvhW4mYygOT/KcWCFZRF2WlHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9Xwa4mk/69sB426JfPC/lY731w6dci0yWMTJpFz6RmWAvhNSMJCDXiRXOa3KTUD9Rtcs6C1XpPXT84CkHdr81HRMU3fJegCPTrh/N7AqxCdQs+EfGnfxDiwBtKsigonMgFRyn5Bu6RvQ7sN7Hdf5DOeYpRuA7KBFOEGxy+Bzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-51873bc7377so4543519e0c.1;
        Mon, 06 Jan 2025 01:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736155155; x=1736759955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVXc151fQNRFK88fM3HyMdxUvdmGpP1g1R2JxE6iXAY=;
        b=YmaE1okOVpXNk9+ksYIfdvUWrAs3RP9vXqJHrBiXeLIglt4QfVvmh0KuFu5oIL0Psx
         o1CuDgY/dauWCs4Cq7Q/y18+XSYJ8CWgyaOd50O3ItjeUqHJJuD9AW7Pdp6pZWpVvqAs
         TYhBnOlBwODIUl47aZE+zNNrEdpy0azJ8vvrVhX3wul6KdYzOEPTRqqWMIC5lmxSMruS
         gUBAqkAYgfw1ZmNWN3UCxQqd6+gfLYaOmU91Mxl4idiLSEmT6VDLTFXqYc0QnOsJqQmh
         zxUgkZeLTn6T/9bj5Z0fad7DOzvwpSRlU3zim9wAGHPcyzRFQ/ChaaLDlxBGOanJP4Qd
         pO4w==
X-Forwarded-Encrypted: i=1; AJvYcCVPHPfuxQTMwPCLtbYgyLETRXCGj7ip+/VSx88Ul769M4+krRCku7BMwvfUszC7+8n2yOJt8FiMK+HaL8p/@vger.kernel.org, AJvYcCWQwhueIxf60nNFuRAQk4NHx3iodBmU94jPdl0kWSSFgUMPgMUFFPdEogE4DFX59N39tQBsbfQpJjP0@vger.kernel.org, AJvYcCWSCYC4L3nZjgShqL6kOpioXBXboOY3+7Rp65V8U7c6dA68LBD3trIR0R+6DMpz8q+b51RMjT3ARzRo@vger.kernel.org, AJvYcCXsaWxfoBtYJLdQKZr43u99vQRZw7grkYRwKIAtaDxeuMKUUA5cgtBbNl4yJAHHUVh5sR1VTNi9/ISOnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDdeiGVs9qAeXmrFBry1f/AGFzuKHvUP1XGrVp15qBP3Jlu3wn
	IVkOuqbTxOwrMWjJ1gHu+7uGvOZhkIzRBPVk8lE561sxgYjnyeY/12u7yQ4C
X-Gm-Gg: ASbGnctVg+FTuKsuRKfp9jQ9Gt0ZWOikKTSRvoC/dAYZp/JjxSDz8HLwrTXA1Iq1GQV
	2lWL67weDLBMDKRjyk7qwL5LUsMsfnk2B6yBQVzEcdXh6Q4VSIl1LE8Neqs0Eg60b1Zy+z8CHh5
	GUQnNB+c5HKAFqIBMVi0ZBRf14EAtAP+4LrKM0RoayZCf8pgz01ABYNKYOIdj4qmojBT3e9iClJ
	SuEPlK/1XTUOwucRAeSnnSs666Ynf/Pxi4CJeI9YH8hw1i7jGRR6b9Lau13idfq5YIhWpLPRQ8q
	J4ecOMgMFxNekFXWTV2FSUU=
X-Google-Smtp-Source: AGHT+IEnMdNmhdLYzog6kLzSdr+7qiHNvSMa3PP0lJZXHmoWuqZdclVdR9mF8qg8lrqC2WsAxiPD8w==
X-Received: by 2002:a05:6122:3221:b0:50c:4707:df0 with SMTP id 71dfb90a1353d-51b75c5f0a1mr46222760e0c.5.1736155155171;
        Mon, 06 Jan 2025 01:19:15 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51b68d08e89sm4152286e0c.45.2025.01.06.01.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 01:19:14 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-51640f7bbd3so4339473e0c.2;
        Mon, 06 Jan 2025 01:19:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSmlkdUqJOXEvpgAkJP70i/wbPzVsHfIyIpv2P60PiYsqizCrZ7tVvDetkOBcZnfWw7ZjkGY6bjRXVdQ==@vger.kernel.org, AJvYcCWAzuYDkY/agDl5IDWNLiSO4JldWcHHsi30Ba6A8kVgVrz57y67hYYyRYJq66oyRa6K01JO6nWp+CCj@vger.kernel.org, AJvYcCWWw6t6JnKgaj+A1xz/QmhUTPk3xEnN3BAzmql0fGcWhcjGbAbmPQ7VgY/d91tXiDuJPFBqS9W/5Grl@vger.kernel.org, AJvYcCXTEh2zJmkgo7/zf8U2oY5fGGs5qq9bnZECjMa2vo8TfgS7qgyK7oJcv8PNwuQwSpORETAy9/9FOkTmyL4P@vger.kernel.org
X-Received: by 2002:a05:6122:6607:b0:516:c0b:8bfe with SMTP id
 71dfb90a1353d-51b75c308a7mr41264352e0c.1.1736155154383; Mon, 06 Jan 2025
 01:19:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224-gpio74-v2-0-bbcf14183191@posteo.net> <173593634037.257292.1488097273042214180.b4-ty@linaro.org>
In-Reply-To: <173593634037.257292.1488097273042214180.b4-ty@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Jan 2025 10:19:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUqvTrSsiGuJ=VvNqsQm4eQs9rNTU8VBg+FzHJZxRnXow@mail.gmail.com>
X-Gm-Features: AbW1kvYJYJux_P1lxS0_XQpYU66qxTJSQHmd1VNX0q6Sc7EExx-pANvxkROX0fM
Message-ID: <CAMuHMdUqvTrSsiGuJ=VvNqsQm4eQs9rNTU8VBg+FzHJZxRnXow@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpio: 74HC595 / 74x164 shift register improvements
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

CC spi

On Fri, Jan 3, 2025 at 9:33=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> On Tue, 24 Dec 2024 09:02:09 +0100, J. Neusch=C3=A4fer wrote:
> > This patchset adds a compatible string for another part, and clarifies
> > the role of the latch clock pin on 74x164-compatible shift registers.
>
> Applied, thanks!
>
> [1/3] dt-bindings: gpio: fairchild,74hc595: Add On Semi MC74HC595A compat
>       commit: 0ba6cec7acbb666d28998780683deb83a3e677e3
> [2/3] gpio: 74x164: Add On Semi MC74HC595A compat
>       commit: b1468db9d865deb5271c9a20d05201b1c0636895

Do we really need to document and add driver support for all variants?
I can easily come up with a list of tens or perhaps even hundreds
of xx74yy595z parts that are all compatible, as far as software is
concerned.  As SPI was invented by Motorola, the original part is
probably named MC74595 or MC74LS595 (yes, ON Semiconductor bought the
logic division of Motorola).

Perhaps we need a separate vendor prefix for the 74xx-series[1]?
The xx-prefix and z-suffix don't matter; the yy-infix for semiconductor
technology rarely matters (there are a few exceptions, though, mostly
pinout, which doesn't matter for software).

Thanks!

[1] https://en.wikipedia.org/wiki/List_of_7400-series_integrated_circuits

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

