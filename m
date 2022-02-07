Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5063F4AC452
	for <lists+linux-spi@lfdr.de>; Mon,  7 Feb 2022 16:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiBGPs2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Feb 2022 10:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357337AbiBGPjv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Feb 2022 10:39:51 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7330DC0401D1
        for <linux-spi@vger.kernel.org>; Mon,  7 Feb 2022 07:39:50 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3274160004;
        Mon,  7 Feb 2022 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644248389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P6v3WSju2B7mSE36VZ7dx7Lp44QoojX43k9fATwrWOw=;
        b=o/rXLu07Eyo+I46bH5RdHiVgOo50cTJXJ+LCyfSjwRxVM6AYZ6D3DEJjnlRskxk+UtCtCK
        cPijAl/ds1puX65m3yQJORcsMlUifaf+Noxcpmi8o8tvI+bv8Rgte1EEJTUOktO3PmlQjC
        LndxjUGY+60VxbPoVVNc0CKUJbcLWQggjJv6bdTOPFpUfCQMPTWSPJe5GI1gupmZEaLgy3
        FSWzLsYWLB4CgimoL3hT/bncNKa+UV1tj9fDahA4RtrIBkWFumDgfij0cJeuKIdwOBLQPK
        vX+w5V+lxnW1Opmhm177ii60hoChiUnwMzolibXjT6VyAmoRVXLMVO1UmOtZ+g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v11] spi: mxic: Add support for pipelined ECC operations
Date:   Mon,  7 Feb 2022 16:39:46 +0100
Message-Id: <20220207153946.710556-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220202144536.393792-1-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd6986e74ec6ee6a48ce9ee1d8051b2988d747558'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 2022-02-02 at 14:45:36 UTC, Miquel Raynal wrote:
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

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
