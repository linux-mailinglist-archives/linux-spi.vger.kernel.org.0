Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7194A4BDB
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349781AbiAaQXE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:23:04 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48879 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380342AbiAaQWy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:22:54 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E086020005;
        Mon, 31 Jan 2022 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643646173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9R9w7nHUTG04n1FcF/qJAxoWCHpQZB01oA9Hg8vlO2w=;
        b=EEh/yrfMphmEaW/ffaiX53WkC4S0e75y8Hs0pVyywJMftHEYeFv+THvjXdnMhJC7xZPXe/
        MVtWAH/Qsn4+OnlQo+8FS6evZEKgRg/VAWZ3gLQ4nzSyVV+TE7I4O9MopTPsIf4r/lRE0c
        9xVYY3R2m2NXBkqXumaY33zEkh7cj1SNu7N+HECRuzgy8CO218ba8u9e9D4vCDMWGEXy2o
        E+IxljOQskSeh+450t8jNVHopHdTtbXYZsLa5Pgu1JaNnQkY0fGjXcOm3HuKe8YRGnVcUR
        ulNu/R+BUhZpbo0scJaEfMlh5grVUT39oTZv7SsADicxDJPvnDQtczwE4KQqHg==
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
Subject: Re: [PATCH v10 01/13] spi: spi-mem: Introduce a capability structure
Date:   Mon, 31 Jan 2022 17:22:50 +0100
Message-Id: <20220131162250.24365-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-2-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'bb693170bc57dd2c33cec37a050323554eccf1ba'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2022-01-27 at 09:17:56 UTC, Miquel Raynal wrote:
> Create a spi_controller_mem_caps structure and put it within the
> spi_controller structure close to the spi_controller_mem_ops
> strucure. So far the only field in this structure is the support for dtr
> operations, but soon we will add another parameter.
> 
> Also create a helper to parse the capabilities and check if the
> requested capability has been set or not.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-2-miquel.raynal@bootlin.com

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
