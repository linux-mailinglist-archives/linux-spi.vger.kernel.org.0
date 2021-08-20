Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA93F298A
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 11:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbhHTJxz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 05:53:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48658 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbhHTJxz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Aug 2021 05:53:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17K9qx58090059;
        Fri, 20 Aug 2021 04:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629453179;
        bh=wJ0e2oEhVCKsqJHZmlmWTW4gw5Qh/Xv+9BHvHBV1zoA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tQff+56rUKJe7Jzi2bKfQQYp3DuNj4FSCk+y1qlhH2N+gh2P4B93ADNE58yoJNSKn
         4VEk+ywekYTmGH3G+/QatAAKoRxdYOhjfD3q+ACR+A9w1SFPZ3fA3qVrQfkk7vyyUQ
         BJyBtw2VNgOWlIjDLQT/Lk5Briue+k8dh2ddbjRc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17K9qxY4121358
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 04:52:59 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 04:52:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 04:52:59 -0500
Received: from [10.250.232.95] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17K9qtGI014630;
        Fri, 20 Aug 2021 04:52:56 -0500
Subject: Re: [PATCH 03/13] mtd: spinand: Setup spi_mem_op for the SPI IO
 protocol using reg_proto
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
 <20210713130538.646-4-a-nandan@ti.com> <20210806203013.30a41fd5@xps13>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <3de32033-2a6e-bc46-a65a-4027ce78c6d6@ti.com>
Date:   Fri, 20 Aug 2021 15:22:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806203013.30a41fd5@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquèl,

On 07/08/21 12:00 am, Miquel Raynal wrote:
> Hi Apurva,
> 
> Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:28
> +0000:
> 
>> Currently, the op macros in spinand.h don't give the option to setup
>> any non-array access instructions for Dual/Quad/Octal DTR SPI bus.
>> Having a function that setups the op based on reg_proto would be
>> better than trying to write all the setup logic in op macros.
>>
>> Create a spimem_setup_op() that would setup cmd, addr, dummy and data
>> phase of the spi_mem op, for the given spinand->reg_proto. And hence,
>> call the spimem_setup_op() before executing any spi_mem op.
>>
>> Note: In this commit, spimem_setup_op() isn't called in the
>> read_reg_op(), write_reg_op() and wait() functions, as they need
>> modifications in address value and data nbytes when in Octal DTR mode.
>> This will be fixed in a later commit.
> 
> Thanks for this series!
> 
> So far I am fine with your changes, but I don't like the setup_op()
> naming much. I don't yet have a better idea, could you propose
> something more meaningful?
> 

I made this similar to the spi_nor_spimem_setup_op(), which essentially 
does the same task as this in the spi-nor core.

Other names that I can think of are:

- config_op(), adjust_op(), amend_op(), patch_op()

or

- handle_op_variations(), apply_op_variations()

What do you suggest?

>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> 
> Thanks,
> Miquèl
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
Thanks,
Apurva Nandan
