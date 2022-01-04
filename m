Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C2483EBB
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jan 2022 10:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiADJFA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jan 2022 04:05:00 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55648 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiADJE7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jan 2022 04:04:59 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DC4A21F42D02;
        Tue,  4 Jan 2022 09:04:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641287098;
        bh=tWUUROTUCs0hzh33hvzqpkODT6ELvrGScCBg5y7RChs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NxKwyCjcsbhMbITbs3BBATNXlilmT77keV57xZ1hSffYZde1FGIh/01Xr/E49y/Ov
         S+6a25g6tVwMb8/EjZMQVYIIntaRvLYsZKyu8StxwphVbGdD+UplYejS7a9G/zCuhO
         Z9BVJ0D9l0LqEajzgCClHTaPL5xOCMg53gVFuT5S6pxoup29xmxBmilW+aRgaThV0s
         j+MoFUqLPYaPAhH3jXXIhOVK7J/lBF47k/3aBx066MtjW/Ha0cSU4AEv9svCZeeS2C
         7ztvhvScYGEQCnCSkVnJJ9L8fD4SeMsAmWvYTD59sb2XKPcFJjUWetANTfnYXKmZYg
         jwzJegt7VYGlw==
Date:   Tue, 4 Jan 2022 10:04:54 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v9 00/13] External ECC engines & Macronix support
Message-ID: <20220104100454.64859a80@collabora.com>
In-Reply-To: <20220104083631.40776-1-miquel.raynal@bootlin.com>
References: <20220104083631.40776-1-miquel.raynal@bootlin.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue,  4 Jan 2022 09:36:18 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Miquel Raynal (13):
>   spi: spi-mem: Introduce a capability structure
>   spi: spi-mem: Check the controller extra capabilities
>   spi: cadence-quadspi: Provide a capability structure
>   spi: mxic: Provide a capability structure
>   spi: spi-mem: Kill the spi_mem_dtr_supports_op() helper
>   spi: spi-mem: Add an ecc parameter to the spi_mem_op structure
>   mtd: spinand: Delay a little bit the dirmap creation
>   mtd: spinand: Create direct mapping descriptors for ECC operations
>   spi: mxic: Fix the transmit path
>   spi: mxic: Create a helper to configure the controller before an
>     operation
>   spi: mxic: Create a helper to ease the start of an operation
>   spi: mxic: Add support for direct mapping
>   spi: mxic: Add support for pipelined ECC operations

All core changes (patches 1 to 8) are

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
