Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951A3476BAC
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 09:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbhLPIOj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 16 Dec 2021 03:14:39 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55705 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhLPIOj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 03:14:39 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 189C660002;
        Thu, 16 Dec 2021 08:14:35 +0000 (UTC)
Date:   Thu, 16 Dec 2021 09:14:34 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v5 12/13] spi: mxic: Use spi_mem_generic_supports_op()
Message-ID: <20211216091434.52a5c1af@xps13>
In-Reply-To: <20211215195219.0d34cb77@collabora.com>
References: <20211214114140.54629-1-miquel.raynal@bootlin.com>
        <20211214114140.54629-13-miquel.raynal@bootlin.com>
        <20211214172410.2b26c17e@collabora.com>
        <20211215184426.67fd3912@xps13>
        <20211215195219.0d34cb77@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris,

boris.brezillon@collabora.com wrote on Wed, 15 Dec 2021 19:52:19 +0100:

> On Wed, 15 Dec 2021 18:44:26 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > In order to keep the series easy to review I decided to go for the
> > following approach:
> > * Introduce the spi_mem_generic_supports_op_helper() which takes a
> >   capabilities structure. This helper gathers all the checks from
> >   spi_mem_default_supports_op() and spi_mem_dtr_supports_op(). These
> >   two helpers now call the new one with either a NULL pointer in the
> >   former case, or a structure with the .dtr parameter set to true in
> >   the latter.  
> 
> Is there a benefit adding an extra NULL check when you could make sure
> all callers pass a zero-initialized caps object when they don't support
> fancy features like DTR or ECC.

That's exactly my point, I really don't like the creation of 15 empty
and useless structures while we could just have a check. If the
controller provides no capabilities, we assure he has none. I don't
think checking "if (caps && caps->PARAM)" hurts. Anyway, if we go for
the spi_mem controller internal structure approach, we might just not
need those.

Thanks,
Miquèl
