Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B6E718130
	for <lists+linux-spi@lfdr.de>; Wed, 31 May 2023 15:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbjEaNOw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 May 2023 09:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjEaNOv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 31 May 2023 09:14:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A459D
        for <linux-spi@vger.kernel.org>; Wed, 31 May 2023 06:14:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b02750ca0dso6574755ad.0
        for <linux-spi@vger.kernel.org>; Wed, 31 May 2023 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685538890; x=1688130890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=702gRUh3khCaTjshEC5/LmTUUlvUaQw5yEu9Y8LQmrQ=;
        b=OB6R28VB+Yzo9/Je8KsXOvjU8AVRvCMr2nDOcV+vUfP3bf6EaMDYDZS9ulOa8AyN+6
         nkNBmu81td8TweyZB4Y8pkf+Jxss3HSIGZN4QL8hEOQD+ea742Bpqg1YRTpzwQZGuoz9
         KkTyk3k6JrwT6eev7hF9bKFNISMcxCxY22dAtcTqksAzRJGgTnGVFGMst2COQhnV/cYk
         TdMdslPJqIz0Z+RNMi/nfIfR2KM92ZMsfkajgj3rpfxNu1qPtiuq/sJGoh14wPc4Utc8
         cjB38KrcfN6OvdS3ZevthJsb043unYr5EttUB858LcXxblIKCGR60FiRuQtEG4pdpoZ5
         YNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685538890; x=1688130890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=702gRUh3khCaTjshEC5/LmTUUlvUaQw5yEu9Y8LQmrQ=;
        b=Yg1mgS76hpPcTIZW2E9JsWwIGhmxr0MftOgjYVBTs4zZegNbuXCRL4Cmh8lLks9iuz
         76355Auj2vTvSbMlcMY1BWb4cWe/a4SnEP4YLDm+cUS2moOYrkxM0XaFAA64544uH0yf
         LWUweatJ19bV5fceM5j0xkI5OHtBDfbTQDWK/1E301f7q1ZJrWpOr+JtQNOWq9EmCbG+
         wOCDXyQvilDQXXrr76uGeJlgtnCzqHitv/48k0sISggN/vZMqGoQMNR21l2LhW5+rnnq
         lRRaT0muybua3L4fQwcaMhyITNuGhlXOksAWwnFiosOPjynN6p073KGauuGvZFmZuByJ
         AH5Q==
X-Gm-Message-State: AC+VfDyjnPSP7RZXnJkYp0rkMQrhg6DDkkyNb3tA4kmak5ZLFFkd8I0D
        hhwli4gFlOvh5Zv8+xrLbZscJ68wHBpybcwiaQw=
X-Google-Smtp-Source: ACHHUZ6QDPgEkBNLnY/a9vB+ulmj2Lugis0mHdbOgH8AAXquxa33EC5PFQdDB3Pll7s82AiCGcJHWcHv2Xzn1bNJfF8=
X-Received: by 2002:a17:902:e843:b0:1ae:8595:14b with SMTP id
 t3-20020a170902e84300b001ae8595014bmr2605601plg.6.1685538889936; Wed, 31 May
 2023 06:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230418083505.466198-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20230418083505.466198-1-alexander.stein@ew.tq-group.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 31 May 2023 10:14:37 -0300
Message-ID: <CAOMZO5CcD5iDkaempdxnQHx1fAgnXAmMq_0MdEq5wNgOLHcMuw@mail.gmail.com>
Subject: Re: [PATCH 1/1] spi: spi-imx: Use dev_err_probe for failed DMA
 channel requests
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Alexander,

On Tue, Apr 18, 2023 at 5:35=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> If dma_request_chan() fails, no error is shown nor any information is
> shown in /sys/kernel/debug/devices_deferred if -EPROBE_DEFER is returned.
> Use dev_err_probe to fix both problems.

Running spi-imx without SDMA is valid and not an error, right?

I am not sure I understood the real motivation for this patch.
