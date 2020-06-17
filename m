Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5376B1FD6F8
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jun 2020 23:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgFQVQp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Jun 2020 17:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFQVQn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Jun 2020 17:16:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A3CC0613ED
        for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2020 14:16:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y18so1519581plr.4
        for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2020 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=tWsVYnQ3iH7YwzkryukDVXzPciX1h/b/fiAQh2Zg/5o=;
        b=blI9kPh6w+TXt4CyfVJyAUo3iWTMT0XXfiSstAnIPO2An/AgiKKnhMDkMBNfNzeCiP
         VhviCu/auXCt/f/rGO6b79mCuLYPJbEAQ3uvUcFxxpfNwdpimIFraw6xdmN8tr1B9iZP
         JCTbEzGD8PWTOdsV6XmPMFTnMJs/is0JdTJsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=tWsVYnQ3iH7YwzkryukDVXzPciX1h/b/fiAQh2Zg/5o=;
        b=QEUDCWsVCBN7+dD9uqVWNIyti6X/nNn3uisSGK3jykkBjlhBmTVKQCLZ8wzWpY7J09
         +DIUPh4btEDcHLDRCN3UqgFsPvqD5qCgDHkLrbYvdgWSSPj3XW9fm5l9UbVjYUJ3eGlZ
         NVEuKZJMVEbIJgCxpx44rmaGHgeFfFvP2UgS4Diu1sGZ32AvBUQv62my+Up1ZjDHulej
         GfBjPNjSC2c3QmNWtLRvqXptazwdxkVCE176BCoaQU+4AmEgDzvYk44+bU7Y2HAVJDcX
         Rhpbo/6dLqTJelz9gwyVOWFCGiTqKBwpTKqCiM+bz3VdPrrY0U7NZTw/shXQqc6+pof7
         NCuw==
X-Gm-Message-State: AOAM532aPzhfwOrrHUPU9ySmBcS/CFEvwZcSR1B2DxbEgiVRPq4xG0Ou
        eRykbtn9CqZnotV3W1WYuuGi8Q==
X-Google-Smtp-Source: ABdhPJy6Ha+e/JkNMswv7ObkhfHvx81ISXHllJLIFfKiOsbqZOC2ZadETUt/j71B1SlKfEnO1XJaJg==
X-Received: by 2002:a17:90b:1013:: with SMTP id gm19mr904294pjb.231.1592428603308;
        Wed, 17 Jun 2020 14:16:43 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a83sm701875pfa.146.2020.06.17.14.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 14:16:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200616034044.v3.5.Ib1e6855405fc9c99916ab7c7dee84d73a8bf3d68@changeid>
References: <20200616104050.84764-1-dianders@chromium.org> <20200616034044.v3.5.Ib1e6855405fc9c99916ab7c7dee84d73a8bf3d68@changeid>
Subject: Re: [PATCH v3 5/5] spi: spi-geni-qcom: Don't keep a local state variable
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Wed, 17 Jun 2020 14:16:41 -0700
Message-ID: <159242860191.62212.18088243128415903480@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Douglas Anderson (2020-06-16 03:40:50)
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 63a62548b078..6feea88d63ac 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -63,13 +63,6 @@
>  #define TIMESTAMP_AFTER                BIT(3)
>  #define POST_CMD_DELAY         BIT(4)
> =20
> -enum spi_m_cmd_opcode {
> -       CMD_NONE,
> -       CMD_XFER,
> -       CMD_CS,
> -       CMD_CANCEL,
> -};
> -
>  struct spi_geni_master {
>         struct geni_se se;
>         struct device *dev;
> @@ -81,10 +74,11 @@ struct spi_geni_master {
>         unsigned int tx_rem_bytes;
>         unsigned int rx_rem_bytes;
>         const struct spi_transfer *cur_xfer;
> -       struct completion xfer_done;
> +       struct completion cs_done;
> +       struct completion cancel_done;
> +       struct completion abort_done;

I wonder if it would be better to use the wait_bit() APIs. That would
let us have one word for various bits like CS_DONE, CANCEL_DONE,
ABORT_DONE and then wake up the waiters when the particular bit happens
to come in through the isr. It is probably over-engineering though
because it saves a handful of bytes while increasing complexity.

Otherwise I like this patch.

>         unsigned int oversampling;
>         spinlock_t lock;
> -       enum spi_m_cmd_opcode cur_mcmd;
>         int irq;
>  };
>
