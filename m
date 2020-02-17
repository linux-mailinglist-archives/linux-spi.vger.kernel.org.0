Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0731611DE
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2020 13:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgBQMRo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Feb 2020 07:17:44 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50068 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgBQMRo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Feb 2020 07:17:44 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01HCHSkP023037;
        Mon, 17 Feb 2020 06:17:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581941848;
        bh=E3VkN1ikCKZ9GbsHBrahfc8EY2iLwLFkjGpj5EcTql0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=D4GGp8mF7bV47mlTNJMdLLIl1wbz/lr0QD3RiX/mG5Xqp87SEnZZ3HVsa4jbOT0TR
         Gq2ffGcqDH2Fz9bV2fUlQx8D79l5WRdVLibFb3I5N8QITj1whA3yqFhEsTkt7GB+RT
         GXt/ghJOEHG3cxLpeUWDESHxuXb49eVhc6hKCXXs=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01HCHSRi121007
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Feb 2020 06:17:28 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 17
 Feb 2020 06:17:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 17 Feb 2020 06:17:28 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01HCHNV2078195;
        Mon, 17 Feb 2020 06:17:24 -0600
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Mark Brown <broonie@kernel.org>,
        "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
CC:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, <dan.carpenter@oracle.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>,
        <dinguyen@kernel.org>, <tien.fong.chee@intel.com>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
 <20200214121145.GF4827@sirena.org.uk>
 <4712cdc4-34cd-990b-3d53-3d394ae1250b@linux.intel.com>
 <20200217115213.GA9304@sirena.org.uk>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <f5f868e5-a977-7487-9395-a76dd5e7c963@ti.com>
Date:   Mon, 17 Feb 2020 17:48:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200217115213.GA9304@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vadivel,

On 17/02/20 5:22 pm, Mark Brown wrote:
> On Mon, Feb 17, 2020 at 05:28:38PM +0800, Ramuthevar, Vadivel MuruganX wrote:
>> On 14/2/2020 8:11 PM, Mark Brown wrote:
> 
>>> Given that this is a new driver I'd be very surprised if it broke other
>>> users?  I can imagine it might not work for them and it would definitely
>>> be much better to get their review but it shouldn't be any worse than
>>> the current lack of support.
> 
>> *[Vignesh]*  The legacy driver under drivers/mtd/spi-nor will be removed as
>> we cannot
>> support both SPI NOR and SPI NAND with single driver if its under
>> spi-nor. New driver should be functionally equivalent to existing one.
>> So I suggest you test this driver on legcay SoCFPGA products.
> 
> You're not actually removing the driver here, you're adding another
> driver for the same thing.
> 

I agree with Mark here.

I realized that you are using same CONFIG option as the old one to build
this driver. This causes new driver to fail to probe as old driver would
bind to the node instead (both drivers will be built into the kernel and
both drivers have same compatible).

So, you should remove the old driver. Could you also include patches
removing old driver? New driver and bindings are anyways backward
compatible with existing one

-- 
Regards
Vignesh
