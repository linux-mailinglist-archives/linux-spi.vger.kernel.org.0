Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E91435EE7
	for <lists+linux-spi@lfdr.de>; Thu, 21 Oct 2021 12:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhJUKWG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Oct 2021 06:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhJUKWC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Oct 2021 06:22:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F7C06174E
        for <linux-spi@vger.kernel.org>; Thu, 21 Oct 2021 03:19:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u18so261045wrg.5
        for <linux-spi@vger.kernel.org>; Thu, 21 Oct 2021 03:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dhSbBeMpplIN9aEwtuPqKPrB7V0aSld0d2iKsObDAz8=;
        b=IzO7FxkWxXu9C1yvUIWIZbVpp9dq+rKGM2iKblt88BzkyvV1Mb52e5LKbzmQPk4+cY
         K4ODB6ssl44/amMfOzPf2tMUSaun3bfe9sTJmxHFEokRudqhLy5bs+k7csSYPs87sDcp
         l8pvcXIBI0lioTsR11rhm8P5oNqAY6XtHOuchGB/E79nCrAFTm/hFwqSAJ04lKTrRxZA
         1PrGiyHgksNd1PfWfiSV57KTZpixc36Nrhcuyu3rE4OqnDuW4SgLg7IUheEpCKC4dBBT
         /NTYNcfHK+rySTuelBdIkBS1VbukfKn1XdxvDkM+nPZGV09P/GT0AcrMKEiibpka8l2m
         lZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dhSbBeMpplIN9aEwtuPqKPrB7V0aSld0d2iKsObDAz8=;
        b=qNNg4JmLxWFvedZ99TXm85mDBpIdm3+FXiRwDyrSaa4qn3tPttSST5yaFMZpZkchJL
         IIGGz9LJiJQGQB33Dle/1/8h0y9fULPhOVWXLWnThVIbUnCOhVnEb4BxL18QCik+iW3E
         W7jlL30F28xOHYYJHTbN0wDgQZxIZ82bYHW8So6LihC1smoJgkBD9h5P2gVV34MWNASS
         SHVDsY4B4VRXdcv6HBuc5cwljLN7gaSJlhAdZv3rRN6dkj3RkZ2xRez33oanzKYB45MY
         AFsLDe2k7VZ7f9heVKPLxCyWssvNVedNdtcQTR43duY1qIf6PG67u3Ju1+vEvu96TvDI
         Wghw==
X-Gm-Message-State: AOAM532fvM6gg5tjFya+7HR+C8jtjdFg4wELSzMI+pmVeXknj5mxVJTS
        9YnzfsLmenWYxVnj12CDb0aL/g==
X-Google-Smtp-Source: ABdhPJzzoNdFzbYSoa90Y5/EikrCF6/C/9sHXw10OXLzZnwA91JbnU/+ft+cqY65JdASL2ktQP8ZlA==
X-Received: by 2002:adf:8b1a:: with SMTP id n26mr6222253wra.182.1634811585166;
        Thu, 21 Oct 2021 03:19:45 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id p188sm494257wmp.30.2021.10.21.03.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 03:19:44 -0700 (PDT)
Date:   Thu, 21 Oct 2021 11:19:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 10/20] mfd: tps65912: Make tps65912_device_exit()
 return void
Message-ID: <YXE+vxeTVCBazgMU@google.com>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
 <20211012153945.2651412-11-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012153945.2651412-11-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 12 Oct 2021, Uwe Kleine-König wrote:

> Up to now tps65912_device_exit() returns zero unconditionally. Make it
> return void instead which makes it easier to see in the callers that
> there is no error to handle.
> 
> Also the return value of i2c and spi remove callbacks is ignored anyway.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mfd/tps65912-core.c  | 4 +---
>  drivers/mfd/tps65912-i2c.c   | 4 +++-
>  drivers/mfd/tps65912-spi.c   | 4 +++-
>  include/linux/mfd/tps65912.h | 2 +-
>  4 files changed, 8 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
