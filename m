Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF904A4BD3
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380256AbiAaQWh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380337AbiAaQWR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:22:17 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01DBC06173D
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 08:22:15 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E9AF86000C;
        Mon, 31 Jan 2022 16:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643646134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJn1QbMcgZm6/T7SOxKlGYjeS/P8gdlrGz4HjM7LvkE=;
        b=euulx/ktdTkX5Skgjo0HaavTzDO9MNgcIfZHTF+U0oZfK7H2vSf7bB+Ob85fsZI0C81d3v
        h2veZYQQqi1ATf3DaMAwomDEH2jFynDeTnQv2SR7of6Qz8vEeItC2+22UALZkm6z/ehkW7
        GWq0Sb0dxxPaixe67Y2XqWtJkUTopL6CYgqwcF41/nUUpYsWx1pnt3XaK9glwhQ+lcQo/o
        0zsyGJZYwiATsGF8Jsrsl+ESHDA/CLsFlh45Jg3g5dfG22+v9YdgWpTHW095XLWz/FIFvD
        ug+Lz3fotsGc0lyyUaihHZh3lrXOFAGDhezylwVWhxh5+Nm5cvzqs+lMcD6DdQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v10 08/13] mtd: spinand: Create direct mapping descriptors for ECC operations
Date:   Mon, 31 Jan 2022 17:22:12 +0100
Message-Id: <20220131162212.23914-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-9-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e501cc3c9f1dc607f5d0497ca63e321bbe0ce57c'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2022-01-27 at 09:18:03 UTC, Miquel Raynal wrote:
> In order for pipelined ECC engines to be able to enable/disable the ECC
> engine only when needed and avoid races when future parallel-operations
> will be supported, we need to provide the information about the use of
> the ECC engine in the direct mapping hooks. As direct mapping
> configurations are meant to be static, it is best to create two new
> mappings: one for regular 'raw' accesses and one for accesses involving
> correction. It is up to the driver to use or not the new ECC enable
> boolean contained in the spi-mem operation.
> 
> As dirmaps are not free (they consume a few pages of MMIO address space)
> and because these extra entries are only meant to be used by pipelined
> engines, let's limit their use to this specific type of engine and save
> a bit of memory with all the other setups.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-9-miquel.raynal@bootlin.com

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
