Return-Path: <linux-spi+bounces-95-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F547FD8C6
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 14:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D381C20A97
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942FE225D9;
	Wed, 29 Nov 2023 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z3M0hUNQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D4F8F
	for <linux-spi@vger.kernel.org>; Wed, 29 Nov 2023 05:58:22 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5cc636d8a21so57420847b3.2
        for <linux-spi@vger.kernel.org>; Wed, 29 Nov 2023 05:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701266302; x=1701871102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfTfdXTp+yMT3mYQewRUIosVebrHQ8SQKCMMMwY3nr0=;
        b=z3M0hUNQgYZr38qfMjlSGmP74m/oqc6tZo4qCv3RdIpA7xLojpWxhx3/6tfsLpfNCQ
         7ijR6WjbH4+Ic3PDEs7xZMZf32G3xx7qypJ89O0vCd6YU9ORk2KMU3czjtMyz7F1AKDo
         9JZ0cdUm4D5nVGkq96XbTuO+/7FlwMHWVk2nSi1XEwMMa/a7f4HNCYcc9sZrfeewmIEX
         wSBMvV5eU026ypkfrarOsc6fcBUrULdAxUbkeP13QtGrYDeBPfTnAHZz5lDo3sxnbPBc
         VIWx8tOS6s9yLlHydw1ZP0inxIvE2c/GpOU65rLHlwZto5mAzrnhpY/O3Iu/oy1Rm7/n
         z34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701266302; x=1701871102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfTfdXTp+yMT3mYQewRUIosVebrHQ8SQKCMMMwY3nr0=;
        b=WeScEaWPTfOEnc1YiIHVZYNbhKcApMyNfHJBo0In4yaTW344LSfiioqQPjgqLzw62v
         yKfMCyWm9V88/2BWyEoiVpiv1zG2nAjDZHX79PfG6JY/WrOElfCX6zHxXgaSkCe2j56Y
         UM9tvXqnDzxazvKKGBlKGBIECcbTr/GgQVUezQw+M+u/ERTGMqmTlN38dSSP4cuKDoyT
         dbVXbs8XVZ31Sj2ulqVc58cfplHUJqGEtp/JPpfwh8GkGyqSZUt0fy7lpMDYdt9HRZXJ
         YWJANYzb+DNYQXMpbb8RgonSAv1QOkYfDCoouI4hcmxjKfZ26AP4939MMAp6G2mXk08A
         md6A==
X-Gm-Message-State: AOJu0YwuWeikHwHkGR/pAbakRMwXo9g9MCuqm8/xJexHoQuVpXGnM0+D
	dSJu1lpxfiieuzNUT4iFR2vyt1mUSSe3+hE1A3DiZg==
X-Google-Smtp-Source: AGHT+IFqBkmwBygBxeMcHv/3k1pv0m4VZo9blFPEezAV0VZ+2zim93NLiXeFfcpmm+csnkY43vaUxmkF4uPcEnMuV3A=
X-Received: by 2002:a81:4322:0:b0:5d1:d1de:e8eb with SMTP id
 q34-20020a814322000000b005d1d1dee8ebmr4699621ywa.18.1701266301817; Wed, 29
 Nov 2023 05:58:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701264413.git.namcao@linutronix.de> <4a0aa2f626f5f6e5509f9d0d64345fc8fe3b34d9.1701264413.git.namcao@linutronix.de>
In-Reply-To: <4a0aa2f626f5f6e5509f9d0d64345fc8fe3b34d9.1701264413.git.namcao@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Nov 2023 14:58:10 +0100
Message-ID: <CACRpkdZmgiON1Sz3e0LobeyDCpiyX-TGswC4xQ62sWQcEi2bjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: spl022: switch to use default spi_transfer_one_message()
To: Nam Cao <namcao@linutronix.de>
Cc: broonie@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 2:32=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
e:

> Except for polling mode, this driver's transfer_one_message() makes use
> of interrupt handler and tasklet. This is problematic because
> spi_transfer_delay_exec(), who may sleep, is called in interrupt handler
> and tasklet. This causes the following warning:
> BUG: sleeping function called from invalid context at drivers/spi/spi.c:1=
428
>
> Switch to use the default spi_transfer_one_message() instead, which
> calls spi_transfer_delay_exec() appropriately.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Tested with polling mode and interrupt mode, NOT with DMA mode.
> Support with testing very appreciated!

Oh this is great!

Because I think Mark started nagging me something like 10 years
ago to fix this in this driver...

I have a device using DMA mode, I will dig it out and make sure to
get this tested ASAP, in the meantime:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

