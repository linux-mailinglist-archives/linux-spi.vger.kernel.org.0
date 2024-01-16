Return-Path: <linux-spi+bounces-479-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0E482EAE6
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 09:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EE91F23F78
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jan 2024 08:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850ED11C8B;
	Tue, 16 Jan 2024 08:33:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B711C83
	for <linux-spi@vger.kernel.org>; Tue, 16 Jan 2024 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5f68af028afso79560817b3.2
        for <linux-spi@vger.kernel.org>; Tue, 16 Jan 2024 00:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705393999; x=1705998799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aw//fcxzDP0LnbU5mlCJb11ckc4dSmGsGnWoDUny7OA=;
        b=NNlT2x4Yy9Obrtr5VX3ulP25waimU9YdO/2ik2rJuyz1oHRVknKHG/riM9x4NSGKkl
         jN6/6001ceCYX5JIePwF7hRALzkt2LwZIbAGyXoF7QakJvyj5Y7293KXG2qnUx3RrZ8M
         vZ39wMmisJhxm/99CEztBhnTWtIQneoZrY/wxwschF51jvwC7177sL8lfmA+Y5MXhh5X
         v2iRmrot/rdpvN51x/el6bTUm7VOu4pH13TZEeBZ7qw8orySPDQ7dugyc+SzKx2VVKaC
         /hrn1GAjWgxeY7I7xnUSvIn3HAj2u9C8KqU7v6Vy74ML4zjSz+qBhQVPddigoYYGeZis
         4ufA==
X-Gm-Message-State: AOJu0YxRtmHfF7pVknCUS4c8THhrDLHwnxSR7sDbOlNjK6aoT8KDs2dJ
	o0Al6ZqrbnfavNXH6g10ZWfEbJJZtYPAEg==
X-Google-Smtp-Source: AGHT+IFMYk1Oi3L2Shg3yIx8cdjzhH/KhiD+eKbcBmoaip/ot3/8B2uN9cc95Eer4eo9TrrcN1rW2A==
X-Received: by 2002:a81:4ec3:0:b0:5e9:4b32:f4c9 with SMTP id c186-20020a814ec3000000b005e94b32f4c9mr3274123ywb.11.1705393999177;
        Tue, 16 Jan 2024 00:33:19 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id o63-20020a0dcc42000000b005ff407a35aesm824936ywd.84.2024.01.16.00.33.19
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 00:33:19 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso6495448276.2
        for <linux-spi@vger.kernel.org>; Tue, 16 Jan 2024 00:33:19 -0800 (PST)
X-Received: by 2002:a25:858e:0:b0:dbd:ae7b:fa8 with SMTP id
 x14-20020a25858e000000b00dbdae7b0fa8mr2533369ybk.89.1705393998850; Tue, 16
 Jan 2024 00:33:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de> <95602f4f5b17eae6f3381a3153dedd0031b03aba.1705348269.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <95602f4f5b17eae6f3381a3153dedd0031b03aba.1705348269.git.u.kleine-koenig@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Jan 2024 09:33:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWj-LSfWv=qFGdC5mQ2GNHt6_Z=__ou7D=u04NuzU6E4Q@mail.gmail.com>
Message-ID: <CAMuHMdWj-LSfWv=qFGdC5mQ2GNHt6_Z=__ou7D=u04NuzU6E4Q@mail.gmail.com>
Subject: Re: [PATCH 17/33] spi: bitbang: Follow renaming of SPI "master" to "controller"
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-spi@vger.kernel.org, kernel@pengutronix.de, 
	Michal Simek <michal.simek@amd.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

Thanks for your patch!

On Mon, Jan 15, 2024 at 9:21=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
>
> To be able to remove these compatibility macros push the renaming into
> v4l2_spi_new_subdev().

... into the SPI bitbang controller drivers/?

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

