Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BF74972C2
	for <lists+linux-spi@lfdr.de>; Sun, 23 Jan 2022 17:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiAWQBK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Sun, 23 Jan 2022 11:01:10 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57907 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbiAWQBK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 23 Jan 2022 11:01:10 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C9063C0009;
        Sun, 23 Jan 2022 16:01:02 +0000 (UTC)
Date:   Sun, 23 Jan 2022 17:01:01 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v9 00/13] External ECC engines & Macronix support
Message-ID: <20220123170101.5bc21291@xps13>
In-Reply-To: <20220104083631.40776-1-miquel.raynal@bootlin.com>
References: <20220104083631.40776-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

miquel.raynal@bootlin.com wrote on Tue,  4 Jan 2022 09:36:18 +0100:

> Hello all,
> 
> I've applied the beginning of the series (bindings + ECC part) in a
> branch named spi-mem-ecc on the MTD korg repository. After discussing a
> bit more some details, I decided not to rush and did not apply the
> second halve of the series for v5.17. Here is now the second halve again
> in a hopefully better shape. I am expecting a few acks on this one and
> I'll then rebase spi-mem-ecc on top of v5.18-rc1, apply these patches
> and share them with the spi tree.

Series applied in its own branch, I will share it next week with the
spi tree.

Thanks,
Miquèl
