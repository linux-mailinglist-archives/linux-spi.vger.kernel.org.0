Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721023E2F4E
	for <lists+linux-spi@lfdr.de>; Fri,  6 Aug 2021 20:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhHFSad convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 6 Aug 2021 14:30:33 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:46749 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240879AbhHFSad (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Aug 2021 14:30:33 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id BD8EB100002;
        Fri,  6 Aug 2021 18:30:14 +0000 (UTC)
Date:   Fri, 6 Aug 2021 20:30:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 03/13] mtd: spinand: Setup spi_mem_op for the SPI IO
 protocol using reg_proto
Message-ID: <20210806203013.30a41fd5@xps13>
In-Reply-To: <20210713130538.646-4-a-nandan@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-4-a-nandan@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Apurva,

Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:28
+0000:

> Currently, the op macros in spinand.h don't give the option to setup
> any non-array access instructions for Dual/Quad/Octal DTR SPI bus.
> Having a function that setups the op based on reg_proto would be
> better than trying to write all the setup logic in op macros.
> 
> Create a spimem_setup_op() that would setup cmd, addr, dummy and data
> phase of the spi_mem op, for the given spinand->reg_proto. And hence,
> call the spimem_setup_op() before executing any spi_mem op.
> 
> Note: In this commit, spimem_setup_op() isn't called in the
> read_reg_op(), write_reg_op() and wait() functions, as they need
> modifications in address value and data nbytes when in Octal DTR mode.
> This will be fixed in a later commit.

Thanks for this series!

So far I am fine with your changes, but I don't like the setup_op()
naming much. I don't yet have a better idea, could you propose
something more meaningful?

> Signed-off-by: Apurva Nandan <a-nandan@ti.com>

Thanks,
Miquèl
