Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE1D49C80E
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jan 2022 11:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbiAZKxD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Jan 2022 05:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbiAZKw6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jan 2022 05:52:58 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170ACC061748
        for <linux-spi@vger.kernel.org>; Wed, 26 Jan 2022 02:52:57 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id CCEEA200010;
        Wed, 26 Jan 2022 10:52:53 +0000 (UTC)
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
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v9 08/13] mtd: spinand: Create direct mapping descriptors for ECC operations
Date:   Wed, 26 Jan 2022 11:52:52 +0100
Message-Id: <20220126105252.882804-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220104083631.40776-9-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'b32d4773f7aa60645ec0c7dfa74992e98facb0b7'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 2022-01-04 at 08:36:26 UTC, Miquel Raynal wrote:
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

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
