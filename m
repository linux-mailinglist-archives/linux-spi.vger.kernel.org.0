Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2233F383933
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 18:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbhEQQLM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 12:11:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43408 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343596AbhEQQID (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 May 2021 12:08:03 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14HG6WVT073174;
        Mon, 17 May 2021 11:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621267592;
        bh=DmBKGotDmWCU/i+6kalj9zUloINRPVqINr28c/Ac90o=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pGO7Ph6rJ/FuhPomk916FCgcwH+ASdmS863TMLtr+8ifLydzl0OTwpBNcrKncZdYY
         +p2UJFbzlrvNh8xcN69H0gYxqaqy7yZ1e2BJyU9yY4iIf0duBJJEQQ4GZQYZvglMKx
         D1NkCmN7L5Nh6lhE9KbfOHnWIfczOxHX+r73zd+Q=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14HG6Wmq031483
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 May 2021 11:06:32 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 17
 May 2021 11:06:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 17 May 2021 11:06:31 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14HG6UOj000929;
        Mon, 17 May 2021 11:06:31 -0500
Date:   Mon, 17 May 2021 21:36:30 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Zhengxun Li <zhengxunli@mxic.com.tw>
CC:     <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <tudor.ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <broonie@kernel.org>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v5 2/2] spi: mxic: patch for octal DTR mode support
Message-ID: <20210517160628.s65h6prjt5mw6bud@ti.com>
References: <1621232088-12567-1-git-send-email-zhengxunli@mxic.com.tw>
 <1621232088-12567-3-git-send-email-zhengxunli@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1621232088-12567-3-git-send-email-zhengxunli@mxic.com.tw>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17/05/21 02:14PM, Zhengxun Li wrote:
> Driver patch for octal DTR mode support.
> 
> Owing to the spi_mem_default_supports_op() is not support dtr
> operation. Based on Pratyush patch "spi: spi-mem: add spi_mem_dtr

I don't like the "Based on Pratyush patch". Please mention the commit 
hash so it is much easier to find later. For example, saying based on 
commit 539cf68cd51b (spi: spi-mem: add spi_mem_dtr_supports_op(), 
2021-02-04) is much better.

But while we are on this topic, I don't think it is needed all that 
much. People use pre-existing APIs all the time. I don't see any need to 
specifically point it out.  So I think saying "Call 
spi_mem_dtr_supports_op() to ..." is better.

> _supports_op()" add spi_mem_dtr_supports_op() to support dtr and
> keep checking the buswidth and command bytes.
> 
> Signed-off-by: Zhengxun Li <zhengxunli@mxic.com.tw>
> ---

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
