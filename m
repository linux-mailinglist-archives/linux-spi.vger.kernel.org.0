Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467253F45C0
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 09:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhHWHYv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 23 Aug 2021 03:24:51 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:49583 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhHWHYv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Aug 2021 03:24:51 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 0B84440002;
        Mon, 23 Aug 2021 07:24:05 +0000 (UTC)
Date:   Mon, 23 Aug 2021 09:24:04 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Apurva Nandan <a-nandan@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 03/13] mtd: spinand: Setup spi_mem_op for the SPI IO
 protocol using reg_proto
Message-ID: <20210823092404.0a9b68e4@xps13>
In-Reply-To: <20210823091145.0fd471ef@collabora.com>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-4-a-nandan@ti.com>
        <20210806203013.30a41fd5@xps13>
        <3de32033-2a6e-bc46-a65a-4027ce78c6d6@ti.com>
        <20210820140840.4bbcac7e@xps13>
        <20210823091145.0fd471ef@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris,

Boris Brezillon <boris.brezillon@collabora.com> wrote on Mon, 23 Aug
2021 09:11:45 +0200:

> On Fri, 20 Aug 2021 14:08:40 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Hi Apurva,
> > 
> > Boris, you might have a good idea for the naming discussed below?  
> 
> {patch,adjust,tweak}_op() all sound good to me. This being said, I'm
> a bit concerned about doing this op tweaking in the hot-path.
> Looks like something that should be done at probe or when switching to
> 8D mode, and kept around. The alternative would be to have per-mode op
> tables, which I think would be clearer.

True! Thanks for the idea!

Cheers,
Miquèl
