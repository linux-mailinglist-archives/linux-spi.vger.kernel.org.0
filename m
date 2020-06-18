Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3441FF629
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 17:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbgFRPGJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 11:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730949AbgFRPGI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 11:06:08 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F8EC0613ED
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 08:06:08 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id d5so1502099vkb.12
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uhyo0sKph8oAx2mIyvhHF5US4adK0E3GfKdnIj29E9Y=;
        b=aB8ub7BN1xbigSK9olQdwudzkwJ1S2Yyrfdib2JJjs9mSUrmcIBMO2frrAcBiZHX7l
         4L9kXEoi3EWaFw233GFFuBhCKCauoatr3Dh0Zel+L6LuxU0GkTw8Fz5FrXpPncLbU1ap
         Wjgam1IaQoIbFXWShumV1iaHOZseVhcJ8qLaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uhyo0sKph8oAx2mIyvhHF5US4adK0E3GfKdnIj29E9Y=;
        b=jiLmrhI2zw8x7cBZS4R7MPRQbu44YlmfMLG7kTHTUvYkrIHhUBeu317fmkW6oSnfn6
         KvY8rUxmhedp7kmG5Gq36ev5YgzpTSq3if7oW63gtqkuXsVB+SxE+8WoS5izWEa1AVv4
         V62VV+TF8iNIl1/weSynpb8IoP6RP6f7duFuJz+QdjX/aIJLaa6vm3Hdk6Jd80R4Z6EZ
         iO2I5ZMT/u9iVa1CvMYCSCzmEvr+OM091wXsr2CSQY3rWE3/GKvbjphTXucW3NJ2pIoc
         2OIlbbKDLIjUQt3ukC4D83QkMsa1JEyX5oRwBFhG3FIXqKmi3Eqb/+WKX++Hd1hepal6
         T1Ng==
X-Gm-Message-State: AOAM533EEh4gVdmmHY08ZUUFBTJTd9pZJc7aULBjADObJj9Wfwlga4oC
        UAYlOKhih7zSqcWC2qUpj09WWTQQPsM=
X-Google-Smtp-Source: ABdhPJxzVMAztq2q1EkxuvGP8beYSFDto2kEpZnzRpsc0Pf3+hs+2WIEuS2NfAQYJYXgvTSQiIaIVw==
X-Received: by 2002:a1f:b202:: with SMTP id b2mr3810377vkf.86.1592492766711;
        Thu, 18 Jun 2020 08:06:06 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id k48sm295556uae.11.2020.06.18.08.06.05
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:06:05 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id t23so1509201vkt.5
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 08:06:05 -0700 (PDT)
X-Received: by 2002:ac5:ce86:: with SMTP id 6mr3726475vke.75.1592492765249;
 Thu, 18 Jun 2020 08:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200616104050.84764-1-dianders@chromium.org> <20200616034044.v3.5.Ib1e6855405fc9c99916ab7c7dee84d73a8bf3d68@changeid>
 <159242860191.62212.18088243128415903480@swboyd.mtv.corp.google.com>
In-Reply-To: <159242860191.62212.18088243128415903480@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Jun 2020 08:05:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XfYnkw2EFFHZNMRffmO3XJE9Qm8YtMzjK8OWLgL39XKQ@mail.gmail.com>
Message-ID: <CAD=FV=XfYnkw2EFFHZNMRffmO3XJE9Qm8YtMzjK8OWLgL39XKQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] spi: spi-geni-qcom: Don't keep a local state variable
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Wed, Jun 17, 2020 at 2:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2020-06-16 03:40:50)
> > diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> > index 63a62548b078..6feea88d63ac 100644
> > --- a/drivers/spi/spi-geni-qcom.c
> > +++ b/drivers/spi/spi-geni-qcom.c
> > @@ -63,13 +63,6 @@
> >  #define TIMESTAMP_AFTER                BIT(3)
> >  #define POST_CMD_DELAY         BIT(4)
> >
> > -enum spi_m_cmd_opcode {
> > -       CMD_NONE,
> > -       CMD_XFER,
> > -       CMD_CS,
> > -       CMD_CANCEL,
> > -};
> > -
> >  struct spi_geni_master {
> >         struct geni_se se;
> >         struct device *dev;
> > @@ -81,10 +74,11 @@ struct spi_geni_master {
> >         unsigned int tx_rem_bytes;
> >         unsigned int rx_rem_bytes;
> >         const struct spi_transfer *cur_xfer;
> > -       struct completion xfer_done;
> > +       struct completion cs_done;
> > +       struct completion cancel_done;
> > +       struct completion abort_done;
>
> I wonder if it would be better to use the wait_bit() APIs. That would
> let us have one word for various bits like CS_DONE, CANCEL_DONE,
> ABORT_DONE and then wake up the waiters when the particular bit happens
> to come in through the isr. It is probably over-engineering though
> because it saves a handful of bytes while increasing complexity.
>
> Otherwise I like this patch.

I'm going to leave it as-is for v4.  We can always make it a future
improvement if we want.

-Doug
