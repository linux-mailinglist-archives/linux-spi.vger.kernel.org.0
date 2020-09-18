Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635EE26FE8E
	for <lists+linux-spi@lfdr.de>; Fri, 18 Sep 2020 15:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIRNdp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Sep 2020 09:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRNdp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Sep 2020 09:33:45 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A7AC0613CE;
        Fri, 18 Sep 2020 06:33:44 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x2so6247984ilm.0;
        Fri, 18 Sep 2020 06:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHP6a/n1DUHQQL99sdaOgDDLN4fD6Mu08+md9guUmtw=;
        b=JAHVq72phYgsTz7+cCz2K98bwVoT3voMNXxrRvYlKds4E2Tcwdic91D/30M3J8KHaM
         HnnjFuvQEB0yHzEx/+o1bOBU06cjVuNivsU3zCGkB0dLwyvZ3GRpdMpC4QuS7aFMIC+x
         oOJ6l2yRi3794WPpPUrCpcyqcpH/rQ7qDu9tKB/ADiCp0eguh3XjoX3ebrqNcGRRpXGU
         v6bcRj2GhLbxfvcPcDMbzsHnOlu9IGabU5vGcCXLMOdXMEa40kyhFbI8+AQ+15pFNCUY
         QqaESEET6BaX3HH9e1DhRzYgb733Uj+aRTGX/Vf34sTEHtPKJqHhyb/fCvOiBiYgaU/c
         y20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHP6a/n1DUHQQL99sdaOgDDLN4fD6Mu08+md9guUmtw=;
        b=EsybWkCMvtofHdIG/3MvMgV3eclVfMmeL/lk1Ep3OvHjWRv0pIjknH3vKVhszlNyKd
         DAm8//+hKrB5jsz++i0B0JUkjwn1BVgSEzGpEb31fCtho+3kvRj/TJ9QvZ42SjNomavg
         yTR4GPCUfqzffN9Qn+JjkUhbIcXH0ir9nElnum9RXgq1GtD/lsbwtpDMr24bnU6xPNjl
         ZWL5ROkqST2exxjBt19or3xRYEhJY22yNMQfnRyVLRAoT6q+1ua5+ocvftgWBOr+eRoe
         ujOYOYYYWDZ15qkGBqYnyFXTP27e0JP0A9cqGMkixaD/NJ63wT6X5PlEpR6W7gQWCXmu
         qBKA==
X-Gm-Message-State: AOAM531rdf5O1wne4KrXG0r+iyDSrMSP3MCylQM6k/KqtYpd3HnVe91B
        kHdUpBhUsEbhsbl5AzaybTObTM6xotFXS/zgjLY=
X-Google-Smtp-Source: ABdhPJz0qCBmtrO5zOnB3h0Skn1hRjcb6T2inQdpc5g/md9N8CbDjqyk4Bo7jWnekfjpoPmERo9MJNhIILGUXPyk2vM=
X-Received: by 2002:a92:c10c:: with SMTP id p12mr4688358ile.274.1600436024267;
 Fri, 18 Sep 2020 06:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200918083124.3921207-1-ikjn@chromium.org> <20200918162834.v2.2.I3de2918f09b817cc2ae6d324f1ece62779ecc7cf@changeid>
 <CAJsYDV+Um3aEsgW-829BsZSaiVCp3O2LkrTmgCthhFv4fuEnLg@mail.gmail.com>
In-Reply-To: <CAJsYDV+Um3aEsgW-829BsZSaiVCp3O2LkrTmgCthhFv4fuEnLg@mail.gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 18 Sep 2020 21:33:33 +0800
Message-ID: <CAJsYDVLcNZ6kyRnZS8zcsC7R_XTZgSVqwqR+SNmNB-rbWrF=CQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] spi: spi-mtk-nor: fix mishandled logics in
 checking SPI memory operation
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi!

On Fri, Sep 18, 2020 at 9:09 PM Chuanhong Guo <gch981213@gmail.com> wrote:
> On Fri, Sep 18, 2020 at 4:34 PM Ikjoon Jang <ikjn@chromium.org> wrote:
> > [...]
> > +               switch (op->data.dir) {
> > +               case SPI_MEM_DATA_IN:
> > +                       if (!mtk_nor_match_read(op))
> > +                               return -EINVAL;
>
> You are changing the code logic here.
> mtk_nor_match_read checks if the operation can be executed
> using controller PIO/DMA reading. Even if it's not supported,
> we can still use PRG mode to execute the operation.
> One example of such an operation is SPI NOR SFDP reading.
> Your change breaks that which then breaks 1_2_2 and 1_4_4
> reading capability because spi-nor driver parses these op formats
> from SFDP table.

I just noticed that you already broke this in:
spi: spi-mtk-nor: support standard spi properties
Please also fix the same logic in mtk_nor_supports_op in your v3.

-- 
Regards,
Chuanhong Guo
