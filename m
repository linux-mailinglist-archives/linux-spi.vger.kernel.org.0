Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6737DA41
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 13:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfHAL1R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 07:27:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40704 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHAL1R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Aug 2019 07:27:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so73157076wrl.7;
        Thu, 01 Aug 2019 04:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JF7ywhFpFNuJZGA1xyx9jGrse3xaPHw4cmSqzNiI3vk=;
        b=qZrk2KEbitOTgCcaTaW5k/XjAfij/uYC3YNS9eRXlAoSRHb6XF+9oQ8f1nv2cKvF70
         msLLtb8OcFSM7qPCZfHi0xvByu9HQlvL5Y4D4opOlkosaa5yB4G19RfZ+udIpbVmtigM
         qIIvMTIhj6vWJwWNksNYbZONQO/stkZk7chcEPn2XxKZetIrPYxYbw2XmUZGWZ8xCTwZ
         dnbsCA54YdtCohdcf3wYdSdf5n4rYSkO/GY40R8ZKcLI6RISG2QnzXOzDRiegB/JzpQM
         NivApK2jHpWsZO8dwMMsMdckwn4pPdlMtndzLhV/xvcMnKEnbErjz+sgNyza0hkAByXZ
         KCPg==
X-Gm-Message-State: APjAAAXpQ9jvbPnK5x6f1GMg/vu8CYvp8MPBQN4IW2ylNCnLrtPZc2OI
        UFKzwaKMH8cIXygQxU7nmNRPxX+ZPkHCZc15vxQ=
X-Google-Smtp-Source: APXvYqzZoh9lq4IJstoOg0/8lFzWL5HjArUiogjMPyBhpEsKUEJr7TttklW94tFumEIQdDSYZ7LjGuimsRYEK9ZHj30=
X-Received: by 2002:a5d:4b91:: with SMTP id b17mr1404812wrt.57.1564658835072;
 Thu, 01 Aug 2019 04:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190801111348.530242235@infradead.org> <20190801111541.917256884@infradead.org>
In-Reply-To: <20190801111541.917256884@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Aug 2019 13:27:03 +0200
Message-ID: <CAMuHMdU3D22PAWepGP6rMvDwJKVTfbxxH9J=kuo59PB7CCVKOA@mail.gmail.com>
Subject: Re: [PATCH 5/5] spi: Reduce kthread priority
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Peter,

On Thu, Aug 1, 2019 at 1:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
> The SPI thingies request FIFO-99 by default, reduce this to FIFO-50.
>
> FIFO-99 is the very highest priority available to SCHED_FIFO and
> it not a suitable default; it would indicate the SPI work is the
> most important work on the machine.
>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-spi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/platform/chrome/cros_ec_spi.c |    2 +-
>  drivers/spi/spi.c                     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -706,7 +706,7 @@ static int cros_ec_spi_devm_high_pri_all
>                                            struct cros_ec_spi *ec_spi)
>  {
>         struct sched_param sched_priority = {
> -               .sched_priority = MAX_RT_PRIO - 1,
> +               .sched_priority = MAX_RT_PRIO / 2,

include/linux/sched/prio.h says:

 * Priority of a process goes from 0..MAX_PRIO-1, valid RT
 * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL/SCHED_BATCH
 * tasks are in the range MAX_RT_PRIO..MAX_PRIO-1. Priority
 * values are inverted: lower p->prio value means higher priority.

So the new 50 is actually a higher priority than the old 99?

Given I'm far from an RT expert, I must be missing something?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
