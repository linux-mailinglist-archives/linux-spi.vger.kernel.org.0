Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141C496C83
	for <lists+linux-spi@lfdr.de>; Wed, 21 Aug 2019 00:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfHTWn6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 18:43:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40884 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbfHTWn6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 18:43:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id h8so566972edv.7
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cX+o7bVVt8qCymwCJxyXCujT16tV/PwHL/B54iRX1w=;
        b=Wq3H62Ex/KCsaYEofMMU7X/DufmTJvFbEAYq81NPnmluEss59ZDkBjS7YnG+z1Kx0i
         YgTZzwUb1KygTzJQbTbv709GdaetlExtQOuOfYpXBUsXD3Js67wAXwuXYwuSv1w5CIfb
         yJzHWdFAPo24ZBnRmtbrFwIT3InxFgMlo5Azz3TJpPwnjTmsHgGs54AK/wuXgy/W9YF1
         sIm9YZ6eoDHAWjmbbveWda0zNllNjOq/SPaU39yTbczq4k974x2QDAk2x1h+08qBxSnI
         IlziKdiTv8a8qNM1Z2JWIDJkO+BoqPqUZcUnysMXQtbQXAbi+PMVDaAtyb7L6o5yb8Kd
         DcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cX+o7bVVt8qCymwCJxyXCujT16tV/PwHL/B54iRX1w=;
        b=llt1+jBbG/y3G/rRN3kfDrFXmU8sN6f4fQH6OQw6SQZR7Ek+GvWFgwKipzUIs53v3c
         ETEKaT+SaPcWIhJZ7CZUco2BZLkkjqFdjh7iddeuiwgQUguY4PwmHzDX2O6zrpWMd77U
         cKxjXxUBZtT1rjO2QJMf7xw3OwKeyG6QV3b6x3RPI/p6vZaiyARP5B8E4s6Pf3PCuKrQ
         yAN2y+mBloelFwlbjCs6RBzPGHfEt2JwPqtJXkSnXVyL2mGKVWcjjcOGn6Jr1Wqu4/ST
         qMPCC0cvRCVtTazqELMZiStqS9mBubDtzRDuNWze8DlbHbmVc1hIgQikrvstItyeSd6n
         BxAw==
X-Gm-Message-State: APjAAAUWaPs1yA7Ss1tewMIAjZyHgkOUWAkIgHaHsu1h7t2gmE7en75B
        jDPGLVCcQfpf7SZVe06FLpuGvMjfp7u9dC2v/Iw=
X-Google-Smtp-Source: APXvYqxm+AATFIRjDXBRkq6uxumepR9ZYpHl4Cc1ZKPqNzNeNDYJfwM4RFhU3QVUwQZ9uRIsnnzkDYtQcaFdb6roGwg=
X-Received: by 2002:a05:6402:1285:: with SMTP id w5mr34094401edv.36.1566341036384;
 Tue, 20 Aug 2019 15:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190818180115.31114-1-olteanv@gmail.com> <20190818180115.31114-14-olteanv@gmail.com>
 <20190820130257.GD4738@sirena.co.uk>
In-Reply-To: <20190820130257.GD4738@sirena.co.uk>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Wed, 21 Aug 2019 01:43:45 +0300
Message-ID: <CA+h21hqCyJ4WQgP31gcMq21k6wG8YQmbg0BZKwh_2YKvWKY5RA@mail.gmail.com>
Subject: Re: [PATCH spi for-5.4 13/14] spi: spi-fsl-dspi: Reduce indentation
 level in dspi_interrupt
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 20 Aug 2019 at 16:02, Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Aug 18, 2019 at 09:01:14PM +0300, Vladimir Oltean wrote:
> > There is no point in checking which interrupt source was triggered in
> > SPI_SR, since only EOQ and TCFQ modes trigger interrupts anyway (see the
> > writes to SPI_RSER). In DMA mode, the RSER is configured for RFDF_DIRS=1
> > and TFFF_DIRS=1, aka FIFO events generate eDMA requests and not CPU
> > interrupts.
>
> It's also good to check interrupt sources in case the interrupt line
> might be shared, that means that it's possible that the interrupt
> handler will be called when there's no interrupt at all from the IP.  It
> also helps with robustness in case there's some system error though
> that's (hopefully!) a lot less common.  This driver does set IRQF_SHARED
> so it does support that, I don't know how many systems could do it but
> it seems a shame to remove the support from the driver.

Ok, I hadn't thought of that, I'll add the check back.
