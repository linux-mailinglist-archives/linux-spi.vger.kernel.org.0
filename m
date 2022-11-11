Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017BC625966
	for <lists+linux-spi@lfdr.de>; Fri, 11 Nov 2022 12:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiKKLdU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Nov 2022 06:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKLdT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Nov 2022 06:33:19 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078C91C0
        for <linux-spi@vger.kernel.org>; Fri, 11 Nov 2022 03:33:19 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id io19so4029048plb.8
        for <linux-spi@vger.kernel.org>; Fri, 11 Nov 2022 03:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5xI0l1zV62eMQ4f9ueOU2zxIe6VrYAH/SmkaVCWcq2I=;
        b=M67HtWF/jMQu8s0MAKzuuuzkfUZ+VZDKN36OjUPjWA4UePGw9GujdT7Uz7yj9Uu7Fi
         0Slvj8A+AFq49nmprMZkZHeCQIABYtQBgVOVUk/wMfkj3/eGmAHqWXgGGyP4gdzz24QP
         9aA6HMVcG6m7Bsd0Rm9QoPCtNDXJUrl8/NJkbfXE5wi4aaPz/qyxpta4ILF+okX2biKQ
         wTpYaqywOWNTD+K9HzR4OAJAymCFOtoDOhFfJhcizSWn712uQ32aYLBarR+6DRVhY+Nd
         8ZNTikB4fmaWoglWft55CDzHKbX3ddwQQaXQhA/xTKyBxdeTIJaA6GxDMgoOgNwK7X96
         j+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xI0l1zV62eMQ4f9ueOU2zxIe6VrYAH/SmkaVCWcq2I=;
        b=6nAR3zTrGPkjIPE1NJlzqd467gKvgungJAxzme+BhNTJYhLJ47RApMr6hLjTTmMGhq
         N8IBeXQjbCgU5fIruq4k3IPG+0/xV0dlPQq7NDXOL9WBzr39O/v+CAozF8Wy1uv3AIbO
         H9tpv7CGUYbMu4SotqO2o/PULsgn9mGOc1ZZWLpS7uwRIr3ovlOk2jrYOpBNeZfK3faQ
         JCvPAnaPMCgKOQ3yLSvVszHHTVwFx4p83Z5pXZXLli2LvrgBOVz2CePyWRO+PT0wSx5B
         WxH9TTa4YaFbUigwzzxbNLL00MbkIYWeOy5cW/YQI2Djdi8hF9qu4ipalGaSC9G8pRFv
         N3kQ==
X-Gm-Message-State: ANoB5pnPI15mshkplf/eECwmnpLJW/MkYXFF+ointmpRNV4XYPfeAtJ0
        oCHd09T7e0M3+GaF3vqMZWpkmB2VanBNZuET8jbTKNCZMmk=
X-Google-Smtp-Source: AA0mqf5O7661nQLIpKc9EVCa1G+8E6weM0UnPK54aQsAT10H5aOhWNNGmkfmtYkp5PyViTb14hq5XT7yQ7eUrPhUISM=
X-Received: by 2002:a17:902:aa88:b0:188:75bb:36d4 with SMTP id
 d8-20020a170902aa8800b0018875bb36d4mr1923507plr.55.1668166398403; Fri, 11 Nov
 2022 03:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20221111003032.82371-1-festevam@gmail.com> <20221111105028.7d605632@erd992>
In-Reply-To: <20221111105028.7d605632@erd992>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 11 Nov 2022 08:33:03 -0300
Message-ID: <CAOMZO5CH9S_RYpLNZbRxChzSVkkZTAd+qpxz1Ycj2UUPROTXpw@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling support"
To:     David Jander <david@protonic.nl>, frieder.schrempf@kontron.de
Cc:     broonie@kernel.org, mkl@pengutronix.de, linux-spi@vger.kernel.org,
        stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi David,

On Fri, Nov 11, 2022 at 6:50 AM David Jander <david@protonic.nl> wrote:

> The effect of this patch is that it will cause short SPI transfers to have a
> lot less latency than without this patch, so could it be that we are looking
> at a timing related bug in the MTD driver, or some other timing issue?
> Your SPI clock is 80MHz, but the datasheet of the MACRONIX MX25R1635F
> specifies a maximum clock of 33MHz. Is your NOR flash chip capable of this
> clock-rate?

Thanks for your suggestions.

I have tried passing spi-max-frequency = <33000000>, and I don't see
the failure anymore.

Looking at the MX25R1635F datasheet the maximum SPI frequency is:

80MHz: when L/H bit is 1 - High Performance mode.
33MHz: when L/H bit is 0 - Ultra Low Power mode.

"L/H switch bit The Low Power / High Performance bit is a volatile bit.
User can change the value of L/H switch bit to keep Ultra Low Power
mode or High Performance mode.
Please check Ordering Information for the L/H Switch default support"

Frieder,

Could it be that the MX25R1635F part that on the Kontron imx8mm SoM has the
Ultra Low Power Mode selected by default?

If that's the case, I can send a patch that changes the
spi-max-frequency from 80MHz to 33MHz.

Thanks
