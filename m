Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D915D4A4BD4
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380259AbiAaQWh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:22:37 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:51009 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380304AbiAaQWX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:22:23 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5D0B4FF80E;
        Mon, 31 Jan 2022 16:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643646141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fKLqyEQnVslm98yvtjPp9oskrhJ+hPB88eL+N2otoMA=;
        b=kDkd5wwFe1l0bkBVF+LcjE9z5ia5nN3JWatgquLgwoJm3KYrJvxOLbKFgEEeBUll841XR7
        RjcUU5Rd8ErJbh2OsCN27pHQTKdyGgm0/BA7o8Mbr0nvVcaTjlije4w+KGj5zfOb0MbFDh
        p4XSm6R/MxHYl1Y13xWXDPS31VWj95iKcUHxoKztGb+MXAkKZdRhXTp0UWUpI7Xb3EwV/g
        234IkNATWmWs17XXn1MuXImUSqFFIdodpaDW9VKuKNpS/aepjWZ0NYU1ybd6C/kjNDW/By
        e3KyinSPTdyyWs9KyKx12hflpVPTx5NY0J7TgHpFPDVSKNbRebT+h+sem0NnVA==
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
Subject: Re: [PATCH v10 07/13] mtd: spinand: Delay a little bit the dirmap creation
Date:   Mon, 31 Jan 2022 17:22:17 +0100
Message-Id: <20220131162217.23978-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-8-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'adfbe3dee2d1cc4e06aa218de6682014343632a9'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2022-01-27 at 09:18:02 UTC, Miquel Raynal wrote:
> As we will soon tweak the dirmap creation to act a little bit
> differently depending on the picked ECC engine, we need to initialize
> dirmaps after ECC engines. This should not have any effect as dirmaps
> are not yet used at this point.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-8-miquel.raynal@bootlin.com

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
