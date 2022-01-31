Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E584A4BCF
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380317AbiAaQWf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380268AbiAaQWJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:22:09 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968D5C06174E
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 08:21:52 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C383220000F;
        Mon, 31 Jan 2022 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643646111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DDTeMeOOIw6olsfuxFu+Cxedy4z1OviP+2QO6mZOzh0=;
        b=n4gJ/GMrsQYbIyp83VTpluxmz32Jit+CuKylpBKfdD8qs6wm4pxG6KeHaNLft+Tw68554j
        749DnKCjpbyYwg+V3mITJmrx0UL6F+VuPCrEuBqsgv/NhzWdVMkXSG2cRWB77kn4ucsl+Q
        3/60LQ2Jtvc5FMH6QE430xxF/+cM9iQBSkTfafjDT0xXjiCwQrJ58gUaM0wONOYmeiz1ix
        s5mxlvF/wzWcCsqQ9gHXjI9aRiIzWrEa7pU/I5iPkuYQHN+doGEF+84Gl7W3pLHp7aRSSs
        EY+O29AO5W6DSFX6jKsBqRiCl1o77OTLS9AS07D6ElstgM0KYlLPDNei2OqW3g==
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
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Zhengxun Li <zhengxunli@mxic.com.tw>
Subject: Re: [PATCH v10 12/13] spi: mxic: Add support for direct mapping
Date:   Mon, 31 Jan 2022 17:21:49 +0100
Message-Id: <20220131162149.23649-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-13-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'70cf0b339497d02d8a3e754ba8c1212b6ddace0f'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2022-01-27 at 09:18:07 UTC, Miquel Raynal wrote:
> Implement the ->dirmap_create() and ->dirmap_read/write() hooks to
> provide a fast path for read and write accesses.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Tested-by: Zhengxun Li <zhengxunli@mxic.com.tw>
> Reviewed-by: Zhengxun Li <zhengxunli@mxic.com.tw>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-13-miquel.raynal@bootlin.com

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
