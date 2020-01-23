Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D403514655B
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2020 11:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAWKHD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Jan 2020 05:07:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:32992 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWKHD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 23 Jan 2020 05:07:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 02:07:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,353,1574150400"; 
   d="scan'208";a="375180018"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 23 Jan 2020 02:07:01 -0800
Received: from [10.226.38.32] (unknown [10.226.38.32])
        by linux.intel.com (Postfix) with ESMTP id 12FB9580100;
        Thu, 23 Jan 2020 02:06:59 -0800 (PST)
Subject: Re: [PATCH v7 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Vignesh Raghavendra <vigneshr@ti.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org
Cc:     robh+dt@kernel.org, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20200122091340.43986-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200122091340.43986-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <617ec5c7-59a0-1e09-bdd7-126a5792889d@ti.com>
 <1aedd2ad-5795-2500-286f-fb55209991f8@linux.intel.com>
 <a4b33129-5ac3-d4d1-c8ba-f170f0f9ee03@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <99ab6210-c9d3-c332-336a-a3d4877c8d6f@linux.intel.com>
Date:   Thu, 23 Jan 2020 18:06:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <a4b33129-5ac3-d4d1-c8ba-f170f0f9ee03@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 23/1/2020 5:58 PM, Vignesh Raghavendra wrote:
>
> On 23/01/20 3:14 pm, Ramuthevar, Vadivel MuruganX wrote:
>>>> +};
>>>> +
>>>> +struct spi_mem_op_cadence {
>>>> +    const void    *tx_buf;
>>>> +    void        *rx_buf;
>>>> +    u32        len;
>>>> +    u32        tx_nbits:3;
>>>> +    u32        rx_nbits:3;
>>>> +};
>>>> +
>>> Please drop thesee.. See further below for more info.
>> it's required for qspi-nand.
> I don't see a need to mimic fields of spi_mem_op inside this driver. Why
> not use them directly where needed?
>
> Looking at the patch:
>
> rx_nbits is never used.
> tx_nbits is assigned value but never used
> rx_buf is never used
>
> tx_buf aliases to addrbuf which can be easily derived from op->addr.val
>
Yes, I have already derived, only placing the correct function to be 
checked and added.
Regards
Vadivel
>
>
