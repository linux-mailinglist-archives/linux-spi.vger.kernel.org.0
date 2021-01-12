Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5242F3439
	for <lists+linux-spi@lfdr.de>; Tue, 12 Jan 2021 16:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391719AbhALPfE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Jan 2021 10:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391716AbhALPfE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Jan 2021 10:35:04 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C0AC0617AA
        for <linux-spi@vger.kernel.org>; Tue, 12 Jan 2021 07:34:13 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id b23so1638563vsp.9
        for <linux-spi@vger.kernel.org>; Tue, 12 Jan 2021 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxCZhN0HPYWVbJAFHzviClBBvfiktQzKxiUuI/WHb64=;
        b=JwBBAAjWC19z8UsuWqxUc5kVg0wMb6EWFRHoz7kkGUngbEhRU+C6/MCHia57wDr8X9
         Jd86Mt63DQEmW6eSaffdLzO7z7LiNnNGMHUe46zYzJcyQA6RGLKr4Kmg011Z0Emovi4/
         at0IHPfJVaNEMbSJ/B0M5S6vGzvw1vRl459Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxCZhN0HPYWVbJAFHzviClBBvfiktQzKxiUuI/WHb64=;
        b=COVfa4dCzUsfB06+Unr3H9OektxCj/C0fjD5OgjHrqNuHQVSVNrJX4VEx8WM19FRsJ
         LU/jIoayWrsZtxCrxnsTgw4e0h+Ow1yvJksAZY6d/F45/2QRmSs/1EEEpn0FJwA/oWPb
         xmiDiwXyARXeK5x3bNfNe3o8r1AiAo7BsrwGNhNT0LyYwlt0Yt6MIeBu5MuZat1NMY3x
         Ve2mh3cyyN/Ck58CqlL3G2fWJ77ySLSkLV+l/DA3tc2tpA0SIxF7WBGBq9W7GyrI5MgN
         6d7Jz6bp45CCa02u/hlLPQHCHLMnS4oKmlvGyU+dLgfZlzTOvB7xKbFTKA2VIul29jJq
         K0ag==
X-Gm-Message-State: AOAM5333Yfu8Zn3w12ORjFPXR+vSNWasapItQSk3CU1d3HYB7EST22KM
        oIiZAOqzminEnVvHRMXAlGBE+4p5po0tiQ==
X-Google-Smtp-Source: ABdhPJziCFnCkgzByDunalhNmYpnTlf1GCMudwDCktJzFMyXZnyYFWZ6SIBbmsNCHy4y7OlR0nK07A==
X-Received: by 2002:a67:882:: with SMTP id 124mr1197471vsi.33.1610465652800;
        Tue, 12 Jan 2021 07:34:12 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id l20sm405257vsr.29.2021.01.12.07.34.11
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 07:34:11 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id e27so699772vkn.2
        for <linux-spi@vger.kernel.org>; Tue, 12 Jan 2021 07:34:11 -0800 (PST)
X-Received: by 2002:ac5:cde4:: with SMTP id v4mr4651199vkn.21.1610465651285;
 Tue, 12 Jan 2021 07:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20210112001301.687628-1-swboyd@chromium.org>
In-Reply-To: <20210112001301.687628-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 Jan 2021 07:33:59 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WRx2+jh7P5rM5S+C2shwbJiZSJxpf_fe57D+KpB4bijw@mail.gmail.com>
Message-ID: <CAD=FV=WRx2+jh7P5rM5S+C2shwbJiZSJxpf_fe57D+KpB4bijw@mail.gmail.com>
Subject: Re: [PATCH v2] spi: spi-qcom-qspi: Use irq trigger flags from firmware
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Mukesh Kumar Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Mon, Jan 11, 2021 at 4:13 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need to force this to be trigger high here, as the firmware
> properly configures the irq flags already. Drop it to save a line.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> Cc: Akash Asthana <akashast@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1:
>  * Rebased onto v5.11-rc1
>
>  drivers/spi/spi-qcom-qspi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
