Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974C44A4BD6
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380116AbiAaQWj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380313AbiAaQWe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:22:34 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91115C061756
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 08:22:33 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BC08DFF805;
        Mon, 31 Jan 2022 16:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643646152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dL05merQzECnv1Pr1qf2OOcN6nM9QYBPBxi/5okjGxo=;
        b=DZlIu5KroUI7Z92wv3h4G4RmWoab5R/QmWa8fuMSiUkD+UxQ21TD1RjmpzBA3YOotD8MkE
        pNBi0m9UCe7DSyHZ2LHtMiTYS6G9J02ZGzNSZ3+BcR0uI2GetFlVjeJ78knc6kNi/A6nXz
        pSoj+4HYvi2q4zsEA2YOqBZccv6O3XabT9l8maBgI4+ndgmc3UvnSIWSVFlN1eRzk6q1jR
        hihnIUpu613oaIoF5wQzYj/egmUojwIj9/znoAhvIsBggeN+Qqm7VSkTCBfpXZ2PaquMYR
        fUF7zSBcEVvdov5cTQM+dIoFmyAlaUkqaV0pwvWRg9P5dqgB/5Z9uwUzAcXSgg==
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
Subject: Re: [PATCH v10 05/13] spi: spi-mem: Kill the spi_mem_dtr_supports_op() helper
Date:   Mon, 31 Jan 2022 17:22:30 +0100
Message-Id: <20220131162230.24106-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-6-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6e3c0bee1a87893638cdfd9e2865a82158cf8119'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2022-01-27 at 09:18:00 UTC, Miquel Raynal wrote:
> Now that spi_mem_default_supports_op() has access to the static
> controller capabilities (relating to memory operations), and now that
> these capabilities have been filled by the relevant controllers, there
> is no need for a specific helper checking only DTR operations, so let's
> just kill spi_mem_dtr_supports_op() and simply use
> spi_mem_default_supports_op() instead.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-6-miquel.raynal@bootlin.com

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
