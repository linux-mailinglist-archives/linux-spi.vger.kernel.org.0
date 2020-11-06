Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E162A93ED
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 11:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgKFKSU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Nov 2020 05:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgKFKSU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Nov 2020 05:18:20 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD42C0613CF;
        Fri,  6 Nov 2020 02:18:18 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id j12so933586iow.0;
        Fri, 06 Nov 2020 02:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DtIoM+86pbK9ftgy/97EbKDLGqvBwa3nw932YW+kl7E=;
        b=YcXr7XCJZUIPaCGvEgZTn32zquwwAJK3K5TMnAsqgIgQgLQK3+9R1n6NzlbvaUq/TM
         pX+HvIRUv23PGPYILMKlnBgdlrePttzSmt/T7Eosf0Miww6lfwtwXD12e6h2fFngahbk
         qixs3Gx7x/cmotDMTiK3qjisAfrCnS6jjWA+oaXiCk00buuzpAXLkEqKjeI4OOiY7a4e
         8FqsolG4bPGH/pD43gH0Tg/fBnGd/aSf6SdBAHTgTfabLr9JNiZ8nx5MLoe1Gvi8r1yQ
         DPukFj+TxbtLKZfjIZhRPE86EC4e1aF9q5L/BLKvudlvB2YEVAo/OgaKJSsjH7Ohfj0f
         RNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DtIoM+86pbK9ftgy/97EbKDLGqvBwa3nw932YW+kl7E=;
        b=TnSyPK9pVKtxNLp+zR4ejUokTL6bR95amgKDn5DFlk2RKZoAJ0qdCajx0HeygZnlFx
         SYCTsqiuedGvy9pHirXXF7NsH5v4S4+uxUfuUoocPjmaEKEyIFZAofaxgxqFTKJX6Wcs
         w5ayqA0qCXP/SrgiXyeGbh/WCUNWgCEpAHVuMpqqnxtB82M+1/Lj7xlqJeOub3ZCVLTn
         MIpdA4M+Te4b0PwTbvXCwHCE4+Ql3Vj90jm5kOzSaWbsebuQGpbqBtb/9n0+O3cPeq2c
         MADxASB2yXXJgDG11HUbFbiZC+2XanKIraWlqeZsVqB6DyVENn23YLISIB5PHqNRIgn9
         pC7Q==
X-Gm-Message-State: AOAM53079tRv1H/bgERDTeXZvb7HaSkMMjegXWPADfhppfAG/6J7lb23
        8oKktM8pJtmwp5no8s43KycwXd49TYs=
X-Google-Smtp-Source: ABdhPJzmuaEvf/5cqF4OR4e6h4DYCWmsuGVxVhnhTpje7bXyfmPg/EVT2+8S5Ye8Xh867rhf2P6G8g==
X-Received: by 2002:a02:ce30:: with SMTP id v16mr1003080jar.33.1604657897882;
        Fri, 06 Nov 2020 02:18:17 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id 9sm835286ila.61.2020.11.06.02.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:18:17 -0800 (PST)
Date:   Fri, 6 Nov 2020 03:18:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] SPI fixes for v5.10-rc2
Message-ID: <20201106101815.GA1403068@ubuntu-m3-large-x86>
References: <20201105164607.AD20021734@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201105164607.AD20021734@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 05, 2020 at 04:45:46PM +0000, Mark Brown wrote:
> The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
> 
>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.10-rc2
> 
> for you to fetch changes up to 9bd77a9ce31dd242fece27219d14fbee5068dd85:
> 
>   spi: fsl-dspi: fix wrong pointer in suspend/resume (2020-11-04 17:50:24 +0000)
> 
> ----------------------------------------------------------------
> spi: Fixes for v5.10
> 
> A small collection of driver specific fixes that have come in since the
> merge window, nothing too major here but all good to ahve.
> 
> ----------------------------------------------------------------
> Mark Brown (1):
>       Merge tag 'v5.10-rc1' into spi-5.10
> 
> Martin Hundebøll (1):
>       spi: bcm2835: fix gpio cs level inversion

Why did this go in with two outstanding reports?

https://lore.kernel.org/linux-spi/20201030090621.GA3594676@ubuntu-m3-large-x86/
https://lore.kernel.org/linux-spi/ad239665-e342-cdef-71c0-4eba06b76797@canonical.com/

It looks like there is a fix for it now:

https://lore.kernel.org/linux-spi/20201105090615.620315-1-martin@geanix.com/

Although I guess it is going to require a resend...

Cheers,
Nathan
