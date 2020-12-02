Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACE82CC8D0
	for <lists+linux-spi@lfdr.de>; Wed,  2 Dec 2020 22:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgLBVUm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Dec 2020 16:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgLBVUm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Dec 2020 16:20:42 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48F6C0613D6;
        Wed,  2 Dec 2020 13:20:01 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id k4so2178013qtj.10;
        Wed, 02 Dec 2020 13:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=99Y7wB6PwhBW9HGShktQMrV6OKqAm5XRMWuYeiHOpak=;
        b=BqzZHtMDKJpRPAQBquh46oC1vWNiD4dwoerDNazlU1w0YLUyXjUsoAlSewXGHZ4DPr
         BPdkF0+l0vZHy3gZ3qTZg70oaSFUrLBUvj8qHjQKIWi178mTmlAkXt/HD1mo+/SlAjeC
         7LhN+sBo6jS5Vlg0Lj149TfVnBXPwx402/q/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99Y7wB6PwhBW9HGShktQMrV6OKqAm5XRMWuYeiHOpak=;
        b=ZGkwaKtKEWOqKLG1C9l7A3FAK3ET4FbIwHA2g7vKG7sDVO8Ps8v6+hYAh/TNdUtO+V
         YTLue/CNSe6rjC2pfeyCp2OU3rKQ7WbPhCmbEi64o7FdLpnjD7dvHqf8nsn00TLFGBCt
         7+BGULRb7IhSeIx5rPx1kagZk8Ignhod8HXJ7aWU4L+OSlnX1X1GIRitK27XSwnIFwmX
         W0px8+34G9wiyml6ee8gYWyrStFw+HwDBfeOYxodXBnh/hDlsRjMk/XtrwJFjecDKmBw
         bKRNqFoGf8uqnYDoTgArbDCGQcS1wH1mRm68Y+jKMIYN3PJFNzp8PmZ8PViE7v9tq/hL
         elaQ==
X-Gm-Message-State: AOAM531PgyBUuuJwXlT62vFHOHwHs8Kp2HWUxjx0s8Oa9xveRzOP22F5
        5FyMMenTFnCUZb/M8ZBFXzPJj0dFUNl6fLpAi6DmAfQsOZk=
X-Google-Smtp-Source: ABdhPJxIBl1u25BODd0tJolB1/liAW5YH4mGsYbeA+xrKq+OgjhUxHxZBjU+lV+Jfj2+NJdO5pwPenyT7U5LiMfTUPU=
X-Received: by 2002:aed:2f64:: with SMTP id l91mr63647qtd.363.1606944000942;
 Wed, 02 Dec 2020 13:20:00 -0800 (PST)
MIME-Version: 1.0
References: <20201103072202.24705-1-chin-ting_kuo@aspeedtech.com> <160683107674.35139.14509237313835347013.b4-ty@kernel.org>
In-Reply-To: <160683107674.35139.14509237313835347013.b4-ty@kernel.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Dec 2020 21:19:47 +0000
Message-ID: <CACPK8Xe4TcRVBnZL7vtqGq1PTe5NEx1k4hvk4FDeYgJQ9HALFg@mail.gmail.com>
Subject: Re: [v2 0/4] Porting ASPEED FMC/SPI memory controller driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 1 Dec 2020 at 13:58, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, 3 Nov 2020 15:21:58 +0800, Chin-Ting Kuo wrote:
> > This patch series aims to porting ASPEED FMC/SPI memory controller
> > driver with spi-mem interface. Adjust device tree setting of SPI NOR
> > flash in order to fit real AST2600 EVB and new SPI memory controller
> > driver. Also, this patch has been verified on AST2600-A1 EVB.
> >
> > v2: Fix sparse warnings reported by kernel test robot <lkp@intel.com>.
> >
> > [...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Really? Or is there a bug in one of your scripts :)

Cheers,

Joel

>
> Thanks!
>
> [1/2] dt-bindings: spi: Add binding file for ASPEED FMC/SPI memory controller
>       (no commit info)
> [2/2] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
>       (no commit info)
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
