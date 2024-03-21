Return-Path: <linux-spi+bounces-1942-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BFA881CA3
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 07:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8882CB217B4
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 06:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4134D9F2;
	Thu, 21 Mar 2024 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I9byFJpD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E43AC2B
	for <linux-spi@vger.kernel.org>; Thu, 21 Mar 2024 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711004246; cv=none; b=OWvHVceBqPZJcktV05tdz/n+k5d7VPNh2q9/Bpr1HdOotNTLLQarhghlT+gFMjzOhDNp/CVoXvcIuyEo/zq2fh2SJVr3mzHaf7cuB2cQHIYOnDsfGdfTmWcHpQxYlisN+/D07H28yAlREhh12p9uSgVAAMcMiVyB0xU1MUc5vgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711004246; c=relaxed/simple;
	bh=g920GDs7VWxnuDSKOujp5wmlf+IvPEGUayy2cRVJISo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFfeDLUiLWDpkIBSfENYYI3JlmPvL2adBa1ClNHRHSpe2L4h/hjfx7N5IVKjenZbP5sHxeNvgY78Zbg3SJiXnPsfManW+lBVYTIdQACL0tvAlsMATZY8wgYhk0KmUwW5yUu9gBmmfn2SPmLg0Qk9cPrTLf0+pz+kddcR3S7UTnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I9byFJpD; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-476757820ceso157777137.1
        for <linux-spi@vger.kernel.org>; Wed, 20 Mar 2024 23:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711004243; x=1711609043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9zbV3no8c83PzjBsl077R25GMg0rcg/3po9zJLqVKs=;
        b=I9byFJpD17UwMXL1gUb4zJqkv5qEZeiDu09CsYfuSsBv39c0B90mn0/3715AtJK26s
         YRGEGK/8zTqmeWjNkhMFvZ3noLRc4qObvuVio/VQHyP2gWAuEL+I5p6qCxLdIYs/AORp
         cr99h+4jHHNnD5AYIy+znvYYfpaCaVL9nPozA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711004243; x=1711609043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9zbV3no8c83PzjBsl077R25GMg0rcg/3po9zJLqVKs=;
        b=THjuz8OBhgIrbGlLqm+SylJtdpteqObv+pDoB2XLg2laz7uwttZg1Sm+Nu8MdqFkqU
         46Ym2n+p5g2TOkbV/QZFota0bw6Ddv/Q1+TY/mGc6N34y90em3gxKTFrD8XIsD3aqtW0
         JgRW8jNbqU1CzZLd4P7Y5bBB/JapD2zg1ykLzh15R6qKML+Nn3IdY22C5J3jPYc42Pzy
         DXm7nC4mw3jYzrNaei80kSFnwgjteXwUeDXkO3Y2zhN2XeASgg8jlftZILMH0xZDkqZh
         nWVJGb0oam9l+S8tdYSXc+F2Z5hc/DQ0NJlf08ZhhfFV0DJM5oL/nCQs+AseP0RhSlO4
         aJRw==
X-Forwarded-Encrypted: i=1; AJvYcCXiGk4L3IAyJS4nDwVpCylHiSKZg+ICX5QDWaa7VpO5/Wp8EHDffNHUlaP5jg4JKL7ZlZYbyVloOWgzT6CzFyMHJkCVDR6M7cR9
X-Gm-Message-State: AOJu0YzMMfDUGwnqflgdNBf9P14UEvvssc3xBnF/pB/LFXwfM+bJOsg8
	n1ZXSqCOyIO79wk5pFUeBr5qbBbFGRAWyAYxy27kOgOBx6MOWeXerwFn3ShKm3FnFXZJn+vW4ZE
	+nA==
X-Google-Smtp-Source: AGHT+IFFZdXi5YnxT3jkChrYDwQNDiQ2X1Ao9iooYOyneLmaazg1r8GDzES5N2fwZcTiuWjCv+DmHw==
X-Received: by 2002:a05:6102:242d:b0:476:85ad:6c54 with SMTP id l13-20020a056102242d00b0047685ad6c54mr957773vsi.4.1711004243162;
        Wed, 20 Mar 2024 23:57:23 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id a17-20020ab03c91000000b007e062b1c054sm1072499uax.8.2024.03.20.23.57.22
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 23:57:22 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4d43d602cd6so228990e0c.0
        for <linux-spi@vger.kernel.org>; Wed, 20 Mar 2024 23:57:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2FvwIkzMUs1En79JYeAkOgSr1Kn6isRpxWNTSu5YvBkQO1SMWi69Wi6foC1JTzcHi6BjqPqodWTcBKEANI797nGmK/B2EnS2v
X-Received: by 2002:ac5:c4cf:0:b0:4cb:56c5:5818 with SMTP id
 a15-20020ac5c4cf000000b004cb56c55818mr989958vkl.3.1711004242162; Wed, 20 Mar
 2024 23:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321064313.1385316-1-fshao@chromium.org>
In-Reply-To: <20240321064313.1385316-1-fshao@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 21 Mar 2024 14:56:45 +0800
X-Gmail-Original-Message-ID: <CAC=S1nixtu8e1L+dOUXxfsFmqW_5xR9NPuJWzyz0OxRXFPd0sg@mail.gmail.com>
Message-ID: <CAC=S1nixtu8e1L+dOUXxfsFmqW_5xR9NPuJWzyz0OxRXFPd0sg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fixes NULL pointer access in spi-mt65xx.c
To: Mark Brown <broonie@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 2:43=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> Hi,
>
> This series contains two patches for spi-mt65xx.c, both focusing on its
> interrupt handler mtk_spi_interrupt().
>
> The first patch is to fix a NULL pointer access in the interrupt
> handler, which is first found on a MT8186 Chromebook device when the
> system tries to establish host communication with its embedded
> controller.
>
> The second one is a decorative clean-up when I'm working on the first
> patch, which simply renames a variable to better follow the rest of the
> code.
> I put this after the first fix because I think that will make
> maintainers and users slightly easier to only backport the fix if
> needed.
>
> Looking forward to any feedback, thank you.
>
> Regards,
> Fei

Sorry, I found I messed things up in the last rebase and this doesn't compi=
le.
I'll send a v2 soon so please disregard this series.

Regards,
Fei

>
>
> Fei Shao (2):
>   spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
>   spi: spi-mt65xx: Rename a variable in interrupt handler
>
>  drivers/spi/spi-mt65xx.c | 47 ++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
>
> --
> 2.44.0.396.g6e790dbe36-goog
>

