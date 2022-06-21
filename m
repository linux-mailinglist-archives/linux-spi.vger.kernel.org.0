Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5685533D1
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 15:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351611AbiFUNjV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 09:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351703AbiFUNiO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 09:38:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3A22BB1C
        for <linux-spi@vger.kernel.org>; Tue, 21 Jun 2022 06:37:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z19so2571505edb.11
        for <linux-spi@vger.kernel.org>; Tue, 21 Jun 2022 06:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=teV9/LHsIcT7kFIRVS3tS6YlV3h6OdDoM3Pe9unkBBY=;
        b=H+jafnxrKxLDb2H/13yn4Oc7TaMdxR89Nu+ZQ7h8dIkRgcpT/o+u2RVFbd45mwxv4H
         IcHiy2cBOsQb3pYSEZxrHbt26sQZqVVxzwXREcedYdH6PdCALMEmjosFc02L7pA1+oPE
         0EQN4vBTloYkVMp8OVEjsUErC34LYpBSFI9osC9roujlg3WqXIOonQfWaeCh7U/IBmgE
         odn08Ou6Z2/W/ReVRnm4RVnm5dem57e7A66MOsRBzwtyHV+g8+XN38BMvzX1AgBvhn50
         sliZwgoGiicgw5g6YrB+NBWutSmVn3GGL/LZVngQ25rKN0WkhTzxwy58wVi/j19sGbbO
         dA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=teV9/LHsIcT7kFIRVS3tS6YlV3h6OdDoM3Pe9unkBBY=;
        b=yfQYEvB9BAhKf/18bMGwkT5Ki6NN0H7V+6CqdB/SJ9F8ZmMH8p4pDO9XcNu1kPLH3P
         1rYKBzdiaY4lrzYkeqeXSqBugtQ6y9fT9+Q/k47AgnrZNZeVmpL8FaTzPJQ4t0JTuEex
         iU6hVFGHummIgot1IZB7R9Tp8RNVe0V89a15ohyIAtG3k8cyvZl6ttk2d/1UDIfG2sFn
         uvwuFfHzpodW/4yPWfJKsDMXj9TwtMS7iKXXDLYTsN2JfwR6TiQkCFVDUejv3FfUU/5M
         ct9N77LIYbx8NAtrIXWKaVrjShquflS4/NVBphLQTakg5rVJjN4bEL3Z7zM5Yfdz5HlN
         68wQ==
X-Gm-Message-State: AJIora+wYdCzXBMfZ+4DnbZoP1Y2RUbVAzNYeWGzPL/Q6TIR/zTu7SSt
        2vdb9KYhU1cdNrMgXca1tcEjqPRru89M43cjiY8=
X-Google-Smtp-Source: AGRyM1uTxVMwyiJ00UDnFKQIZNLE42xWEiwgDcmWWu4K+RnyzbvCkNxgGyGTney5PPLTx5HDXuNrl79qxj6yzqm1V6k=
X-Received: by 2002:a50:9f6a:0:b0:435:5804:e07 with SMTP id
 b97-20020a509f6a000000b0043558040e07mr30700778edf.178.1655818619751; Tue, 21
 Jun 2022 06:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220621061234.3626638-1-david@protonic.nl> <20220621061234.3626638-4-david@protonic.nl>
In-Reply-To: <20220621061234.3626638-4-david@protonic.nl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 15:36:23 +0200
Message-ID: <CAHp75VeHcdcRMYxsJ3At+YyFZEauDPp-+deXbsBpcqKdxaicfg@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] spi: Lock controller idling transition inside
 the io_mutex
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

On Tue, Jun 21, 2022 at 8:15 AM David Jander <david@protonic.nl> wrote:
>
> This way, the spi sync path does not need to deal with the idling
> transition.

...

> -       mutex_lock(&ctlr->io_mutex);
>         ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
>         mutex_unlock(&ctlr->io_mutex);
>
>         /* Prod the scheduler in case transfer_one() was busy waiting */

>         if (!ret)
>                 cond_resched();

In the similar way


ret = ...
if (ret)
  goto out_unlock;

mutex_unlock();
cond_resched();
return;

> +       return;
> +
> +out_unlock:
> +       mutex_unlock(&ctlr->io_mutex);

-- 
With Best Regards,
Andy Shevchenko
