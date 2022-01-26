Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D0249C813
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jan 2022 11:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbiAZKxW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Jan 2022 05:53:22 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56879 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbiAZKxV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jan 2022 05:53:21 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B31E720011;
        Wed, 26 Jan 2022 10:53:16 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v9 04/13] spi: mxic: Provide a capability structure
Date:   Wed, 26 Jan 2022 11:53:16 +0100
Message-Id: <20220126105316.883073-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220104083631.40776-5-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd56caeb0dd8bed566e65394187f444f2d128dec2'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 2022-01-04 at 08:36:22 UTC, Miquel Raynal wrote:
> This controller has DTR support, so advertize it with a capability now
> that the spi-controller structure contains this new field. This will
> later be used by the core to discriminate whether an operation is
> supported or not, in a more generic way than having different helpers.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
