Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8182D49D0DE
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jan 2022 18:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbiAZRgI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 26 Jan 2022 12:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243746AbiAZRgI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jan 2022 12:36:08 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC14CC06161C
        for <linux-spi@vger.kernel.org>; Wed, 26 Jan 2022 09:36:07 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id F32BD20000E;
        Wed, 26 Jan 2022 17:36:02 +0000 (UTC)
Date:   Wed, 26 Jan 2022 18:36:01 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v9 01/13] spi: spi-mem: Introduce a capability structure
Message-ID: <20220126183601.42d38e88@xps13>
In-Reply-To: <YfF4UhhVFu749ZYK@sirena.org.uk>
References: <20220104083631.40776-2-miquel.raynal@bootlin.com>
        <20220126105333.883267-1-miquel.raynal@bootlin.com>
        <YfF4UhhVFu749ZYK@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

broonie@kernel.org wrote on Wed, 26 Jan 2022 16:35:30 +0000:

> On Wed, Jan 26, 2022 at 11:53:33AM +0100, Miquel Raynal wrote:
> 
> > Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.  
> 
> I was hoping to review this stuff?  I think I was expecting it to be
> rebased after the merge window...

Sorry for the misunderstanding, I thought you were fine with these
spi bits so I didn't ping you before applying. Can you review the v9
then? There is nothing different in the series I applied.

Depending on the outcome I'll either fix inline if you ack the patches
or drop the patches from that branch and send a v10 otherwise.

Thanks,
Miquèl
