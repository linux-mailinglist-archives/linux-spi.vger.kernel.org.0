Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDF82B4645
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 15:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgKPOr0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Mon, 16 Nov 2020 09:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbgKPOrX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 09:47:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48277C0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 06:47:23 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kefml-0000g9-JG; Mon, 16 Nov 2020 15:47:15 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kefmk-0008T7-SO; Mon, 16 Nov 2020 15:47:14 +0100
Message-ID: <00f1e6b477c84b8c671f12e42bb9612133fbea6c.camel@pengutronix.de>
Subject: Re: [PATCH v2] spi: cadence-quadspi: Fix error return code in
 cqspi_probe
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>, broonie@kernel.org,
        tudor.ambarus@microchip.com,
        vadivel.muruganx.ramuthevar@linux.intel.com, vigneshr@ti.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Date:   Mon, 16 Nov 2020 15:47:14 +0100
In-Reply-To: <20201116141836.2970579-1-chengzhihao1@huawei.com>
References: <20201116141836.2970579-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 2020-11-16 at 22:18 +0800, Zhihao Cheng wrote:
> Fix to return the error code from
> devm_reset_control_get_optional_exclusive() instaed of 0
> in cqspi_probe().
> 
> Fixes: 31fb632b5d43ca ("spi: Move cadence-quadspi driver to drivers/spi/")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Thank you,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
