Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD10E2ABE86
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 15:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgKIOVv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 09:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgKIOVu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 09:21:50 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE08C0613CF
        for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2020 06:21:50 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r10so7260612pgb.10
        for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2020 06:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4GMBoB959F8I/yHY10NXzv7YVgWaUaagFE7TNa7x+WU=;
        b=nThHWUF3NQLXKjImHwACxUVPr66QA6dk+eGAMfLgzO6QTkP6JUZLCbBLqmijMCAxp2
         6PbW56ueDSeRPQqTwYH0zUxMl5chqBVcjz9JrGi9gLYNZl0yW1DoGtr8dJA+2y7y0eRM
         RtnyXj5RPvsptzFhGTCeupqYXHNLzxa0aFqXhZaweVtEZQFtmDXmGlnhMyA68tck5ZnB
         PWyfegGVG+y+lGht7Ahep+aEXighn4eiUIXON5FYkFOV31jvOlZaTtOzuBbTAe+7YQK3
         z8pOktko0RHfBVC4HR3WOinb+S+/ehiZ5esNTjiziLPvzZ4lwQItleh5y97Ov6cg2Wm5
         GZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GMBoB959F8I/yHY10NXzv7YVgWaUaagFE7TNa7x+WU=;
        b=Hl86mzQZCZRLYkQVnxlokd+2zJQQbXnRQ6QnNooq2+Sdsbqt2c2QC2HVsl0TSaGfth
         FvI3Fs28EKv996KooB196soOB9vE4yK3qTBjWwg23ZEJ+zINcb6Hjb/wTUIAtw++1GwO
         VGc+Q4QJvNsv995CRjN79da1xxP4vw7gr12yoO0zB2CAd0JzXu8G+UlyqBrQJgqXL/HT
         sGElyTlkRpSrIno9si1aF3MsWn8Wu8X3M4kxXCqpvbk1afI0/XkHcY6vYhT6RG2+1L1C
         6go20dQvJHvC6KSF1ok/sxIM1zP8LGgQgVoWn9qCJlQirVjvMfsLw2l7N1IFJgDxUX1o
         HOPg==
X-Gm-Message-State: AOAM532vVRzzDuCFJ3xUhNnezfCviRN74qvoJgrka6ok2HFHnXkXCpl3
        JJo8uWgMFNH/nqVx4PtpMwCgqVqBkdm3hpsQ95o=
X-Google-Smtp-Source: ABdhPJwroqN66MsrMjkxbMNldFbeTZAV2fgVPAsREhbWnTRVoOOAMu3jKaoY8lzc2p4Qv43dEfa3EYaQwwMVv46/oyo=
X-Received: by 2002:aa7:942a:0:b029:164:a853:f0fc with SMTP id
 y10-20020aa7942a0000b0290164a853f0fcmr13556411pfo.40.1604931710181; Mon, 09
 Nov 2020 06:21:50 -0800 (PST)
MIME-Version: 1.0
References: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
 <232281df1ab91d8f0f553a62d5f97fc264ace4da.1604874488.git.lukas@wunner.de>
In-Reply-To: <232281df1ab91d8f0f553a62d5f97fc264ace4da.1604874488.git.lukas@wunner.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 Nov 2020 16:22:38 +0200
Message-ID: <CAHp75Vc+Gi_+SAj93_Aj95R-1h=rbMH_==G9Pgg1fcp5uQQcfg@mail.gmail.com>
Subject: Re: [PATCH] spi: synquacer: Disable clock in probe error path
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 9, 2020 at 12:52 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> If the calls to platform_get_irq() or devm_request_irq() fail on probe
> of the SynQuacer SPI driver, the clock "sspi->clk" is erroneously not
> unprepared and disabled.
>
> If the clock rate "master->max_speed_hz" cannot be determined, the same
> happens and in addition the spi_master struct is not freed.

Wouldn't be better to switch over devm_add_action_or_reset() in such cases?

-- 
With Best Regards,
Andy Shevchenko
