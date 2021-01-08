Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2736C2EEB22
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 02:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbhAHBx7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 20:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbhAHBx7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Jan 2021 20:53:59 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6025C0612F4
        for <linux-spi@vger.kernel.org>; Thu,  7 Jan 2021 17:53:18 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s26so19255675lfc.8
        for <linux-spi@vger.kernel.org>; Thu, 07 Jan 2021 17:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jpkzu2NlKH8tLq+b0mrXcxeZYQO2IJS1mmz+PwfsaYM=;
        b=HZ0NVWFFbLcmJlolt2oZlk9r24Ln15LaxYvmtXviqPBpAh7nYsbkcw6wDbPCUhHzBe
         3avy02cTmlmsjBJbZQMRiLPxWLRrocdMEbhQ8vomIEs1pVY6POkV3ryLgILdzWZuqBRI
         6n4XxkgzbF+HvnkNiF/9ELgfZXSp/MW4XjZI8i+PXH9ACvfKRsvEhtmf92XUedPhxXat
         Z1wQPHAwtZ/UZRTPAPj/bJflX/tO2YodP+GiKp/lE00zsYifUnJhIxep512LnACeh6cV
         tB/bPB/x0+2oHsi7W6O+EM4TVC/cp5E1703NjP0I7qjiJuXUm8Bwtctdd8lVd54CfJpG
         OFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jpkzu2NlKH8tLq+b0mrXcxeZYQO2IJS1mmz+PwfsaYM=;
        b=ulVm8rRte3RtSJPTPX98eM6Rw1i/BtlLb7sLJKW5URfQZi4HEvCUxwnHSsG0YPiGU4
         mEuXijUri447DzmI29+OK7U7jjbx24p/UVaEaat+dVe2x1bpCuZyg/hm9ZxJerYYC8Y/
         zYNPVSe6W50TEzeVgvzdXhGahF6J+Sqjh/aLF7w4e49dk2CqaijccfLE6bHY1XzxOrYu
         RD+yvnn0E47H0rBaswigfSYf7NK/dzILzIih41ZD0Fo4/US7YbcTteGwCWjAakOc6Dpn
         9u/Q1xeWDBbvEiDI/NC2x/Ke0PtD/jsXLSFkdqTD0yVz/qSQDia2ib+Q6Lo/4280s9y6
         Jntg==
X-Gm-Message-State: AOAM531tt5+L4Vi1G0bQr36CSe0XKgEr1AZY/1dDKWa7woDc/R6oeouH
        uLpiP9vuDUhnbMQ6gkww2I4DxuLPdEOQdJ62L7g=
X-Google-Smtp-Source: ABdhPJzDJDfMApTFjjQOSARghJZ8tJyeLSzo3QMzr5ob2PNzT0Ew6JmD1mNOGc8vrO2JLycGcgEHmvEjS8kF9/x00VA=
X-Received: by 2002:a19:e20a:: with SMTP id z10mr695261lfg.295.1610070797313;
 Thu, 07 Jan 2021 17:53:17 -0800 (PST)
MIME-Version: 1.0
References: <CAF78GY3NWQ1jzkauG26nagcMuqR0=u7zcWLh+wDdrJ8G=e7how@mail.gmail.com>
 <20210106130049.GC4752@sirena.org.uk> <CAF78GY3=m0kMd3d4tS92tZS57mY5XeRuXtET+BVVvnTwcdtO3g@mail.gmail.com>
 <20210106173759.GF4752@sirena.org.uk> <CAF78GY0xnKrOj5RhU2GHcQUTo2MLryrBj3+5dAMKoGzJn2okYw@mail.gmail.com>
 <20210107153546.GD4726@sirena.org.uk> <20210108011044.5780aa96@gmail.com>
In-Reply-To: <20210108011044.5780aa96@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 7 Jan 2021 22:53:05 -0300
Message-ID: <CAOMZO5DSw2Nz5e_0Qn0LcqT-uvvpbjEczUOs2qoEbgC+H8Ho5g@mail.gmail.com>
Subject: Re: 5.11.0-rc1+: "Division by zero in kernel." when writing to spidev
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vincent,

On Thu, Jan 7, 2021 at 10:16 PM Vincent Pelletier <plr.vincent@gmail.com> wrote:

> Thanks.
> I added Tudor Ambarus as well as my debugging points in the direction
> of:
> commit 9326e4f1e5dd1a4410c429638d3c412b6fc17040 (spi/for-5.10)
> Author: Tudor Ambarus <tudor.ambarus@microchip.com>
> Date:   Wed Dec 9 19:35:14 2020 +0200
>
>     spi: Limit the spi device max speed to controller's max speed
>
>     Make sure the max_speed_hz of spi_device does not override
>     the max_speed_hz of controller.

There is a fix for this:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-linus&id=6820e812dafb4258bc14692f686eec5bde6fba86
