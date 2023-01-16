Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A20B66BE1E
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jan 2023 13:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjAPMrt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Jan 2023 07:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjAPMrq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Jan 2023 07:47:46 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA551E5E4
        for <linux-spi@vger.kernel.org>; Mon, 16 Jan 2023 04:47:44 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id l139so30102394ybl.12
        for <linux-spi@vger.kernel.org>; Mon, 16 Jan 2023 04:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vhvpSA7z9gYK2hvw3Lp+rmugm97iqDNc/tpHtJeI9jo=;
        b=tCnFodVqCISnp82U0/rJnPq2DxapbA21HtHFCnOi0pKcunEN9tK9kZrK2/4FBQrDRt
         TsLCpvtBJHXYZKwN49sJSiJlDNa/oewa/RUKC8LgRc2kPtvIbuoqJ/kgT4R+2iOE7MOI
         w3DRt0AupY7xybVP7FoTnFMZO3QOmtVUZvE/NFLrdhDrtf3R+3057u9LR6VQww8NlRRV
         q8FXQWUWU3ZXQ5rmW8FwSjL1OwVWH2gEuxjFBtWFcVK9eHizve9dGkRRwCBDg6xn0obw
         GkoTsZQ/vDVa8Xc2SW+6bP12PyaJuvu+c6Ei8lC5gB4Fj1xoexsQYECH3vDqoCPOn0og
         F4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhvpSA7z9gYK2hvw3Lp+rmugm97iqDNc/tpHtJeI9jo=;
        b=d3dd+UVSeXpuEegsl3IqqGX1NjGCH69SfM8PBIZ1TQ+iXnD8dTYmXnVGTxAh20715w
         MjvnmKFgVhDxyXTUPKrD+pAvZOu0QIGVDSE6JcOVXPZfCbZIA1/ELlNF1rut2AhGQ+mk
         TkJB/UZ/vlHA/Ekf06xhcU2WC5SxpERpCazoeThOq7XNybPjjDZYLRhJSdRaVjDwYG/m
         Ayj32B5gu+6F4yx4q0kyZoDUbvgAE3Uo41Tu++VkaSIBc47ZXLlbfQW6xu/c7qYRWpOh
         4uEWZupgWZ9faXhwugG7kzSRmPc/YOVe4MBmoivEQ+XJLe+CVTH8r0oN6rkRcE7bDiwa
         RJLA==
X-Gm-Message-State: AFqh2kpmS40KXqqSnPHofpxEWhkYrr1pX1GDqkONHbmIdStesgo3e0lf
        UFqZyXQxUFaEMnIjDmV0i1gEEZXwNfhoUMFxZY1eAw==
X-Google-Smtp-Source: AMrXdXvpAuQIne1fKCn8fJbJf7B7KBxDctALlYPxmBIdhoNVLLfa63sMpL6r+sSMTFraaKGb8EFlgFgNTS4tWb29QLg=
X-Received: by 2002:a5b:385:0:b0:736:1320:4d69 with SMTP id
 k5-20020a5b0385000000b0073613204d69mr7781274ybp.122.1673873264092; Mon, 16
 Jan 2023 04:47:44 -0800 (PST)
MIME-Version: 1.0
References: <Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com> <CAMRc=Mc5YgWqRsmw=n6EV8PW5OZfMZYotiqSy=gSvHH1PbVN4w@mail.gmail.com>
In-Reply-To: <CAMRc=Mc5YgWqRsmw=n6EV8PW5OZfMZYotiqSy=gSvHH1PbVN4w@mail.gmail.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Mon, 16 Jan 2023 13:47:33 +0100
Message-ID: <CACMJSesujoLTRFXMRuA2tBAJhainmy6-CmoeuO8OwW9VifaiKw@mail.gmail.com>
Subject: Re: spidev regression in 6.2-rc kernel
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, max.krummenacher@toradex.com,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 16 Jan 2023 at 13:19, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Jan 16, 2023 at 1:06 PM Francesco Dolcini <francesco@dolcini.it> wrote:
> >
> > Hello,
> > we spotted a regression on spidev on latest 6.2-rc kernel.
> >
> > [  214.047619]
> > [  214.049198] ============================================
> > [  214.054533] WARNING: possible recursive locking detected
> > [  214.059858] 6.2.0-rc3-0.0.0-devel+git.97ec4d559d93 #1 Not tainted
> > [  214.065969] --------------------------------------------
> > [  214.071290] spidev_test/1454 is trying to acquire lock:
> > [  214.076530] c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x8e0/0xab8
> > [  214.084164]
> > [  214.084164] but task is already holding lock:
> > [  214.090007] c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x44/0xab8
> > [  214.097537]
> > [  214.097537] other info that might help us debug this:
> > [  214.104075]  Possible unsafe locking scenario:
> > [  214.104075]
> > [  214.110004]        CPU0
> > [  214.112461]        ----
> > [  214.114916]   lock(&spidev->spi_lock);
> > [  214.118687]   lock(&spidev->spi_lock);
> > [  214.122457]
> > [  214.122457]  *** DEADLOCK ***
> > [  214.122457]
> > [  214.128386]  May be due to missing lock nesting notation
> > [  214.128386]
> > [  214.135183] 2 locks held by spidev_test/1454:
> > [  214.139553]  #0: c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x44/0xab8
> > [  214.147524]  #1: c4925e14 (&spidev->buf_lock){+.+.}-{3:3}, at: spidev_ioctl+0x70/0xab8
> > [  214.155493]
> > [  214.155493] stack backtrace:
> > [  214.159861] CPU: 0 PID: 1454 Comm: spidev_test Not tainted 6.2.0-rc3-0.0.0-devel+git.97ec4d559d93 #1
> > [  214.169012] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> > [  214.175555]  unwind_backtrace from show_stack+0x10/0x14
> > [  214.180819]  show_stack from dump_stack_lvl+0x60/0x90
> > [  214.185900]  dump_stack_lvl from __lock_acquire+0x874/0x2858
> > [  214.191584]  __lock_acquire from lock_acquire+0xfc/0x378
> > [  214.196918]  lock_acquire from __mutex_lock+0x9c/0x8a8
> > [  214.202083]  __mutex_lock from mutex_lock_nested+0x1c/0x24
> > [  214.207597]  mutex_lock_nested from spidev_ioctl+0x8e0/0xab8
> > [  214.213284]  spidev_ioctl from sys_ioctl+0x4d0/0xe2c
> > [  214.218277]  sys_ioctl from ret_fast_syscall+0x0/0x1c
> > [  214.223351] Exception stack(0xe75cdfa8 to 0xe75cdff0)
> > [  214.228422] dfa0:                   00000000 00001000 00000003 40206b00 bee266e8 bee266e0
> > [  214.236617] dfc0: 00000000 00001000 006a71a0 00000036 004c0040 004bfd18 00000000 00000003
> > [  214.244809] dfe0: 00000036 bee266c8 b6f16dc5 b6e8e5f6
> >
> >
> > This is not running the latest rc4, but on sha 97ec4d559d93 (this is
> > just what our CI had available when this test was run). I was not able
> > to bisect it, but it seems something that you could have introduced.
> >
> > The log is from an apalis-imx6, but I have the same on other ARM SOC.
> >
> > Can you have a look?
> > Thanks
> >
> > Francesco
> >
>
> Eek! Yes it's commit 1f4d2dd45b6e ("spi: spidev: fix a race condition
> when accessing spidev->spi"): spidev_ioctl() takes the lock and in
> certain instances can end up calling spidev_compat_ioc_message() which
> takes the same lock again. I'll send a fix shortly.
>
> Bart

Seems, like that's not it... Francesco: what is the output of:

./scripts/faddr2line drivers/spi/spidev.o spidev_ioctl+0x44/0xab8

and

./scripts/faddr2line drivers/spi/spidev.o spidev_ioctl+0x44/0xab8

on the spidev.o object for that build?

Bart
