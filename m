Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D7A457693
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 19:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhKSSqA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 13:46:00 -0500
Received: from mslow1.mail.gandi.net ([217.70.178.240]:37755 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbhKSSp7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Nov 2021 13:45:59 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id C4B29C59F1
        for <linux-spi@vger.kernel.org>; Fri, 19 Nov 2021 18:35:33 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id DA493FF804;
        Fri, 19 Nov 2021 18:35:10 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/4] mtd: mchp23k256: Warn about failure to unregister mtd device
Date:   Fri, 19 Nov 2021 19:35:10 +0100
Message-Id: <20211119183510.1329796-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211108093153.63792-2-u.kleine-koenig@pengutronix.de>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'45c26c1f6b2d995ba44c20186ee72bfb561bdc9b'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 2021-11-08 at 09:31:50 UTC, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= wrote:
> mtd_device_unregister() shouldn't fail. Wail loudly if it does anyhow.
> 
> This matches how other drivers (e.g. nand/raw/nandsim.c) use
> mtd_device_unregister().
> 
> By returning 0 in the spi remove callback a generic error message by the
> spi framework (and nothing else) is suppressed.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
