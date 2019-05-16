Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE48202C9
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2019 11:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfEPJnK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 May 2019 05:43:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48582 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfEPJnK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 May 2019 05:43:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5A53460A43; Thu, 16 May 2019 09:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557999789;
        bh=mAn2iFFHckRd3ohvLpQRx+OaGWXOZ6D8XXn0kPEekd8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=URTlWqVuyLjs/kQDtcpdDUxVr8YgTjjgWYoj8xT4cmA+YBXjOTLUtXzxGUaIdvWxy
         YARC98uXjl/3+M1c2whPrpKePPUyHhxJQl39pdr9G0WA+eRLAObMHpQbYp913pAa/+
         E6bcqevL/ax8GRHYdIxPgI0BvX7ulmevPuC1rqoI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93AFB60A42;
        Thu, 16 May 2019 09:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557999788;
        bh=mAn2iFFHckRd3ohvLpQRx+OaGWXOZ6D8XXn0kPEekd8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y/o7rx7dOzVIjuyKGUaoCLvWiuZ4NBsagvC0uwH4r990f8hlxKDrH8MawVLp6Lcyo
         bQz1teq5l7EAwZ8+NpnOJ1CxToyk16Gb15cawjBs1lRnZ9PxEULx0B/CnVKtpEc3yw
         ze6oC17PBVWw2wsSRcN2eAxvQMOlaW3JJfb5zgtA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93AFB60A42
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] spi: bitbang: Fix NULL pointer dereference in
 spi_unregister_master
To:     YueHaibing <yuehaibing@huawei.com>, broonie@kernel.org,
        axel.lin@ingics.com
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        albeu@free.fr, lorenzo.bianconi@redhat.com
References: <20190516075656.25880-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <e2a15e35-3faf-58be-7b76-5550ddcd49de@codeaurora.org>
Date:   Thu, 16 May 2019 15:13:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516075656.25880-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 5/16/2019 1:26 PM, YueHaibing wrote:
> If spi_register_master fails in spi_bitbang_start
> because device_add failure, We should return the
> error code other than 0, otherwise calling
> spi_bitbang_stop may trigger NULL pointer dereference
> like this:
>
> BUG: KASAN: null-ptr-deref in __list_del_entry_valid+0x45/0xd0
> Read of size 8 at addr 0000000000000000 by task syz-executor.0/3661
>
> CPU: 0 PID: 3661 Comm: syz-executor.0 Not tainted 5.1.0+ #28
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> Call Trace:
>   dump_stack+0xa9/0x10e
>   ? __list_del_entry_valid+0x45/0xd0
>   ? __list_del_entry_valid+0x45/0xd0
>   __kasan_report+0x171/0x18d
>   ? __list_del_entry_valid+0x45/0xd0
>   kasan_report+0xe/0x20
>   __list_del_entry_valid+0x45/0xd0
>   spi_unregister_controller+0x99/0x1b0
>   spi_lm70llp_attach+0x3ae/0x4b0 [spi_lm70llp]
>   ? 0xffffffffc1128000
>   ? klist_next+0x131/0x1e0
>   ? driver_detach+0x40/0x40 [parport]
>   port_check+0x3b/0x50 [parport]
>   bus_for_each_dev+0x115/0x180
>   ? subsys_dev_iter_exit+0x20/0x20
>   __parport_register_driver+0x1f0/0x210 [parport]
>   ? 0xffffffffc1150000
>   do_one_initcall+0xb9/0x3b5
>   ? perf_trace_initcall_level+0x270/0x270
>   ? kasan_unpoison_shadow+0x30/0x40
>   ? kasan_unpoison_shadow+0x30/0x40
>   do_init_module+0xe0/0x330
>   load_module+0x38eb/0x4270
>   ? module_frob_arch_sections+0x20/0x20
>   ? kernel_read_file+0x188/0x3f0
>   ? find_held_lock+0x6d/0xd0
>   ? fput_many+0x1a/0xe0
>   ? __do_sys_finit_module+0x162/0x190
>   __do_sys_finit_module+0x162/0x190
>   ? __ia32_sys_init_module+0x40/0x40
>   ? __mutex_unlock_slowpath+0xb4/0x3f0
>   ? wait_for_completion+0x240/0x240
>   ? vfs_write+0x160/0x2a0
>   ? lockdep_hardirqs_off+0xb5/0x100
>   ? mark_held_locks+0x1a/0x90
>   ? do_syscall_64+0x14/0x2a0
>   do_syscall_64+0x72/0x2a0
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 702a4879ec33 ("spi: bitbang: Let spi_bitbang_start() take a reference to master")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/spi/spi-bitbang.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
> index dd9a8c54..be95be4 100644
> --- a/drivers/spi/spi-bitbang.c
> +++ b/drivers/spi/spi-bitbang.c
> @@ -403,7 +403,7 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
>   	if (ret)
>   		spi_master_put(master);
>   
> -	return 0;
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(spi_bitbang_start);
>   
