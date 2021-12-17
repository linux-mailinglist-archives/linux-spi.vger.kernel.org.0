Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B231047906F
	for <lists+linux-spi@lfdr.de>; Fri, 17 Dec 2021 16:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbhLQPxN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Dec 2021 10:53:13 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:45611 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbhLQPxK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Dec 2021 10:53:10 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id BA38120000B;
        Fri, 17 Dec 2021 15:53:02 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 14/28] mtd: nand: mxic-ecc: Add Macronix external ECC engine support
Date:   Fri, 17 Dec 2021 16:53:01 +0100
Message-Id: <20211217155301.366176-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211216111654.238086-15-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'b78baf1891f0b7c3f0e2e3e6022eab38ee6c871f'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2021-12-16 at 11:16:40 UTC, Miquel Raynal wrote:
> Some SPI-NAND chips do not support on-die ECC. For these chips,
> correction must apply on the SPI controller end. In order to avoid
> doing all the calculations by software, Macronix provides a specific
> engine that can offload the intensive work.
> 
> Add Macronix ECC engine support, this engine can work in conjunction
> with a SPI controller and a raw NAND controller, it can be pipelined
> or external and supports linear and syndrome layouts.
> 
> Right now the simplest configuration is supported: SPI controller
> external and linear ECC engine.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
