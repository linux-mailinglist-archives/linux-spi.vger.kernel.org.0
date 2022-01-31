Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD504A4BD9
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380270AbiAaQXE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:23:04 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:42409 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380310AbiAaQWs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:22:48 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7E736200007;
        Mon, 31 Jan 2022 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643646167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=00QmH9ZSV1KrxgsE23TL7EVgHqdgvORlx80j77l0KVU=;
        b=TsCAYYucoisHpkHvV04EV6nJ6K6fQh/2pY1DsqcTRmXX/XF7wxXZjLfKdwq776O5iRbcDM
        7HQ/yYB6aEV1G1TggcNFeTJKxl2E4l1V2C2CCPStQyrHHcfp7Ln9wIMLXvESMPTpTx7WAr
        q2uGz7Cm6udLBQ/744xXft2gzjeTpBziIOzYo/5yBmighQZbTE//XlzOYetg9abxNDXsn8
        m4RUy9m0UWXfX/qVUdz5F2fLJTLbE0ZYHDt/iGmWa+Qqv/sgWRSwUeQ9eVNnMbBLv50Jha
        SdqSUwpg8z4aIch+Wma0+Jt8aMZy/W461m5FL0IhybeEs4dLNHfw+fPtxyTbgw==
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
Subject: Re: [PATCH v10 02/13] spi: spi-mem: Check the controller extra capabilities
Date:   Mon, 31 Jan 2022 17:22:45 +0100
Message-Id: <20220131162245.24300-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-3-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'3163fc9215d89c19cd0ee1f6f9566d292d7db275'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2022-01-27 at 09:17:57 UTC, Miquel Raynal wrote:
> Controllers can now provide a spi-mem capabilities structure. Let's make
> use of it in spi_mem_controller_default_supports_op(). As we want to
> check for DTR operations as well as normal operations in a single
> helper, let's pull the necessary checks from spi_mem_dtr_supports_op()
> for now.
> 
> However, because no controller provide these extra capabilities, this
> change has no effect so far.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-3-miquel.raynal@bootlin.com

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
