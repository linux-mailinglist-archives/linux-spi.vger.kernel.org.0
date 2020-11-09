Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787EA2AC8FF
	for <lists+linux-spi@lfdr.de>; Tue, 10 Nov 2020 00:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgKIXB7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 18:01:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbgKIXB6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 18:01:58 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDAB2216C4;
        Mon,  9 Nov 2020 23:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604962918;
        bh=bdVwG8FdK8vGdGJpj6PbiUz89A7YebtbgtmC+QRlL7E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xcPtGsovGAopPW00WPdEEdc8JNgrZGL3OjANQE2oz9EMHmLZLzH4/ofW08tvno22F
         IhLaOGHU6FHCtNKAtCVnMTDzIduTOyLsYAcrtzdzF4ogMtQi5fR8CNZCKzPAlfBcx6
         BKetx0PTsqPbZFiRzCjTwTIeBymy32Ez7X+i6t48=
Received: by mail-oi1-f176.google.com with SMTP id c80so12120788oib.2;
        Mon, 09 Nov 2020 15:01:57 -0800 (PST)
X-Gm-Message-State: AOAM531DHz1cufDkx6dLkfNc4FyP+sfPlL6k8C/YiCMDDToZsbYTQ0uq
        /YGqtAJf40SgF1Os9MiEdxZh/PniaT4VkDDsyw==
X-Google-Smtp-Source: ABdhPJzCZJCbfWEZKn7ljIDJSDyRopmT9Qy63j3JoNPd/CoI6RdzJ+BkiuvBYn5qdzN6veChd5BwrgPBR1ZoRr0Mg58=
X-Received: by 2002:aca:fdd4:: with SMTP id b203mr1033604oii.152.1604962917159;
 Mon, 09 Nov 2020 15:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20201107081420.60325-1-damien.lemoal@wdc.com> <20201107081420.60325-16-damien.lemoal@wdc.com>
 <20201109215913.GA1828781@bogus> <9e0bf865-99ff-3ca4-c693-34fb3d155c80@gmail.com>
In-Reply-To: <9e0bf865-99ff-3ca4-c693-34fb3d155c80@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Nov 2020 17:01:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJweFy90h0VuXnZ2fm-7oeuF6wHKh9dN-ZMDcDowU2GCQ@mail.gmail.com>
Message-ID: <CAL_JsqJweFy90h0VuXnZ2fm-7oeuF6wHKh9dN-ZMDcDowU2GCQ@mail.gmail.com>
Subject: Re: [PATCH 15/32] dt-bindings: Define Kendryte K210 sysctl registers
To:     Sean Anderson <seanga2@gmail.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 9, 2020 at 4:10 PM Sean Anderson <seanga2@gmail.com> wrote:
>
> On 11/9/20 4:59 PM, Rob Herring wrote:
> > On Sat, Nov 07, 2020 at 05:14:03PM +0900, Damien Le Moal wrote:
> >> Introduce the dt-bindings file include/dt-bindings/mfd/k210_sysctl.h to
> >> define the offset of all registers of the K210 system controller.
> >
> > We generally don't have defines for registers in DT.
>
> At least K210_SYSCTL_SOFT_RESET is necessary for the syscon-reboot driver.

How does a generic driver need your platform specific define? I meant
just use numbers directly.

Rob
