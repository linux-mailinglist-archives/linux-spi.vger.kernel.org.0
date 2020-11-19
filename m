Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008FC2B92A4
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 13:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgKSMhG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 07:37:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36410 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgKSMhG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 07:37:06 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AJCavTG056603;
        Thu, 19 Nov 2020 06:36:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605789417;
        bh=36qW6Hdzvc8q4QaaKaYXTa+cp2qx83QVdrm6XFKQ1mk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LaqX9r7fkasp1lEJ6ulnGxx7lDd582brlyX9MZKjsoQM0lnciWRMkP/1PI9cNq7qK
         rjRy9CzWSErxPIc3H9CLuL8VGISPZ5hP27fjT+y53qH1XfY0eCnwXohcEO4zF8Qs9c
         n9L4S3Qf/2zCgmikOSMyTu7xeQ8yetn/0oGdCcAc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AJCauKE064137
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 06:36:56 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 19
 Nov 2020 06:36:56 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 19 Nov 2020 06:36:56 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AJCarAt001987;
        Thu, 19 Nov 2020 06:36:54 -0600
Subject: Re: [PATCH v8 0/6] spi: cadence-quadspi: Add QSPI controller support
 for Intel LGM SoC
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <p.yadav@ti.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20201119055551.26493-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <98b7b367-0bf3-e745-1dd2-302f76bab0b7@ti.com>
Date:   Thu, 19 Nov 2020 18:06:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119055551.26493-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 11/19/20 11:25 AM, Ramuthevar,Vadivel MuruganX wrote:
> Add QSPI controller support for Intel LGM SoC.
> 
> Note from Vignesh(mtd subsystem maintainer):
> This series is a subset of "[PATCH v12 0/4] spi: cadence-quadspi: Add
> support for the Cadence QSPI controller" by Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> that intended to move
> cadence-quadspi driver to spi-mem framework
> 
> Those patches were trying to accomplish too many things in a single set
> of patches and need to split into smaller patches. This is reduced
> version of above series.
> 
> Changes that are intended to make migration easy are split into separate
> patches. Patches 1 to 3 drop features that cannot be supported under
> spi-mem at the moment (backward compatibility is maintained).
> Patch 4-5 are trivial cleanups. Patch 6 does the actual conversion to
> spi-mem and patch 7 moves the driver to drivers/spi folder.
> 
> I have tested both INDAC mode (used by non TI platforms like Altera
> SoCFPGA) and DAC mode (used by TI platforms) on TI EVMs.
> 
> Patches to move move bindings over to
> "Documentation/devicetree/bindings/spi/" directory and also conversion
> of bindig doc to YAML will be posted separately.  Support for Intel
> platform would follow that.
> 
> Reference:
>         https://lkml.org/lkml/2020/6/1/50
> 
> ---
> v8:
>   - As Mark suggested to add the dt-bindings documentation patches
>     end of the series , so dropped.  

Suggestion was to drop patches converting legacy binding doc to YAML schema.
You still need to include a patch documenting new compatible
"intel,lgm-qspi" in the existing (legacy) binding doc.
