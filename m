Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 112DE146537
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2020 10:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgAWJ6T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Jan 2020 04:58:19 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41342 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgAWJ6T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Jan 2020 04:58:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00N9vh8A106195;
        Thu, 23 Jan 2020 03:57:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579773463;
        bh=+qvSVa/6zw7io9wfh3uZ8q9pGGSXsK+0TXmEgb1fu44=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mSEqLJAEl3kCTUoQ3nkYABSnJBUoEWrZ7v5Al1+ZZY5Yl7RHUzin2YhJXGwPDinjZ
         fABVZq9++aMMPkeeMjsf4PvwjYpRG1Kx1WOyBWq30LfXrv31VqX49+4m8CHwqEDNCS
         M3PrZFMUOUx2U5bO+ClkpxnkjBvTO/B4g3+Zkvgg=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00N9vh5s030723
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jan 2020 03:57:43 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 23
 Jan 2020 03:57:42 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 23 Jan 2020 03:57:42 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00N9ver0004842;
        Thu, 23 Jan 2020 03:57:41 -0600
Subject: Re: [PATCH v7 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <dan.carpenter@oracle.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20200122091340.43986-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200122091340.43986-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <617ec5c7-59a0-1e09-bdd7-126a5792889d@ti.com>
 <1aedd2ad-5795-2500-286f-fb55209991f8@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <a4b33129-5ac3-d4d1-c8ba-f170f0f9ee03@ti.com>
Date:   Thu, 23 Jan 2020 15:28:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1aedd2ad-5795-2500-286f-fb55209991f8@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 23/01/20 3:14 pm, Ramuthevar, Vadivel MuruganX wrote:
>>> +};
>>> +
>>> +struct spi_mem_op_cadence {
>>> +    const void    *tx_buf;
>>> +    void        *rx_buf;
>>> +    u32        len;
>>> +    u32        tx_nbits:3;
>>> +    u32        rx_nbits:3;
>>> +};
>>> +
>> Please drop thesee.. See further below for more info.
> it's required for qspi-nand.

I don't see a need to mimic fields of spi_mem_op inside this driver. Why
not use them directly where needed?

Looking at the patch:

rx_nbits is never used.
tx_nbits is assigned value but never used
rx_buf is never used

tx_buf aliases to addrbuf which can be easily derived from op->addr.val




-- 
Regards
Vignesh
