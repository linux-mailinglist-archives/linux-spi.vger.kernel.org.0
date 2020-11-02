Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC512A2375
	for <lists+linux-spi@lfdr.de>; Mon,  2 Nov 2020 04:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgKBDSK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 1 Nov 2020 22:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgKBDSK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 1 Nov 2020 22:18:10 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6445FC0617A6;
        Sun,  1 Nov 2020 19:18:08 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id x7so12855685wrl.3;
        Sun, 01 Nov 2020 19:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q3C5GQA9wQZiVR4rbjQLXhx4UW7+eSyQV4meTWkrwEY=;
        b=WbOZv+mzknxr7K0rCL9OHGDQqj0dP5/dBzQoHQjAad5hjbsBcro3cwh7iouXnngzHA
         gBBG+Znb8vtX+IVWMufce5KAtp4wdj/pQVtUEbZbL96DMPGmjAwdxIflMGiDENdrW14y
         GskCacK/NSS6Sy2Jq6zG0Z9cmeuQ5sjr/sUGieLbd7AX+fk7uJqXThReCIoRTj9Jpnr2
         xeuS3gI/TirkgpkCFAzs8J8zG7Pg6GUs1lEH2AoMtPfAz9dKLERPcJN+geBqClZcMADh
         X7EnuBhEXQ4dOGy4diJeoyG12i9X1Hn2pR3ormGDveSeQhO40XhQus5+WrkfdquRFxle
         ungg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3C5GQA9wQZiVR4rbjQLXhx4UW7+eSyQV4meTWkrwEY=;
        b=mGItzoRlujRRLBk0/+zCIlidSeusOruJ3bjO+nV0/prkxCymjZ1yxWzIRLw0r1YKiD
         uz6QY5cpb9CFZAZAus725uqequI5wiw4ESFSfZLmYV8hNB5DRjleZ+Tsuqrk7FDoGmgP
         23mkDhRL7kpAnRPz60KDUEQwyJkXn4xO3uE6pGlOOby9CmuSOxLdJbcAwkAXsYPWaKQc
         GCtmiyWd+k76LN6qPjfS2wbW0MBia6p5phwAbDcOntQb1V92KiLX19wRUDA7lGWBR0k3
         tkfV4QHDeCxtD3FW/2682DeTZGBVpI6g0EVaWP8+yf2vWZZ84JtHYvI1jh3V0S4Q0/+n
         KnPw==
X-Gm-Message-State: AOAM533PqhxH/sMYJrvRs9vT9a1Xa0s3lD9GfSLfUIR46rWW0mntECJH
        1dGy5nIGlBao0WaUL8+jwYKsbLr1wLHw/p/pKC8=
X-Google-Smtp-Source: ABdhPJwrqi3iAua43lIl4WJGkG3mR3ByJc8N596j3SPtMWYGn4MrsB05PikstTQ2yaxaP/qA7ASsJyesp14sSY+VcE4=
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr13463615wrx.425.1604287087162;
 Sun, 01 Nov 2020 19:18:07 -0800 (PST)
MIME-Version: 1.0
References: <20201030072444.22122-1-zhang.lyra@gmail.com> <20201030134227.GC4405@sirena.org.uk>
In-Reply-To: <20201030134227.GC4405@sirena.org.uk>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 2 Nov 2020 11:17:30 +0800
Message-ID: <CAAfSe-sTUptZKq9v8MqW247cXPnh__QKmNe9+M458owtB82Pfg@mail.gmail.com>
Subject: Re: [PATCH] spi: sprd: add runtime pm for transfer message
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Bangzheng Liu <bangzheng.liu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 30 Oct 2020 at 21:42, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Oct 30, 2020 at 03:24:44PM +0800, Chunyan Zhang wrote:
> > From: Bangzheng Liu <bangzheng.liu@unisoc.com>
> >
> > Before transfer one message, spi core would set chipselect, sprd spi
> > device should be resumed from runtime suspend, otherwise kernel would
> > crash once access spi registers. The sprd spi device can be suspended
> > until clearing chipselect which would be executed after transfer.
>
> The core should be handling runtime PM for normal transfers, if it's not
> managing to do that then we should fix the core so it's fixed for all
> drivers not just this one.

Sure, I will send a new patch.
