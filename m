Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B784479097
	for <lists+linux-spi@lfdr.de>; Fri, 17 Dec 2021 16:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbhLQPyO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Dec 2021 10:54:14 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48789 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbhLQPyM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Dec 2021 10:54:12 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 63CB060015;
        Fri, 17 Dec 2021 15:54:09 +0000 (UTC)
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 06/28] dt-bindings: vendor-prefixes: Clarify Macronix prefix
Date:   Fri, 17 Dec 2021 16:54:07 +0100
Message-Id: <20211217155407.366700-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211216111654.238086-7-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'df2d3ce1eed351f963a797849034316ab2c8a9f8'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2021-12-16 at 11:16:32 UTC, Miquel Raynal wrote:
> When looking at compatible prefixes, Macronix is sometimes referred as
> "mxicy":
> - mxicy,mx25r1635f
> - mxicy,mx25u6435f
> - mxicy,mx25v8035f
> - mxicy,mx25f0a-spi
> and sometimes as "mxic":
> - mxic,multi-itfc-v009-nand-controller
> - mxic,enable-randomizer-otp
> 
> The oldest prefix that is also the one preferred by Macronix engineers
> is "mxicy", so document the other one and mark it deprecated.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
