Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0D049C807
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jan 2022 11:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbiAZKwg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Jan 2022 05:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240295AbiAZKwf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jan 2022 05:52:35 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1760BC06161C
        for <linux-spi@vger.kernel.org>; Wed, 26 Jan 2022 02:52:34 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2BC07FF806;
        Wed, 26 Jan 2022 10:52:30 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Zhengxun Li <zhengxunli@mxic.com.tw>
Subject: Re: [PATCH v9 12/13] spi: mxic: Add support for direct mapping
Date:   Wed, 26 Jan 2022 11:52:29 +0100
Message-Id: <20220126105229.882545-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220104083631.40776-13-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'875ff3fc6bc4d293a09f5e71fc01f1a84b616618'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 2022-01-04 at 08:36:30 UTC, Miquel Raynal wrote:
> Implement the ->dirmap_create() and ->dirmap_read/write() hooks to
> provide a fast path for read and write accesses.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Tested-by: Zhengxun Li <zhengxunli@mxic.com.tw>
> Reviewed-by: Zhengxun Li <zhengxunli@mxic.com.tw>
> Reviewed-by: Mark Brown <broonie@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
