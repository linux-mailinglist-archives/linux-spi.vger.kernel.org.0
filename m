Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405FA38256C
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 09:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhEQHej (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 03:34:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43646 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbhEQHej (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 May 2021 03:34:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14H7X80G069032;
        Mon, 17 May 2021 02:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621236788;
        bh=wIJJ5jCdwTb9SsArEhc/jnRTTl69GTr3L7YuAZJu/gs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=d+7NQsrg58MtVK7semUILHI4Z8ZqD2J+EiOOq615+6YlGaR+xMXjsF0mXZaINokUt
         bvzQd0hppufsZNwlwWpKNuLLzMlLAK7eWoyrzGtaeab4/P7e12Npq9MW7V6u9DNC8j
         QRHRAe5y2H1LSSwqfJDcuIiPh/d9OGnVKuOGkjUk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14H7X7xM104587
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 May 2021 02:33:07 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 17
 May 2021 02:33:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 17 May 2021 02:33:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14H7X67V024915;
        Mon, 17 May 2021 02:33:07 -0500
Date:   Mon, 17 May 2021 13:03:06 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Zhengxun Li <zhengxunli@mxic.com.tw>
CC:     <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <tudor.ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <broonie@kernel.org>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v5 1/2] mtd: spi-nor: macronix: add support for Macronix
 octaflash
Message-ID: <20210517073304.sldl5eybdkd6owvl@ti.com>
References: <1621232088-12567-1-git-send-email-zhengxunli@mxic.com.tw>
 <1621232088-12567-2-git-send-email-zhengxunli@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1621232088-12567-2-git-send-email-zhengxunli@mxic.com.tw>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17/05/21 02:14PM, Zhengxun Li wrote:
> The octaflash is an xSPI compliant octal DTR flash. Add support
> for using it in octal DTR mode.
> 
> Try to verify the flash ID to check whether the flash memory in octal
> DTR mode and SPI mode are correct. When reading ID in OCTAL DTR mode,
> ID will appear in a repeated manner. ex: ID[0] = 0xc2, ID[1] = 0xc2,
> ID[2] = 0x94, ID[3] = 0x94... Rearrange the order so that the ID can pass.
> 
> The octaflash series can be divided into the following types:
> 
> MX25 series : Serial NOR Flash.
> MX66 series : Serial NOR Flash with stacked die.(Size larger than 1Gb)
> LM/UM series : Up to 250MHz clock frequency with both DTR/STR operation.
> LW/UW series : Support simultaneous Read-while-Write operation in multiple
> 	       bank architecture. Read-while-write feature which means read
> 	       data one bank while another bank is programing or erasing.
> 
> MX25LM : 3.0V Octal I/O
>  -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7841/MX25LM51245G,%203V,%20512Mb,%20v1.1.pdf
> 
> MX25UM : 1.8V Octal I/O
>  -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7525/MX25UM51245G%20Extreme%20Speed,%201.8V,%20512Mb,%20v1.0.pdf
> 
> MX66LM : 3.0V Octal I/O with stacked die
>  -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7929/MX66LM1G45G,%203V,%201Gb,%20v1.1.pdf
> 
> MX66UM : 1.8V Octal I/O with stacked die
>  -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7721/MX66UM1G45G,%201.8V,%201Gb,%20v1.1.pdf
> 
> MX25LW : 3.0V Octal I/O with Read-while-Write
> MX25UW : 1.8V Octal I/O with Read-while-Write
> MX66LW : 3.0V Octal I/O with Read-while-Write and stack die
> MX66UW : 1.8V Octal I/O with Read-while-Write and stack die
> 
> About LW/UW series, please contact us freely if you have any
> questions. For adding Octal NOR Flash IDs, we have validated
> each Flash on plateform zynq-picozed.
> 
> Signed-off-by: Zhengxun Li <zhengxunli@mxic.com.tw>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
