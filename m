Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADC61CA667
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 10:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHIq2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 04:46:28 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:48120 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgEHIq2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 04:46:28 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 May 2020 04:46:27 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 8BAF520024AB;
        Fri,  8 May 2020 16:38:34 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LeJQaVGZ0PTG; Fri,  8 May 2020 16:38:34 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 6A8CC20020CB;
        Fri,  8 May 2020 16:38:34 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 5D4DBC019F9;
        Fri,  8 May 2020 16:38:34 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 385EB201641; Fri,  8 May 2020 16:38:34 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Jack Lo <jack.lo@gtsys.com.hk>
Cc:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v0] spi: spi-rockchip spi slave mode
Date:   Fri,  8 May 2020 16:37:28 +0800
Message-Id: <20200508083729.5560-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver spi-rockchip does not support spi slave mode, but the register map
has an entry indicate that the chip support it. An example implementation found
here: https://dev.t-firefly.com/thread-101485-1-1.html
The patch is my first approach to support slave mode which is needed
in one of our projects, the PCBA is not yet available but we think
to have it for testing very soon. Yes, the code in the patch
isn't tested yet.

I found it odd, that the num_chipselect is set fixed to the amount of 
native chip-select lines rather use the max_native_cs.
Changed it.
-   master->num_chipselect = ROCKCHIP_SPI_MAX_CS_NUM;
+       of_property_read_u32(np, "num-cs", &num_cs);
+       master->num_chipselect = num_cs;
+       master->max_native_cs = ROCKCHIP_SPI_MAX_CS_NUM;

That ask to enable cs_gpiods, and support gpio cs
+       master->use_gpio_descriptors = true;

Patch against next-20200505

Thanks for review!

Happy hacking
Chris

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---

