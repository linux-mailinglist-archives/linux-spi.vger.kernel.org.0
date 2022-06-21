Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBCF5533E5
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350928AbiFUNmg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 09:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiFUNme (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 09:42:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04E425E2
        for <linux-spi@vger.kernel.org>; Tue, 21 Jun 2022 06:42:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id es26so17730881edb.4
        for <linux-spi@vger.kernel.org>; Tue, 21 Jun 2022 06:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BjpHxT7USNlYVm3C7xBkw6xiQAd1RnMTssjkHBLRh0o=;
        b=US7HpyEbOiF7iafkNiVoDnjaqiGwvrg5wfm7u6W+wZPNME6eh9STWMhZ7gU/JAXkHq
         VpQwZ7XamnxlbxZBirTQmRoVtAbRP2XMgpLiylfX9/Wx9+2awNuWFKzFFdDTyqgF3nhY
         IkqJObSgRTIRuH2fui2MeSjzF20I4JB2w8Zu6ewIKqa6XMeRl8IG89Da7gB0N7GvGJTT
         yVyaxhI7Z1MA9byAA1shnIaibwvNyG6R4jwMgSUCdTMXc9zmrwGfb82b6Ux6MrTmYpoZ
         8PWWb6SWN/wyyBVQJ7qYrf0/6DIYhhNTF+VK5d08cPYMpYH5LLskRWd70cTwFxKXb2mb
         veMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BjpHxT7USNlYVm3C7xBkw6xiQAd1RnMTssjkHBLRh0o=;
        b=VuVyvDpmhczW3jjKZSv5o2q2DO8s21zzvuug9m5yKjqNKZvcNG3kocjPzswRgvMCNz
         wLRGT8Uqcu9px9FN0C9YbDik6XBQ14G4/trY8bx4kylAms8Dr0KUiu+rEK5CTPVAS4sN
         UhB2jP5EovCG8uowQECaakeaZaSlHt/fWsmCvCdX9D47Hi7L5s25sCEx02ZFK0p4uUcX
         mm08YB193SS3emBMnp1DtGG2hB8YY0jvYl5JJbzEDDlPwu/hnz0QE4/o+kbOB12FrFwV
         TPbEzV7ktLpbXDI47VYYGEC1RB7MDh+DbyrmfRksxOSm21o3RCPOC5BIyuic0bKaFwdv
         hP1Q==
X-Gm-Message-State: AJIora++9IBu2r1Pl+Nop3+a1++vIPuXDO+unqSjYwOqWoF/f856426q
        5buk6z9EvghsdFck/lVqu7a7C8K8P/ovtdS9gt2cFq03liit0Q==
X-Google-Smtp-Source: AGRyM1uK9lxvF43pVEgezPAmxC2hb+yVq7ylrzMTcMhGnVmtvE2pa79MRPxUj4kZgFE91/W9MlQdXjPpUJC+sEDT0Cg=
X-Received: by 2002:a05:6402:f8d:b0:435:6df2:68a with SMTP id
 eh13-20020a0564020f8d00b004356df2068amr21312640edb.209.1655818952545; Tue, 21
 Jun 2022 06:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220621061234.3626638-1-david@protonic.nl> <20220621061234.3626638-11-david@protonic.nl>
In-Reply-To: <20220621061234.3626638-11-david@protonic.nl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 15:41:56 +0200
Message-ID: <CAHp75VeoNg-+VYF=W=Y2KrHBUPNgVfQf9M0TDaJwW44ZxAiexw@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] spi: Ensure the io_mutex is held until spi_finalize_current_message()
To:     David Jander <david@protonic.nl>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
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

On Tue, Jun 21, 2022 at 8:16 AM David Jander <david@protonic.nl> wrote:
>
> This patch introduces a completion that is completed in
> spi_finalize_current_message() and waited for in
> __spi_pump_transfer_message(). This way all manipulation of ctlr->cur_msg
> is done with the io_mutex held and strictly ordered:
> __spi_pump_transfer_message() will not return until
> spi_finalize_current_message() is done using ctlr->cur_msg, and its
> calling context is only touching ctlr->cur_msg after returning.
> Due to this, we can safely drop the spin-locks around ctlr->cur_msg.

...

> +       reinit_completion(&ctlr->cur_msg_completion);
>         ret = ctlr->transfer_one_message(ctlr, msg);
>         if (ret) {
>                 dev_err(&ctlr->dev,
>                         "failed to transfer one message from queue\n");
>                 return ret;
> +       } else {

Redundant.

if (ret) {
 ...
 return ...;
}

...do other stuff...

> +               wait_for_completion(&ctlr->cur_msg_completion);
>         }

...

>         ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
> +

No need to add a blank line here.

> +       if (!ret)
> +               kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);

> +       ctlr->cur_msg = NULL;
> +       ctlr->fallback = false;

Does ->pump_messages() use any of these two?

>         mutex_unlock(&ctlr->io_mutex);

-- 
With Best Regards,
Andy Shevchenko
