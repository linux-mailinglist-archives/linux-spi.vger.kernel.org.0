Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25444A4BCB
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380307AbiAaQWd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:22:33 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:54185 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380311AbiAaQVr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:21:47 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 6FC32200006;
        Mon, 31 Jan 2022 16:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643646106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTFcrH3RulTxp46/bvFVG5JUrGsELqmVK6LqBqmxDsU=;
        b=XCPCTEVo/xqZuy6wj+9OlsR/6/OzZl/tkqFt6koe8Y7O/MVEnm/lc8QUzkyVzeGJNa9G+L
        lXNqu3MsWpHo2m5izPvY/oEMNlgCgGXAQIllmFodnx1aE9h4mJiv/bDI/wpa0TxAPRjj8P
        tE+JNfyODECieSQl8BLxVSRrhXOEo5y+RKQG8w4CZou015zSFscdZ1maFpiQMsYuMbaxGd
        eTZ753NE8kHWUZrExpUwMETrbteJI/LjMDwWk+jKl4cYPHUCl99Ng1fEYdHLrqLxSGS2PK
        Az1WM3B3x02RPkGQ5qLY5KvmKlDEU5s7CM+oLNA5HNkzV2ZQp7keWmKk/GP/qw==
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
Subject: Re: [PATCH v10 13/13] spi: mxic: Add support for pipelined ECC operations
Date:   Mon, 31 Jan 2022 17:21:42 +0100
Message-Id: <20220131162142.23580-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-14-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6d0fadec1de4434fce145b374ef25c665357fa60'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2022-01-27 at 09:18:08 UTC, Miquel Raynal wrote:
> Some SPI-NAND chips do not have a proper on-die ECC engine providing
> error correction/detection. This is particularly an issue on embedded
> devices with limited resources because all the computations must
> happen in software, unless an external hardware engine is provided.
> 
> These external engines are new and can be of two categories: external
> or pipelined. Macronix is providing both, the former being already
> supported. The second, however, is very SoC implementation dependent
> and must be instantiated by the SPI host controller directly.
> 
> An entire subsystem has been contributed to support these engines which
> makes the insertion into another subsystem such as SPI quite
> straightforward without the need for a lot of specific functions.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-14-miquel.raynal@bootlin.com

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
