Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1DD1CD3E9
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 10:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgEKIan (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 04:30:43 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:58604 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbgEKIan (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 May 2020 04:30:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id C7A462002518;
        Mon, 11 May 2020 16:30:40 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AuE0Dfh_okQ8; Mon, 11 May 2020 16:30:40 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id A2E5320020CB;
        Mon, 11 May 2020 16:30:40 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 96943C01F94;
        Mon, 11 May 2020 16:30:40 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 3F6272001DE; Mon, 11 May 2020 16:30:40 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Jack Lo <jack.lo@gtsys.com.hk>
Cc:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] spi: spi-rockchip spi slave mode
Date:   Mon, 11 May 2020 16:30:19 +0800
Message-Id: <20200511083022.23678-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi-rockchip driver does not implement spi slave mode, but the register map
have a corresponding flag. An example implementation found
here: https://dev.t-firefly.com/thread-101485-1-1.html
This patchset clean the compatiblity names and add support slave mode.
We need the slave mode for our project, but the PCBA is not yet available
in consequence the code in the patch isn't tested yet but need your review.

Patch 1/3
Cleanup, move from the compatibily layer struct spi_master over
to struct spi_controller, and rename the related function calls.

Patch 2/3
Add support for spi slave mode and support function

Patch 3/3
Use OF property num-cs and enable support for cs_gpiods

IMHO its wrong, that the num_chipselect is set fixed to the amount of 
native chip-select lines. SPI0 which has two native lines, while the others
SPIs one native cs line only.
Set max_native_cs in the controller struct with ROCKCHIP_SPI_MAX_CS_NUM seems
the correct way to do and let num-cs the OF / dts config set the CS count for
the boards.

Patch against next-20200508

Thanks for review!

Happy hacking
Chris

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---

