Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FB17A5ADE
	for <lists+linux-spi@lfdr.de>; Tue, 19 Sep 2023 09:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjISH1B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 19 Sep 2023 03:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjISH1A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Sep 2023 03:27:00 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC8BFC
        for <linux-spi@vger.kernel.org>; Tue, 19 Sep 2023 00:26:55 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-58dce1f42d6so87301327b3.0
        for <linux-spi@vger.kernel.org>; Tue, 19 Sep 2023 00:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695108414; x=1695713214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCGwH308sB/r99UQpYzgGiy7Pr1IoFmH99meQ4mcLqo=;
        b=FasoW/09LJ09FLScOS2D9+QYQy3+9itF684gcBSZ6GArR6ObcOdgqPOPzU6R7Nw/N1
         6HGzLd9WVN+id0UH1BU0n3Afy5t0kSeqwycCu/fSESBqhBQG7FHRuURIgldEPYgHN3Jf
         AkFKhtPgB14/1/K+sZM0AO+VvR8E6Eod9vEK5CJJ+gX+GV/WhU0nRbNh161Us+7bvqFi
         ZE2aO1iLvNCz8PuitiS7RqiwwThbaMatp9FFK2SImoC7fVqUb4mM10rAXrwU18z59kun
         PUmk5BeNDPGpcHaYL2gEV3TTLNAQXE2n2Pwd+dMqCowxlftggLMIeiD1p9ecNlpyDbhx
         iPrg==
X-Gm-Message-State: AOJu0YxwXqj4mSE/lVBafzNcVA77kDHz/npdcb7rqTAVvJRfashCVLDJ
        IO8qMfuCDSVFSn5/lhRSaB/Ym612TDzB6g==
X-Google-Smtp-Source: AGHT+IFNUnU3IZAg6UZ7fKXHtlyNwJftclmdQDHngBsEyJIuFODNLDjDnaSFMXD3lVgg10YGUVKAAw==
X-Received: by 2002:a81:4e0f:0:b0:59b:cd92:779f with SMTP id c15-20020a814e0f000000b0059bcd92779fmr2023916ywb.6.1695108414518;
        Tue, 19 Sep 2023 00:26:54 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id w65-20020a0dd444000000b0058c55d40765sm3032768ywd.106.2023.09.19.00.26.54
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 00:26:54 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59bc97d7b3dso82494137b3.1
        for <linux-spi@vger.kernel.org>; Tue, 19 Sep 2023 00:26:54 -0700 (PDT)
X-Received: by 2002:a05:690c:ec9:b0:59b:cfc1:8dfc with SMTP id
 cs9-20020a05690c0ec900b0059bcfc18dfcmr1382141ywb.0.1695108414083; Tue, 19 Sep
 2023 00:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230916161235.1050176-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230916161235.1050176-1-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 09:26:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVi2TeWv0NXtxx=7NnGfJfWHoHCKty7Se0K-QusVi1xAQ@mail.gmail.com>
Message-ID: <CAMuHMdVi2TeWv0NXtxx=7NnGfJfWHoHCKty7Se0K-QusVi1xAQ@mail.gmail.com>
Subject: Re: [PATCH] spi: Drop warning from spi_stop_queue()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Uwe,

On Sat, Sep 16, 2023 at 6:14 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> Both callers of spi_stop_queue() (i.e. spi_destroy_queue() and
> spi_controller_suspend()) already emit an error message if
> spi_stop_queue() fails. Another warning in this case isn't helpful, so
> drop it.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for your patch, which is now commit 9386c958beb77aee ("spi:
Drop warning from spi_stop_queue()") in spi/for-next.

> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2093,10 +2093,6 @@ static int spi_stop_queue(struct spi_controller *ctlr)
>
>         spin_unlock_irqrestore(&ctlr->queue_lock, flags);
>
> -       if (ret) {
> -               dev_warn(&ctlr->dev, "could not stop message queue\n");
> -               return ret;
> -       }
>         return ret;
>  }

Why did you decide to remove the printed warning from the callee,
instead of the multiple printed warnings from the callers?
The alternative would have reduced kernel size a bit more.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
