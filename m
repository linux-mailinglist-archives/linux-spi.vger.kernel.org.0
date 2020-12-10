Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329312D5139
	for <lists+linux-spi@lfdr.de>; Thu, 10 Dec 2020 04:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgLJDRn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 22:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbgLJDRn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 22:17:43 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F23C0613CF
        for <linux-spi@vger.kernel.org>; Wed,  9 Dec 2020 19:17:03 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id p6so2055659plr.7
        for <linux-spi@vger.kernel.org>; Wed, 09 Dec 2020 19:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=k53PFT7deXWzGUQq0Qpf6W/21ZGbwiD77Sh9ifdNlYI=;
        b=j/3AaR7Rv5E0+fKghUnWh6A8a2UeZzPe81/mLS/v3NuwDplaOQN7T01j81j978t12h
         Bv9RlbNJWBBugNdKcx8NNnfildF6mmoJj0b92N2lH5GxU6SKQMNwTH9JTvNBpLJpl87c
         ZbfOQwyLx35Nuie38/uNAF48DHT4i+K8moLJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=k53PFT7deXWzGUQq0Qpf6W/21ZGbwiD77Sh9ifdNlYI=;
        b=ei6UZrMqupXrUfNszixdjAWLEBUwXmN+sGF0+QhOJmaMb5UNYEZ8GKuoV3NTmqmffX
         kuvQP7Gcgv8DfQhEBhDyzbDy2uV6aM2bEePFcly155vxdJX8D74bBv1p3lzZwJ6dj9q5
         SACPk77hPk1TrxFWLNv5GKx+Qf0f4IQMPLgc/bsSLVWZwwxEdhc6tygmwTBnBDmqZehH
         FLx/wGDiJCkPzFoLlq5jFFSZErrcs6huHHusBG/8jH7ZZRNHRaCZVeR+FNB43GWrjHY9
         iHr0+u1LmjoR+cK8D0T/WUP6uARzB/9UilOMfS2hLoFRmmWedn4qyJQCpdK13jYJJXWc
         bzlg==
X-Gm-Message-State: AOAM5323Luv5UGlMoFDmNRLBo1hyw00dLHtrv178lJSxsfZoLhHajO/a
        /tbqf9J1IVA3c8gRBbUyh3tgIw==
X-Google-Smtp-Source: ABdhPJxCdPN48jN7aGTW0NAvFrMo0PSR1HiBugsItDALpwR1BgRUQBc57Mz37oFQa7zYg0hYEQiSfA==
X-Received: by 2002:a17:902:74cc:b029:da:9287:2b4 with SMTP id f12-20020a17090274ccb02900da928702b4mr4650468plt.9.1607570222586;
        Wed, 09 Dec 2020 19:17:02 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id l17sm3665289pjy.29.2020.12.09.19.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 19:17:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=XKyXnjsM4iS-ydRWBnmYMojPOaYAdYhOkxkPTCQf0RLQ@mail.gmail.com>
References: <20201203074459.13078-1-rojay@codeaurora.org> <CAD=FV=XKyXnjsM4iS-ydRWBnmYMojPOaYAdYhOkxkPTCQf0RLQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Fix NULL pointer access in geni_spi_isr
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        msavaliy@qti.qualcomm.com
To:     Doug Anderson <dianders@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Date:   Wed, 09 Dec 2020 19:17:00 -0800
Message-ID: <160757022002.1580929.8656750350166301192@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Doug Anderson (2020-12-03 08:40:46)

> I would guess that if "mas->cur_xfer" is NULL then
> geni_spi_handle_rx() should read all data in the FIFO and throw it
> away and geni_spi_handle_tx() should set SE_GENI_TX_WATERMARK_REG to
> 0.  NOTE: I _think_ that with the synchronize_irq() I'm suggesting
> above we'll avoid this case, but it never hurts to be defensive.
>=20
>=20
> Does that all make sense?  So the summary is that instead of your patch:

Can we get a CPU diagram describing the race and scenario where this
happens? Something like:

  CPU0                                CPU1
  ----                                ----
  setup_fifo_xfer()
   spin_lock_irq(&mas->lock);
   spin_unlock_irq(&mas->lock);
   mas->cur_xfer =3D xfer
   ...
   <IRQ>
                                      geni_spi_isr()
				       geni_spi_handle_rx()
				        <NULL deref boom explosion!>

But obviously this example diagram is incorrect and some timeout happens
instead? Sorry, I'm super lazy and don't want to read many paragraphs of
text. :) I'd rather have a diagram like above that clearly points out
the steps taken to the NULL pointer deref.

>=20
> 1. Add synchronize_irq() at the start and end of
> handle_fifo_timeout().  Not under lock.
>=20
> 2. In geni_spi_handle_rx(), check for NULL "mas->cur_xfer".  Read all
> data in the FIFO (don't cap at rx_rem_bytes), but throw it away.
>=20
> 3. In geni_spi_handle_tx(), check for NULL "mas->cur_xfer".  Don't
> write any data.  Just write 0 to SE_GENI_TX_WATERMARK_REG.
>=20
> I think #1 is the real fix, but #2 and #3 will avoid crashes in case
> there's another bug somewhere.
>=20

Aren't 2 and 3 papering over some weird problem though where irqs are
coming in unexpectedly?
