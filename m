Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AE53B6B75
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 01:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhF1Xkt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Jun 2021 19:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbhF1Xkk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Jun 2021 19:40:40 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12031C061760
        for <linux-spi@vger.kernel.org>; Mon, 28 Jun 2021 16:38:14 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d9so14841437qtx.8
        for <linux-spi@vger.kernel.org>; Mon, 28 Jun 2021 16:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miYY2dmUa8aOm4aFUUNNkSxFLOIn70qDkiO0NjVvZko=;
        b=nV8UvqlMp80EZh03fJr7ThFcbJyzi6eYcMjOZYU/YWtPbhj0fi2Bc/uhP5P/k9heDu
         V7/GzY+XyI83HS9tzCN6IN3uhhp/AqVgWd1JH+pTpQmRpEZb5+izLOpQESgRoZXGYEF4
         07PiqC06/UlBCuh87w2WO52BugnaUrs3/WxS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miYY2dmUa8aOm4aFUUNNkSxFLOIn70qDkiO0NjVvZko=;
        b=H7OfQur/QH6nHGq8Q4V0TdmaUS5LoDNAGbnBPdUqK4tmeZoX3/FKO0dow/qGu1omX6
         5tucie/6+wUVgwSb8QrexUBCnZAcwmbZVdthR1NR7IocrvK2nAXGpYBAdOrf8Qm4wqrB
         ciPSG7UU/Gg9kszsBDRHVa5XhdVotguzx/CkE7TVRxhXW7rsAiHRGR4xs5gBAyTIu4Ii
         ZQTfUZeWh/6HP1RibD2wQoysoRwlFEVYuMmiqVuJu6vNshi9Jt94zHGcQApnVqPM6GcR
         06US1ViwpG2ktbySkFMNnnqQE98u6dSPndGuj+HI0o7Mxv72c/VFjlyhCEm95MTP7buL
         FU8A==
X-Gm-Message-State: AOAM533obKdGRRts8X9NND1wySi1PnoFgmFOhjxlwFQBQbDJoR9FJYxw
        eBITOlLW9WGGIykJfPhwB57WnefS9s+qYQ==
X-Google-Smtp-Source: ABdhPJzgauUhs87AfLOpgtKexkHxmEEmcmqTXRLVwGtKrXpHLaSfXRDOPH9tiYKaxkLcxmtWGsYeXg==
X-Received: by 2002:ac8:4618:: with SMTP id p24mr14922628qtn.324.1624923492887;
        Mon, 28 Jun 2021 16:38:12 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id d76sm5872143qkc.54.2021.06.28.16.38.11
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 16:38:11 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id c8so21414632ybq.1
        for <linux-spi@vger.kernel.org>; Mon, 28 Jun 2021 16:38:11 -0700 (PDT)
X-Received: by 2002:a25:dc50:: with SMTP id y77mr18847228ybe.405.1624923491186;
 Mon, 28 Jun 2021 16:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210625052213.32260-1-vkoul@kernel.org> <20210625052213.32260-2-vkoul@kernel.org>
In-Reply-To: <20210625052213.32260-2-vkoul@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Jun 2021 16:37:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XsUbyB4enDobda3eDoTpCqdgVogyC3YWGe9rsjgR1REw@mail.gmail.com>
Message-ID: <CAD=FV=XsUbyB4enDobda3eDoTpCqdgVogyC3YWGe9rsjgR1REw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] soc: qcom: geni: move GENI_IF_DISABLE_RO to common header
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Thu, Jun 24, 2021 at 10:22 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> GENI_IF_DISABLE_RO is used by geni spi driver as well to check the
> status if GENI, so move this to common header qcom-geni-se.h
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 1 -
>  include/linux/qcom-geni-se.h    | 4 ++++
>  2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
