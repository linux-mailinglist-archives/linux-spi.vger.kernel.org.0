Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4F7364D2
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2019 21:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfFETg4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jun 2019 15:36:56 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53610 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFETg4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jun 2019 15:36:56 -0400
Received: by mail-it1-f193.google.com with SMTP id m187so5378092ite.3;
        Wed, 05 Jun 2019 12:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwLHe6pw2ihYaqYwiNpoJsGqzozTnZa4V+fIZmXgIP4=;
        b=cKbCbfQspxY9eoiFMAsfwqFQ557wQejiKva0hGHspXK+PRb0bDb+o5yjN5kA66GxWs
         EjsiLj0MBwdcUoLvoG+Pda9CLa/WDF8JnUROS1WaUMddhml0glS6c+Ueav5c9ks71WA5
         xMETpmFrKK1QUwrmdP7Ay/yrn0HdSuqBIFY6L9lMOeafRB140dXz1V3LH+9bSGbM1aMn
         TxHRdW8k/kh2ioPlcWeHSmwK3megESXCyog9Zbtj9JX+mBW0N1F4hks7Pw2824LxWAU+
         H/yrBVMGELLeowfgDelUEkTd++XxkZQ1L5tOwJHiWpXjFDYqv/dWd+CJlY/xreNG22eB
         5phA==
X-Gm-Message-State: APjAAAVq6zvBOH5Nj0076oHLTXUEi6SBhvM5KTvao0AKJuEyjHbH1q97
        eUIZR2HeLJ/26YNpAmYhCMSrmSCfSl1OPzwk/7c=
X-Google-Smtp-Source: APXvYqx6Oah+YT6T5psZ1qhPIYRGZiWlfwqb5jPRk8MHOTrYaBqYOjTVp1LlSMJ3g0urFLpxp888Ebd0l1PeShpDBNg=
X-Received: by 2002:a24:7f0d:: with SMTP id r13mr25805755itc.28.1559763415651;
 Wed, 05 Jun 2019 12:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190412105320.2924-1-kernel@esmil.dk> <20190508103358.5C7EB440010@finisterre.sirena.org.uk>
In-Reply-To: <20190508103358.5C7EB440010@finisterre.sirena.org.uk>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Wed, 5 Jun 2019 21:36:44 +0200
Message-ID: <CANBLGcxiXR7KqKn4U-2PgefuxpBFX=yR06cw6A5GEALuqa54FA@mail.gmail.com>
Subject: Re: Applied "spi: rockchip: turn down tx dma bursts" to the spi tree
To:     Mark Brown <broonie@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-spi@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark

On Wed, 8 May 2019 at 12:34, Mark Brown <broonie@kernel.org> wrote:
>
> The patch
>
>    spi: rockchip: turn down tx dma bursts
>
> has been applied to the spi tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.

I've tried looking in the for-next and for-5.x branches here, and I
can't seem to find this patch.
Am I missing something?

It fixes a problem introduced in 4.19, so it'd be nice if it could
make it to stable trees eventually.

/Emil
