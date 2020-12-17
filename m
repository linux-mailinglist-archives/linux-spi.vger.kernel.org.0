Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8043E2DCBB9
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 05:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgLQEaf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Dec 2020 23:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgLQEaf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Dec 2020 23:30:35 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F774C0617B0
        for <linux-spi@vger.kernel.org>; Wed, 16 Dec 2020 20:29:55 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t8so18231155pfg.8
        for <linux-spi@vger.kernel.org>; Wed, 16 Dec 2020 20:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=dAJEzuEkVABPDPs6E6lM9hmUPqMeI4fJJlXgghYJKkA=;
        b=CMuombnSQlI8vHlOndLTmVhKeL92d2nC6WxM5vvjNMNacDMpr9WvKMda+3zu2Q9qE5
         LF2cl39XMp/UaOIOV0aFQtmFNWRst6ajbcmRy7WelkkraDJwIxuU3LhetMflhVq8OpFX
         k/kjHrxnH8ygbeFPSG0HmO5CaZuSgX3pijvUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=dAJEzuEkVABPDPs6E6lM9hmUPqMeI4fJJlXgghYJKkA=;
        b=V2izhaJjIDZXr3xtA29gQ+0mZEDQ9oOUOFIwauzcH+Ft1sAEUj4BIWPOYLqmclUkhy
         UYAEYwViFwJ7BvMtxbKuv7wiWVu9tL3VqRBzVdxv5JHK4Qe/yaoSWdJwwNuPLcZtRz9x
         aww4N21i2WCAO/ci/SQmv/MSS24UfKtvBeEmTvOVhxeEZf1itdaQqh1oMLBuTiEa0x/H
         LgU9ZsWeiC28xBx+/+fej+5BpHxgaRklhGSLogxWyEnQjDZDClBHZERo200URrg9fX6O
         YJeg77MXTTJNdl5qiKf88KqteX53hSAIphm1SsDhCMTba99C4643iMnD65Ufe3M8no/m
         abBQ==
X-Gm-Message-State: AOAM533FMNOK/MN4iZVBUBB/qoET0QFXttaO+WSibM734ZeeB8qY58rX
        EBN5W391j4JgC4vsjerMePl2tQ==
X-Google-Smtp-Source: ABdhPJzxQcPXL/SXdnCSj5SquGqgTE40wlQAR6R4baJeWmw4z3nSc9tAjEWL4mDTx/RhO+QrrRG9vQ==
X-Received: by 2002:a65:4785:: with SMTP id e5mr8123157pgs.0.1608179394623;
        Wed, 16 Dec 2020 20:29:54 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b2sm3901860pfo.164.2020.12.16.20.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 20:29:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201216144114.v2.3.I07afdedcc49655c5d26880f8df9170aac5792378@changeid>
References: <20201216144114.v2.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid> <20201216144114.v2.3.I07afdedcc49655c5d26880f8df9170aac5792378@changeid>
Subject: Re: [PATCH v2 3/4] spi: spi-geni-qcom: Don't try to set CS if an xfer is pending
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     msavaliy@qti.qualcomm.com, akashast@codeaurora.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Wed, 16 Dec 2020 20:29:52 -0800
Message-ID: <160817939232.1580929.12113046418592056259@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Douglas Anderson (2020-12-16 14:41:51)
> If we get a timeout sending then this happens:
> * spi_transfer_wait() will get a timeout.
> * We'll set the chip select
> * We'll call handle_err() =3D> handle_fifo_timeout().
>=20
> Unfortunately that won't work so well on geni.  If we got a timeout
> transferring then it's likely that our interrupt handler is blocked,
> but we need that same interrupt handler to adjust the chip select.
> Trying to set the chip select doesn't crash us but ends up confusing
> our state machine and leads to messages like:
>   Premature done. rx_rem =3D 32 bpw8
>=20
> Let's just drop the chip select request in this case.  Sure, we might
> leave the chip select in the wrong state but it's likely it was going
> to fail anyway and this avoids getting the driver even more confused
> about what it's doing.
>=20
> The SPI core in general assumes that setting chip select is a simple
> operation that doesn't fail.  Yet another reason to just reconfigure
> the chip select line as GPIOs.

BTW, we could peek at the irq bit for the CS change and ignore the irq
handler entirely. That would be one way to make sure the cs change went
through, and would avoid an irq delay/scheduling problem for this simple
operation. Maybe using the irq path is worse in general here?
