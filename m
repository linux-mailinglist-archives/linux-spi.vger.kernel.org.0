Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB38457675
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 19:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhKSShp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 13:37:45 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59265 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhKSShp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Nov 2021 13:37:45 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id ECC8B60009;
        Fri, 19 Nov 2021 18:34:40 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: Re: [PATCH 4/4] mtd: sst25l: Warn about failure to unregister mtd device
Date:   Fri, 19 Nov 2021 19:34:40 +0100
Message-Id: <20211119183440.1329154-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211108093153.63792-4-u.kleine-koenig@pengutronix.de>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'8836db88cdaaa82999fb60b7961361e30421dae8'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 2021-11-08 at 09:31:52 UTC, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= wrote:
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
