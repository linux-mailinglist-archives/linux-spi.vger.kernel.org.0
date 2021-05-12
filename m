Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBFE37B45F
	for <lists+linux-spi@lfdr.de>; Wed, 12 May 2021 05:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhELDJG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 23:09:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2633 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhELDJF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 May 2021 23:09:05 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg04y3d1JzQlyj;
        Wed, 12 May 2021 11:04:34 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Wed, 12 May 2021
 11:07:47 +0800
Subject: Re: [PATCH] spi: omap-100k: remove set but not used variable
To:     "tiantao (H)" <tiantao6@hisilicon.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <1620784512-46828-1-git-send-email-tiantao6@hisilicon.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <0c45664b-5a4f-08a4-79fc-038c4f1991a1@huawei.com>
Date:   Wed, 12 May 2021 11:07:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1620784512-46828-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


ÔÚ 2021/5/12 9:55, tiantao (H) Ð´µÀ:
> The assignment to status on lines 296 and 315 is meaningless and will
> rewriten, so just delete.
Sorry, please ignore this patch, jay fang has already fixed this problem.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>   drivers/spi/spi-omap-100k.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
> index 7062f29..dc9b86b 100644
> --- a/drivers/spi/spi-omap-100k.c
> +++ b/drivers/spi/spi-omap-100k.c
> @@ -296,7 +296,6 @@ static int omap1_spi100k_transfer_one_message(struct spi_master *master,
>   
>   	list_for_each_entry(t, &m->transfers, transfer_list) {
>   		if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
> -			status = -EINVAL;
>   			break;
>   		}
>   		status = omap1_spi100k_setup_transfer(spi, t);
> @@ -315,7 +314,6 @@ static int omap1_spi100k_transfer_one_message(struct spi_master *master,
>   			m->actual_length += count;
>   
>   			if (count != t->len) {
> -				status = -EIO;
>   				break;
>   			}
>   		}

