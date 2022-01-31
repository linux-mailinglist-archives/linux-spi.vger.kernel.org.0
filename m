Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1454A4BCD
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380285AbiAaQWf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:22:35 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52001 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380286AbiAaQWF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:22:05 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F080260004;
        Mon, 31 Jan 2022 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643646123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UtIloJsR4Q0PYnZsjM6Fj0jrI6qRtZQg4gllAGP6NFI=;
        b=N6KrtvLQbB25E+R6Vk3Zx3Ps5kFSgEOjHODLLNNfc+uB1Bk8vmrX1JZ2kUMUVYA70M6Xp4
        MZ3WuXlvblW2i7wlr/bPnMtGbs9Wx6+PVJLYHO+g7lGk1v861ULgsvXToQHSyjKwUqQ9YM
        qyYA8NKozyDtLuGRdG7LOhjUJY91LtK0f3xinJ3CyuFGYNq36DH0kIv/i++6mxYxQjtyGb
        9AF/N0nNH7HHNduUXc8uDsb4n6/fV+S4WNXLztANSfKGJQwqodX9kTDHznBHSV8+goC5RZ
        HIVIdemZC2yLeo2DuCjKgGfBrUs5o8cOu20vmfxaHwnMxTCikIfHRaQaPJcdOQ==
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
Subject: Re: [PATCH v10 10/13] spi: mxic: Create a helper to configure the controller before an operation
Date:   Mon, 31 Jan 2022 17:22:01 +0100
Message-Id: <20220131162201.23780-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-11-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'28410cbf1eb5feae955b2a75e9c24b6494df78e8'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2022-01-27 at 09:18:05 UTC, Miquel Raynal wrote:
> Create the mxic_spi_set_hc_cfg() helper to configure the HC_CFG
> register. This helper will soon be used by the dirmap implementation and
> having this code factorized out earlier will clarify this addition.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-11-miquel.raynal@bootlin.com

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
