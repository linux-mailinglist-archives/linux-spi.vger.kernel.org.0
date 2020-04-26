Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915F41B8BCE
	for <lists+linux-spi@lfdr.de>; Sun, 26 Apr 2020 05:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDZDxv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 25 Apr 2020 23:53:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35356 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbgDZDxv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 25 Apr 2020 23:53:51 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 93FE666F8A9BDA450EDB;
        Sun, 26 Apr 2020 11:53:49 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sun, 26 Apr 2020
 11:53:45 +0800
Subject: Re: [PATCH v4 05/16] mtd: spi-nor: default to address width of 3 for
 configurable widths
To:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20200424184410.8578-1-p.yadav@ti.com>
 <20200424184410.8578-6-p.yadav@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <6b6384ad-d37a-eea6-af29-322e83924912@hisilicon.com>
Date:   Sun, 26 Apr 2020 11:53:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200424184410.8578-6-p.yadav@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/4/25 2:43, Pratyush Yadav wrote:
> JESD216D.01 says that when the address width can be 3 or 4, it defaults
> to 3 and enters 4-byte mode when given the appropriate command. So, when
> we see a configurable width, default to 3 and let flash that default to
> 4 change it in a post-bfpt fixup.
>
> This fixes SMPT parsing for flashes with configurable address width. If
> the SMPT descriptor advertises variable address width, we use
> nor->addr_width as the address width. But since it was not set to any
> value from the SFDP table, the read command uses an address width of 0,
> resulting in an incorrect read being issued.
>
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/mtd/spi-nor/sfdp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index f917631c8110..5cecc4ba2141 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -460,6 +460,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  	/* Number of address bytes. */
>  	switch (bfpt.dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK) {
>  	case BFPT_DWORD1_ADDRESS_BYTES_3_ONLY:
> +	case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4:
>  		nor->addr_width = 3;
>  		break;

Should we also assign address width to 3 in default condition. At least we should not
leave it uninitialized here.

Regards,
Yicong


>  

