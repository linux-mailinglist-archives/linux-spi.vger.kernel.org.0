Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6F94A4BD5
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380306AbiAaQWi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:22:38 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:36003 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380350AbiAaQW1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:22:27 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 57107FF803;
        Mon, 31 Jan 2022 16:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643646146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKUycR3XcVmomFNR09l75jCJm2qK8Dij9qhq6ySE4tk=;
        b=gHd874RhQl5aQEtFurgCQMreQB5RnNi1GgfjS/DLWKxcG6FZDm6VJxCFu5Zk0jZps+aZnU
        /lDQvWBam+Fmkwv9XgrUeSyfF/vp574Zus0RNFg12u1jhkHWqWG69Dx0TlT63tfRz+erOe
        1axtyUdiQzI/Gij4HCLwI4pd0gb82ZOfmRx25Yg5M2INyqskr0mZ8B57JOmPT4nUveyM4G
        5gjNHOeMzAC8tQBR0/mRBCko7bhVsSI2GoGnYWfGWvLEmJX4se7P0KXHZ+Lyd3FoQ+dpvb
        Zp606KZ6pmJ3nDIeqaENv+fZV8QmdSVxSTyM5DaU5GtfcJs5hCM67+PGf6zhfA==
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
Subject: Re: [PATCH v10 06/13] spi: spi-mem: Add an ecc parameter to the spi_mem_op structure
Date:   Mon, 31 Jan 2022 17:22:24 +0100
Message-Id: <20220131162224.24042-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-7-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd0020bb2d2a6719287cf8f53dbc1eb710f82fd57'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2022-01-27 at 09:18:01 UTC, Miquel Raynal wrote:
> Soon the SPI-NAND core will need a way to request a SPI controller to
> enable ECC support for a given operation. This is because of the
> pipelined integration of certain ECC engines, which are directly managed
> by the SPI controller itself.
> 
> Introduce a spi_mem_op additional field for this purpose: ecc.
> 
> So far this field is left unset and checked to be false by all
> the SPI controller drivers in their ->supports_op() hook, as they all
> call spi_mem_default_supports_op().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-7-miquel.raynal@bootlin.com
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
