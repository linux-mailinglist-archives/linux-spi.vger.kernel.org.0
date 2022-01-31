Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3F34A4BD7
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380289AbiAaQWj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380299AbiAaQWj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:22:39 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC314C06173B
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 08:22:38 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EE7CFFF80B;
        Mon, 31 Jan 2022 16:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643646157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6m2GficIeLFtb3didu21RB0OOyHFYkaO4nP1daMw7XQ=;
        b=j6RqOxIylUZEVVoi6GgkCl6pogCCF6VD3SuUtb1kQVYtqJhaI9ep5bvo2FZJbJN1gAEbVH
        GKclsaWpTVcVBEWrJQePeNxYxIXMG99PwM3ZqBgxH4EkKa4JJ5rO32e5fM1x3ZYfPAmvSG
        FzxJS1fHrIRFwNXwNIwdmvJSUM0i3VKXZxRvlBRG9x/EMeT0JJZUgZw66OEiHxC9TdM05h
        kl1acRCF3aHQ6+wJdcJ2Yq4axmi3JX4RjRQ3NG+3g3HCmPY2F7mAdATGu7R7qu7VwbGVWQ
        L7DnPBDOKfu2uYxwrh9mveai1hvFAgR23Nb4XsG7GcGqnxnYNsVKZCLdBqzgCw==
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
Subject: Re: [PATCH v10 04/13] spi: mxic: Provide a capability structure
Date:   Mon, 31 Jan 2022 17:22:35 +0100
Message-Id: <20220131162235.24171-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-5-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9130f39d17f53163a7703e7d5d51272f0d090e0c'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2022-01-27 at 09:17:59 UTC, Miquel Raynal wrote:
> This controller has DTR support, so advertize it with a capability now
> that the spi-controller structure contains this new field. This will
> later be used by the core to discriminate whether an operation is
> supported or not, in a more generic way than having different helpers.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-5-miquel.raynal@bootlin.com

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
