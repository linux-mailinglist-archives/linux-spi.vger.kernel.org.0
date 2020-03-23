Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2787818F9C1
	for <lists+linux-spi@lfdr.de>; Mon, 23 Mar 2020 17:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgCWQcz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Mar 2020 12:32:55 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46093 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbgCWQcy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Mar 2020 12:32:54 -0400
Received: by mail-ua1-f68.google.com with SMTP id y17so1368412uap.13
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2020 09:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vX/pTxX5leUKI//FHes+EDjkWAmuKn+xAlsAhXDay5w=;
        b=c1CQI6r5AyGrK7N+JP44nrKbQ0k3r8F5dz6wSdikRKRG8IBAr591tkZHPW4rL5sQ0K
         FEIOrHYN/ryK4FWkhbMYudP9qub+iU9PP6IqV2AufntwMh0sDIrw8OhzUhO9h7+AEtcU
         bntwsCZo8mATCRdmMgeNj+YyBFYL6wTejiX5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vX/pTxX5leUKI//FHes+EDjkWAmuKn+xAlsAhXDay5w=;
        b=WtOoCfpQrhblqWytB6+I2KBLn+E7rl2ZPruqbZ4rywJIa/yndRMA8EgIXajisEVOp3
         QbOYMqPKvpEsyWaoSrX8RujFhKuBESU7fbahBqNstSfEgB/Yp0iuAprS1dQhCFiNsSDm
         MHmec0kx2gZQVA6Y0INZzmvt7Ne13oP6GAdT3EHxgNKxdjRLkqJPn/0Rfc1sw5HQAodu
         XZbHWKVYHPFf3nnhd7ro8gNocneuLkpgXh5GI0q5RRG6erL41ngES9/RhqLbx4N3qpv5
         d8RokQTXftXt1ID6/AGIjlhqj17nblnb8EGFsan0/tEe1laO6hKULvJSvAJYYYg5u4KK
         akrg==
X-Gm-Message-State: ANhLgQ37Avo+2NJlyduhdu5hoLg60bZ4JX7jJxvvfuhl4900aP/I5u9B
        cPdz/SVkaEc3Tyr9aE07Md0Rqgk4pI8=
X-Google-Smtp-Source: ADFU+vuUGfV/4sTuMM++pufRx1PTwnpT7TEgucgpuSYEpS/1dLwKNXgOPcrN3EwhfIU6eEe9omxYng==
X-Received: by 2002:ab0:378:: with SMTP id 111mr15456316uat.78.1584981173044;
        Mon, 23 Mar 2020 09:32:53 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 79sm8972130uaf.11.2020.03.23.09.32.51
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 09:32:51 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id g24so1388793uan.10
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2020 09:32:51 -0700 (PDT)
X-Received: by 2002:ab0:604f:: with SMTP id o15mr8911387ual.120.1584981170619;
 Mon, 23 Mar 2020 09:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200317133653.v2.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
 <20200323110756.GD26299@kadam>
In-Reply-To: <20200323110756.GD26299@kadam>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 Mar 2020 09:32:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WcnAtA2WRoC-+R2yKC1OCsDOEDMXu5jKveOARhw4gmOg@mail.gmail.com>
Message-ID: <CAD=FV=WcnAtA2WRoC-+R2yKC1OCsDOEDMXu5jKveOARhw4gmOg@mail.gmail.com>
Subject: Re: [PATCH v2] spi: spi-geni-qcom: Speculative fix of "nobody cared"
 about interrupt
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, kbuild-all@lists.01.org,
        Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Mon, Mar 23, 2020 at 4:08 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> 561de45f72bd5f Girish Mahadevan 2018-10-03  327                 ret = get_spi_clk_cfg(xfer->speed_hz, mas, &idx, &div);
> 561de45f72bd5f Girish Mahadevan 2018-10-03  328                 if (ret) {
> 561de45f72bd5f Girish Mahadevan 2018-10-03  329                         dev_err(mas->dev, "Err setting clks:%d\n", ret);
> 561de45f72bd5f Girish Mahadevan 2018-10-03  330                         return;
>
> Needs to drop the lock before returning.

Oops, thanks for catching.  I will wait before spinning a v3 until
there is some clarity about whether folks want to do something more
like Stephen suggested or whether I should continue with my strategy.
At the moment I'm still in favor of keeping w/ my strategy and seeing
if I can reduce the amount of time with interrupts disabled in
setup_fifo_xfer(), maybe just grabbing the lock around the start of
the transfer to keep the state machine in sync with the kickoff...

-Doug
