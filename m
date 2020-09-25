Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92E27829A
	for <lists+linux-spi@lfdr.de>; Fri, 25 Sep 2020 10:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgIYIVz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Sep 2020 04:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbgIYIVz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Sep 2020 04:21:55 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BA1C0613CE;
        Fri, 25 Sep 2020 01:21:55 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s88so1556827ilb.6;
        Fri, 25 Sep 2020 01:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LJvK1S1wM77CEwiTWGHH4blwT2BpBAlEo89Zgh09KOA=;
        b=c6UN+CI1Fp4uk5RW2Kl5hegia7PgWhtLlM7r1U47nBCKQW72a7A4XRQcXs33oeaDor
         +Pekks1fUk4lcSdjBfDpJNj8Lb+IWNmLhQGoYiWisLkv3D41VUsroEnfczSCvn93iMA0
         PdgoNS1YbL/b4ZMuMJFX/1ZXSLFAggeEoX2ktDD9FO+0pwsANqptIRMKFiFYN4KX7qqC
         WDDJstdvvqNx8NXIKmPnfS63q2GhbEEE1YnuLTkynqPYmELrM+FlCF2ozTVc/6yewcjv
         uyqAXpyf+XMSyM3oKmVb8hOYgFUVTQTL4LQrVbqn3Y8e3BtJGlXTQ5GVgKq2oCwFpg+W
         1DAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJvK1S1wM77CEwiTWGHH4blwT2BpBAlEo89Zgh09KOA=;
        b=oEJMbbOE6iBWSLh+BOEzMvxmeeLbSi9h8DHyTDtIof6BvElyucOs/D50xi3drp8aaj
         HTKT42yyzlW2vo18yf1Cv0ov97NHX3rrnmCCm6GEcpnXVrtvSZlWPbpICLZAfFtszuMi
         ZEvK7lSsHo7w164sQqD4HQg8mEXArXPoJoRuyBopFgRyuS47WIAc2p1NaJZ0ZS5aNy69
         2l6zCrqK5GuSWz3o43M1yheG74rNhA1Y8nEnX8KuMmPrCQJKFdD7XQQhLryJHGCDnlgm
         hmiAzt88U5xGyE9XhhqyIrrz8+ZQr6q5CT9iLaW5RI+XqF2lCUb8yTCxV0E8uB26A8ls
         hDYA==
X-Gm-Message-State: AOAM532MVpaGyMU8idUNrRJSbsVEF8L9d/ujY6bM7wQy/qFp1JlVM149
        JjAQ6AhstOz6C/ox9rAScOe4TVHK0ACtqCDBvC0=
X-Google-Smtp-Source: ABdhPJxbkPFY03hpX61qBi/nCU+CsJEoNVRZmepsG6KM0Jr4eQ/tgOQDlyETWRPRhaB53PSTYIq/19x3diRibukeHKw=
X-Received: by 2002:a92:cbcf:: with SMTP id s15mr2378625ilq.39.1601022114691;
 Fri, 25 Sep 2020 01:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200925065418.1077472-1-ikjn@chromium.org> <20200925145255.v3.4.I06cb65401ab5ad63ea30c4788d26633928d80f38@changeid>
In-Reply-To: <20200925145255.v3.4.I06cb65401ab5ad63ea30c4788d26633928d80f38@changeid>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 25 Sep 2020 16:21:43 +0800
Message-ID: <CAJsYDVLaw_ViJECoX8VxtrhCDg7m-fOZ0XmF1+n9Y13oVgd4oQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] spi: spi-mtk-nor: use dma_alloc_coherent() for
 bounce buffer
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

On Fri, Sep 25, 2020 at 2:56 PM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> Use dma_alloc_coherent() for bounce buffer instead of kmalloc() to
> make sure the bounce buffer to be allocated within its DMAable range.

I think the introduction of need_bounce can be in its own commit or
at least mentioned here.

>
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
>
> ---
>
> (no changes since v1)

 There have been a lot of changes since v2 :)

Reviewed-by: Chuanhong Guo <gch981213@gmail.com>
-- 
Regards,
Chuanhong Guo
