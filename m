Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C181FAD98
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 12:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgFPKLc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 06:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgFPKLc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 06:11:32 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 437AC20767;
        Tue, 16 Jun 2020 10:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592302291;
        bh=zSfipJoycycqxaCuBeGKMu4P0mp1YuiXVf5MlZ2int8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yQX0vQg4a9u7aEyGEEQsDZWSPBXYmyM4crsvvDVQ+54+Tba2Hzpo13qtwvHu4uS69
         Lh2Ai8QKoeQwojqNVCU3Xiu1jtCNOg7hwP6iJ3NiQXaseMZQtYA4aZP22RBom9m71c
         AwR9KutXIggbu+DV83G+OphS5XkM1VlhgZNc1EQU=
Received: by mail-lj1-f179.google.com with SMTP id q19so22831328lji.2;
        Tue, 16 Jun 2020 03:11:31 -0700 (PDT)
X-Gm-Message-State: AOAM530i7NljY9E4km03W7Gw9Mdk5s2h8/2LpLYMj0ziRShC6oNFDhjd
        f+ezBy2mJkT7vFjgUjzVzB/qTWxX9T9G3xeZpxM=
X-Google-Smtp-Source: ABdhPJxAGYTa5TM2iZcJcSa9qS5oZENiqU99mpRsWCivOY+inRr4VYWNscCGMkSEGKobWZnnuaYCo49iZhicJjMM0PA=
X-Received: by 2002:a2e:8651:: with SMTP id i17mr1061792ljj.45.1592302289579;
 Tue, 16 Jun 2020 03:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <1592208439-17594-1-git-send-email-krzk@kernel.org>
 <1592208439-17594-3-git-send-email-krzk@kernel.org> <20200615120844.GL4447@sirena.org.uk>
In-Reply-To: <20200615120844.GL4447@sirena.org.uk>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Jun 2020 12:11:17 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfEpLN9jS11WW367Na3Ukfi8p3urKDcJoafg9dHuCDSUA@mail.gmail.com>
Message-ID: <CAJKOXPfEpLN9jS11WW367Na3Ukfi8p3urKDcJoafg9dHuCDSUA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] genirq: Do not test disabled IRQs with DEBUG_SHIRQ
To:     Mark Brown <broonie@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-spi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfram Sang <wsa@kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jun 15, 2020 at 01:08:44PM +0100, Mark Brown wrote:
> On Mon, Jun 15, 2020 at 10:07:19AM +0200, Krzysztof Kozlowski wrote:
> > Testing events during freeing of disabled shared interrupts
> > (CONFIG_DEBUG_SHIRQ) leads to false positives.  The driver disabled
> > interrupts on purpose to be sure that they will not fire during device
> > removal.
>
> Surely the whole issue with shared IRQs that's being tested for here is
> that when the interrupt is shared some other device connected to the
> same interrupt line may trigger an interrupt regardless of what's going
> on with this device?

Yes. However if that device disabled the interrupt, it should not be
fired for other users. In such case the testing does not point to a
real issue.

Anyway, this patch is not necessary with my v3 approach to SPI shared
interrupts issue.

Best regards,
Krzysztof
