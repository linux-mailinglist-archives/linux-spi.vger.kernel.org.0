Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323E62933B9
	for <lists+linux-spi@lfdr.de>; Tue, 20 Oct 2020 05:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391322AbgJTDwt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 19 Oct 2020 23:52:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40042 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391321AbgJTDwt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Oct 2020 23:52:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so321401lfc.7;
        Mon, 19 Oct 2020 20:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QSKcWCkaOciBpr52CFiHddOWbs/SRgpSc2aqm5gms6Y=;
        b=poYJzxodG2eX4Awb2Gph+GfF8idgxItMAw8PHRI7jeuUOIj3i+N1vrzTB9mWv4c385
         zjfyb3YJUrkadtE2pukTGe/1sHUqqmLYLRF9HVqGSPAnvEQU39d1Hll28Sg5HBwFvVjX
         82aSkZXBmykksFyvZOQ5XAqDRG0PfP+6Iy/E1NtlzXmS35FrPPQuZBCHTzGOOTTyH7An
         rQwq/k+lFqiiNYHwePXQKcTaXcuKxYF0pBpgPmJWSa6impu4bxXjPc1dL4heF8JboXcy
         0z4YYYB1CH5Q1wltVSm+hInJsKY9tuHUde3I8EPw8+6ekGvxCJQlKH1P4VsFxJZIBR8F
         M+Ag==
X-Gm-Message-State: AOAM531Ssj5LCNpz8NIMRVuzX/YAMSsqsZh4K0eZ0EDmANsqcb4Ski2z
        +NGtrJDy69s/xo2Zh0R/p4qBpCkMXOKB7A==
X-Google-Smtp-Source: ABdhPJz3Q21Wwn0jy/k4+bMme03BagKlnkEBrWvKmoeDAb30gmiertlJS74UBreq7SbXez2TdmPRSQ==
X-Received: by 2002:a19:838e:: with SMTP id f136mr240994lfd.16.1603165966339;
        Mon, 19 Oct 2020 20:52:46 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id r80sm83454lff.284.2020.10.19.20.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 20:52:46 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id d24so320342lfa.8;
        Mon, 19 Oct 2020 20:52:45 -0700 (PDT)
X-Received: by 2002:a19:c88c:: with SMTP id y134mr230506lff.283.1603165965810;
 Mon, 19 Oct 2020 20:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201015154740.20825-1-al.kochet@gmail.com> <20201019082129.myxpxla5xwoqwldo@gilmour.lan>
 <4EC91DD5-5611-4B48-B6FC-00690B400584@gmail.com>
In-Reply-To: <4EC91DD5-5611-4B48-B6FC-00690B400584@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 20 Oct 2020 11:52:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v64ruUf7Lv-cHZTRPs-U-gOboGtTwOB3+qtxZTFyLVFLjg@mail.gmail.com>
Message-ID: <CAGb2v64ruUf7Lv-cHZTRPs-U-gOboGtTwOB3+qtxZTFyLVFLjg@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-sun6i: implement DMA-based transfer mode
To:     Alexander Kochetkov <al.kochet@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 20, 2020 at 1:43 AM Alexander Kochetkov <al.kochet@gmail.com> wrote:
>
>
>
> > 19 окт. 2020 г., в 11:21, Maxime Ripard <maxime@cerno.tech> написал(а):
> >
> > Hi!
> >
> > On Thu, Oct 15, 2020 at 06:47:40PM +0300, Alexander Kochetkov wrote:
> >> DMA-based transfer will be enabled if data length is larger than FIFO size
> >> (64 bytes for A64). This greatly reduce number of interrupts for
> >> transferring data.
> >>
> >> For smaller data size PIO mode will be used. In PIO mode whole buffer will
> >> be loaded into FIFO.
> >>
> >> If driver failed to request DMA channels then it fallback for PIO mode.
> >>
> >> Tested on SOPINE (https://www.pine64.org/sopine/)
> >>
> >> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> >
> > Thanks for working on this, it's been a bit overdue
>
> Hi, Maxime!
>
> We did custom A64 based computation module for our product.
> Do you mean that A64 is obsolete or EOL product?
> If so, can you recommend active replacement for A64 from Allwinner same price?

I believe what Maxime meant was that DMA transfer for SPI is a long
sought-after feature, but no one had finished it.

ChenYu
