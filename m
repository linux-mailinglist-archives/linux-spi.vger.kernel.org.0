Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2565431B3
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jun 2022 15:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbiFHNoO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jun 2022 09:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240587AbiFHNoM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jun 2022 09:44:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0227026E88B
        for <linux-spi@vger.kernel.org>; Wed,  8 Jun 2022 06:44:00 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y19so41567322ejq.6
        for <linux-spi@vger.kernel.org>; Wed, 08 Jun 2022 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ds/zrx+rqQwnQYTRwOmsVLkIx8bV696K6L8hSPPeJk=;
        b=CJ3ddTiZZWp59QEIcAJ85eutH9tZEoOa2N4MML3tleMEEmvesWQ+ImQ5NbAm3xjwYb
         fH/+McWIxfEkYCd8xFrWKAvd5KetNkP82E7EjFjthKUI70dodngJS+Wc2XjP2VMa6NRE
         4X3jiQQcP1MH2ojIcICYCnr3jRb/HZPbvni5hzsREV5LOEbVzAzkXEgGXLtCxzMG2bty
         GXuqDmBEERzl8YkoFH2qSBjyY0n2+jlyPIGpRYwGj1e9lwUS5qJM/zjQgma4ThOBAWjb
         7YUZvcsW5xzdSHhoNjgrw4ds7Yu843sBAmTDknMMTEEi9r1HFwGorv+O5bQ5mfbmYGj2
         hExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ds/zrx+rqQwnQYTRwOmsVLkIx8bV696K6L8hSPPeJk=;
        b=HU/7ZMcVMO6VGeDyWFnpsJipuwLfArUolwaWdmv+CrWkBDwZTLGwsOMagq4qOnjXrO
         kyrSpGBmGbEHLiF9ptCFYbLJURXjC1wZ9IDiP+t+o41rex1HQ5eqvcVAaoLJYCRtttJ/
         JZLXEmho2TU/LYOY/ccQsffPZfcnUkewYZm710x0OQGIP1It7Xkju0urir9xNyx+UceU
         ByOC3ZBIikK/r9k5rAL/0n9Uodhi3ZaFThG6NSFPVcwRU+mM2aNs8kJiMms5wR0Nl71O
         t1RxmrMWCpjRzKC/H4IoMgv1YjuCBr+8FKVmPp0HR4WNJw0zpeOTwm/o8jpcF0TYU2EK
         GR3g==
X-Gm-Message-State: AOAM532fMvr4LCBp3Z4OrnOV+RE68ARbmTo4xiadM1QRsxHS5hRpTquI
        xR6ZUbWDsW2yE04s9NCTKsVcQfr22J7lBVwLm9k=
X-Google-Smtp-Source: ABdhPJz1krqbp/XpN87xIXVr2MuT4lB69seJhV0qHAfuqzRF9Nyw1bNiVutXvP07eP4ckxS3hk340GhuNhE1rsegdNM=
X-Received: by 2002:a17:906:1193:b0:70d:cf39:a4db with SMTP id
 n19-20020a170906119300b0070dcf39a4dbmr26191771eja.44.1654695838754; Wed, 08
 Jun 2022 06:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220525142928.2335378-1-david@protonic.nl> <20220525142928.2335378-4-david@protonic.nl>
In-Reply-To: <20220525142928.2335378-4-david@protonic.nl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Jun 2022 15:43:22 +0200
Message-ID: <CAHp75VcsOmyuSbwJjrAgA-MB-i05WPKX7C-qDgusF_eZ4ak0cA@mail.gmail.com>
Subject: Re: [RFC] [PATCH 3/3] drivers: spi: spi.c: Don't use the message
 queue if possible in spi_sync
To:     David Jander <david@protonic.nl>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 26, 2022 at 2:46 AM David Jander <david@protonic.nl> wrote:
>
> The interaction with the controller message queue and its corresponding
> auxiliary flags and variables requires the use of the queue_lock which is
> costly. Since spi_sync will transfer the complete message anyway, and not
> return until it is finished, there is no need to put the message into the
> queue if the queue is empty. This can save a lot of overhead.
>
> As an example of how significant this is, when using the MCP2518FD SPI CAN
> controller on a i.MX8MM SoC, the time during which the interrupt line
> stays active (during 3 relatively short spi_sync messages), is reduced
> from 98us to 72us by this patch.

...

> +       /* If another context is idling the device then wait */
> +       while (ctlr->idling) {
> +               printk(KERN_INFO "spi sync message processing: controller is idling!\n");

printk() when we have a device pointer, why (despite of pr_info() existence)?

> +               usleep_range(10000, 11000);
> +       }
> +
> +       was_busy = READ_ONCE(ctlr->busy);
> +
> +       ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
> +       if (ret)
> +               goto out;
> +
> +       if (!was_busy) {
> +               kfree(ctlr->dummy_rx);
> +               ctlr->dummy_rx = NULL;
> +               kfree(ctlr->dummy_tx);
> +               ctlr->dummy_tx = NULL;
> +               if (ctlr->unprepare_transfer_hardware &&
> +                   ctlr->unprepare_transfer_hardware(ctlr))
> +                       dev_err(&ctlr->dev,
> +                               "failed to unprepare transfer hardware\n");
> +               spi_idle_runtime_pm(ctlr);
> +       }

-- 
With Best Regards,
Andy Shevchenko
