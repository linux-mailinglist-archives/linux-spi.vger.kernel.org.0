Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45573F45A3
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 09:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbhHWHMc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Aug 2021 03:12:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42454 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhHWHMb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Aug 2021 03:12:31 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5B6C51F422A0;
        Mon, 23 Aug 2021 08:11:48 +0100 (BST)
Date:   Mon, 23 Aug 2021 09:11:45 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Apurva Nandan <a-nandan@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH 03/13] mtd: spinand: Setup spi_mem_op for the SPI IO
 protocol using reg_proto
Message-ID: <20210823091145.0fd471ef@collabora.com>
In-Reply-To: <20210820140840.4bbcac7e@xps13>
References: <20210713130538.646-1-a-nandan@ti.com>
        <20210713130538.646-4-a-nandan@ti.com>
        <20210806203013.30a41fd5@xps13>
        <3de32033-2a6e-bc46-a65a-4027ce78c6d6@ti.com>
        <20210820140840.4bbcac7e@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 20 Aug 2021 14:08:40 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Apurva,
> 
> Boris, you might have a good idea for the naming discussed below?

{patch,adjust,tweak}_op() all sound good to me. This being said, I'm
a bit concerned about doing this op tweaking in the hot-path.
Looks like something that should be done at probe or when switching to
8D mode, and kept around. The alternative would be to have per-mode op
tables, which I think would be clearer.
