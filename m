Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C505449B8
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jun 2022 13:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiFILHC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jun 2022 07:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiFILHC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jun 2022 07:07:02 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7626223F219
        for <linux-spi@vger.kernel.org>; Thu,  9 Jun 2022 04:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=w353nuApGt8vtX5Jn2h0hJmZSjbzHdw8HL6417uaAWc=;
        b=O3HjyoOWUe+4/MSt6rA1m+4Ki0ELha15Mmbo1hF0xX6EkrnTYlsMjADocS4uqwuPH9zvFtNMQwpZg
         GjBLSvp7snQJwbX9GLhnNG+ZA4jl/nd5xSN//1OtmfID3zXwOj3eVZ+2bjHU7XQSjWHfSN1dOP1IRU
         o28SRmPPDBwmsdtzHcnAl5KbGg9WgLW9yzFmtCIj9z7PkMCikyodpQVJe7JhUK4tVkcMIgPVXmN7zb
         WfSAvmp4MeFQkIi9V+HQX4868FXXsY4eBFEhUjPGumpletK0SfAqF+5nCX/8YEUXwsr3VYeBhAO5eO
         dZqnJYEH+hh7XfjLwoEZh4/Y8cZUlhw==
X-MSG-ID: 4639d699-e7e4-11ec-9896-0050569d2c73
Date:   Thu, 9 Jun 2022 13:06:55 +0200
From:   David Jander <david@protonic.nl>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, ore@pengutronix.de,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] drivers: spi: spi.c: Convert statistics to per-cpu
 u64_stats_t
Message-ID: <20220609130655.3912bf63@erd992>
In-Reply-To: <20220609093251.22l6farvsmggttz3@pengutronix.de>
References: <20220524091808.2269898-1-david@protonic.nl>
        <20220609093251.22l6farvsmggttz3@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 9 Jun 2022 11:32:51 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 24.05.2022 11:18:08, David Jander wrote:
> > This change gives a dramatic performance improvement in the hot path,
> > since many costly spin_lock_irqsave() calls can be avoided.
> >
> > On an i.MX8MM system with a MCP2518FD CAN controller connected via SPI,
> > the time the driver takes to handle interrupts, or in other words the time
> > the IRQ line of the CAN controller stays low is mainly dominated by the
> > time it takes to do 3 relatively short sync SPI transfers. The effect of
> > this patch is a reduction of this time from 136us down to only 98us.
> >
> > Suggested-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: David Jander <david@protonic.nl>  
> 
> This patch (cherry picked on top of v5.19-rc1) explodes on 32-bit SMP
> ARMv7 (imx6q) with:
> 
> | [    0.397493] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> | [    0.397514] caller is debug_smp_processor_id+0x18/0x24
> | [    0.397544] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc1-00001-g6ae0aec8a366 #181
> | [    0.397559] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> | [    0.397566] Backtrace:
> | [    0.397576]  dump_backtrace from show_stack+0x20/0x24
> | [    0.397616]  r7:81024ffd r6:00000000 r5:81024ffd r4:60000013
> | [    0.397621]  show_stack from dump_stack_lvl+0x60/0x78
> | [    0.397644]  dump_stack_lvl from dump_stack+0x14/0x1c
> | [    0.397664]  r7:81024ffd r6:80f652de r5:80bec180 r4:819a2500
> | [    0.397669]  dump_stack from check_preemption_disabled+0xc8/0xf0
> | [    0.397690]  check_preemption_disabled from debug_smp_processor_id+0x18/0x24
> | [    0.397714]  r8:8119b7e0 r7:81205534 r6:819f5c00 r5:819f4c00 r4:c083d724
> | [    0.397719]  debug_smp_processor_id from __spi_sync+0x78/0x220
> | [    0.397746]  __spi_sync from spi_sync+0x34/0x4c
> | [    0.397772]  r10:bb7bf4e0 r9:c083d724 r8:00000007 r7:81a068c0 r6:822a83c0 r5:c083d724
> | [    0.397779]  r4:819f4c00
> | [    0.397784]  spi_sync from spi_mem_exec_op+0x338/0x370
> | [    0.397810]  r5:000000b4 r4:c083d910
> | [    0.397815]  spi_mem_exec_op from spi_nor_read_id+0x98/0xdc
> | [    0.397846]  r10:bb7bf4e0 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:82358040
> | [    0.397852]  r4:819f7c40
> | [    0.397856]  spi_nor_read_id from spi_nor_detect+0x38/0x114
> | [    0.397878]  r7:82358040 r6:00000000 r5:819f7c40 r4:819f7c40
> | [    0.397883]  spi_nor_detect from spi_nor_scan+0x11c/0xbec
> | [    0.397910]  r10:bb7bf4e0 r9:00000000 r8:00000000 r7:c083da4c r6:00000000 r5:00010101
> | [    0.397916]  r4:819f7c40
> | [    0.397921]  spi_nor_scan from spi_nor_probe+0x10c/0x2d0
> | [    0.397946]  r10:bb7bf4e0 r9:bb7bf4d0 r8:00000000 r7:819f4c00 r6:00000000 r5:00000000
> | [    0.397952]  r4:819f7c40

*ouch*. Thanks for reporting. Fix coming up asap... apparently I forgot to
get_cpu/put_cpu around the per-cpu operations :-(

Best regards,

-- 
David Jander
