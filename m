Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFFA476119
	for <lists+linux-spi@lfdr.de>; Wed, 15 Dec 2021 19:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhLOSw1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Dec 2021 13:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344007AbhLOSw0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Dec 2021 13:52:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F060C061574
        for <linux-spi@vger.kernel.org>; Wed, 15 Dec 2021 10:52:25 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 13FC81F458D6;
        Wed, 15 Dec 2021 18:52:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639594343; bh=lSwTdglEMsehkWcc/2vunjShV0vV91Td2VrKRQ2w2kg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RQgRkrRIewXQqdMgE3ppN8+4gqpvBNXnUCdCTQxT7AoNGKPPw5/TA2iaV3NvUUf1P
         zk9HZr22FDLdonis3ZfdWdqwWch7vK48zojXZVxflIsKFvYXQWvXizcmX+x0ZzfOm+
         M7OtDtw9n6NYH3dsOsg1niF+9XktzyTz9Q3KujJhJJ1+ZmJKKVkdzzqq0/1xkgrz5T
         g8s8keo9U34NJ3wdavxOeCVj3bXFTs2kwix0gIxpHpplhMiqhyEREvlfUHFsSxlubj
         S0/uAZGi/6NNHIGgIB7uZehY46X0nKM3oZiXph8LMCaJ9MQCiMbm3NLPITxOeRcsB5
         HZR4PlGS+5pYw==
Date:   Wed, 15 Dec 2021 19:52:19 +0100
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
Subject: Re: [PATCH v5 12/13] spi: mxic: Use spi_mem_generic_supports_op()
Message-ID: <20211215195219.0d34cb77@collabora.com>
In-Reply-To: <20211215184426.67fd3912@xps13>
References: <20211214114140.54629-1-miquel.raynal@bootlin.com>
        <20211214114140.54629-13-miquel.raynal@bootlin.com>
        <20211214172410.2b26c17e@collabora.com>
        <20211215184426.67fd3912@xps13>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 15 Dec 2021 18:44:26 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> In order to keep the series easy to review I decided to go for the
> following approach:
> * Introduce the spi_mem_generic_supports_op_helper() which takes a
>   capabilities structure. This helper gathers all the checks from
>   spi_mem_default_supports_op() and spi_mem_dtr_supports_op(). These
>   two helpers now call the new one with either a NULL pointer in the
>   former case, or a structure with the .dtr parameter set to true in
>   the latter.

Is there a benefit adding an extra NULL check when you could make sure
all callers pass a zero-initialized caps object when they don't support
fancy features like DTR or ECC.
